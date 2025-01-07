# Install script for directory: /home/test/Downloads/190816_cmtm_code/catkin_ws/src/rosjava_custom_srv

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/test/Downloads/190816_cmtm_code/catkin_ws/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rosjava_custom_srv/msg" TYPE FILE FILES
    "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/rosjava_custom_srv/msg/ActionGoalMsg.msg"
    "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/rosjava_custom_srv/msg/ActionResultMsg.msg"
    "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/rosjava_custom_srv/msg/ActionState.msg"
    "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/rosjava_custom_srv/msg/ArmAction.msg"
    "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/rosjava_custom_srv/msg/MainServiceRequest.msg"
    "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/rosjava_custom_srv/msg/Monitor.msg"
    "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/rosjava_custom_srv/msg/MonitorServiceRequest.msg"
    "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/rosjava_custom_srv/msg/MonitorServiceResponse.msg"
    "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/rosjava_custom_srv/msg/QueryServiceRequest.msg"
    "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/rosjava_custom_srv/msg/QueryServiceResponse.msg"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rosjava_custom_srv/srv" TYPE FILE FILES
    "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/rosjava_custom_srv/srv/JamService.srv"
    "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/rosjava_custom_srv/srv/PathService.srv"
    "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/rosjava_custom_srv/srv/PoseService.srv"
    "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/rosjava_custom_srv/srv/PosesService.srv"
    "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/rosjava_custom_srv/srv/PredicateService.srv"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rosjava_custom_srv/cmake" TYPE FILE FILES "/home/test/Downloads/190816_cmtm_code/catkin_ws/build/rosjava_custom_srv/catkin_generated/installspace/rosjava_custom_srv-msg-paths.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/test/Downloads/190816_cmtm_code/catkin_ws/devel/include/rosjava_custom_srv")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/test/Downloads/190816_cmtm_code/catkin_ws/devel/share/roseus/ros/rosjava_custom_srv")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/test/Downloads/190816_cmtm_code/catkin_ws/devel/share/common-lisp/ros/rosjava_custom_srv")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/test/Downloads/190816_cmtm_code/catkin_ws/devel/share/gennodejs/ros/rosjava_custom_srv")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/usr/bin/python2" -m compileall "/home/test/Downloads/190816_cmtm_code/catkin_ws/devel/lib/python2.7/dist-packages/rosjava_custom_srv")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/test/Downloads/190816_cmtm_code/catkin_ws/devel/lib/python2.7/dist-packages/rosjava_custom_srv")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/test/Downloads/190816_cmtm_code/catkin_ws/build/rosjava_custom_srv/catkin_generated/installspace/rosjava_custom_srv.pc")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rosjava_custom_srv/cmake" TYPE FILE FILES "/home/test/Downloads/190816_cmtm_code/catkin_ws/build/rosjava_custom_srv/catkin_generated/installspace/rosjava_custom_srv-msg-extras.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rosjava_custom_srv/cmake" TYPE FILE FILES
    "/home/test/Downloads/190816_cmtm_code/catkin_ws/build/rosjava_custom_srv/catkin_generated/installspace/rosjava_custom_srvConfig.cmake"
    "/home/test/Downloads/190816_cmtm_code/catkin_ws/build/rosjava_custom_srv/catkin_generated/installspace/rosjava_custom_srvConfig-version.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rosjava_custom_srv" TYPE FILE FILES "/home/test/Downloads/190816_cmtm_code/catkin_ws/src/rosjava_custom_srv/package.xml")
endif()

