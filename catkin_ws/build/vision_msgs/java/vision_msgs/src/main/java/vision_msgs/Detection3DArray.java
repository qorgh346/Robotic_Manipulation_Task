package vision_msgs;

public interface Detection3DArray extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "vision_msgs/Detection3DArray";
  static final java.lang.String _DEFINITION = "# A list of 3D detections, for a multi-object 3D detector.\n\nHeader header\n\n# A list of the detected proposals. A multi-proposal detector might generate\n#   this list with many candidate detections generated from a single input.\nDetection3D[] detections\n";
  std_msgs.Header getHeader();
  void setHeader(std_msgs.Header value);
  java.util.List<vision_msgs.Detection3D> getDetections();
  void setDetections(java.util.List<vision_msgs.Detection3D> value);
}
