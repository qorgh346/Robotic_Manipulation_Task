package vision_msgs;

public interface Detection2D extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "vision_msgs/Detection2D";
  static final java.lang.String _DEFINITION = "# Defines a 2D detection result.\n#\n# This is similar to a 2D classification, but includes position information,\n#   allowing a classification result for a specific crop or image point to\n#   to be located in the larger image.\n\nHeader header\n\n# Class probabilities\nObjectHypothesisWithPose[] results\n\n# 2D bounding box surrounding the object.\nBoundingBox2D bbox\n\n# The 2D data that generated these results (i.e. region proposal cropped out of\n#   the image). Not required for all use cases, so it may be empty.\nsensor_msgs/Image source_img\n";
  std_msgs.Header getHeader();
  void setHeader(std_msgs.Header value);
  java.util.List<vision_msgs.ObjectHypothesisWithPose> getResults();
  void setResults(java.util.List<vision_msgs.ObjectHypothesisWithPose> value);
  vision_msgs.BoundingBox2D getBbox();
  void setBbox(vision_msgs.BoundingBox2D value);
  sensor_msgs.Image getSourceImg();
  void setSourceImg(sensor_msgs.Image value);
}
