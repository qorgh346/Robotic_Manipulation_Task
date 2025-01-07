; Auto-generated. Do not edit!


(cl:in-package rosjava_custom_srv-msg)


;//! \htmlinclude QueryServiceResponse.msg.html

(cl:defclass <QueryServiceResponse> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:string
    :initform ""))
)

(cl:defclass QueryServiceResponse (<QueryServiceResponse>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <QueryServiceResponse>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'QueryServiceResponse)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosjava_custom_srv-msg:<QueryServiceResponse> is deprecated: use rosjava_custom_srv-msg:QueryServiceResponse instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <QueryServiceResponse>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-msg:result-val is deprecated.  Use rosjava_custom_srv-msg:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <QueryServiceResponse>) ostream)
  "Serializes a message object of type '<QueryServiceResponse>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'result))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'result))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <QueryServiceResponse>) istream)
  "Deserializes a message object of type '<QueryServiceResponse>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'result) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<QueryServiceResponse>)))
  "Returns string type for a message object of type '<QueryServiceResponse>"
  "rosjava_custom_srv/QueryServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'QueryServiceResponse)))
  "Returns string type for a message object of type 'QueryServiceResponse"
  "rosjava_custom_srv/QueryServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<QueryServiceResponse>)))
  "Returns md5sum for a message object of type '<QueryServiceResponse>"
  "c22f2a1ed8654a0b365f1bb3f7ff2c0f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'QueryServiceResponse)))
  "Returns md5sum for a message object of type 'QueryServiceResponse"
  "c22f2a1ed8654a0b365f1bb3f7ff2c0f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<QueryServiceResponse>)))
  "Returns full string definition for message of type '<QueryServiceResponse>"
  (cl:format cl:nil "string result~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'QueryServiceResponse)))
  "Returns full string definition for message of type 'QueryServiceResponse"
  (cl:format cl:nil "string result~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <QueryServiceResponse>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'result))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <QueryServiceResponse>))
  "Converts a ROS message object to a list"
  (cl:list 'QueryServiceResponse
    (cl:cons ':result (result msg))
))
