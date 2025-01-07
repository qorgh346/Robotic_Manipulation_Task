#include <pick_place.h>
#include <ros/console.h>

#include <tf_conversions/tf_eigen.h>


const double FINGER_MAX = 2;

using namespace kinova;

PickPlace::PickPlace(ros::NodeHandle &nh) : nh_(nh)
{
    ros::NodeHandle pn("~");
    nh_.param<std::string>("/robot_type", robot_type_, "j2n6s300");
    nh_.param<bool>("/robot_connected", robot_connected_, false);

    sub_joint_ = nh_.subscribe<sensor_msgs::JointState>("/j2n6s300/joint_states", 1, &PickPlace::get_current_state, this);

    sub_arm_action_goal_ = nh_.subscribe<rosjava_custom_srv::ActionGoalMsg>("/arm_action_cmd", 10, &PickPlace::arm_action_cb, this);
    sub_gripper_action_goal_ = nh_.subscribe<rosjava_custom_srv::ActionGoalMsg>("/gripper_action_cmd", 10, &PickPlace::gripper_action_cb, this);
    sub_arm_action_state_ = nh_.subscribe<moveit_msgs::MoveGroupActionFeedback>("/move_group/feedback", 1, &PickPlace::arm_action_state_cb, this);
    sub_finger_action_state_ = nh_.subscribe<control_msgs::FollowJointTrajectoryActionFeedback>("/j2n6s300/effort_finger_trajectory_controller/follow_joint_trajectory/feedback", 1, &PickPlace::finger_action_state_cb, this);

    sub_robot_state_ = nh.subscribe<std_msgs::Int32>("/vrep_ros_interface/grasp", 1, &PickPlace::get_robot_state, this);
    can_posi_ = nh.subscribe<geometry_msgs::Pose>("/vrep_ros_interface/can_pose", 1, &PickPlace::get_can_pose, this);
    cup_posi_ = nh.subscribe<geometry_msgs::Pose>("/vrep_ros_interface/cup_pose", 1, &PickPlace::get_cup_pose, this);
    bear_posi_ = nh.subscribe<geometry_msgs::Pose>("/vrep_ros_interface/bear_pose", 1, &PickPlace::get_bear_pose, this);
    box_can_posi_ = nh.subscribe<geometry_msgs::Pose>("/vrep_ros_interface/box_can_pose", 1, &PickPlace::get_box_can_pose, this);
    box_cup_posi_ = nh.subscribe<geometry_msgs::Pose>("/vrep_ros_interface/box_cup_pose", 1, &PickPlace::get_box_cup_pose, this);
    box_bear_posi_ = nh.subscribe<geometry_msgs::Pose>("/vrep_ros_interface/box_bear_pose", 1, &PickPlace::get_box_bear_pose, this);
    table_target_posi_ = nh.subscribe<geometry_msgs::Pose>("/vrep_ros_interface/table_target_pose", 1, &PickPlace::get_table_target_pose, this);
    table_box_posi_ = nh.subscribe<geometry_msgs::Pose>("/vrep_ros_interface/table_box_pose", 1, &PickPlace::get_table_box_pose, this);
    
    if (robot_connected_)
    {
        sub_pose_ = nh_.subscribe<geometry_msgs::PoseStamped>("/" + robot_type_ + "_driver/out/tool_pose", 1, &PickPlace::get_current_pose, this);
    }

    robot_model_loader::RobotModelLoader robot_model_loader("robot_description");
    robot_model_ = robot_model_loader.getModel();

    planning_scene_.reset(new planning_scene::PlanningScene(robot_model_));
    planning_scene_monitor_.reset(new planning_scene_monitor::PlanningSceneMonitor("robot_description"));

    //    //  every time need retrive current robot state, do the following.
    //	robot_state::RobotState& robot_state = planning_scene_->getCurrentStateNonConst();
    //	const robot_state::JointModelGroup *joint_model_group = robot_state.getJointModelGroup("arm");

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

    //FIXME: What is this code means?
    grip_command_pub = nh_.advertise<sensor_msgs::JointState>("/j2n6s300/finger_set", 100);
    grip_command_msg.name.resize(3);
    grip_command_msg.position.resize(3);

    action_state_pub = nh_.advertise<rosjava_custom_srv::ActionResultMsg>("/action_state", 10);

    grip_command_msg.header.frame_id = "world";
    grip_command_msg.name[0] = "j2n6s300_joint_finger_1";
    grip_command_msg.name[1] = "j2n6s300_joint_finger_2";
    grip_command_msg.name[2] = "j2n6s300_joint_finger_3";
    //

    int arm_joint_num = robot_type_[3] - '0';
    joint_names_.resize(arm_joint_num);
    joint_values_.resize(joint_names_.size());
    for (uint i = 0; i < joint_names_.size(); i++)
    {
        joint_names_[i] = robot_type_ + "_joint_" + boost::lexical_cast<std::string>(i + 1);
        target_joint.push_back(0);
    }

    // pick process
    result_ = moveit_msgs::MoveItErrorCodes::PLANNING_FAILED;

    add_target();
}

PickPlace::~PickPlace()
{
    joint_command_pub.shutdown();
    grip_command_pub.shutdown();
    pub_co_.shutdown();

    pub_planning_scene_diff_.shutdown();

    sub_pose_.shutdown();
    sub_joint_.shutdown();
    sub_robot_state_.shutdown();

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
            return;
    }

    robot_state = 0;
}

//Change object handed object
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

//##############################################################################################################################
//Get objects positions
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
//add
}

void PickPlace::get_bear_pose(const geometry_msgs::Pose::ConstPtr &msg)
{
// add
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

//##############################################################################################################################
//Callback functions of each action group
void PickPlace::arm_action_state_cb(const moveit_msgs::MoveGroupActionFeedbackConstPtr &msg)
{
    rosjava_custom_srv::ActionResultMsg actionResult;
    actionResult.actionStatus = msg->status.status;
    ros::WallDuration(15).sleep();
    action_state_pub.publish(actionResult);
}

void PickPlace::finger_action_state_cb(const control_msgs::FollowJointTrajectoryActionFeedbackConstPtr &msg)
{
    rosjava_custom_srv::ActionResultMsg actionResult;
    actionResult.actionStatus = msg->status.status;
    action_state_pub.publish(actionResult);
}
//Set arm to initiate pose
void PickPlace::MoveInitialPose()
{
    start_joint_.resize(joint_names_.size());
    start_joint_[0] = 0.0;
    start_joint_[1] = 3.141592;
    start_joint_[2] = 3.141592;
    start_joint_[3] = 0.0;
    start_joint_[4] = 0.0;
    start_joint_[5] = 0.0;

    group_->setJointValueTarget(start_joint_);
    evaluate_plan(*group_);

}

void PickPlace::MoveInitialGripperPose(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg)
{

    if (can_grasp) {
        can_grasp = !can_grasp;
        //std::cout << "can is invisible.\n";
    }

    if (cup_grasp) {
        cup_grasp = !cup_grasp;
        //std::cout << "can is invisible.\n";
    }

    if (bear_grasp) {
        bear_grasp = !bear_grasp;
        //std::cout << "can is invisible.\n";
    }

    moveit::planning_interface::MoveGroup::Plan my_plan;
    grasp_joint_.resize(3);
    //grasp_joint_ = jointState.position;
    grasp_joint_[0] = 0;
    grasp_joint_[1] = 0;
    grasp_joint_[2] = 0;
    //grasp_joint_[0] = 1.5;
    // grasp_joint_[1] = 1.5;
    // grasp_joint_[2] = 1.5;
    gripper_group_->setJointValueTarget(grasp_joint_);
    gripper_group_->setMaxVelocityScalingFactor(1);
    gripper_group_->plan(my_plan);
    gripper_group_->execute(my_plan);
}

void PickPlace::arm_action_cb(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg)
{
    ROS_INFO("Arm Action Received");
    group_->clearPathConstraints();

    if (msg->actionType == 1){
         MoveInitialPose();
    }
    else if (msg->actionType == 3){
        printf("1");
        MoveArmPose(msg);
    }
    else{
        printf("2");
        MoveArm(msg);
    }

    /* if (msg->actionType)
    {
        MoveInitialPose();
    }
    else
    {
        //RetractHandWithBottle(msg); //demo test
    }
    */
    /*if(msg->targetBody == kinova_msgs::Constant::JACO_ARM){
        if(msg->actionType == kinova_msgs::Constant::REACH){
            if(strcmp(msg->object.c_str(), "bottle")) {
                ReachForBottleWithHand(msg);
            }
            else if(strcmp(msg->object.c_str(), "CrackerBox")) {
                ReachForCrackerBoxWithHand(msg);
            }
            else if(strcmp(msg->object.c_str(), "Can")) {
                ReachForCanWithHand(msg);
            }
        }
        else if(msg->actionType == kinova_msgs::Constant::LIFT){
            if(strcmp(msg->object.c_str(), "bottle")) {
                RetractHandWithBottle(msg);
            }
            else if(strcmp(msg->object.c_str(), "CrackerBox")) {
                RetractHandWithCrackerBox(msg);
            }
            else if(strcmp(msg->object.c_str(), "Can")) {
                RetractHandWithCan(msg);
            }e
        }
        else if(msg->actionType == kinova_msgs::Constant::PUSH){
            if(strcmp(msg->object.c_str(), "bottle")) {
                PushBottleWithHand(msg);
            }
            else if(strcmp(msg->object.c_str(), "CrackerBox")) {
                PushCrackerBoxWithHand(msg);
            }
            else if(strcmp(msg->object.c_str(), "Can")) {
                PushCanWithHand(msg);
            }
        }
        else if(msg->actionType == kinova_msgs::Constant::LOWER){
            if(strcmp(msg->object.c_str(), "bottle")) {
                LowerAnBottleOnSupportPlane(msg);
            }
            else if(strcmp(msg->object.c_str(), "CrackerBox")) {
                LowerAnCrackerBoxOnSupportPlane(msg);
            }
            else if(strcmp(msg->object.c_str(), "Can")) {
                LowerAnCanOnSupportPlane(msg);
            }
        }
        else if(msg->actionType == kinova_msgs::Constant::MOVE_HAND){
            if(strcmp(msg->object.c_str(), "bottle")) {
                MoveHandToPositionWithBottle(msg);
            }
            else if(strcmp(msg->object.c_str(), "CrackerBox")) {
                MoveHandToPositionWithCrackerBox(msg);
            }
            else if(strcmp(msg->object.c_str(), "Can")) {
                MoveHandToPositionWithCan(msg);
            }
        }
    }*/
}


void PickPlace::gripper_action_cb(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg)
{
    ROS_INFO("Hand Action Received");

    if(msg->actionType == 1){
        MoveInitialGripperPose(msg);
    }


    else{
        gripper_action(msg);
    }
    
    /*if(msg->targetBody == kinova_msgs::Constant::JACO_HAND){
        if(msg->actionType == kinova_msgs::Constant::CLOSE){
            if(strcmp(msg->object.c_str(), "water_bottle_1")) {
                GraspBottle(msg);
            }
            else if(strcmp(msg->object.c_str(), "cracker_box_3")) {
                GraspCrackerBox(msg);
            }
            else if(strcmp(msg->object.c_str(), "Can")) {
                GraspCan(msg);
            }
        }
        else if(msg->actionType == kinova_msgs::Constant::OPEN) {
            ReleaseGraspOfObject(msg);
        }
    }*/
}

void PickPlace::get_current_pose(const geometry_msgs::PoseStampedConstPtr &msg)
{
    boost::mutex::scoped_lock lock(mutex_pose_);
    current_pose_ = *msg;
}

/**
 * @brief PickPlace::gripper_action
 * @param gripper_rad close for 6400 and open for 0.0
 * @return true is gripper motion reaches the goal
 */

bool PickPlace::gripper_action(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg)
{
    //std::cout << msg->object << "\n";
    if (msg->object.find("can") != std::string::npos) {
        can_grasp = !can_grasp;
        //std::cout << "can is invisible.\n";
    }
    else if (msg->object.find("cup") != std::string::npos) {
        cup_grasp = !cup_grasp;
        //std::cout << "cup is invisible.\n";
    }
    else if (msg->object.find("bear") != std::string::npos) {
        bear_grasp = !bear_grasp;
        //std::cout << "bear is invisible.\n";
    }

    geometry_msgs::PoseStamped pose = msg->targetPose;

    moveit::planning_interface::MoveGroup::Plan my_plan;
    grasp_joint_.resize(3);
    //grasp_joint_ = jointState.position;
    if(msg->actionType == 3)
    {
        std::cout << "!!!\n";
        grasp_joint_[0] = 1.5;
        grasp_joint_[1] = 1.5;
        grasp_joint_[2] = 1.5;
    }
    else
    {
        std::cout << "!!!!\n";
        grasp_joint_[0] = pose.pose.position.x;
        grasp_joint_[1] = pose.pose.position.y;
        grasp_joint_[2] = pose.pose.position.z;
     }
    //grasp_joint_[0] = 1.5;
    // grasp_joint_[1] = 1.5;
    // grasp_joint_[2] = 1.5;
    gripper_group_->setJointValueTarget(grasp_joint_);
    gripper_group_->setMaxVelocityScalingFactor(1);
    gripper_group_->plan(my_plan);
    gripper_group_->execute(my_plan);

    
    return true;
}

bool PickPlace::evaluate_plan(moveit::planning_interface::MoveGroup &group)
{
    int count = 0;
    double plan_time;

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
    }
    else // not found
    {
        std::cout << "Exit since plan failed until reach maximum attemp: " << count << std::endl;
        return false;
    }

    ros::WallDuration(1).sleep();
    return true;
}

//##########################################################################################################################
//Robot arm action
//TODO: Make functions corresponding to each actions
void PickPlace::ReachForBottleWithHand(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg)
{
    ROS_INFO("ReachForBottleWithHand");
    group_->setJointValueTarget(msg->targetJointState);
    evaluate_plan(*group_);
}

//##########################################################################################################################
//Robot hand action
//TODO: Make functions corresponding to each actions
void PickPlace::GraspBottle(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg)
{
    move_obj = msg->object.c_str();
    visual = false;
    move = true;
    ros::Duration(2.0).sleep();
    //gripper_action(msg->targetPose);
}

//FIXME: Why this function be disabled?
void PickPlace::ReleaseGraspOfObject(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg)
{
    //gripper_action(msg->targetJointState);
}

//##########################################################################################################################
//Temporarily adding objects
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

void PickPlace::add_bear()
{
//add
}

void PickPlace::add_cup()
{
//add
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
    co_box_can_.mesh_poses[0].position.z = 1;

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

//##########################################################################################################################


//test code
bool PickPlace::MoveArm(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg)
{
   
    
    move_joint_.resize(joint_names_.size());
    move_joint_[0] = msg->targetJointState.position[0];
    move_joint_[1] = msg->targetJointState.position[1];
    move_joint_[2] = msg->targetJointState.position[2];
    move_joint_[3] = msg->targetJointState.position[3];
    move_joint_[4] = msg->targetJointState.position[4];
    move_joint_[5] = msg->targetJointState.position[5];
    group_->setJointValueTarget(move_joint_);
   // target_joint = move_joint_;
    // std::cout << msg->targetJointState.position;
    if(!evaluate_plan(*group_))
        return false;
    
    return true;
}

bool PickPlace::MoveArmPose(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg)
{
   
    
    start_pose_.header.frame_id = "root";
    start_pose_.header.stamp = ros::Time::now();
    start_pose_.pose.orientation.x = msg->targetPose.pose.orientation.x;
    start_pose_.pose.orientation.y = msg->targetPose.pose.orientation.y;
    start_pose_.pose.orientation.z = msg->targetPose.pose.orientation.z;
    start_pose_.pose.orientation.w = msg->targetPose.pose.orientation.w;

    // start_pose_.pose.orientation = tf::createQuaternionMsgFromRollPitchYaw(-1.205884, -2.902540, -1.208770);
    start_pose_.pose.position.x = msg->targetPose.pose.position.x;
    start_pose_.pose.position.y = msg->targetPose.pose.position.y;
    start_pose_.pose.position.z = msg->targetPose.pose.position.z;


    group_->setPoseTarget(start_pose_);
    
    if(!evaluate_plan(*group_))
        return false;
    
    return true;
}


int main(int argc, char **argv)
{
    ros::init(argc, argv, "pick_place_demo");
    ros::NodeHandle node;
    ROS_INFO("Action Manager Interface");
    ros::AsyncSpinner spinner(4);
    spinner.start();


    kinova::PickPlace pick_place(node);
    ros::waitForShutdown();
    return 0;
}
