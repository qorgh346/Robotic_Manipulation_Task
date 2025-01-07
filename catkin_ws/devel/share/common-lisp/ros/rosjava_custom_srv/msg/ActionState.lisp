; Auto-generated. Do not edit!


(cl:in-package rosjava_custom_srv-msg)


;//! \htmlinclude ActionState.msg.html

(cl:defclass <ActionState> (roslisp-msg-protocol:ros-message)
  ((status
    :reader status
    :initarg :status
    :type cl:integer
    :initform 0))
)

(cl:defclass ActionState (<ActionState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ActionState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ActionState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosjava_custom_srv-msg:<ActionState> is deprecated: use rosjava_custom_srv-msg:ActionState instead.")))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <ActionState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-msg:status-val is deprecated.  Use rosjava_custom_srv-msg:status instead.")
  (status m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ActionState>) ostream)
  "Serializes a message object of type '<ActionState>"
  (cl:let* ((signed (cl:slot-value msg 'status)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ActionState>) istream)
  "Deserializes a message object of type '<ActionState>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'status) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ActionState>)))
  "Returns string type for a message object of type '<ActionState>"
  "rosjava_custom_srv/ActionState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ActionState)))
  "Returns string type for a message object of type 'ActionState"
  "rosjava_custom_srv/ActionState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ActionState>)))
  "Returns md5sum for a message object of type '<ActionState>"
  "86791dcf1de997ec7de5a0de7e4dcfcc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ActionState)))
  "Returns md5sum for a message object of type 'ActionState"
  "86791dcf1de997ec7de5a0de7e4dcfcc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ActionState>)))
  "Returns full string definition for message of type '<ActionState>"
  (cl:format cl:nil "int32 status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ActionState)))
  "Returns full string definition for message of type 'ActionState"
  (cl:format cl:nil "int32 status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ActionState>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ActionState>))
  "Converts a ROS message object to a list"
  (cl:list 'ActionState
    (cl:cons ':status (status msg))
))
