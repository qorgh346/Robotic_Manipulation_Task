package rosjava_custom_srv;

public interface ActionState extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "rosjava_custom_srv/ActionState";
  static final java.lang.String _DEFINITION = "int32 status\n";
  int getStatus();
  void setStatus(int value);
}
