package moveit_msgs;

public interface ExecuteTrajectoryGoal extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "moveit_msgs/ExecuteTrajectoryGoal";
  static final java.lang.String _DEFINITION = "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======\n#goal definition# The trajectory to execute\nRobotTrajectory trajectory\n\n";
  moveit_msgs.RobotTrajectory getTrajectory();
  void setTrajectory(moveit_msgs.RobotTrajectory value);
}
