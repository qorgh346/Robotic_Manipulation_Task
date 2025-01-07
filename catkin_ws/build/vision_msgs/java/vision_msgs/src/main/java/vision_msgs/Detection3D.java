package vision_msgs;

public interface Detection3D extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "vision_msgs/Detection3D";
  static final java.lang.String _DEFINITION = "# Defines a 3D detection result.\n#\n# This extends a basic 3D classification by including position information,\n#   allowing a classification result for a specific position in an image to\n#   to be located in the larger image.\n\nHeader header\n\n# Class probabilities. Does not have to include hypotheses for all possible\n#   object ids, the scores for any ids not listed are assumed to be 0.\nObjectHypothesisWithPose[] results\n\n# 3D bounding box surrounding the object.\nBoundingBox3D bbox\n\n# The 3D data that generated these results (i.e. region proposal cropped out of\n#   the image). This information is not required for all detectors, so it may\n#   be empty.\nsensor_msgs/PointCloud2 source_cloud\n";
  std_msgs.Header getHeader();
  void setHeader(std_msgs.Header value);
  java.util.List<vision_msgs.ObjectHypothesisWithPose> getResults();
  void setResults(java.util.List<vision_msgs.ObjectHypothesisWithPose> value);
  vision_msgs.BoundingBox3D getBbox();
  void setBbox(vision_msgs.BoundingBox3D value);
  sensor_msgs.PointCloud2 getSourceCloud();
  void setSourceCloud(sensor_msgs.PointCloud2 value);
}
