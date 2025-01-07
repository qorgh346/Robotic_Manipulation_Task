package vision_msgs;

public interface BoundingBox3D extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "vision_msgs/BoundingBox3D";
  static final java.lang.String _DEFINITION = "# A 3D bounding box that can be positioned and rotated about its center (6 DOF)\n# Dimensions of this box are in meters, and as such, it may be migrated to\n#   another package, such as geometry_msgs, in the future.\n\n# The 3D position and orientation of the bounding box center\ngeometry_msgs/Pose center\n\n# The size of the bounding box, in meters, surrounding the object\'s center\n#   pose.\ngeometry_msgs/Vector3 size\n";
  geometry_msgs.Pose getCenter();
  void setCenter(geometry_msgs.Pose value);
  geometry_msgs.Vector3 getSize();
  void setSize(geometry_msgs.Vector3 value);
}
