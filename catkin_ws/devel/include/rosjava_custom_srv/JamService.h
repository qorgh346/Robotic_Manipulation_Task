// Generated by gencpp from file rosjava_custom_srv/JamService.msg
// DO NOT EDIT!


#ifndef ROSJAVA_CUSTOM_SRV_MESSAGE_JAMSERVICE_H
#define ROSJAVA_CUSTOM_SRV_MESSAGE_JAMSERVICE_H

#include <ros/service_traits.h>


#include <rosjava_custom_srv/JamServiceRequest.h>
#include <rosjava_custom_srv/JamServiceResponse.h>


namespace rosjava_custom_srv
{

struct JamService
{

typedef JamServiceRequest Request;
typedef JamServiceResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct JamService
} // namespace rosjava_custom_srv


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::rosjava_custom_srv::JamService > {
  static const char* value()
  {
    return "31d2fe905e359df0b2a8510339b9b736";
  }

  static const char* value(const ::rosjava_custom_srv::JamService&) { return value(); }
};

template<>
struct DataType< ::rosjava_custom_srv::JamService > {
  static const char* value()
  {
    return "rosjava_custom_srv/JamService";
  }

  static const char* value(const ::rosjava_custom_srv::JamService&) { return value(); }
};


// service_traits::MD5Sum< ::rosjava_custom_srv::JamServiceRequest> should match 
// service_traits::MD5Sum< ::rosjava_custom_srv::JamService > 
template<>
struct MD5Sum< ::rosjava_custom_srv::JamServiceRequest>
{
  static const char* value()
  {
    return MD5Sum< ::rosjava_custom_srv::JamService >::value();
  }
  static const char* value(const ::rosjava_custom_srv::JamServiceRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::rosjava_custom_srv::JamServiceRequest> should match 
// service_traits::DataType< ::rosjava_custom_srv::JamService > 
template<>
struct DataType< ::rosjava_custom_srv::JamServiceRequest>
{
  static const char* value()
  {
    return DataType< ::rosjava_custom_srv::JamService >::value();
  }
  static const char* value(const ::rosjava_custom_srv::JamServiceRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::rosjava_custom_srv::JamServiceResponse> should match 
// service_traits::MD5Sum< ::rosjava_custom_srv::JamService > 
template<>
struct MD5Sum< ::rosjava_custom_srv::JamServiceResponse>
{
  static const char* value()
  {
    return MD5Sum< ::rosjava_custom_srv::JamService >::value();
  }
  static const char* value(const ::rosjava_custom_srv::JamServiceResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::rosjava_custom_srv::JamServiceResponse> should match 
// service_traits::DataType< ::rosjava_custom_srv::JamService > 
template<>
struct DataType< ::rosjava_custom_srv::JamServiceResponse>
{
  static const char* value()
  {
    return DataType< ::rosjava_custom_srv::JamService >::value();
  }
  static const char* value(const ::rosjava_custom_srv::JamServiceResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // ROSJAVA_CUSTOM_SRV_MESSAGE_JAMSERVICE_H
