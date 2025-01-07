#include <pick_place_RC.h>
#include <ros/console.h>

#include <tf_conversions/tf_eigen.h>

const double FINGER_MAX = 2;

using namespace kinova;

PickPlace::PickPlace(ros::NodeHandle &nh) : nh_(nh)
{
    //    if(ros::console::set_logger_level(ROSCONSOLE_DEFAULT_NAME, ros::console::levels::Debug))
    //    {
    //        ros::console::notifyLoggerLevelsChanged();
    //    }

    ros::NodeHandle pn("~");

    nh_.param<std::string>("/robot_type", robot_type_, "j2n6s300");
    nh_.param<bool>("/robot_connected", robot_connected_, false);

    sub_robot_state_ = nh.subscribe<std_msgs::Int32>("/vrep_ros_interface/grasp", 1, &PickPlace::get_robot_state, this);
    can_posi_ = nh.subscribe<geometry_msgs::Pose>("/vrep_ros_interface/can_pose", 1, &PickPlace::get_can_pose, this);
    cup_posi_ = nh.subscribe<geometry_msgs::Pose>("/vrep_ros_interface/cup_pose", 1, &PickPlace::get_cup_pose, this);
    bear_posi_ = nh.subscribe<geometry_msgs::Pose>("/vrep_ros_interface/bear_pose", 1, &PickPlace::get_bear_pose, this);
    box_can_posi_ = nh.subscribe<geometry_msgs::Pose>("/vrep_ros_interface/box_can_pose", 1, &PickPlace::get_box_can_pose, this);
    box_cup_posi_ = nh.subscribe<geometry_msgs::Pose>("/vrep_ros_interface/box_cup_pose", 1, &PickPlace::get_box_cup_pose, this);
    box_bear_posi_ = nh.subscribe<geometry_msgs::Pose>("/vrep_ros_interface/box_bear_pose", 1, &PickPlace::get_box_bear_pose, this);
    table_target_posi_ = nh.subscribe<geometry_msgs::Pose>("/vrep_ros_interface/table_target_pose", 1, &PickPlace::get_table_target_pose, this);
    table_box_posi_ = nh.subscribe<geometry_msgs::Pose>("/vrep_ros_interface/table_box_pose", 1, &PickPlace::get_table_box_pose, this);

    sub_joint_ = nh_.subscribe<sensor_msgs::JointState>("/j2n6s300/joint_states", 1, &PickPlace::get_current_state, this);

    if (robot_connected_)
    {
        sub_pose_ = nh_.subscribe<geometry_msgs::PoseStamped>("/" + robot_type_ + "_driver/out/tool_pose", 1, &PickPlace::get_current_pose, this);
    }

    // Before we can load the planner, we need two objects, a RobotModel and a PlanningScene.
    robot_model_loader::RobotModelLoader robot_model_loader("robot_description");
    robot_model_ = robot_model_loader.getModel();

    // construct a `PlanningScene` that maintains the state of the world (including the robot).
    planning_scene_.reset(new planning_scene::PlanningScene(robot_model_));
    planning_scene_monitor_.reset(new planning_scene_monitor::PlanningSceneMonitor("robot_description"));

    //    //  every time need retrive current robot state, do the following.
    //    robot_state::RobotState& robot_state = planning_scene_->getCurrentStateNonConst();
    //    const robot_state::JointModelGroup *joint_model_group = robot_state.getJointModelGroup("arm");

    group_ = new moveit::planning_interface::MoveGroup("arm");
    gripper_group_ = new moveit::planning_interface::MoveGroup("gripper");

    group_->setEndEffectorLink(robot_type_ + "_end_effector");

    finger_client_ = new actionlib::SimpleActionClient<kinova_msgs::SetFingersPositionAction>("/" + robot_type_ + "_driver/fingers_action/finger_positions", false);
    while (robot_connected_ && !finger_client_->waitForServer(ros::Duration(5.0)))
    {
        ROS_INFO("Waiting for the finger action server to come up");
    }

    pub_co_ = nh_.advertise<moveit_msgs::CollisionObject>("/collision_object", 10);
    pub_aco_ = nh_.advertise<moveit_msgs::AttachedCollisionObject>("/attached_collision_object", 10);
    pub_planning_scene_diff_ = nh_.advertise<moveit_msgs::PlanningScene>("planning_scene", 1);

    int arm_joint_num = robot_type_[3] - '0';
    joint_names_.resize(arm_joint_num);
    joint_values_.resize(joint_names_.size());
    for (uint i = 0; i < joint_names_.size(); i++)
    {
        joint_names_[i] = robot_type_ + "_joint_" + boost::lexical_cast<std::string>(i + 1);
        target_joint.push_back(0);
    }

    // set pre-defined joint and pose values.
    define_joint_values();
    define_cartesian_pose();

    // pick process
    result_ = moveit_msgs::MoveItErrorCodes::PLANNING_FAILED;
    my_pick();
}

PickPlace::~PickPlace()
{
    // shut down pub and subs
    pub_co_.shutdown();
    pub_aco_.shutdown();

    pub_planning_scene_diff_.shutdown();

    sub_pose_.shutdown();
    sub_joint_.shutdown();
    can_posi_.shutdown();
    cup_posi_.shutdown();
    bear_posi_.shutdown();
    box_can_posi_.shutdown();
    box_cup_posi_.shutdown();
    box_bear_posi_.shutdown();
    table_target_posi_.shutdown();
    table_box_posi_.shutdown();
    sub_robot_state_.shutdown();

    // release memory
    delete group_;
    delete gripper_group_;
    delete finger_client_;
}

void PickPlace::get_robot_state(const std_msgs::Int32::ConstPtr &msg)
{
    boost::mutex::scoped_lock lock(mutex_grasp_);
    robot_state = msg->data;
}

void PickPlace::get_current_state(const sensor_msgs::JointStateConstPtr &msg)
{
    boost::mutex::scoped_lock lock(mutex_state_);

    for (int i = 0; i < joint_names_.size(); i++)
    {
        double tmp = fabs(target_joint[i] - msg->position[i]);
        while (tmp > 3)
            tmp -= 3.141592;
        if (tmp > 0.002)
        { /*
			for(int i = 0;i<joint_names_.size();i++){
				ROS_INFO("%f", msg->position[i]);
			}ROS_INFO("");*/
            return;
        }
    }

    robot_state = 0;
}

void PickPlace::get_current_pose(const geometry_msgs::PoseStampedConstPtr &msg)
{
    boost::mutex::scoped_lock lock(mutex_pose_);
    current_pose_ = *msg;
}

void PickPlace::get_can_pose(const geometry_msgs::Pose::ConstPtr &msg)
{
    co_can_.id = "target_can";

    if (can_grasp)
    {
        if (!is_can_grasped)
        {
            add_attached_obstacle(co_can_);
            is_can_grasped = 1;
        }
    }
    else
    {
        if (is_can_grasped)
        {
            aco_.object = co_can_;
            aco_.object.operation = moveit_msgs::CollisionObject::REMOVE;
            pub_co_.publish(co_can_);
            pub_aco_.publish(aco_);
            is_can_grasped = 0;
        }
        co_can_.meshes.resize(1);
        co_can_.mesh_poses.resize(1);

        co_can_.mesh_poses[0].position.x = msg->position.x;
        co_can_.mesh_poses[0].position.y = msg->position.y;
        co_can_.mesh_poses[0].position.z = msg->position.z;
        co_can_.mesh_poses[0].orientation.x = msg->orientation.x;
        co_can_.mesh_poses[0].orientation.y = msg->orientation.y;
        co_can_.mesh_poses[0].orientation.z = msg->orientation.z;
        co_can_.mesh_poses[0].orientation.w = msg->orientation.w;

        co_can_.operation = moveit_msgs::CollisionObject::ADD;
        std::vector<moveit_msgs::CollisionObject> collision_vector;
        collision_vector.push_back(co_can_);

        planning_scene_interface.applyCollisionObjects(collision_vector);
    }
}

void PickPlace::get_cup_pose(const geometry_msgs::Pose::ConstPtr &msg)
{
    co_cup_.id = "target_cup";

    if (cup_grasp)
    {
        if (!is_cup_grasped)
        {
            add_attached_obstacle(co_cup_);
            is_cup_grasped = 1;
        }
    }
    else
    {
        if (is_cup_grasped)
        {
            aco_.object = co_cup_;
            aco_.object.operation = moveit_msgs::CollisionObject::REMOVE;
            pub_co_.publish(co_cup_);
            pub_aco_.publish(aco_);
            is_cup_grasped = 0;
        }
        co_cup_.meshes.resize(1);
        co_cup_.mesh_poses.resize(1);

        co_cup_.mesh_poses[0].position.x = msg->position.x;
        co_cup_.mesh_poses[0].position.y = msg->position.y;
        co_cup_.mesh_poses[0].position.z = msg->position.z;
        co_cup_.mesh_poses[0].orientation.x = msg->orientation.x;
        co_cup_.mesh_poses[0].orientation.y = msg->orientation.y;
        co_cup_.mesh_poses[0].orientation.z = msg->orientation.z;
        co_cup_.mesh_poses[0].orientation.w = msg->orientation.w;

        co_cup_.operation = moveit_msgs::CollisionObject::ADD;

        std::vector<moveit_msgs::CollisionObject> collision_vector;
        collision_vector.push_back(co_cup_);

        planning_scene_interface.applyCollisionObjects(collision_vector);
    }
}

void PickPlace::get_bear_pose(const geometry_msgs::Pose::ConstPtr &msg)
{
    co_bear_.id = "target_bear";

    if (bear_grasp)
    {
        if (!is_bear_grasped)
        {
            add_attached_obstacle(co_bear_);
            is_bear_grasped = 1;
        }
    }
    else
    {
        if (is_bear_grasped)
        {
            aco_.object = co_bear_;
            aco_.object.operation = moveit_msgs::CollisionObject::REMOVE;
            pub_co_.publish(co_bear_);
            pub_aco_.publish(aco_);
            is_bear_grasped = 0;
        }
        co_bear_.meshes.resize(1);
        co_bear_.mesh_poses.resize(1);

        co_bear_.mesh_poses[0].position.x = msg->position.x;
        co_bear_.mesh_poses[0].position.y = msg->position.y;
        co_bear_.mesh_poses[0].position.z = msg->position.z;
        co_bear_.mesh_poses[0].orientation.x = msg->orientation.x;
        co_bear_.mesh_poses[0].orientation.y = msg->orientation.y;
        co_bear_.mesh_poses[0].orientation.z = msg->orientation.z;
        co_bear_.mesh_poses[0].orientation.w = msg->orientation.w;

        co_bear_.operation = moveit_msgs::CollisionObject::ADD;

        std::vector<moveit_msgs::CollisionObject> collision_vector;
        collision_vector.push_back(co_bear_);

        planning_scene_interface.applyCollisionObjects(collision_vector);
    }
}

void PickPlace::add_attached_obstacle(moveit_msgs::CollisionObject &co_)
{
    //once the object is know to be grasped
    //we remove obstacle from work scene
    co_.operation = moveit_msgs::CollisionObject::REMOVE;
    pub_co_.publish(co_);

    //and then we declare it as an attached obstacle
    aco_.object = co_;
    aco_.object.operation = moveit_msgs::CollisionObject::ADD;
    aco_.link_name = robot_type_ + "_end_effector";
    aco_.touch_links.push_back(robot_type_ + "_end_effector");
    aco_.touch_links.push_back(robot_type_ + "_link_finger_1");
    aco_.touch_links.push_back(robot_type_ + "_link_finger_2");
    aco_.touch_links.push_back(robot_type_ + "_link_finger_3");
    aco_.touch_links.push_back(robot_type_ + "_link_finger_tip_1");
    aco_.touch_links.push_back(robot_type_ + "_link_finger_tip_2");
    aco_.touch_links.push_back(robot_type_ + "_link_finger_tip_3");
    pub_aco_.publish(aco_);
}

void PickPlace::get_box_can_pose(const geometry_msgs::Pose::ConstPtr &msg)
{
    co_box_can_.id = "target_box_can";
    co_box_can_.meshes.resize(1);
    co_box_can_.mesh_poses.resize(1);

    co_box_can_.mesh_poses[0].position.x = msg->position.x;
    co_box_can_.mesh_poses[0].position.y = msg->position.y;
    co_box_can_.mesh_poses[0].position.z = msg->position.z;
    co_box_can_.mesh_poses[0].orientation.x = msg->orientation.x;
    co_box_can_.mesh_poses[0].orientation.y = msg->orientation.y;
    co_box_can_.mesh_poses[0].orientation.z = msg->orientation.z;
    co_box_can_.mesh_poses[0].orientation.w = msg->orientation.w;

    co_box_can_.operation = moveit_msgs::CollisionObject::ADD;

    std::vector<moveit_msgs::CollisionObject> collision_vector;
    collision_vector.push_back(co_box_can_);

    planning_scene_interface.applyCollisionObjects(collision_vector);
}

void PickPlace::get_box_cup_pose(const geometry_msgs::Pose::ConstPtr &msg)
{
    co_box_cup_.id = "target_box_cup";
    co_box_cup_.meshes.resize(1);
    co_box_cup_.mesh_poses.resize(1);

    co_box_cup_.mesh_poses[0].position.x = msg->position.x;
    co_box_cup_.mesh_poses[0].position.y = msg->position.y;
    co_box_cup_.mesh_poses[0].position.z = msg->position.z;
    co_box_cup_.mesh_poses[0].orientation.x = msg->orientation.x;
    co_box_cup_.mesh_poses[0].orientation.y = msg->orientation.y;
    co_box_cup_.mesh_poses[0].orientation.z = msg->orientation.z;
    co_box_cup_.mesh_poses[0].orientation.w = msg->orientation.w;

    co_box_cup_.operation = moveit_msgs::CollisionObject::ADD;

    std::vector<moveit_msgs::CollisionObject> collision_vector;
    collision_vector.push_back(co_box_cup_);

    planning_scene_interface.applyCollisionObjects(collision_vector);
}

void PickPlace::get_box_bear_pose(const geometry_msgs::Pose::ConstPtr &msg)
{
    co_box_bear_.id = "target_box_bear";
    co_box_bear_.meshes.resize(1);
    co_box_bear_.mesh_poses.resize(1);

    co_box_bear_.mesh_poses[0].position.x = msg->position.x;
    co_box_bear_.mesh_poses[0].position.y = msg->position.y;
    co_box_bear_.mesh_poses[0].position.z = msg->position.z;
    co_box_bear_.mesh_poses[0].orientation.x = msg->orientation.x;
    co_box_bear_.mesh_poses[0].orientation.y = msg->orientation.y;
    co_box_bear_.mesh_poses[0].orientation.z = msg->orientation.z;
    co_box_bear_.mesh_poses[0].orientation.w = msg->orientation.w;

    co_box_bear_.operation = moveit_msgs::CollisionObject::ADD;

    std::vector<moveit_msgs::CollisionObject> collision_vector;
    collision_vector.push_back(co_box_bear_);

    planning_scene_interface.applyCollisionObjects(collision_vector);
}

void PickPlace::get_table_target_pose(const geometry_msgs::Pose::ConstPtr &msg)
{
    co_table_target_.id = "target_table_target";
    co_table_target_.meshes.resize(1);
    co_table_target_.mesh_poses.resize(1);

    co_table_target_.mesh_poses[0].position.x = msg->position.x;
    co_table_target_.mesh_poses[0].position.y = msg->position.y;
    co_table_target_.mesh_poses[0].position.z = msg->position.z;
    co_table_target_.mesh_poses[0].orientation.x = msg->orientation.x;
    co_table_target_.mesh_poses[0].orientation.y = msg->orientation.y;
    co_table_target_.mesh_poses[0].orientation.z = msg->orientation.z;
    co_table_target_.mesh_poses[0].orientation.w = msg->orientation.w;

    co_table_target_.operation = moveit_msgs::CollisionObject::ADD;

    std::vector<moveit_msgs::CollisionObject> collision_vector;
    collision_vector.push_back(co_table_target_);

    planning_scene_interface.applyCollisionObjects(collision_vector);
}

void PickPlace::get_table_box_pose(const geometry_msgs::Pose::ConstPtr &msg)
{
    co_table_box_.id = "target_table_box";
    co_table_box_.meshes.resize(1);
    co_table_box_.mesh_poses.resize(1);

    co_table_box_.mesh_poses[0].position.x = msg->position.x;
    co_table_box_.mesh_poses[0].position.y = msg->position.y;
    co_table_box_.mesh_poses[0].position.z = msg->position.z;
    co_table_box_.mesh_poses[0].orientation.x = msg->orientation.x;
    co_table_box_.mesh_poses[0].orientation.y = msg->orientation.y;
    co_table_box_.mesh_poses[0].orientation.z = msg->orientation.z;
    co_table_box_.mesh_poses[0].orientation.w = msg->orientation.w;

    co_table_box_.operation = moveit_msgs::CollisionObject::ADD;

    std::vector<moveit_msgs::CollisionObject> collision_vector;
    collision_vector.push_back(co_table_box_);

    planning_scene_interface.applyCollisionObjects(collision_vector);
}

/**
 * @brief PickPlace::gripper_action
 * @param gripper_rad close for 6400 and open for 0.0
 * @return true is gripper motion reaches the goal
 */
bool PickPlace::gripper_action(double finger_turn)
{
    robot_state = 1; ////////
    if (robot_connected_ == false)
    {
        if (finger_turn > 0.5 * FINGER_MAX)
        {
            gripper_group_->setNamedTarget("Close");
        }
        else
        {
            gripper_group_->setNamedTarget("Open");
        }
        if (gripper_group_->move() == moveit_msgs::MoveItErrorCodes::SUCCESS)
        {
            while (robot_state)
            {
            }
            ros::WallDuration(2).sleep();
            return true;
        }
        else
            return false;
    }

    if (finger_turn < 0)
    {
        finger_turn = 0.0;
    }
    else
    {
        finger_turn = std::min(finger_turn, FINGER_MAX);
    }

    kinova_msgs::SetFingersPositionGoal goal;
    goal.fingers.finger1 = finger_turn;
    goal.fingers.finger2 = goal.fingers.finger1;
    goal.fingers.finger3 = goal.fingers.finger1;
    finger_client_->sendGoal(goal);

    if (finger_client_->waitForResult(ros::Duration(5.0)))
    {
        finger_client_->getResult();
        return true;
    }
    else
    {
        finger_client_->cancelAllGoals();
        ROS_WARN_STREAM("The gripper action timed-out");
        return false;
    }
}

void PickPlace::add_bear()
{
    co_bear_.id = "target_bear";
    co_bear_.header.frame_id = "root";
    shapes::Mesh *m = shapes::createMeshFromResource("package://kinova_description/meshes/export/bear.stl");
    shape_msgs::Mesh mesh;
    shapes::ShapeMsg mesh_msg;
    shapes::constructMsgFromShape(m, mesh_msg);
    mesh = boost::get<shape_msgs::Mesh>(mesh_msg);

    co_bear_.meshes.resize(1);
    co_bear_.mesh_poses.resize(1);
    co_bear_.meshes[0] = mesh;

    co_bear_.mesh_poses[0].position.x = 0; //초기 위치값을 임시로 0으로 줬음
    co_bear_.mesh_poses[0].position.y = 0;
    co_bear_.mesh_poses[0].position.z = -1000;

    co_bear_.meshes.push_back(mesh);
    co_bear_.mesh_poses.push_back(co_bear_.mesh_poses[0]);
    co_bear_.operation = moveit_msgs::CollisionObject::ADD; //mesh를 add하겠다는 명령

    std::vector<moveit_msgs::CollisionObject> collision_vector;
    collision_vector.push_back(co_bear_);

    planning_scene_interface.applyCollisionObjects(collision_vector); //rviz화면에 나타내주는 함수

    ROS_INFO("bear added into the world");
    pub_co_.publish(co_bear_);
}

void PickPlace::add_cup()
{
    co_cup_.id = "target_cup";
    co_cup_.header.frame_id = "root";
    shapes::Mesh *m = shapes::createMeshFromResource("package://kinova_description/meshes/export/cup.stl");
    shape_msgs::Mesh mesh;
    shapes::ShapeMsg mesh_msg;
    shapes::constructMsgFromShape(m, mesh_msg);
    mesh = boost::get<shape_msgs::Mesh>(mesh_msg);

    co_cup_.meshes.resize(1);
    co_cup_.mesh_poses.resize(1);
    co_cup_.meshes[0] = mesh;

    co_cup_.mesh_poses[0].position.x = 0; //초기 위치값을 임시로 0으로 줬음
    co_cup_.mesh_poses[0].position.y = 0;
    co_cup_.mesh_poses[0].position.z = -1000;

    co_cup_.meshes.push_back(mesh);
    co_cup_.mesh_poses.push_back(co_cup_.mesh_poses[0]);
    co_cup_.operation = moveit_msgs::CollisionObject::ADD; //mesh를 add하겠다는 명령

    std::vector<moveit_msgs::CollisionObject> collision_vector;
    collision_vector.push_back(co_cup_);

    planning_scene_interface.applyCollisionObjects(collision_vector); //rviz화면에 나타내주는 함수
    ROS_INFO("cup added into the world");
    pub_co_.publish(co_cup_);
}

void PickPlace::add_can()
{
    co_can_.id = "target_can";
    co_can_.header.frame_id = "root";
    shapes::Mesh *m = shapes::createMeshFromResource("package://kinova_description/meshes/export/can.stl");
    shape_msgs::Mesh mesh;
    shapes::ShapeMsg mesh_msg;
    shapes::constructMsgFromShape(m, mesh_msg);
    mesh = boost::get<shape_msgs::Mesh>(mesh_msg);

    co_can_.meshes.resize(1);
    co_can_.mesh_poses.resize(1);
    co_can_.meshes[0] = mesh;

    co_can_.mesh_poses[0].position.x = 0; //초기 위치값을 임시로 0으로 줬음
    co_can_.mesh_poses[0].position.y = 0;
    co_can_.mesh_poses[0].position.z = -1000;

    co_can_.meshes.push_back(mesh);
    co_can_.mesh_poses.push_back(co_can_.mesh_poses[0]);
    co_can_.operation = moveit_msgs::CollisionObject::ADD; //mesh를 add하겠다는 명령

    std::vector<moveit_msgs::CollisionObject> collision_vector;
    collision_vector.push_back(co_can_);

    planning_scene_interface.applyCollisionObjects(collision_vector); //rviz화면에 나타내주는 함수

    //planning_scene_msg_.world.collision_objects.push_back(co_can_);
    //planning_scene_msg_.is_diff = true;
    //pub_planning_scene_diff_.publish(planning_scene_msg_);

    ROS_INFO("can added into the world");
    pub_co_.publish(co_can_);
}

void PickPlace::add_box_bear()
{
    co_box_bear_.id = "target_box_bear";
    co_box_bear_.header.frame_id = "root";
    shapes::Mesh *m = shapes::createMeshFromResource("package://kinova_description/meshes/export/box_bear.stl");
    shape_msgs::Mesh mesh;
    shapes::ShapeMsg mesh_msg;
    shapes::constructMsgFromShape(m, mesh_msg);
    mesh = boost::get<shape_msgs::Mesh>(mesh_msg);

    co_box_bear_.meshes.resize(1);
    co_box_bear_.mesh_poses.resize(1);
    co_box_bear_.meshes[0] = mesh;

    co_box_bear_.mesh_poses[0].position.x = 0; //초기 위치값을 임시로 0으로 줬음
    co_box_bear_.mesh_poses[0].position.y = 0;
    co_box_bear_.mesh_poses[0].position.z = -1000;

    co_box_bear_.meshes.push_back(mesh);
    co_box_bear_.mesh_poses.push_back(co_box_bear_.mesh_poses[0]);
    co_box_bear_.operation = moveit_msgs::CollisionObject::ADD; //mesh를 add하겠다는 명령

    std::vector<moveit_msgs::CollisionObject> collision_vector;
    collision_vector.push_back(co_box_bear_);

    planning_scene_interface.applyCollisionObjects(collision_vector); //rviz화면에 나타내주는 함수
    ROS_INFO("box_bear added into the world");
    pub_co_.publish(co_box_bear_);
}

void PickPlace::add_box_cup()
{
    co_box_cup_.id = "target_box_cup";
    co_box_cup_.header.frame_id = "root";
    shapes::Mesh *m = shapes::createMeshFromResource("package://kinova_description/meshes/export/box_cup.stl");
    shape_msgs::Mesh mesh;
    shapes::ShapeMsg mesh_msg;
    shapes::constructMsgFromShape(m, mesh_msg);
    mesh = boost::get<shape_msgs::Mesh>(mesh_msg);

    co_box_cup_.meshes.resize(1);
    co_box_cup_.mesh_poses.resize(1);
    co_box_cup_.meshes[0] = mesh;

    co_box_cup_.mesh_poses[0].position.x = 0; //초기 위치값을 임시로 0으로 줬음
    co_box_cup_.mesh_poses[0].position.y = 0;
    co_box_cup_.mesh_poses[0].position.z = -1000;

    co_box_cup_.meshes.push_back(mesh);
    co_box_cup_.mesh_poses.push_back(co_box_cup_.mesh_poses[0]);
    co_box_cup_.operation = moveit_msgs::CollisionObject::ADD; //mesh를 add하겠다는 명령

    std::vector<moveit_msgs::CollisionObject> collision_vector;
    collision_vector.push_back(co_box_cup_);

    planning_scene_interface.applyCollisionObjects(collision_vector); //rviz화면에 나타내주는 함수
    ROS_INFO("box_cup added into the world");
    pub_co_.publish(co_box_cup_);
}

void PickPlace::add_box_can()
{
    co_box_can_.id = "target_box_can";
    co_box_can_.header.frame_id = "root";
    shapes::Mesh *m = shapes::createMeshFromResource("package://kinova_description/meshes/export/box_can.stl");
    shape_msgs::Mesh mesh;
    shapes::ShapeMsg mesh_msg;
    shapes::constructMsgFromShape(m, mesh_msg);
    mesh = boost::get<shape_msgs::Mesh>(mesh_msg);

    co_box_can_.meshes.resize(1);
    co_box_can_.mesh_poses.resize(1);
    co_box_can_.meshes[0] = mesh;

    co_box_can_.mesh_poses[0].position.x = 0; //초기 위치값을 임시로 0으로 줬음
    co_box_can_.mesh_poses[0].position.y = 0;
    co_box_can_.mesh_poses[0].position.z = -1000;

    co_box_can_.meshes.push_back(mesh);
    co_box_can_.mesh_poses.push_back(co_box_can_.mesh_poses[0]);
    co_box_can_.operation = moveit_msgs::CollisionObject::ADD; //mesh를 add하겠다는 명령

    std::vector<moveit_msgs::CollisionObject> collision_vector;
    collision_vector.push_back(co_box_can_);

    planning_scene_interface.applyCollisionObjects(collision_vector); //rviz화면에 나타내주는 함수
    ROS_INFO("box_can added into the world");
    pub_co_.publish(co_box_can_);
}

void PickPlace::add_table_target()
{
    co_table_target_.id = "target_table_target";
    co_table_target_.header.frame_id = "root";
    shapes::Mesh *m = shapes::createMeshFromResource("package://kinova_description/meshes/export/table_target.stl");
    shape_msgs::Mesh mesh;
    shapes::ShapeMsg mesh_msg;
    shapes::constructMsgFromShape(m, mesh_msg);
    mesh = boost::get<shape_msgs::Mesh>(mesh_msg);

    co_table_target_.meshes.resize(1);
    co_table_target_.mesh_poses.resize(1);
    co_table_target_.meshes[0] = mesh;

    co_table_target_.mesh_poses[0].position.x = 0; //초기 위치값을 임시로 0으로 줬음
    co_table_target_.mesh_poses[0].position.y = 0;
    co_table_target_.mesh_poses[0].position.z = -1000;

    co_table_target_.meshes.push_back(mesh);
    co_table_target_.mesh_poses.push_back(co_table_target_.mesh_poses[0]);
    co_table_target_.operation = moveit_msgs::CollisionObject::ADD; //mesh를 add하겠다는 명령

    std::vector<moveit_msgs::CollisionObject> collision_vector;
    collision_vector.push_back(co_table_target_);

    planning_scene_interface.applyCollisionObjects(collision_vector); //rviz화면에 나타내주는 함수
    ROS_INFO("box_can added into the world");
    pub_co_.publish(co_table_target_);
}

void PickPlace::add_table_box()
{
    co_table_box_.id = "target_table_box";
    co_table_box_.header.frame_id = "root";
    shapes::Mesh *m = shapes::createMeshFromResource("package://kinova_description/meshes/export/table_box.stl");
    shape_msgs::Mesh mesh;
    shapes::ShapeMsg mesh_msg;
    shapes::constructMsgFromShape(m, mesh_msg);
    mesh = boost::get<shape_msgs::Mesh>(mesh_msg);

    co_table_box_.meshes.resize(1);
    co_table_box_.mesh_poses.resize(1);
    co_table_box_.meshes[0] = mesh;

    co_table_box_.mesh_poses[0].position.x = 0; //초기 위치값을 임시로 0으로 줬음
    co_table_box_.mesh_poses[0].position.y = 0;
    co_table_box_.mesh_poses[0].position.z = -1000;

    co_table_box_.meshes.push_back(mesh);
    co_table_box_.mesh_poses.push_back(co_table_box_.mesh_poses[0]);
    co_table_box_.operation = moveit_msgs::CollisionObject::ADD; //mesh를 add하겠다는 명령

    std::vector<moveit_msgs::CollisionObject> collision_vector;
    collision_vector.push_back(co_table_box_);

    planning_scene_interface.applyCollisionObjects(collision_vector); //rviz화면에 나타내주는 함수
    ROS_INFO("box_can added into the world");
    pub_co_.publish(co_table_box_);
}

void PickPlace::add_target()
{
    add_bear();
    add_can();
    add_cup();
    add_box_bear();
    add_box_can();
    add_box_cup();
    add_table_target();
    add_table_box();
}

void PickPlace::setup_constrain(geometry_msgs::Pose target_pose, bool orientation, bool position)
{
    if ( (!orientation) && (!position) )
    {
        ROS_WARN("Neither orientation nor position constrain applied.");
        return;
    }

    moveit_msgs::Constraints grasp_constrains;

    // setup constrains
    moveit_msgs::OrientationConstraint ocm;
    ocm.link_name = robot_type_ + "_end_effector";
    ocm.header.frame_id = "root";
    ocm.orientation = target_pose.orientation;
    ocm.absolute_x_axis_tolerance = 2*M_PI;
    ocm.absolute_y_axis_tolerance = 2*M_PI;
    ocm.absolute_z_axis_tolerance = M_PI/10;
    ocm.weight = 0.5;
    if (orientation)
    {
        grasp_constrains.orientation_constraints.push_back(ocm);
    }


    /* Define position constrain box based on current pose and target pose. */
    shape_msgs::SolidPrimitive primitive;
    primitive.type = primitive.BOX;
    primitive.dimensions.resize(3);

    // group_->getCurrentPose() does not work.
//    current_pose_ = group_->getCurrentPose();
    geometry_msgs::Pose current_pose;
    { // scope for mutex update
        boost::mutex::scoped_lock lock_pose(mutex_pose_);
        current_pose = current_pose_.pose;
//        ROS_DEBUG_STREAM(__PRETTY_FUNCTION__ << ": LINE: " << __LINE__ << ": " << "current_pose_: x " << current_pose_.pose.position.x  << ", y " << current_pose_.pose.position.y  << ", z " << current_pose_.pose.position.z  << ", qx " << current_pose_.pose.orientation.x  << ", qy " << current_pose_.pose.orientation.y  << ", qz " << current_pose_.pose.orientation.z  << ", qw " << current_pose_.pose.orientation.w );
    }

    double constrain_box_scale = 2.0;
    primitive.dimensions[0] = constrain_box_scale * std::abs(target_pose.position.x - current_pose.position.x);
    primitive.dimensions[1] = constrain_box_scale * std::abs(target_pose.position.y - current_pose.position.y);
    primitive.dimensions[2] = constrain_box_scale * std::abs(target_pose.position.z - current_pose.position.z);

    /* A pose for the box (specified relative to frame_id) */
    geometry_msgs::Pose box_pose;
    box_pose.orientation.w = 1.0;
    // place between start point and goal point.
    box_pose.position.x = (target_pose.position.x + current_pose.position.x)/2.0;
    box_pose.position.y = (target_pose.position.y + current_pose.position.y)/2.0;
    box_pose.position.z = (target_pose.position.z + current_pose.position.z)/2.0;

    moveit_msgs::PositionConstraint pcm;
    pcm.link_name = robot_type_+"_end_effector";
    pcm.header.frame_id = "root";
    pcm.constraint_region.primitives.push_back(primitive);
    pcm.constraint_region.primitive_poses.push_back(box_pose);
    pcm.weight = 0.5;
    if(position)
    {
        grasp_constrains.position_constraints.push_back(pcm);
    }

    group_->setPathConstraints(grasp_constrains);


//    // The bellowing code is just for visulizing the box and check.
//    // Disable this part after checking.
    moveit_msgs::CollisionObject co_;

    co_.id = "check_constrain";
    co_.operation = moveit_msgs::CollisionObject::REMOVE;
    pub_co_.publish(co_);

    co_.operation = moveit_msgs::CollisionObject::ADD;
    co_.primitives.push_back(primitive);
    co_.primitive_poses.push_back(box_pose);
    pub_co_.publish(co_);
    planning_scene_msg_.world.collision_objects.push_back(co_);
    planning_scene_msg_.is_diff = true;
    pub_planning_scene_diff_.publish(planning_scene_msg_);
    ros::WallDuration(0.1).sleep();
}

void PickPlace::define_cartesian_pose()
{
    tf::Quaternion q;

    // define start pose before grasp
    //TODO: find orientation
    start_pose_.header.frame_id = "root";
    start_pose_.header.stamp = ros::Time::now();
    start_pose_.pose.orientation = tf::createQuaternionMsgFromRollPitchYaw(-1.205884, -2.902540, -1.208770);

    start_pose_.pose.position.x = co_cup_.mesh_poses[0].position.x - 0.1212;
    start_pose_.pose.position.y = co_cup_.mesh_poses[0].position.y;
    start_pose_.pose.position.z = co_cup_.mesh_poses[0].position.z;

    can_pregrasp_pose_.header.frame_id = "root";
    can_pregrasp_pose_.header.stamp = ros::Time::now();

    can_pregrasp_pose_.pose.orientation = tf::createQuaternionMsgFromRollPitchYaw(PI, PI, PI);
    can_pregrasp_pose_.pose.position.x = co_cup_.mesh_poses[0].position.x - 0.216088;
    can_pregrasp_pose_.pose.position.y = co_cup_.mesh_poses[0].position.y;
    can_pregrasp_pose_.pose.position.z = co_cup_.mesh_poses[0].position.z;

    can_grasp_pose_.header.frame_id = "root";
    can_grasp_pose_.header.stamp = ros::Time::now();
    can_grasp_pose_.pose.orientation = tf::createQuaternionMsgFromRollPitchYaw(PI, PI, PI);

    can_grasp_pose_.pose.position.x = co_cup_.mesh_poses[0].position.x - 0.018876;
    can_grasp_pose_.pose.position.y = co_cup_.mesh_poses[0].position.y + 0.015206;
    can_grasp_pose_.pose.position.z = co_cup_.mesh_poses[0].position.z;
}

void PickPlace::define_joint_values()
{
    double hpi = 1.570796;

    start_joint_.resize(joint_names_.size());
    start_joint_[0] = 0.0;
    start_joint_[1] = 3.1415;
    start_joint_[2] = 3.1415;
    start_joint_[3] = 0.0;
    start_joint_[4] = 0.0;
    start_joint_[5] = 0.0;

    //can_joint############################################################
    //pregrasp
    can_pregrasp_joint_.resize(joint_names_.size());
    can_pregrasp_joint_[0] = -1.242659;
    can_pregrasp_joint_[1] = 1.364195;
    can_pregrasp_joint_[2] = 1.081056;
    can_pregrasp_joint_[3] = -2.543487;
    can_pregrasp_joint_[4] = 1.961130;
    can_pregrasp_joint_[5] = 2.768767;

    //grasp
    can_grasp_joint_.resize(joint_names_.size());
    can_grasp_joint_[0] = -0.82903122222;
    can_grasp_joint_[1] = 1.368418;
    can_grasp_joint_[2] = 1.564578;
    can_grasp_joint_[3] = -2.833139;
    can_grasp_joint_[4] = 1.754990;
    can_grasp_joint_[5] = 2.544225;

    //grasp_back
    can_grasp_back_joint_.resize(joint_names_.size());
    can_grasp_back_joint_[0] = -0.82903122222;
    can_grasp_back_joint_[1] = 2.065600;
    can_grasp_back_joint_[2] = 2.229508;
    can_grasp_back_joint_[3] = -2.833139;
    can_grasp_back_joint_[4] = 1.754990;
    can_grasp_back_joint_[5] = 2.544225;

    //postgrasp
    can_postgrasp_joint_.resize(joint_names_.size());
    can_postgrasp_joint_[0] = 1.025663;
    can_postgrasp_joint_[1] = 2.255360;
    can_postgrasp_joint_[2] = 3.118780;
    can_postgrasp_joint_[3] = -2.870229;
    can_postgrasp_joint_[4] = 0.785863;
    can_postgrasp_joint_[5] = 2.620298;

    //release
    can_release_joint_.resize(joint_names_.size());
    can_release_joint_[0] = 1.037979;
    can_release_joint_[1] = 2.007268;
    can_release_joint_[2] = 2.910167;
    can_release_joint_[3] = -2.790771;
    can_release_joint_[4] = 0.837867;
    can_release_joint_[5] = 2.638082;

    //postrelease
    can_postrelease_joint_.resize(joint_names_.size());
    can_postrelease_joint_[0] = 0.857511;
    can_postrelease_joint_[1] = 2.644226;
    can_postrelease_joint_[2] = 3.821042;
    can_postrelease_joint_[3] = -2.412823;
    can_postrelease_joint_[4] = 0.880464;
    can_postrelease_joint_[5] = 2.184843;

    //cup_joint############################################################
    //pregrasp
    cup_pregrasp_joint_.resize(joint_names_.size());
    cup_pregrasp_joint_[0] = 0.2962150573;
    cup_pregrasp_joint_[1] = 3.1337811946;
    cup_pregrasp_joint_[2] = 5.485594749;
    cup_pregrasp_joint_[3] = 0.183734178;
    cup_pregrasp_joint_[4] = 0.9149947166;
    cup_pregrasp_joint_[5] = -0.5389575;

    //grasp
    cup_grasp_joint_.resize(joint_names_.size());
    cup_grasp_joint_[0] = 0.145792484;
    cup_grasp_joint_[1] = 2.81678366;
    cup_grasp_joint_[2] = 5.13907480;
    cup_grasp_joint_[3] = 0.00122094;
    cup_grasp_joint_[4] = 0.84088325;
    cup_grasp_joint_[5] = -0.3810632;

    /*/postgrasp
    cup_postgrasp_joint_.resize(joint_names_.size());
    cup_postgrasp_joint_[0] = 0.120525836944;
    cup_postgrasp_joint_[1] = 3.0260353088;
    cup_postgrasp_joint_[2] = 4.9346609115;
    cup_postgrasp_joint_[3] = 0.2716214656;
    cup_postgrasp_joint_[4] = 0.391327857971;
    cup_postgrasp_joint_[5] = -0.447357892990;*/

    cup_postgrasp_joint_.resize(joint_names_.size());
    cup_postgrasp_joint_[0] = 0.08726644444;
    cup_postgrasp_joint_[1] = 2.792526222;
    cup_postgrasp_joint_[2] = 3.675209999084;
    cup_postgrasp_joint_[3] = 0.2103869915008;
    cup_postgrasp_joint_[4] = -0.36006116867;
    cup_postgrasp_joint_[5] = -0.04069089889;

    cup_prerelease_joint_.resize(joint_names_.size());
    cup_prerelease_joint_[0] = 1.646394252777;
    cup_prerelease_joint_[1] = 2.792526222;
    cup_prerelease_joint_[2] = 3.675209999084;
    cup_prerelease_joint_[3] = 0.2103869915008;
    cup_prerelease_joint_[4] = -0.36006116867;
    cup_prerelease_joint_[5] = -0.04069089889;

    //release
    cup_release_joint_.resize(joint_names_.size());
    cup_release_joint_[0] = 1.646394252777;
    cup_release_joint_[1] = 2.39790153503;
    cup_release_joint_[2] = 3.675209999084;
    cup_release_joint_[3] = 0.2103869915008;
    cup_release_joint_[4] = -0.36006116867;
    cup_release_joint_[5] = -0.04069089889;

    cup_postrelease_joint_.resize(joint_names_.size());
    cup_postrelease_joint_[0] = 1.3763864040;
    cup_postrelease_joint_[1] = 3.336081266403;
    cup_postrelease_joint_[2] = 4.75912094116;
    cup_postrelease_joint_[3] = 1.19493818283;
    cup_postrelease_joint_[4] = -0.401210069656;
    cup_postrelease_joint_[5] = -0.988783836;

    //bear_joint############################################################
    //pregrasp
    bear_pregrasp_joint_.resize(joint_names_.size());
    bear_pregrasp_joint_[0] = 0.939930;
    bear_pregrasp_joint_[1] = 3.038258;
    bear_pregrasp_joint_[2] = 4.864327;
    bear_pregrasp_joint_[3] = 1.128681;
    bear_pregrasp_joint_[4] = 1.128986;
    bear_pregrasp_joint_[5] = -1.5738027;

    //grasp
    bear_grasp_joint_.resize(joint_names_.size());
    bear_grasp_joint_[0] = 0.614193;
    bear_grasp_joint_[1] = 2.715790;
    bear_grasp_joint_[2] = 4.518429;
    bear_grasp_joint_[3] = 1.123657;
    bear_grasp_joint_[4] = 0.753592;
    bear_grasp_joint_[5] = -1.409765;

    //postgrasp
    bear_postgrasp_joint_.resize(joint_names_.size());
    bear_postgrasp_joint_[0] = -1.0090332;
    bear_postgrasp_joint_[1] = 4.13670921;
    bear_postgrasp_joint_[2] = 3.274328;
    bear_postgrasp_joint_[3] = 2.6295967;
    bear_postgrasp_joint_[4] = -0.999928;
    bear_postgrasp_joint_[5] = 0.9886407;

    //release
    bear_release_joint_.resize(joint_names_.size());
    bear_release_joint_[0] = -1.07266306;
    bear_release_joint_[1] = 4.1951637;
    bear_release_joint_[2] = 3.07328033;
    bear_release_joint_[3] = 2.4194917;
    bear_release_joint_[4] = -0.747298717;
    bear_release_joint_[5] = 1.10968589;

    bear_postrelease_joint_.resize(joint_names_.size());
    bear_postrelease_joint_[0] = -1.0320470;
    bear_postrelease_joint_[1] = 4.0410747;
    bear_postrelease_joint_[2] = 3.03789687;
    bear_postrelease_joint_[3] = 2.51737356;
    bear_postrelease_joint_[4] = -0.8685598;
    bear_postrelease_joint_[5] = 1.03555941;
}

bool PickPlace::evaluate_plan(moveit::planning_interface::MoveGroup &group)
{
    int time = 15; //timer
    int count = 0;
    double plan_time;
    robot_state = 1;
    moveit::planning_interface::MoveGroup::Plan my_plan;

    result_ = moveit_msgs::MoveItErrorCodes::PLANNING_FAILED;

    // try to find a success plan.

    while (result_ != moveit_msgs::MoveItErrorCodes::SUCCESS && count < 5)
    {
        count++;
        plan_time = 20 + count * 10;
        ROS_INFO("Setting plan time to %f sec", plan_time);
        group.setPlanningTime(plan_time);
        result_ = group.plan(my_plan);
        std::cout << "at attemp: " << count << std::endl;
        ros::WallDuration(0.1).sleep();
    }

    // found a plan
    if (result_ == moveit_msgs::MoveItErrorCodes::SUCCESS)
    {
        std::cout << "plan success at attemp: " << count << std::endl;
        group.execute(my_plan);
        //std::cin >> pause_;
        while (robot_state)
        {
            ros::WallDuration(1.0).sleep();
            time--;
            if (time <= 0)
                return false;
        }
    }
    else // not found
    {
        std::cout << "Exit since plan failed until reach maximum attemp: " << count << std::endl;
        return false;
    }

    ros::WallDuration(1).sleep();
    return true;
}

bool PickPlace::move_can()
{
    std::cout << "Move can...\n";
    std::cin >> pause_;
    ROS_INFO_STREAM("Planning to go to pregrasp pose ...");
    group_->setJointValueTarget(can_pregrasp_joint_);
    target_joint = can_pregrasp_joint_;
    if (!evaluate_plan(*group_))
        return false;

    std::cin >> pause_;
    ROS_INFO_STREAM("Approaching grasp position ...");
    group_->setJointValueTarget(can_grasp_joint_);
    target_joint = can_grasp_joint_;
    if (!evaluate_plan(*group_))
        return false;

    can_grasp = 1;
    std::cin >> pause_;
    ROS_INFO_STREAM("Grasping ...");
    //add_attached_obstacle();
    gripper_action(0.70 * FINGER_MAX); // partially close
    ros::WallDuration(1.0).sleep();

    std::cin >> pause_;
    ROS_INFO_STREAM("Planning to go to up pose ...");
    group_->setJointValueTarget(can_grasp_back_joint_);
    target_joint = can_grasp_back_joint_;
    if (!evaluate_plan(*group_))
        return false;

    std::cin >> pause_;
    ROS_INFO_STREAM("Planning to go to postgrasp pose ...");
    group_->setJointValueTarget(can_postgrasp_joint_);
    target_joint = can_postgrasp_joint_;
    if (!evaluate_plan(*group_))
        return false;

    std::cin >> pause_;
    ROS_INFO_STREAM("Planning to go to down position ...");
    group_->setJointValueTarget(can_release_joint_);
    target_joint = can_release_joint_;
    if (!evaluate_plan(*group_))
        return false;

    std::cin >> pause_;
    can_grasp = 0;
    ROS_INFO_STREAM("Releasing ...");
    gripper_action(0.0); // full open
    ros::WallDuration(1.0).sleep();

    std::cin >> pause_;
    ROS_INFO_STREAM("Planning to go to another position ...");
    group_->setJointValueTarget(can_postrelease_joint_);
    target_joint = can_postrelease_joint_;
    if (!evaluate_plan(*group_))
        return false;

    std::cin >> pause_;
    ROS_INFO_STREAM("Planning to go to another position ...");
    group_->setJointValueTarget(start_joint_);
    target_joint = start_joint_;
    if (!evaluate_plan(*group_))
        return false;

    return true;
}

bool PickPlace::move_cup()
{
    std::cout << "Move cup...\n";
    ROS_INFO_STREAM("Planning to go to pregrasp pose ...");
    group_->setJointValueTarget(cup_pregrasp_joint_);
    target_joint = cup_pregrasp_joint_;
    if (!evaluate_plan(*group_))
        return false;

    ROS_INFO_STREAM("Approaching grasp position ...");
    group_->setJointValueTarget(cup_grasp_joint_);
    target_joint = cup_grasp_joint_;
    if (!evaluate_plan(*group_))
        return false;

    cup_grasp = 1;
    ROS_INFO_STREAM("Grasping ...");
    //add_attached_obstacle();
    gripper_action(0.75 * FINGER_MAX); // partially close
    ros::WallDuration(1.0).sleep();

    ROS_INFO_STREAM("Planning to go to postgrasp pose ...");
    group_->setJointValueTarget(cup_postgrasp_joint_);
    target_joint = cup_postgrasp_joint_;
    if (!evaluate_plan(*group_))
        return false;

    ROS_INFO_STREAM("Planning to go to postgrasp pose ...");
    group_->setJointValueTarget(cup_prerelease_joint_);
    target_joint = cup_prerelease_joint_;
    if (!evaluate_plan(*group_))
        return false;

    ROS_INFO_STREAM("Planning to go to down position ...");
    group_->setJointValueTarget(cup_release_joint_);
    target_joint = cup_release_joint_;
    if (!evaluate_plan(*group_))
        return false;

    cup_grasp = 0;
    ROS_INFO_STREAM("Releasing ...");
    gripper_action(0.0); // full open
    ros::WallDuration(1.0).sleep();

    ROS_INFO_STREAM("Planning to go to another position ...");
    group_->setJointValueTarget(cup_postrelease_joint_);
    target_joint = cup_postrelease_joint_;
    if (!evaluate_plan(*group_))
        return false;

    ROS_INFO_STREAM("Planning to go to another position ...");
    group_->setJointValueTarget(start_joint_);
    target_joint = start_joint_;
    if (!evaluate_plan(*group_))
        return false;

    return true;
}

bool PickPlace::move_bear()
{
    std::cout << "Move bear...\n";
    ROS_INFO_STREAM("Planning to go to pregrasp pose ...");
    group_->setJointValueTarget(bear_pregrasp_joint_);
    target_joint = bear_pregrasp_joint_;
    if (!evaluate_plan(*group_))
        return false;

    ROS_INFO_STREAM("Approaching grasp position ...");
    group_->setJointValueTarget(bear_grasp_joint_);
    target_joint = bear_grasp_joint_;
    if (!evaluate_plan(*group_))
        return false;

    bear_grasp = 1;
    ROS_INFO_STREAM("Grasping ...");
    //add_attached_obstacle();
    gripper_action(0.75 * FINGER_MAX); // partially close
    ros::WallDuration(1.0).sleep();

    ROS_INFO_STREAM("Planning to go to postgrasp pose ...");
    group_->setJointValueTarget(bear_postgrasp_joint_);
    target_joint = bear_postgrasp_joint_;
    if (!evaluate_plan(*group_))
        return false;

    ROS_INFO_STREAM("Planning to go to down position ...");
    group_->setJointValueTarget(bear_release_joint_);
    target_joint = bear_release_joint_;
    if (!evaluate_plan(*group_))
        return false;

    bear_grasp = 0;
    ROS_INFO_STREAM("Releasing ...");
    gripper_action(0.0); // full open
    ros::WallDuration(1.0).sleep();

    ROS_INFO_STREAM("Planning to go to another position ...");
    group_->setJointValueTarget(bear_postrelease_joint_);
    target_joint = bear_postrelease_joint_;
    if (!evaluate_plan(*group_))
        return false;

    ROS_INFO_STREAM("Planning to go to another position ...");
    group_->setJointValueTarget(start_joint_);
    target_joint = start_joint_;
    if (!evaluate_plan(*group_))
        return false;

    return true;
}

bool PickPlace::my_pick()
{
    bool is_can_moved = false;
    bool is_cup_moved = false;
    bool is_bear_moved = false;

    add_target();
    ros::WallDuration(1.0).sleep();

    std::cout << "Please start simulation on V-rep.\nIf you ready, press any key...";
    std::cin >> pause_;

    ROS_INFO_STREAM("Planning to go to start pose ...");
    group_->setJointValueTarget(start_joint_);
    target_joint = start_joint_;
    evaluate_plan(*group_);

    while ((!is_can_moved || !is_cup_moved) || !is_bear_moved)
    {
        std::cout << "Please input the character you want to move(a:can, u:cup, b:bear, e:exit): ";
        std::cin >> object_;
        if (object_ == "a")
            if (!is_can_moved)
            {
                is_can_moved = true;
                if (!move_can())
                {
                    ROS_INFO("CAN MOVE FAIL!!");
                    return false;
                }
            }
            else
                std::cout << "Can is already moved!\n";
        else if (object_ == "u")
            if (!is_cup_moved)
            {
                is_cup_moved = true;
                if (!move_cup())
                {
                    ROS_INFO("CUP MOVE FAIL!!");
                    return false;
                }
            }
            else
                std::cout << "Cup is already moved!\n";
        else if (object_ == "b")
            if (!is_bear_moved)
            {
                is_bear_moved = true;
                if (!move_bear())
                {
                    ROS_INFO("BEAR MOVE FAIL!!");
                    return false;
                }
            }
            else
                std::cout << "Bear is already moved!\n";
        else if (object_ == "k")
        {
            group_->setPoseTarget(start_pose_);
            std::cout << "x : " << start_pose_.pose.position.x << " y : " << start_pose_.pose.position.y << " z : " << start_pose_.pose.position.z << "\n";
            evaluate_plan(*group_);
        }
        else if (object_ == "x")
        {
            group_->setJointValueTarget(cup_pregrasp_joint_);
            target_joint = cup_pregrasp_joint_;
            evaluate_plan(*group_);
        }
        else if (object_ == "n")
        {
            std::cout << "Move can...\n";
            ROS_INFO_STREAM("Planning to go to pregrasp pose ...");
            group_->setPoseTarget(can_pregrasp_pose_);
            evaluate_plan(*group_);

            setup_constrain(can_grasp_pose_.pose, false, true);

            ROS_INFO_STREAM("Approaching grasp position ...");
            group_->setPoseTarget(can_grasp_pose_);
            evaluate_plan(*group_);

                can_grasp = 1;
            ROS_INFO_STREAM("Grasping ...");
            gripper_action(0.70 * FINGER_MAX); // partially close
            ros::WallDuration(1.0).sleep();
        }
        else if (object_ == "e")
            break;
        else
            std::cout << "Invalid input!\n";
    }

    ROS_INFO_STREAM("finish! Press any key to quit ...");
    std::cin >> pause_;
    return true;
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "pick_place_demo");
    ros::NodeHandle node;
    ros::AsyncSpinner spinner(4);
    spinner.start();

    kinova::PickPlace pick_place(node);
    return 0;
}
