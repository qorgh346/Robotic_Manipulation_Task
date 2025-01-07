package rosjava_custom_srv;

public interface ActionResultMsg extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "rosjava_custom_srv/ActionResultMsg";
  static final java.lang.String _DEFINITION = "int32 actionStatus\n";
  int getActionStatus();
  void setActionStatus(int value);
}
