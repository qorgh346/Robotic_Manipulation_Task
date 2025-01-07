; Auto-generated. Do not edit!


(cl:in-package rosjava_custom_srv-msg)


;//! \htmlinclude MonitorServiceResponse.msg.html

(cl:defclass <MonitorServiceResponse> (roslisp-msg-protocol:ros-message)
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
    :initform "")
   (status
    :reader status
    :initarg :status
    :type cl:integer
    :initform 0)
   (manager
    :reader manager
    :initarg :manager
    :type cl:string
    :initform ""))
)

(cl:defclass MonitorServiceResponse (<MonitorServiceResponse>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MonitorServiceResponse>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MonitorServiceResponse)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosjava_custom_srv-msg:<MonitorServiceResponse> is deprecated: use rosjava_custom_srv-msg:MonitorServiceResponse instead.")))

(cl:ensure-generic-function 'predicate-val :lambda-list '(m))
(cl:defmethod predicate-val ((m <MonitorServiceResponse>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-msg:predicate-val is deprecated.  Use rosjava_custom_srv-msg:predicate instead.")
  (predicate m))

(cl:ensure-generic-function 'param1-val :lambda-list '(m))
(cl:defmethod param1-val ((m <MonitorServiceResponse>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-msg:param1-val is deprecated.  Use rosjava_custom_srv-msg:param1 instead.")
  (param1 m))

(cl:ensure-generic-function 'param2-val :lambda-list '(m))
(cl:defmethod param2-val ((m <MonitorServiceResponse>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-msg:param2-val is deprecated.  Use rosjava_custom_srv-msg:param2 instead.")
  (param2 m))

(cl:ensure-generic-function 'param3-val :lambda-list '(m))
(cl:defmethod param3-val ((m <MonitorServiceResponse>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-msg:param3-val is deprecated.  Use rosjava_custom_srv-msg:param3 instead.")
  (param3 m))

(cl:ensure-generic-function 'param4-val :lambda-list '(m))
(cl:defmethod param4-val ((m <MonitorServiceResponse>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-msg:param4-val is deprecated.  Use rosjava_custom_srv-msg:param4 instead.")
  (param4 m))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <MonitorServiceResponse>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-msg:status-val is deprecated.  Use rosjava_custom_srv-msg:status instead.")
  (status m))

(cl:ensure-generic-function 'manager-val :lambda-list '(m))
(cl:defmethod manager-val ((m <MonitorServiceResponse>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-msg:manager-val is deprecated.  Use rosjava_custom_srv-msg:manager instead.")
  (manager m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MonitorServiceResponse>) ostream)
  "Serializes a message object of type '<MonitorServiceResponse>"
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
  (cl:let* ((signed (cl:slot-value msg 'status)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'manager))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'manager))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MonitorServiceResponse>) istream)
  "Deserializes a message object of type '<MonitorServiceResponse>"
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
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'status) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'manager) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'manager) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MonitorServiceResponse>)))
  "Returns string type for a message object of type '<MonitorServiceResponse>"
  "rosjava_custom_srv/MonitorServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MonitorServiceResponse)))
  "Returns string type for a message object of type 'MonitorServiceResponse"
  "rosjava_custom_srv/MonitorServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MonitorServiceResponse>)))
  "Returns md5sum for a message object of type '<MonitorServiceResponse>"
  "b8ba3e44b28132447b0a2a6a1386de5d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MonitorServiceResponse)))
  "Returns md5sum for a message object of type 'MonitorServiceResponse"
  "b8ba3e44b28132447b0a2a6a1386de5d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MonitorServiceResponse>)))
  "Returns full string definition for message of type '<MonitorServiceResponse>"
  (cl:format cl:nil "string predicate~%string param1~%string param2~%string param3~%string param4~%~%int32 status~%string manager~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MonitorServiceResponse)))
  "Returns full string definition for message of type 'MonitorServiceResponse"
  (cl:format cl:nil "string predicate~%string param1~%string param2~%string param3~%string param4~%~%int32 status~%string manager~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MonitorServiceResponse>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'predicate))
     4 (cl:length (cl:slot-value msg 'param1))
     4 (cl:length (cl:slot-value msg 'param2))
     4 (cl:length (cl:slot-value msg 'param3))
     4 (cl:length (cl:slot-value msg 'param4))
     4
     4 (cl:length (cl:slot-value msg 'manager))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MonitorServiceResponse>))
  "Converts a ROS message object to a list"
  (cl:list 'MonitorServiceResponse
    (cl:cons ':predicate (predicate msg))
    (cl:cons ':param1 (param1 msg))
    (cl:cons ':param2 (param2 msg))
    (cl:cons ':param3 (param3 msg))
    (cl:cons ':param4 (param4 msg))
    (cl:cons ':status (status msg))
    (cl:cons ':manager (manager msg))
))
