cmake_minimum_required(VERSION 2.8.3)
project(moveit_vrep_interface)

add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  actionlib
  control_msgs
  sensor_msgs
  eigen_conversions
)

catkin_package(
)

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)

add_executable(moveit_vrep_interface src/main.cpp src/moveitcontroller.cpp)
target_link_libraries(moveit_vrep_interface
   ${catkin_LIBRARIES}
 )

