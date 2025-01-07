package vision_msgs;

public interface ObjectHypothesis extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "vision_msgs/ObjectHypothesis";
  static final java.lang.String _DEFINITION = "# An object hypothesis that contains no position information.\n\n# The unique numeric ID of object detected. To get additional information about\n#   this ID, such as its human-readable name, listeners should perform a lookup\n#   in a metadata database. See vision_msgs/VisionInfo.msg for more detail.\nint64 id\n\n# The probability or confidence value of the detected object. By convention,\n#   this value should lie in the range [0-1].\nfloat64 score";
  long getId();
  void setId(long value);
  double getScore();
  void setScore(double value);
}
