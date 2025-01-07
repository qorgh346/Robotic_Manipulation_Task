package vision_msgs;

public interface ObjectHypothesisWithPose extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "vision_msgs/ObjectHypothesisWithPose";
  static final java.lang.String _DEFINITION = "# An object hypothesis that contains position information.\n\n# The unique numeric ID of the object class. To get additional information about\n#   this ID, such as its human-readable class name, listeners should perform a\n#   lookup in a metadata database. See vision_msgs/VisionInfo.msg for more detail.\nint64 id\n\n# The probability or confidence value of the detected object. By convention,\n#   this value should lie in the range [0-1].\nfloat64 score\n\n# The 6D pose of the object hypothesis. This pose should be\n#   defined as the pose of some fixed reference point on the object, such a\n#   the geometric center of the bounding box or the center of mass of the\n#   object.\n# Note that this pose is not stamped; frame information can be defined by\n#   parent messages.\n# Also note that different classes predicted for the same input data may have\n#   different predicted 6D poses.\ngeometry_msgs/PoseWithCovariance pose\n";
  long getId();
  void setId(long value);
  double getScore();
  void setScore(double value);
  geometry_msgs.PoseWithCovariance getPose();
  void setPose(geometry_msgs.PoseWithCovariance value);
}
