package rosjava_custom_srv;

public interface JamServiceRequest extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "rosjava_custom_srv/JamServiceRequest";
  static final java.lang.String _DEFINITION = "string path\n";
  java.lang.String getPath();
  void setPath(java.lang.String value);
}
