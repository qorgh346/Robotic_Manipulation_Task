package vision_msgs;

public interface Classification2D extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "vision_msgs/Classification2D";
  static final java.lang.String _DEFINITION = "# Defines a 2D classification result.\n#\n# This result does not contain any position information. It is designed for\n#   classifiers, which simply provide class probabilities given a source image.\n\nHeader header\n\n# A list of class probabilities. This list need not provide a probability for\n#   every possible class, just ones that are nonzero, or above some\n#   user-defined threshold.\nObjectHypothesis[] results\n\n# The 2D data that generated these results (i.e. region proposal cropped out of\n#   the image). Not required for all use cases, so it may be empty.\nsensor_msgs/Image source_img";
  std_msgs.Header getHeader();
  void setHeader(std_msgs.Header value);
  java.util.List<vision_msgs.ObjectHypothesis> getResults();
  void setResults(java.util.List<vision_msgs.ObjectHypothesis> value);
  sensor_msgs.Image getSourceImg();
  void setSourceImg(sensor_msgs.Image value);
}
