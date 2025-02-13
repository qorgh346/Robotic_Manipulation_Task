// Generated by gencpp from file vision_msgs/VisionInfo.msg
// DO NOT EDIT!


#ifndef VISION_MSGS_MESSAGE_VISIONINFO_H
#define VISION_MSGS_MESSAGE_VISIONINFO_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <std_msgs/Header.h>

namespace vision_msgs
{
template <class ContainerAllocator>
struct VisionInfo_
{
  typedef VisionInfo_<ContainerAllocator> Type;

  VisionInfo_()
    : header()
    , method()
    , database_location()
    , database_version(0)  {
    }
  VisionInfo_(const ContainerAllocator& _alloc)
    : header(_alloc)
    , method(_alloc)
    , database_location(_alloc)
    , database_version(0)  {
  (void)_alloc;
    }



   typedef  ::std_msgs::Header_<ContainerAllocator>  _header_type;
  _header_type header;

   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _method_type;
  _method_type method;

   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _database_location_type;
  _database_location_type database_location;

   typedef int32_t _database_version_type;
  _database_version_type database_version;





  typedef boost::shared_ptr< ::vision_msgs::VisionInfo_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::vision_msgs::VisionInfo_<ContainerAllocator> const> ConstPtr;

}; // struct VisionInfo_

typedef ::vision_msgs::VisionInfo_<std::allocator<void> > VisionInfo;

typedef boost::shared_ptr< ::vision_msgs::VisionInfo > VisionInfoPtr;
typedef boost::shared_ptr< ::vision_msgs::VisionInfo const> VisionInfoConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::vision_msgs::VisionInfo_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::vision_msgs::VisionInfo_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace vision_msgs

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': True}
// {'sensor_msgs': ['/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/sensor_msgs/msg'], 'vision_msgs': ['/home/test/Downloads/190816_cmtm_code/catkin_ws/src/vision_msgs/msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'geometry_msgs': ['/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::vision_msgs::VisionInfo_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::vision_msgs::VisionInfo_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vision_msgs::VisionInfo_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vision_msgs::VisionInfo_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vision_msgs::VisionInfo_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vision_msgs::VisionInfo_<ContainerAllocator> const>
  : TrueType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::vision_msgs::VisionInfo_<ContainerAllocator> >
{
  static const char* value()
  {
    return "eee36f8dc558754ceb4ef619179d8b34";
  }

  static const char* value(const ::vision_msgs::VisionInfo_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xeee36f8dc558754cULL;
  static const uint64_t static_value2 = 0xeb4ef619179d8b34ULL;
};

template<class ContainerAllocator>
struct DataType< ::vision_msgs::VisionInfo_<ContainerAllocator> >
{
  static const char* value()
  {
    return "vision_msgs/VisionInfo";
  }

  static const char* value(const ::vision_msgs::VisionInfo_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::vision_msgs::VisionInfo_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# Provides meta-information about a visual pipeline.\n\
#\n\
# This message serves a similar purpose to sensor_msgs/CameraInfo, but instead\n\
#   of being tied to hardware, it represents information about a specific\n\
#   computer vision pipeline. This information stays constant (or relatively\n\
#   constant) over time, and so it is wasteful to send it with each individual\n\
#   result. By listening to these messages, subscribers will receive\n\
#   the context in which published vision messages are to be interpreted.\n\
# Each vision pipeline should publish its VisionInfo messages to its own topic,\n\
#   in a manner similar to CameraInfo.\n\
\n\
# Used for sequencing\n\
Header header\n\
\n\
# Name of the vision pipeline. This should be a value that is meaningful to an\n\
#   outside user.\n\
string method\n\
\n\
# Location where the metadata database is stored. The recommended location is\n\
#   as an XML string on the ROS parameter server, but the exact implementation\n\
#   and information is left up to the user.\n\
# The database should store information attached to numeric ids. Each\n\
#   numeric id should map to an atomic, visually recognizable element. This\n\
#   definition is intentionally vague to allow extreme flexibility. The\n\
#   elements could be classes in a pixel segmentation algorithm, object classes\n\
#   in a detector, different people's faces in a face detection algorithm, etc.\n\
#   Vision pipelines report results in terms of numeric IDs, which map into\n\
#   this  database.\n\
# The information stored in this database is, again, left up to the user. The\n\
#   database could be as simple as a map from ID to class name, or it could\n\
#   include information such as object meshes or colors to use for\n\
#   visualization.\n\
string database_location\n\
\n\
# Metadata database version. This counter is incremented\n\
#   each time the pipeline begins using a new version of the database (useful\n\
#   in the case of online training or user modifications).\n\
#   The counter value can be monitored by listeners to ensure that the pipeline\n\
#   and the listener are using the same metadata.\n\
int32 database_version\n\
================================================================================\n\
MSG: std_msgs/Header\n\
# Standard metadata for higher-level stamped data types.\n\
# This is generally used to communicate timestamped data \n\
# in a particular coordinate frame.\n\
# \n\
# sequence ID: consecutively increasing ID \n\
uint32 seq\n\
#Two-integer timestamp that is expressed as:\n\
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')\n\
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')\n\
# time-handling sugar is provided by the client library\n\
time stamp\n\
#Frame this data is associated with\n\
# 0: no frame\n\
# 1: global frame\n\
string frame_id\n\
";
  }

  static const char* value(const ::vision_msgs::VisionInfo_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::vision_msgs::VisionInfo_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.header);
      stream.next(m.method);
      stream.next(m.database_location);
      stream.next(m.database_version);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct VisionInfo_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::vision_msgs::VisionInfo_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::vision_msgs::VisionInfo_<ContainerAllocator>& v)
  {
    s << indent << "header: ";
    s << std::endl;
    Printer< ::std_msgs::Header_<ContainerAllocator> >::stream(s, indent + "  ", v.header);
    s << indent << "method: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.method);
    s << indent << "database_location: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.database_location);
    s << indent << "database_version: ";
    Printer<int32_t>::stream(s, indent + "  ", v.database_version);
  }
};

} // namespace message_operations
} // namespace ros

#endif // VISION_MSGS_MESSAGE_VISIONINFO_H
