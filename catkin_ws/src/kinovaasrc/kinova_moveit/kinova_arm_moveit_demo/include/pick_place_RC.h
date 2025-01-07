#ifndef PICK_PLACE_H
#define PICK_PLACE_H

#include <ros/ros.h>
#include <kinova_driver/kinova_ros_types.h>

#include <actionlib/client/simple_action_client.h>
#include <kinova_msgs/SetFingersPositionAction.h>

// MoveIt!
#include <moveit/robot_model_loader/robot_model_loader.h>
#include <moveit/robot_state/robot_state.h>
#include <moveit/robot_state/conversions.h>

#include <moveit/move_group_interface/move_group.h>
#include <moveit/planning_interface/planning_interface.h>
#include <moveit/planning_scene/planning_scene.h>
#include <moveit/planning_scene_monitor/planning_scene_monitor.h>
#include <moveit/planning_pipeline/planning_pipeline.h>

#include <moveit/kinematic_constraints/utils.h>
#include <geometric_shapes/solid_primitive_dims.h>

#include <moveit_msgs/PlanningScene.h>
#include <moveit_msgs/AttachedCollisionObject.h>
#include <moveit_msgs/GetStateValidity.h>
#include <moveit_msgs/DisplayRobotState.h>
#include <moveit_msgs/ApplyPlanningScene.h>
#include <moveit_msgs/DisplayTrajectory.h>
#include <moveit_msgs/CollisionObject.h>

#include "geometric_shapes/shapes.h"
#include "geometric_shapes/mesh_operations.h"
#include "geometric_shapes/shape_operations.h"

#include <moveit/planning_scene_interface/planning_scene_interface.h>
#include <std_msgs/Int32.h>
#include <math.h>

namespace kinova
{


    class PickPlace
    {
    public:
        PickPlace(ros::NodeHandle &nh);
        ~PickPlace();



    private:
        ros::NodeHandle nh_;

        std::vector<moveit_msgs::CollisionObject> collision_vector;
        moveit::planning_interface::PlanningSceneInterface planning_scene_interface;

        // open&close fingers: gripper_group_.plan not alway have a solution
        actionlib::SimpleActionClient<kinova_msgs::SetFingersPositionAction>* finger_client_;

        moveit::planning_interface::MoveGroup* group_;
        moveit::planning_interface::MoveGroup* gripper_group_;
        robot_model::RobotModelPtr robot_model_;

        planning_scene::PlanningScenePtr planning_scene_;
        planning_scene_monitor::PlanningSceneMonitorPtr planning_scene_monitor_;

        // work scene
        moveit_msgs::CollisionObject co_cup_;
        moveit_msgs::CollisionObject co_can_;
        moveit_msgs::CollisionObject co_bear_;
        moveit_msgs::CollisionObject co_box_cup_;
        moveit_msgs::CollisionObject co_box_can_;
        moveit_msgs::CollisionObject co_box_bear_;
        moveit_msgs::CollisionObject co_table_target_;
        moveit_msgs::CollisionObject co_table_box_;
        moveit_msgs::AttachedCollisionObject aco_;
        moveit_msgs::PlanningScene planning_scene_msg_;

	//ros::Publisher pub_target;///////////////
        ros::Publisher pub_co_;
        ros::Publisher pub_aco_;
        ros::Publisher pub_planning_scene_diff_;
        ros::Subscriber sub_pose_;
        ros::Subscriber sub_joint_;
        ros::Subscriber can_posi_;
        ros::Subscriber cup_posi_;
        ros::Subscriber bear_posi_;
        ros::Subscriber box_can_posi_;
        ros::Subscriber box_cup_posi_;
        ros::Subscriber box_bear_posi_;
        ros::Subscriber table_target_posi_;
        ros::Subscriber table_box_posi_;
	ros::Subscriber sub_robot_state_;

        std::vector<std::string> joint_names_;
        std::vector<double> joint_values_;

        // use Kinova Inverse Kinematic model to generate joint value, then setJointTarget().
        bool use_KinovaInK_;

        // check some process if success.
        moveit::planning_interface::MoveItErrorCode result_;
        // wait for user input to continue: cin >> pause_;
        std::string pause_;
        std::string robot_type_;
        std::string object_;
        bool robot_connected_;

        // update current state and pose
	boost::mutex mutex_grasp_;
        boost::mutex mutex_state_;
        boost::mutex mutex_pose_;
        boost::mutex mutex_object_pose_;
        sensor_msgs::JointState current_state_;
        geometry_msgs::PoseStamped current_pose_;
        geometry_msgs::Pose bear_pose_;

        // define pick_place joint value and pose
	std::vector<double> target_joint;
        std::vector<double> start_joint_;
        std::vector<double> can_pregrasp_joint_;
        std::vector<double> can_grasp_joint_;
        std::vector<double> can_postgrasp_joint_;
        std::vector<double> can_release_joint_;
        std::vector<double> can_postrelease_joint_;
        std::vector<double> cup_pregrasp_joint_;
        std::vector<double> cup_grasp_joint_;
        std::vector<double> can_grasp_back_joint_;
        std::vector<double> cup_postgrasp_joint_;
	std::vector<double> cup_prerelease_joint_;
        std::vector<double> cup_release_joint_;
        std::vector<double> cup_postrelease_joint_;
        std::vector<double> bear_pregrasp_joint_;
        std::vector<double> bear_grasp_joint_;
        std::vector<double> bear_postgrasp_joint_;
        std::vector<double> bear_release_joint_;
        std::vector<double> bear_postrelease_joint_;

        geometry_msgs::PoseStamped start_pose_;
        geometry_msgs::PoseStamped can_pregrasp_pose_;
        geometry_msgs::PoseStamped can_grasp_pose_;

        void add_attached_obstacle(moveit_msgs::CollisionObject& co_);

        void add_target();
        void add_can();
        void add_cup();
        void add_bear();
        void add_box_can();
        void add_box_cup();
        void add_box_bear();
        void add_table_target();
        void add_table_box();

        void define_joint_values();
        void define_cartesian_pose();
        void setup_constrain(geometry_msgs::Pose target_pose, bool orientation, bool position);

        bool move_can();
        bool move_cup();
        bool move_bear();

        bool my_pick();
        bool my_place();

        const int PI = 3.141592;
        const int H_PI = 1.570796;

	int robot_state;
	bool can_grasp = 0;
	bool cup_grasp = 0;
	bool bear_grasp = 0;
	bool is_can_grasped = 0;
	bool is_cup_grasped = 0;
	bool is_bear_grasped = 0;

	void get_robot_state(const std_msgs::Int32::ConstPtr &msg);
        void get_current_state(const sensor_msgs::JointStateConstPtr &msg);
        void get_current_pose(const geometry_msgs::PoseStampedConstPtr &msg);
        void get_can_pose(const geometry_msgs::Pose::ConstPtr &msg);
        void get_cup_pose(const geometry_msgs::Pose::ConstPtr &msg);
        void get_bear_pose(const geometry_msgs::Pose::ConstPtr &msg);
        void get_box_can_pose(const geometry_msgs::Pose::ConstPtr &msg);
        void get_box_cup_pose(const geometry_msgs::Pose::ConstPtr &msg);
        void get_box_bear_pose(const geometry_msgs::Pose::ConstPtr &msg);
        void get_table_target_pose(const geometry_msgs::Pose::ConstPtr &msg);
        void get_table_box_pose(const geometry_msgs::Pose::ConstPtr &msg);
        // TODO: use Kinova inverse kinematic solution instead of from ROS.
        bool evaluate_plan(moveit::planning_interface::MoveGroup &group);
        bool gripper_action(double gripper_rad);
    };
}


#endif // PICK_PLACE_H

