package rosjava_custom_srv;

public interface ArmAction extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "rosjava_custom_srv/ArmAction";
  static final java.lang.String _DEFINITION = "int32 targetBody\nint32 actionGoal\nstring object\nmoveit_msgs/JointConstraint[] joint_constraints\nmoveit_msgs/PositionConstraint[] position_constraints\nmoveit_msgs/OrientationConstraint[] orientation_constraints\nmoveit_msgs/VisibilityConstraint[] visibility_constraints\ngeometry_msgs/PoseStamped targetPose\nsensor_msgs/JointState targetJointState\n\n";
  int getTargetBody();
  void setTargetBody(int value);
  int getActionGoal();
  void setActionGoal(int value);
  java.lang.String getObject();
  void setObject(java.lang.String value);
  java.util.List<moveit_msgs.JointConstraint> getJointConstraints();
  void setJointConstraints(java.util.List<moveit_msgs.JointConstraint> value);
  java.util.List<moveit_msgs.PositionConstraint> getPositionConstraints();
  void setPositionConstraints(java.util.List<moveit_msgs.PositionConstraint> value);
  java.util.List<moveit_msgs.OrientationConstraint> getOrientationConstraints();
  void setOrientationConstraints(java.util.List<moveit_msgs.OrientationConstraint> value);
  java.util.List<moveit_msgs.VisibilityConstraint> getVisibilityConstraints();
  void setVisibilityConstraints(java.util.List<moveit_msgs.VisibilityConstraint> value);
  geometry_msgs.PoseStamped getTargetPose();
  void setTargetPose(geometry_msgs.PoseStamped value);
  sensor_msgs.JointState getTargetJointState();
  void setTargetJointState(sensor_msgs.JointState value);
}
