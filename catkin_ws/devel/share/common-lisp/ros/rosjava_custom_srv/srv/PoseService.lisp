; Auto-generated. Do not edit!


(cl:in-package rosjava_custom_srv-srv)


;//! \htmlinclude PoseService-request.msg.html

(cl:defclass <PoseService-request> (roslisp-msg-protocol:ros-message)
  ((predicate
    :reader predicate
    :initarg :predicate
    :type cl:string
    :initform "")
   (param1
    :reader param1
    :initarg :param1
    :type cl:string
    :initform "")
   (param2
    :reader param2
    :initarg :param2
    :type cl:string
    :initform "")
   (param3
    :reader param3
    :initarg :param3
    :type cl:string
    :initform "")
   (param4
    :reader param4
    :initarg :param4
    :type cl:string
    :initform ""))
)

(cl:defclass PoseService-request (<PoseService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PoseService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PoseService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosjava_custom_srv-srv:<PoseService-request> is deprecated: use rosjava_custom_srv-srv:PoseService-request instead.")))

(cl:ensure-generic-function 'predicate-val :lambda-list '(m))
(cl:defmethod predicate-val ((m <PoseService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-srv:predicate-val is deprecated.  Use rosjava_custom_srv-srv:predicate instead.")
  (predicate m))

(cl:ensure-generic-function 'param1-val :lambda-list '(m))
(cl:defmethod param1-val ((m <PoseService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-srv:param1-val is deprecated.  Use rosjava_custom_srv-srv:param1 instead.")
  (param1 m))

(cl:ensure-generic-function 'param2-val :lambda-list '(m))
(cl:defmethod param2-val ((m <PoseService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-srv:param2-val is deprecated.  Use rosjava_custom_srv-srv:param2 instead.")
  (param2 m))

(cl:ensure-generic-function 'param3-val :lambda-list '(m))
(cl:defmethod param3-val ((m <PoseService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-srv:param3-val is deprecated.  Use rosjava_custom_srv-srv:param3 instead.")
  (param3 m))

(cl:ensure-generic-function 'param4-val :lambda-list '(m))
(cl:defmethod param4-val ((m <PoseService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-srv:param4-val is deprecated.  Use rosjava_custom_srv-srv:param4 instead.")
  (param4 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PoseService-request>) ostream)
  "Serializes a message object of type '<PoseService-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'predicate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'predicate))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'param1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'param1))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'param2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'param2))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'param3))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'param3))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'param4))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'param4))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PoseService-request>) istream)
  "Deserializes a message object of type '<PoseService-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'predicate) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'predicate) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'param1) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'param1) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'param2) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'param2) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'param3) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'param3) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'param4) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'param4) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PoseService-request>)))
  "Returns string type for a service object of type '<PoseService-request>"
  "rosjava_custom_srv/PoseServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PoseService-request)))
  "Returns string type for a service object of type 'PoseService-request"
  "rosjava_custom_srv/PoseServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PoseService-request>)))
  "Returns md5sum for a message object of type '<PoseService-request>"
  "acd11f6a539565b51de4cb0861b94f97")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PoseService-request)))
  "Returns md5sum for a message object of type 'PoseService-request"
  "acd11f6a539565b51de4cb0861b94f97")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PoseService-request>)))
  "Returns full string definition for message of type '<PoseService-request>"
  (cl:format cl:nil "string predicate~%string param1~%string param2~%string param3~%string param4~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PoseService-request)))
  "Returns full string definition for message of type 'PoseService-request"
  (cl:format cl:nil "string predicate~%string param1~%string param2~%string param3~%string param4~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PoseService-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'predicate))
     4 (cl:length (cl:slot-value msg 'param1))
     4 (cl:length (cl:slot-value msg 'param2))
     4 (cl:length (cl:slot-value msg 'param3))
     4 (cl:length (cl:slot-value msg 'param4))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PoseService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'PoseService-request
    (cl:cons ':predicate (predicate msg))
    (cl:cons ':param1 (param1 msg))
    (cl:cons ':param2 (param2 msg))
    (cl:cons ':param3 (param3 msg))
    (cl:cons ':param4 (param4 msg))
))
;//! \htmlinclude PoseService-response.msg.html

(cl:defclass <PoseService-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:integer
    :initform 0))
)

(cl:defclass PoseService-response (<PoseService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PoseService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PoseService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosjava_custom_srv-srv:<PoseService-response> is deprecated: use rosjava_custom_srv-srv:PoseService-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <PoseService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-srv:result-val is deprecated.  Use rosjava_custom_srv-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PoseService-response>) ostream)
  "Serializes a message object of type '<PoseService-response>"
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PoseService-response>) istream)
  "Deserializes a message object of type '<PoseService-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PoseService-response>)))
  "Returns string type for a service object of type '<PoseService-response>"
  "rosjava_custom_srv/PoseServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PoseService-response)))
  "Returns string type for a service object of type 'PoseService-response"
  "rosjava_custom_srv/PoseServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PoseService-response>)))
  "Returns md5sum for a message object of type '<PoseService-response>"
  "acd11f6a539565b51de4cb0861b94f97")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PoseService-response)))
  "Returns md5sum for a message object of type 'PoseService-response"
  "acd11f6a539565b51de4cb0861b94f97")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PoseService-response>)))
  "Returns full string definition for message of type '<PoseService-response>"
  (cl:format cl:nil "int32 result~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PoseService-response)))
  "Returns full string definition for message of type 'PoseService-response"
  (cl:format cl:nil "int32 result~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PoseService-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PoseService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'PoseService-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'PoseService)))
  'PoseService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'PoseService)))
  'PoseService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PoseService)))
  "Returns string type for a service object of type '<PoseService>"
  "rosjava_custom_srv/PoseService")