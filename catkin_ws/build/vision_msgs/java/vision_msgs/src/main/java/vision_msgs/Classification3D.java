package vision_msgs;

public interface Classification3D extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "vision_msgs/Classification3D";
  static final java.lang.String _DEFINITION = "# Defines a 3D classification result.\n#\n# This result does not contain any position information. It is designed for\n#   classifiers, which simply provide probabilities given a source image.\n\nHeader header\n\n# Class probabilities\nObjectHypothesis[] results\n\n# The 3D data that generated these results (i.e. region proposal cropped out of\n#   the image). Not required for all detectors, so it may be empty.\nsensor_msgs/PointCloud2 source_cloud";
  std_msgs.Header getHeader();
  void setHeader(std_msgs.Header value);
  java.util.List<vision_msgs.ObjectHypothesis> getResults();
  void setResults(java.util.List<vision_msgs.ObjectHypothesis> value);
  sensor_msgs.PointCloud2 getSourceCloud();
  void setSourceCloud(sensor_msgs.PointCloud2 value);
}
