package vision_msgs;

public interface BoundingBox2D extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "vision_msgs/BoundingBox2D";
  static final java.lang.String _DEFINITION = "# A 2D bounding box that can be rotated about its center.\n# All dimensions are in pixels, but represented using floating-point\n#   values to allow sub-pixel precision. If an exact pixel crop is required\n#   for a rotated bounding box, it can be calculated using Bresenham\'s line\n#   algorithm.\n\n# The 2D position (in pixels) and orientation of the bounding box center.\ngeometry_msgs/Pose2D center\n\n# The size (in pixels) of the bounding box surrounding the object relative\n#   to the pose of its center.\nfloat64 size_x\nfloat64 size_y\n";
  geometry_msgs.Pose2D getCenter();
  void setCenter(geometry_msgs.Pose2D value);
  double getSizeX();
  void setSizeX(double value);
  double getSizeY();
  void setSizeY(double value);
}
