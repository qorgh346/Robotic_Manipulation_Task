// Generated by gencpp from file moveit_msgs/JointConstraint.msg
// DO NOT EDIT!


#ifndef MOVEIT_MSGS_MESSAGE_JOINTCONSTRAINT_H
#define MOVEIT_MSGS_MESSAGE_JOINTCONSTRAINT_H


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
struct JointConstraint_
{
  typedef JointConstraint_<ContainerAllocator> Type;

  JointConstraint_()
    : joint_name()
    , position(0.0)
    , tolerance_above(0.0)
    , tolerance_below(0.0)
    , weight(0.0)  {
    }
  JointConstraint_(const ContainerAllocator& _alloc)
    : joint_name(_alloc)
    , position(0.0)
    , tolerance_above(0.0)
    , tolerance_below(0.0)
    , weight(0.0)  {
  (void)_alloc;
    }



   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _joint_name_type;
  _joint_name_type joint_name;

   typedef double _position_type;
  _position_type position;

   typedef double _tolerance_above_type;
  _tolerance_above_type tolerance_above;

   typedef double _tolerance_below_type;
  _tolerance_below_type tolerance_below;

   typedef double _weight_type;
  _weight_type weight;





  typedef boost::shared_ptr< ::moveit_msgs::JointConstraint_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::moveit_msgs::JointConstraint_<ContainerAllocator> const> ConstPtr;

}; // struct JointConstraint_

typedef ::moveit_msgs::JointConstraint_<std::allocator<void> > JointConstraint;

typedef boost::shared_ptr< ::moveit_msgs::JointConstraint > JointConstraintPtr;
typedef boost::shared_ptr< ::moveit_msgs::JointConstraint const> JointConstraintConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::moveit_msgs::JointConstraint_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::moveit_msgs::JointConstraint_<ContainerAllocator> >::stream(s, "", v);
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
struct IsFixedSize< ::moveit_msgs::JointConstraint_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::moveit_msgs::JointConstraint_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::moveit_msgs::JointConstraint_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::moveit_msgs::JointConstraint_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::moveit_msgs::JointConstraint_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::moveit_msgs::JointConstraint_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::moveit_msgs::JointConstraint_<ContainerAllocator> >
{
  static const char* value()
  {
    return "c02a15146bec0ce13564807805b008f0";
  }

  static const char* value(const ::moveit_msgs::JointConstraint_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xc02a15146bec0ce1ULL;
  static const uint64_t static_value2 = 0x3564807805b008f0ULL;
};

template<class ContainerAllocator>
struct DataType< ::moveit_msgs::JointConstraint_<ContainerAllocator> >
{
  static const char* value()
  {
    return "moveit_msgs/JointConstraint";
  }

  static const char* value(const ::moveit_msgs::JointConstraint_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::moveit_msgs::JointConstraint_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# Constrain the position of a joint to be within a certain bound\n\
string joint_name\n\
\n\
# the bound to be achieved is [position - tolerance_below, position + tolerance_above]\n\
float64 position\n\
float64 tolerance_above\n\
float64 tolerance_below\n\
\n\
# A weighting factor for this constraint (denotes relative importance to other constraints. Closer to zero means less important)\n\
float64 weight\n\
";
  }

  static const char* value(const ::moveit_msgs::JointConstraint_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::moveit_msgs::JointConstraint_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.joint_name);
      stream.next(m.position);
      stream.next(m.tolerance_above);
      stream.next(m.tolerance_below);
      stream.next(m.weight);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct JointConstraint_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::moveit_msgs::JointConstraint_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::moveit_msgs::JointConstraint_<ContainerAllocator>& v)
  {
    s << indent << "joint_name: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.joint_name);
    s << indent << "position: ";
    Printer<double>::stream(s, indent + "  ", v.position);
    s << indent << "tolerance_above: ";
    Printer<double>::stream(s, indent + "  ", v.tolerance_above);
    s << indent << "tolerance_below: ";
    Printer<double>::stream(s, indent + "  ", v.tolerance_below);
    s << indent << "weight: ";
    Printer<double>::stream(s, indent + "  ", v.weight);
  }
};

} // namespace message_operations
} // namespace ros

#endif // MOVEIT_MSGS_MESSAGE_JOINTCONSTRAINT_H
