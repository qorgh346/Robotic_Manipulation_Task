package rosjava_custom_srv;

public interface PoseServiceRequest extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "rosjava_custom_srv/PoseServiceRequest";
  static final java.lang.String _DEFINITION = "string predicate\nstring param1\nstring param2\nstring param3\nstring param4\n";
  java.lang.String getPredicate();
  void setPredicate(java.lang.String value);
  java.lang.String getParam1();
  void setParam1(java.lang.String value);
  java.lang.String getParam2();
  void setParam2(java.lang.String value);
  java.lang.String getParam3();
  void setParam3(java.lang.String value);
  java.lang.String getParam4();
  void setParam4(java.lang.String value);
}
