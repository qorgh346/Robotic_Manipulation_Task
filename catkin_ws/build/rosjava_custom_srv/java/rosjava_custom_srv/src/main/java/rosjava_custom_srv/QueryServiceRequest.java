package rosjava_custom_srv;

public interface QueryServiceRequest extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "rosjava_custom_srv/QueryServiceRequest";
  static final java.lang.String _DEFINITION = "string query\nstring manager\n";
  java.lang.String getQuery();
  void setQuery(java.lang.String value);
  java.lang.String getManager();
  void setManager(java.lang.String value);
}
