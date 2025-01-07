package vision_msgs;

public interface VisionInfo extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "vision_msgs/VisionInfo";
  static final java.lang.String _DEFINITION = "# Provides meta-information about a visual pipeline.\n#\n# This message serves a similar purpose to sensor_msgs/CameraInfo, but instead\n#   of being tied to hardware, it represents information about a specific\n#   computer vision pipeline. This information stays constant (or relatively\n#   constant) over time, and so it is wasteful to send it with each individual\n#   result. By listening to these messages, subscribers will receive\n#   the context in which published vision messages are to be interpreted.\n# Each vision pipeline should publish its VisionInfo messages to its own topic,\n#   in a manner similar to CameraInfo.\n\n# Used for sequencing\nHeader header\n\n# Name of the vision pipeline. This should be a value that is meaningful to an\n#   outside user.\nstring method\n\n# Location where the metadata database is stored. The recommended location is\n#   as an XML string on the ROS parameter server, but the exact implementation\n#   and information is left up to the user.\n# The database should store information attached to numeric ids. Each\n#   numeric id should map to an atomic, visually recognizable element. This\n#   definition is intentionally vague to allow extreme flexibility. The\n#   elements could be classes in a pixel segmentation algorithm, object classes\n#   in a detector, different people\'s faces in a face detection algorithm, etc.\n#   Vision pipelines report results in terms of numeric IDs, which map into\n#   this  database.\n# The information stored in this database is, again, left up to the user. The\n#   database could be as simple as a map from ID to class name, or it could\n#   include information such as object meshes or colors to use for\n#   visualization.\nstring database_location\n\n# Metadata database version. This counter is incremented\n#   each time the pipeline begins using a new version of the database (useful\n#   in the case of online training or user modifications).\n#   The counter value can be monitored by listeners to ensure that the pipeline\n#   and the listener are using the same metadata.\nint32 database_version";
  std_msgs.Header getHeader();
  void setHeader(std_msgs.Header value);
  java.lang.String getMethod();
  void setMethod(java.lang.String value);
  java.lang.String getDatabaseLocation();
  void setDatabaseLocation(java.lang.String value);
  int getDatabaseVersion();
  void setDatabaseVersion(int value);
}
