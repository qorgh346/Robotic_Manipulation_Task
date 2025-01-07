package moveit_msgs;

public interface ExecuteTrajectory extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "moveit_msgs/ExecuteTrajectory";
  static final java.lang.String _DEFINITION = "# The trajectory to execute\nRobotTrajectory trajectory\n\n---\n\n# Error code - encodes the overall reason for failure\nMoveItErrorCodes error_code\n\n---\n\n# The internal state that the move group action currently is in\nstring state\n";
}
