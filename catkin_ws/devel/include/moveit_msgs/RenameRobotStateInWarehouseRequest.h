// Generated by gencpp from file moveit_msgs/RenameRobotStateInWarehouseRequest.msg
// DO NOT EDIT!


#ifndef MOVEIT_MSGS_MESSAGE_RENAMEROBOTSTATEINWAREHOUSEREQUEST_H
#define MOVEIT_MSGS_MESSAGE_RENAMEROBOTSTATEINWAREHOUSEREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace moveit_msgs
{
template <class ContainerAllocator>
struct RenameRobotStateInWarehouseRequest_
{
  typedef RenameRobotStateInWarehouseRequest_<ContainerAllocator> Type;

  RenameRobotStateInWarehouseRequest_()
    : old_name()
    , new_name()
    , robot()  {
    }
  RenameRobotStateInWarehouseRequest_(const ContainerAllocator& _alloc)
    : old_name(_alloc)
    , new_name(_alloc)
    , robot(_alloc)  {
  (void)_alloc;
    }



   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _old_name_type;
  _old_name_type old_name;

   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _new_name_type;
  _new_name_type new_name;

   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _robot_type;
  _robot_type robot;





  typedef boost::shared_ptr< ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator> const> ConstPtr;

}; // struct RenameRobotStateInWarehouseRequest_

typedef ::moveit_msgs::RenameRobotStateInWarehouseRequest_<std::allocator<void> > RenameRobotStateInWarehouseRequest;

typedef boost::shared_ptr< ::moveit_msgs::RenameRobotStateInWarehouseRequest > RenameRobotStateInWarehouseRequestPtr;
typedef boost::shared_ptr< ::moveit_msgs::RenameRobotStateInWarehouseRequest const> RenameRobotStateInWarehouseRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace moveit_msgs

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': False}
// {'shape_msgs': ['/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/shape_msgs/msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'moveit_msgs': ['/home/test/Downloads/190816_cmtm_code/catkin_ws/devel/share/moveit_msgs/msg', '/home/test/Downloads/190816_cmtm_code/catkin_ws/src/moveit_msgs/msg'], 'trajectory_msgs': ['/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/trajectory_msgs/msg'], 'sensor_msgs': ['/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/sensor_msgs/msg'], 'object_recognition_msgs': ['/home/test/Downloads/190816_cmtm_code/catkin_ws/devel/share/object_recognition_msgs/msg', '/home/test/Downloads/190816_cmtm_code/catkin_ws/src/object_recognition_msgs/msg'], 'octomap_msgs': ['/home/test/Downloads/190816_cmtm_code/catkin_ws/src/octomap_msgs/msg'], 'geometry_msgs': ['/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/geometry_msgs/msg'], 'actionlib_msgs': ['/home/test/Downloads/190816_cmtm_code/catkin_ws/src/common_msgs/actionlib_msgs/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "073dc05c3fd313b947cea483c25c46b0";
  }

  static const char* value(const ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x073dc05c3fd313b9ULL;
  static const uint64_t static_value2 = 0x47cea483c25c46b0ULL;
};

template<class ContainerAllocator>
struct DataType< ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "moveit_msgs/RenameRobotStateInWarehouseRequest";
  }

  static const char* value(const ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "string old_name\n\
string new_name\n\
string robot\n\
";
  }

  static const char* value(const ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.old_name);
      stream.next(m.new_name);
      stream.next(m.robot);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct RenameRobotStateInWarehouseRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::moveit_msgs::RenameRobotStateInWarehouseRequest_<ContainerAllocator>& v)
  {
    s << indent << "old_name: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.old_name);
    s << indent << "new_name: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.new_name);
    s << indent << "robot: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.robot);
  }
};

} // namespace message_operations
} // namespace ros

#endif // MOVEIT_MSGS_MESSAGE_RENAMEROBOTSTATEINWAREHOUSEREQUEST_H
