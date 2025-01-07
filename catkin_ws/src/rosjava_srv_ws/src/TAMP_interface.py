#!/usr/bin/env python

import sys
sys.path.insert(0, '/home/kkw/catkin_ws/src/') # should update this path (containing msg, srv folder)

from rosjava_custom_srv.srv import *
from rosjava_custom_srv.msg import *
from geometry_msgs.msg import *
from moveit_msgs.msg import *
import rospy

pose_generation = {}

def init():
    detectableBasePoseMsg = ActionGoalMsg()
    detectableBasePoseStamped = PoseStamped()
    detectableBasePose = Pose()
    detectableBasePosePoint = Point(-1.05, -1.25, 0.0635)
    detectableBasePose.position = detectableBasePosePoint
    detectableBasePoseStamped.pose = detectableBasePose
    detectableBasePoseMsg.targetPose = detectableBasePoseStamped
    pose_generation['detectableBasePoses'] = detectableBasePoseMsg
    pose_generation['reachableBasePoses'] = detectableBasePoseMsg
    placeableBasePoseMsg = ActionGoalMsg()
    placeableBasePoseStamped = PoseStamped()
    placeableBasePose = Pose()
    placeableBasePosePoint = Point(2.346045, -0.720888, 0.0635)
    placeableBasePose.position = placeableBasePosePoint
    placeableBasePoseStamped.pose = placeableBasePose
    placeableBasePoseMsg.targetPose = placeableBasePoseStamped
    pose_generation['placeableBasePoses'] = placeableBasePoseMsg
    preGraspHandPoseMsg = ActionGoalMsg()
    preGraspHandPoseStamped = PoseStamped()
    preGraspHandPose = Pose()
    preGraspHandPosePoint = Point(-1.35355, -1.25, 0.679499)
    preGraspHandPose.position = preGraspHandPosePoint
    preGraspHandPoseQuaternion = Quaternion(-0.39755, -0.606131, 0.437479, 0.532138)
    preGraspHandPose.orientation = preGraspHandPoseQuaternion
    preGraspHandPoseStamped.pose = preGraspHandPose
    preGraspHandPoseMsg.targetPose = preGraspHandPoseStamped
    GraspHandPoseOrientationConstraint = OrientationConstraint()
    GraspHandPoseOrientationConstraint.link_name = 'j2n6s300_end_effector'
    GraspHandPoseOrientationConstraint.header.frame_id = 'world'
    GraspHandPoseOrientationConstraint.orientation = preGraspHandPoseStamped.pose.orientation
    GraspHandPoseOrientationConstraint.absolute_x_axis_tolerance = 0.1
    GraspHandPoseOrientationConstraint.absolute_y_axis_tolerance = 0.1
    GraspHandPoseOrientationConstraint.absolute_z_axis_tolerance = 0.1
    GraspHandPoseOrientationConstraint.weight = 1.0
    GraspHandPoseJointConstraint1 = JointConstraint()
    GraspHandPoseJointConstraint1.joint_name = 'j2n6s300_joint_2'
    GraspHandPoseJointConstraint1.position = 2.9
    GraspHandPoseJointConstraint1.tolerance_above = 1.2
    GraspHandPoseJointConstraint1.tolerance_below = 1.0
    GraspHandPoseJointConstraint1.weight = 1.0
    GraspHandPoseJointConstraint2 = JointConstraint()
    GraspHandPoseJointConstraint2.joint_name = 'j2n6s300_joint_1'
    GraspHandPoseJointConstraint2.position = 6.283
    GraspHandPoseJointConstraint2.tolerance_above = 0.0
    GraspHandPoseJointConstraint2.tolerance_below = 2.0
    GraspHandPoseJointConstraint2.weight = 1.0
    GraspHandPosePositionConstraint = PositionConstraint()
    GraspHandPosePositionConstraint.link_name = 'j2n6s300_end_effector'
    GraspHandPosePositionConstraint.header.frame_id = 'world'
    GraspHandPosePositionConstraint.target_point_offset.y = -0.720888
    GraspHandPosePositionConstraint.weight = 1.0
    pose_generation['preGraspHandPoses'] = preGraspHandPoseMsg
    graspHandPoseMsg = ActionGoalMsg()
    graspHandPoseStamped = PoseStamped()
    graspHandPose = Pose()
    graspHandPosePoint = Point(-1.58355, -1.25, 0.679499)
    graspHandPoseQuaternion = Quaternion(-0.39755, -0.606131, 0.437479, 0.532138)
    graspHandPose.position = graspHandPosePoint
    graspHandPose.orientation = graspHandPoseQuaternion
    graspHandPoseStamped.pose = graspHandPose
    graspHandPoseMsg.targetPose = graspHandPoseStamped
    graspHandPoseMsg.orientation_constraints.append(GraspHandPoseOrientationConstraint)
    graspHandPoseMsg.joint_constraints.append(GraspHandPoseJointConstraint1)
    graspHandPoseMsg.joint_constraints.append(GraspHandPoseJointConstraint2)
    graspHandPoseMsg.position_constraints.append(GraspHandPosePositionConstraint)
    pose_generation['graspHandPoses'] = graspHandPoseMsg
    closeHandPoseMsg = ActionGoalMsg()
    closeHandPoseStamped = PoseStamped()
    closeHandPose = Pose()
    closeHandPosePoint = Point(1.0, 0.2, 1.0)
    closeHandPose.position = closeHandPosePoint
    closeHandPoseStamped.pose = closeHandPose
    closeHandPoseMsg.targetPose = closeHandPoseStamped
    pose_generation['closeHandPoses'] = closeHandPoseMsg
    postGraspHandPoseMsg1 = ActionGoalMsg()
    postGraspHandPoseStamped1 = PoseStamped()
    postGraspHandPose1 = Pose()
    postGraspHandPosePoint1 = Point(-1.54355, -1.25, 0.714499)
    postGraspHandPoseQuaternion1 = Quaternion(-0.39755, -0.606131, 0.437479, 0.532138)
    postGraspHandPose1.position = postGraspHandPosePoint1
    postGraspHandPose1.orientation = postGraspHandPoseQuaternion1
    postGraspHandPoseStamped1.pose = postGraspHandPose1
    postGraspHandPoseMsg1.targetPose = postGraspHandPoseStamped1
    postGraspHandPoseMsg1.orientation_constraints.append(GraspHandPoseOrientationConstraint)
    postGraspHandPoseMsg1.joint_constraints.append(GraspHandPoseJointConstraint1)
    postGraspHandPoseMsg1.joint_constraints.append(GraspHandPoseJointConstraint2)
    postGraspHandPoseMsg1.position_constraints.append(GraspHandPosePositionConstraint)
    pose_generation['postGraspHandPoses1'] = postGraspHandPoseMsg1
    postGraspHandPoseMsg2 = ActionGoalMsg()
    postGraspHandPoseStamped2 = PoseStamped()
    postGraspHandPose2 = Pose()
    postGraspHandPosePoint2 = Point(-1.26355, -1.25, 0.714499)
    postGraspHandPoseQuaternion2 = Quaternion(-0.39755, -0.606131, 0.437479, 0.532138)
    postGraspHandPose2.position = postGraspHandPosePoint2
    postGraspHandPose2.orientation = postGraspHandPoseQuaternion2
    postGraspHandPoseStamped2.pose = postGraspHandPose2
    postGraspHandPoseMsg2.targetPose = postGraspHandPoseStamped2
    postGraspHandPoseMsg2.orientation_constraints.append(GraspHandPoseOrientationConstraint)
    postGraspHandPoseMsg2.joint_constraints.append(GraspHandPoseJointConstraint1)
    postGraspHandPoseMsg2.joint_constraints.append(GraspHandPoseJointConstraint2)
    postGraspHandPoseMsg2.position_constraints.append(GraspHandPosePositionConstraint)
    pose_generation['postGraspHandPoses2'] = postGraspHandPoseMsg2
    postGraspHandPoseMsg3 = ActionGoalMsg()
    postGraspHandPoseStamped3 = PoseStamped()
    postGraspHandPose3 = Pose()
    postGraspHandPosePoint3 = Point(-1.18355, -1.25, 0.9)
    postGraspHandPoseQuaternion3 = Quaternion(-0.39755, -0.606131, 0.437479, 0.532138)
    postGraspHandPose3.position = postGraspHandPosePoint3
    postGraspHandPose3.orientation = postGraspHandPoseQuaternion3
    postGraspHandPoseStamped3.pose = postGraspHandPose3
    postGraspHandPoseMsg3.targetPose = postGraspHandPoseStamped3
    postGraspHandPoseMsg3.orientation_constraints.append(GraspHandPoseOrientationConstraint)
    postGraspHandPoseMsg3.joint_constraints.append(GraspHandPoseJointConstraint1)
    postGraspHandPoseMsg3.joint_constraints.append(GraspHandPoseJointConstraint2)
    postGraspHandPoseMsg3.position_constraints.append(GraspHandPosePositionConstraint)
    pose_generation['postGraspHandPoses3'] = postGraspHandPoseMsg3
    preRealeaseHandPoseMsg = ActionGoalMsg()
    preRealeaseHandPoseStamped = PoseStamped()
    preRealeaseHandPose = Pose()
    preRealeaseHandPosePoint = Point(2.83367, -0.720888, 1.015354)
    preRealeaseHandPoseQuaternion = Quaternion(0.606166, -0.39745, 0.532079, -0.437592)
    preRealeaseHandPose.position = preRealeaseHandPosePoint
    preRealeaseHandPose.orientation = preRealeaseHandPoseQuaternion
    preRealeaseHandPoseStamped.pose = preRealeaseHandPose
    preRealeaseHandPoseMsg.targetPose = preRealeaseHandPoseStamped
    realeaseHandPoseJointConstraint1 = JointConstraint()
    realeaseHandPoseJointConstraint1.joint_name = 'j2n6s300_joint_2'
    realeaseHandPoseJointConstraint1.position = 2.9
    realeaseHandPoseJointConstraint1.tolerance_above = 0.84
    realeaseHandPoseJointConstraint1.tolerance_below = 0.84
    realeaseHandPoseJointConstraint1.weight = 1.0
    realeaseHandPoseJointConstraint2 = JointConstraint()
    realeaseHandPoseJointConstraint2.joint_name = 'j2n6s300_joint_1'
    realeaseHandPoseJointConstraint2.position = 6.283
    realeaseHandPoseJointConstraint2.tolerance_above = 0.0
    realeaseHandPoseJointConstraint2.tolerance_below = 2.0
    realeaseHandPoseJointConstraint2.weight = 1.0
    preRealeaseHandPoseMsg.joint_constraints.append(realeaseHandPoseJointConstraint1)
    preRealeaseHandPoseMsg.joint_constraints.append(realeaseHandPoseJointConstraint2)
    pose_generation['preRealeaseHandPoses'] = preRealeaseHandPoseMsg
    realeaseHandPoseMsg = ActionGoalMsg()
    realeaseHandPoseStamped = PoseStamped()
    realeaseHandPose = Pose()
    realeaseHandPosePoint = Point(2.93367, -0.720888, 0.765354)
    realeaseHandPoseQuaternion = Quaternion(0.606166, -0.39745, 0.532079, -0.437592)
    realeaseHandPose.position = realeaseHandPosePoint
    realeaseHandPose.orientation = realeaseHandPoseQuaternion
    realeaseHandPoseStamped.pose = realeaseHandPose
    realeaseHandPoseMsg.targetPose = realeaseHandPoseStamped
    realeaseHandPoseOrientationConstraint = OrientationConstraint()
    realeaseHandPoseOrientationConstraint.link_name = 'j2n6s300_end_effector'
    realeaseHandPoseOrientationConstraint.header.frame_id = 'world'
    realeaseHandPoseOrientationConstraint.orientation = preRealeaseHandPoseStamped.pose.orientation
    realeaseHandPoseOrientationConstraint.absolute_x_axis_tolerance = 0.1
    realeaseHandPoseOrientationConstraint.absolute_y_axis_tolerance = 0.1
    realeaseHandPoseOrientationConstraint.absolute_z_axis_tolerance = 0.1
    realeaseHandPoseOrientationConstraint.weight = 1.0
    realeaseHandPoseMsg.orientation_constraints.append(realeaseHandPoseOrientationConstraint)
    realeaseHandPoseMsg.joint_constraints.append(realeaseHandPoseJointConstraint1)
    realeaseHandPoseMsg.joint_constraints.append(realeaseHandPoseJointConstraint2)
    pose_generation['realeaseHandPoses'] = realeaseHandPoseMsg
    openHandPoseMsg = ActionGoalMsg()
    openHandPoseStamped = PoseStamped()
    openHandPose = Pose()
    openHandPosePoint = Point(0.2, 0.2, 0.2)
    openHandPose.position = openHandPosePoint
    openHandPoseStamped.pose = openHandPose
    openHandPoseMsg.targetPose = openHandPoseStamped
    pose_generation['openHandPoses'] = openHandPoseMsg
    postRealeaseHandPoseMsg = ActionGoalMsg()
    postRealeaseHandPoseStamped = PoseStamped()
    postRealeaseHandPose = Pose()
    postRealeaseHandPosePoint = Point(2.546045, -0.720888, 0.765354)
    postRealeaseHandPoseQuaternion = Quaternion(0.606166, -0.39745, 0.532079, -0.437592)
    postRealeaseHandPose.position = postRealeaseHandPosePoint
    postRealeaseHandPose.orientation = postRealeaseHandPoseQuaternion
    postRealeaseHandPoseStamped.pose = postRealeaseHandPose
    postRealeaseHandPoseMsg.targetPose = postRealeaseHandPoseStamped
    realeaseHandPosePositionConstraint = PositionConstraint()
    realeaseHandPosePositionConstraint.link_name = 'j2n6s300_end_effector'
    realeaseHandPosePositionConstraint.header.frame_id = 'world'
    realeaseHandPosePositionConstraint.target_point_offset.y = -0.720888
    realeaseHandPosePositionConstraint.target_point_offset.z = postRealeaseHandPose.position.z
    realeaseHandPosePositionConstraint.weight = 1.0
    postRealeaseHandPoseMsg.orientation_constraints.append(realeaseHandPoseOrientationConstraint)
    postRealeaseHandPoseMsg.joint_constraints.append(realeaseHandPoseJointConstraint1)
    postRealeaseHandPoseMsg.joint_constraints.append(realeaseHandPoseJointConstraint2)
    postRealeaseHandPoseMsg.position_constraints.append(realeaseHandPosePositionConstraint)
    pose_generation['postRealeaseHandPoses'] = postRealeaseHandPoseMsg

def handle_motion_planning(req):# dummy function
    rospy.wait_for_service('task_manager/assert_pose')
    try:
        assert_pose = rospy.ServiceProxy('task_manager/assert_pose', PathService)
        for i in req.param3:
            ## should add check available pose 
            res = assert_pose(req.predicate, req.param1, req.param2, [i], req.param4)
            print 'check_path: ' + req.predicate + '(' + req.param1 + ', ' + str(req.param2) + ', ' + str(i) + ', ' + req.param4 + ')'
        print 'Return: 1'
    except rospy.ServiceException, e:
        print "Service call failed: %s"%e
    return PathServiceResponse(1)

def handle_pose_generation(req):# dummy function
    rospy.wait_for_service('task_manager/assert_poses')
    try:
        assert_poses = rospy.ServiceProxy('task_manager/assert_poses', PosesService)
        newParam = []
        if 'Location' in req.param3:
            newParam = ['[0.392, 1.982, ...]']
            res = assert_fact([req.predicate], [req.param1], [req.param2], newParam, [req.param4])
        else:
            if 'Pose' in req.param3:
                res = assert_poses(req.predicate, req.param1, req.param2, [pose_generation[req.param3]], req.param4)
            elif 'Pose' in req.param4 or 'Location' in req.param4:
                newParam = ['[0.392, 1.982, ...]', '[0.198, 1.198, ...]']
                res = assert_poses(req.predicate, req.param1, req.param2, req.param3, newParam)
        # if 'obstructs' in req.param4:
        #     res_tmp1 = assert_fact(['obstructs'], ['crackerBox01'], ['chipsCan02'], [''], [''])
        #     res_tmp2 = assert_fact(['obstructs'], ['crackerBox01'], ['chipsCan03'], [''], [''])
        print 'make_pose: ' + req.predicate + '(' + req.param1 + ', ' + req.param2 + ', ' + req.param3 + ', ' + req.param4 + ')'
        print 'Return: 1'
    except rospy.ServiceException, e:
        print "Service call failed: %s"%e
    return PoseServiceResponse(1)

def TAMP_Interface_server():
    rospy.init_node('tamp_interface')
    init()
    srv1 = rospy.Service('tamp_interface/motion_planning', PathService, handle_motion_planning)
    srv2 = rospy.Service('tamp_interface/pose_generation', PoseService, handle_pose_generation)
    print "Ready to TAMP Interface"
    rospy.spin()

if __name__ == "__main__":
    TAMP_Interface_server()