# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "octomap_msgs: 2 messages, 2 services")

set(MSG_I_FLAGS "-Ioctomap_msgs:/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genjava REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(octomap_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/BoundingBoxQuery.srv" NAME_WE)
add_custom_target(_octomap_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "octomap_msgs" "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/BoundingBoxQuery.srv" "geometry_msgs/Point"
)

get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/OctomapWithPose.msg" NAME_WE)
add_custom_target(_octomap_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "octomap_msgs" "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/OctomapWithPose.msg" "geometry_msgs/Point:geometry_msgs/Quaternion:std_msgs/Header:geometry_msgs/Pose:octomap_msgs/Octomap"
)

get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg" NAME_WE)
add_custom_target(_octomap_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "octomap_msgs" "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/GetOctomap.srv" NAME_WE)
add_custom_target(_octomap_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "octomap_msgs" "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/GetOctomap.srv" "octomap_msgs/Octomap:std_msgs/Header"
)

#
#  langs = gencpp;geneus;genjava;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/OctomapWithPose.msg"
  "${MSG_I_FLAGS}"
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/octomap_msgs
)
_generate_msg_cpp(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/octomap_msgs
)

### Generating Services
_generate_srv_cpp(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/BoundingBoxQuery.srv"
  "${MSG_I_FLAGS}"
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/octomap_msgs
)
_generate_srv_cpp(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/GetOctomap.srv"
  "${MSG_I_FLAGS}"
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/octomap_msgs
)

### Generating Module File
_generate_module_cpp(octomap_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/octomap_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(octomap_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(octomap_msgs_generate_messages octomap_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/BoundingBoxQuery.srv" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_cpp _octomap_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/OctomapWithPose.msg" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_cpp _octomap_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_cpp _octomap_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/GetOctomap.srv" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_cpp _octomap_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(octomap_msgs_gencpp)
add_dependencies(octomap_msgs_gencpp octomap_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS octomap_msgs_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/OctomapWithPose.msg"
  "${MSG_I_FLAGS}"
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/octomap_msgs
)
_generate_msg_eus(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/octomap_msgs
)

### Generating Services
_generate_srv_eus(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/BoundingBoxQuery.srv"
  "${MSG_I_FLAGS}"
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/octomap_msgs
)
_generate_srv_eus(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/GetOctomap.srv"
  "${MSG_I_FLAGS}"
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/octomap_msgs
)

### Generating Module File
_generate_module_eus(octomap_msgs
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/octomap_msgs
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(octomap_msgs_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(octomap_msgs_generate_messages octomap_msgs_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/BoundingBoxQuery.srv" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_eus _octomap_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/OctomapWithPose.msg" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_eus _octomap_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_eus _octomap_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/GetOctomap.srv" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_eus _octomap_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(octomap_msgs_geneus)
add_dependencies(octomap_msgs_geneus octomap_msgs_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS octomap_msgs_generate_messages_eus)

### Section generating for lang: genjava
### Generating Messages
_generate_msg_java(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/OctomapWithPose.msg"
  "${MSG_I_FLAGS}"
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg"
  ${CATKIN_DEVEL_PREFIX}/${genjava_INSTALL_DIR}/octomap_msgs
)
_generate_msg_java(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genjava_INSTALL_DIR}/octomap_msgs
)

### Generating Services
_generate_srv_java(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/BoundingBoxQuery.srv"
  "${MSG_I_FLAGS}"
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genjava_INSTALL_DIR}/octomap_msgs
)
_generate_srv_java(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/GetOctomap.srv"
  "${MSG_I_FLAGS}"
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genjava_INSTALL_DIR}/octomap_msgs
)

### Generating Module File
_generate_module_java(octomap_msgs
  ${CATKIN_DEVEL_PREFIX}/${genjava_INSTALL_DIR}/octomap_msgs
  "${ALL_GEN_OUTPUT_FILES_java}"
)

add_custom_target(octomap_msgs_generate_messages_java
  DEPENDS ${ALL_GEN_OUTPUT_FILES_java}
)
add_dependencies(octomap_msgs_generate_messages octomap_msgs_generate_messages_java)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/BoundingBoxQuery.srv" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_java _octomap_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/OctomapWithPose.msg" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_java _octomap_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_java _octomap_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/GetOctomap.srv" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_java _octomap_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(octomap_msgs_genjava)
add_dependencies(octomap_msgs_genjava octomap_msgs_generate_messages_java)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS octomap_msgs_generate_messages_java)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/OctomapWithPose.msg"
  "${MSG_I_FLAGS}"
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/octomap_msgs
)
_generate_msg_lisp(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/octomap_msgs
)

### Generating Services
_generate_srv_lisp(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/BoundingBoxQuery.srv"
  "${MSG_I_FLAGS}"
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/octomap_msgs
)
_generate_srv_lisp(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/GetOctomap.srv"
  "${MSG_I_FLAGS}"
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/octomap_msgs
)

### Generating Module File
_generate_module_lisp(octomap_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/octomap_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(octomap_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(octomap_msgs_generate_messages octomap_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/BoundingBoxQuery.srv" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_lisp _octomap_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/OctomapWithPose.msg" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_lisp _octomap_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_lisp _octomap_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/GetOctomap.srv" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_lisp _octomap_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(octomap_msgs_genlisp)
add_dependencies(octomap_msgs_genlisp octomap_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS octomap_msgs_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/OctomapWithPose.msg"
  "${MSG_I_FLAGS}"
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/octomap_msgs
)
_generate_msg_nodejs(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/octomap_msgs
)

### Generating Services
_generate_srv_nodejs(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/BoundingBoxQuery.srv"
  "${MSG_I_FLAGS}"
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/octomap_msgs
)
_generate_srv_nodejs(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/GetOctomap.srv"
  "${MSG_I_FLAGS}"
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/octomap_msgs
)

### Generating Module File
_generate_module_nodejs(octomap_msgs
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/octomap_msgs
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(octomap_msgs_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(octomap_msgs_generate_messages octomap_msgs_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/BoundingBoxQuery.srv" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_nodejs _octomap_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/OctomapWithPose.msg" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_nodejs _octomap_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_nodejs _octomap_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/GetOctomap.srv" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_nodejs _octomap_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(octomap_msgs_gennodejs)
add_dependencies(octomap_msgs_gennodejs octomap_msgs_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS octomap_msgs_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/OctomapWithPose.msg"
  "${MSG_I_FLAGS}"
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/octomap_msgs
)
_generate_msg_py(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/octomap_msgs
)

### Generating Services
_generate_srv_py(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/BoundingBoxQuery.srv"
  "${MSG_I_FLAGS}"
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/octomap_msgs
)
_generate_srv_py(octomap_msgs
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/GetOctomap.srv"
  "${MSG_I_FLAGS}"
  "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/octomap_msgs
)

### Generating Module File
_generate_module_py(octomap_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/octomap_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(octomap_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(octomap_msgs_generate_messages octomap_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/BoundingBoxQuery.srv" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_py _octomap_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/OctomapWithPose.msg" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_py _octomap_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg/Octomap.msg" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_py _octomap_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/srv/GetOctomap.srv" NAME_WE)
add_dependencies(octomap_msgs_generate_messages_py _octomap_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(octomap_msgs_genpy)
add_dependencies(octomap_msgs_genpy octomap_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS octomap_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/octomap_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/octomap_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(octomap_msgs_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(octomap_msgs_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/octomap_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/octomap_msgs
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(octomap_msgs_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(octomap_msgs_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genjava_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genjava_INSTALL_DIR}/octomap_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genjava_INSTALL_DIR}/octomap_msgs
    DESTINATION ${genjava_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_java)
  add_dependencies(octomap_msgs_generate_messages_java std_msgs_generate_messages_java)
endif()
if(TARGET geometry_msgs_generate_messages_java)
  add_dependencies(octomap_msgs_generate_messages_java geometry_msgs_generate_messages_java)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/octomap_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/octomap_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(octomap_msgs_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(octomap_msgs_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/octomap_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/octomap_msgs
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(octomap_msgs_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(octomap_msgs_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/octomap_msgs)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/octomap_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/octomap_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(octomap_msgs_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(octomap_msgs_generate_messages_py geometry_msgs_generate_messages_py)
endif()
