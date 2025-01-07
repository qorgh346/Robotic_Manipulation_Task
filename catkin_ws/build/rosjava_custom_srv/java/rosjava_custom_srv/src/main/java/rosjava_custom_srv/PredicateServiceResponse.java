package rosjava_custom_srv;

public interface PredicateServiceResponse extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "rosjava_custom_srv/PredicateServiceResponse";
  static final java.lang.String _DEFINITION = "int32 result";
  int getResult();
  void setResult(int value);
}
