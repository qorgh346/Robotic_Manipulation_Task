package rosjava_custom_srv;

public interface PosesServiceRequest extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "rosjava_custom_srv/PosesServiceRequest";
  static final java.lang.String _DEFINITION = "string predicate\nstring param1\nstring param2\nActionGoalMsg[] param3\nstring param4\n";
  java.lang.String getPredicate();
  void setPredicate(java.lang.String value);
  java.lang.String getParam1();
  void setParam1(java.lang.String value);
  java.lang.String getParam2();
  void setParam2(java.lang.String value);
  java.util.List<rosjava_custom_srv.ActionGoalMsg> getParam3();
  void setParam3(java.util.List<rosjava_custom_srv.ActionGoalMsg> value);
  java.lang.String getParam4();
  void setParam4(java.lang.String value);
}
