#include "moveitcontroller.h"


int main(int argc, char **argv)
{
  ros::init(argc, argv, "moveit_vrep_interface");
  ros::NodeHandle n;

  ArmController arm("arm_controller/joint_action_server",n);
  GripperController hand("hand_controller/joint_action_server",n);

  ros::Rate rate(100);

  while(ros::ok()){
    ros::spinOnce();
    arm.compute();
    hand.compute();
    rate.sleep();
  }


  return 0;
}
