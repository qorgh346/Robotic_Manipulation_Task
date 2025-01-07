gnome-terminal -x sh -c "rosrun moveit_vrep_interface moveit_vrep_interface"
gnome-terminal -x sh -c "roslaunch j2n6s300_moveit_config j2n6s300_virtual_robot_demo.launch"
rosrun kinova_arm_moveit_demo pick_place

