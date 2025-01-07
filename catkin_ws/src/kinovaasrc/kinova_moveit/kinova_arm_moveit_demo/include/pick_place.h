#ifndef PICK_PLACE_H
#define PICK_PLACE_H

#include <ros/ros.h>
#include <kinova_driver/kinova_ros_types.h>

#include <actionlib/client/simple_action_client.h>
#include <kinova_msgs/SetFingersPositionAction.h>

// Move_base
#include <std_msgs/Int32.h>
#include <move_base_msgs/MoveBaseAction.h>
#include <move_base_msgs/MoveBaseActionGoal.h>
#include <move_base_msgs/MoveBaseActionResult.h>

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
#include <moveit_msgs/MoveGroupActionFeedback.h>

#include <control_msgs/FollowJointTrajectoryActionFeedback.h>

#include "geometric_shapes/shapes.h"
#include "geometric_shapes/mesh_operations.h"
#include "geometric_shapes/shape_operations.h"
#include "geometry_msgs/Quaternion.h"
#include <tf/tf.h>

#include <moveit/planning_scene_interface/planning_scene_interface.h>
#include <math.h>
#include "gazebo_msgs/ModelStates.h"

#include <rosjava_custom_srv/ActionGoalMsg.h>
#include <rosjava_custom_srv/ActionResultMsg.h>

#define NUM_OF_MODELS 50
#define PI 3.141592
#define H_PI 1.570796

namespace kinova
{

class PickPlace
{
public:
        PickPlace(ros::NodeHandle &nh);
        ~PickPlace();

private:
        bool move = false;
        bool visual = false;
        bool is_added = false;
        std::string move_obj = "";

        ros::Publisher joint_command_pub;
        sensor_msgs::JointState joint_command_msg;
        ros::Publisher grip_command_pub;
        sensor_msgs::JointState grip_command_msg;

        ros::NodeHandle nh_;

        std::vector<moveit_msgs::CollisionObject> collision_vector;
        moveit::planning_interface::PlanningSceneInterface planning_scene_interface;

        // open&close fingers: gripper_group_.plan not alway have a solution
        actionlib::SimpleActionClient<kinova_msgs::SetFingersPositionAction> *finger_client_;

        moveit::planning_interface::MoveGroup *group_;
        moveit::planning_interface::MoveGroup *gripper_group_;
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
        moveit_msgs::CollisionObject co_;
        moveit_msgs::PlanningScene planning_scene_msg_;
        moveit_msgs::AttachedCollisionObject aco_;
        
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
        ros::Publisher action_state_pub;

        ros::Subscriber model_states_;
        ros::Subscriber sub_arm_action_goal_;
        ros::Subscriber sub_gripper_action_goal_;
        ros::Subscriber sub_arm_action_state_;
        ros::Subscriber sub_finger_action_state_;
        std::vector<std::string> joint_names_;
        std::vector<double> joint_values_;
        std::vector<double> grasp_joint_;

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
        boost::mutex mutex_model_;
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
        std::vector<double> move_joint_;

        /* define pick_place pose valuse
                std::vector<double> example_pose;

                example_pose.resize(7);
                example_pose[0] = '(double) position.x'
                example_pose[1] = '(double) position.y'
                example_pose[2] = '(double) position.z'
                example_pose[3] = '(double) orientation.x'
                example_pose[4] = '(double) orientation.y'
                example_pose[5] = '(double) orientation.z'
                example_pose[6] = '(double) orientation.w'
        */
        std::vector<double> master_chef_can_grasp_pose;
        std::vector<double> tomato_soup_can_grasp_pose;
        std::vector<double> cracker_box_0_grasp_pose;
        std::vector<double> master_chef_can1_grasp_pose;

        /* define navigation pose valuse
                std::vector<double> example_pose;

                example_pose.resize(7);
                example_pose[0] = '(double) position.x'
                example_pose[1] = '(double) position.y'
                example_pose[2] = '(double) position.z'
                example_pose[3] = '(double) orientation.x'
                example_pose[4] = '(double) orientation.y'
                example_pose[5] = '(double) orientation.z'
                example_pose[6] = '(double) orientation.w'
        */

        void define_joint_values();
        void define_pose_values();

        //Robot arm action
        void ReachForBottleWithHand(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        void ReachForCrackerBoxWithHand(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        void ReachForCanWithHand(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        void RetractHandWithBottle(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        void RetractHandWithCrackerBox(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        void RetractHandWithCan(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        void MoveHandToPositionWithBottle(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        void MoveHandToPositionWithCrackerBox(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        void MoveHandToPositionWithCan(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        void LowerAnBottleOnSupportPlane(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        void LowerAnCrackerBoxOnSupportPlane(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        void LowerAnCanOnSupportPlane(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        void PushBottleWithHand(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        void PushCrackerBoxWithHand(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        void PushCanWithHand(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);

        //Robot hand action
        void GraspBottle(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        void GraspCrackerBox(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        void GraspCan(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        void ReleaseGraspOfObject(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);

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

        void arm_action_cb(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        void gripper_action_cb(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);

        //home pose action
        void MoveInitialPose();
        void MoveInitialGripperPose(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);


        //action state
        void arm_action_state_cb(const moveit_msgs::MoveGroupActionFeedbackConstPtr &msg);
        void finger_action_state_cb(const control_msgs::FollowJointTrajectoryActionFeedbackConstPtr &msg);
        bool MoveArm(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);
        bool MoveArmPose(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);

        // TODO: use Kinova inverse kinematic solution instead of from ROS.
        bool evaluate_plan(moveit::planning_interface::MoveGroup &group);
        bool gripper_action(const rosjava_custom_srv::ActionGoalMsgConstPtr &msg);

        geometry_msgs::PoseStamped start_pose_;
};
} // namespace kinova

#endif // PICK_PLACE_H
