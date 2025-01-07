; Auto-generated. Do not edit!


(cl:in-package rosjava_custom_srv-msg)


;//! \htmlinclude ActionResultMsg.msg.html

(cl:defclass <ActionResultMsg> (roslisp-msg-protocol:ros-message)
  ((actionStatus
    :reader actionStatus
    :initarg :actionStatus
    :type cl:integer
    :initform 0))
)

(cl:defclass ActionResultMsg (<ActionResultMsg>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ActionResultMsg>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ActionResultMsg)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosjava_custom_srv-msg:<ActionResultMsg> is deprecated: use rosjava_custom_srv-msg:ActionResultMsg instead.")))

(cl:ensure-generic-function 'actionStatus-val :lambda-list '(m))
(cl:defmethod actionStatus-val ((m <ActionResultMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-msg:actionStatus-val is deprecated.  Use rosjava_custom_srv-msg:actionStatus instead.")
  (actionStatus m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ActionResultMsg>) ostream)
  "Serializes a message object of type '<ActionResultMsg>"
  (cl:let* ((signed (cl:slot-value msg 'actionStatus)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ActionResultMsg>) istream)
  "Deserializes a message object of type '<ActionResultMsg>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'actionStatus) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ActionResultMsg>)))
  "Returns string type for a message object of type '<ActionResultMsg>"
  "rosjava_custom_srv/ActionResultMsg")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ActionResultMsg)))
  "Returns string type for a message object of type 'ActionResultMsg"
  "rosjava_custom_srv/ActionResultMsg")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ActionResultMsg>)))
  "Returns md5sum for a message object of type '<ActionResultMsg>"
  "d0d63bd7875eb84a563aa44f75268f19")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ActionResultMsg)))
  "Returns md5sum for a message object of type 'ActionResultMsg"
  "d0d63bd7875eb84a563aa44f75268f19")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ActionResultMsg>)))
  "Returns full string definition for message of type '<ActionResultMsg>"
  (cl:format cl:nil "int32 actionStatus~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ActionResultMsg)))
  "Returns full string definition for message of type 'ActionResultMsg"
  (cl:format cl:nil "int32 actionStatus~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ActionResultMsg>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ActionResultMsg>))
  "Converts a ROS message object to a list"
  (cl:list 'ActionResultMsg
    (cl:cons ':actionStatus (actionStatus msg))
))
