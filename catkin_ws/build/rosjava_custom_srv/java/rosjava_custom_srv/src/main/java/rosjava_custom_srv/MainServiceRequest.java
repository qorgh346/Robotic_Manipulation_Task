package rosjava_custom_srv;

public interface MainServiceRequest extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "rosjava_custom_srv/MainServiceRequest";
  static final java.lang.String _DEFINITION = "string[] predicate\nstring[] param1\nstring[] param2\nstring[] param3\nstring[] param4\n\nint32[] status\nstring manager\n";
  java.util.List<java.lang.String> getPredicate();
  void setPredicate(java.util.List<java.lang.String> value);
  java.util.List<java.lang.String> getParam1();
  void setParam1(java.util.List<java.lang.String> value);
  java.util.List<java.lang.String> getParam2();
  void setParam2(java.util.List<java.lang.String> value);
  java.util.List<java.lang.String> getParam3();
  void setParam3(java.util.List<java.lang.String> value);
  java.util.List<java.lang.String> getParam4();
  void setParam4(java.util.List<java.lang.String> value);
  int[] getStatus();
  void setStatus(int[] value);
  java.lang.String getManager();
  void setManager(java.lang.String value);
}
