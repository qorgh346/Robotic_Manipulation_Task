; Auto-generated. Do not edit!


(cl:in-package rosjava_custom_srv-msg)


;//! \htmlinclude QueryServiceRequest.msg.html

(cl:defclass <QueryServiceRequest> (roslisp-msg-protocol:ros-message)
  ((query
    :reader query
    :initarg :query
    :type cl:string
    :initform "")
   (manager
    :reader manager
    :initarg :manager
    :type cl:string
    :initform ""))
)

(cl:defclass QueryServiceRequest (<QueryServiceRequest>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <QueryServiceRequest>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'QueryServiceRequest)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosjava_custom_srv-msg:<QueryServiceRequest> is deprecated: use rosjava_custom_srv-msg:QueryServiceRequest instead.")))

(cl:ensure-generic-function 'query-val :lambda-list '(m))
(cl:defmethod query-val ((m <QueryServiceRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-msg:query-val is deprecated.  Use rosjava_custom_srv-msg:query instead.")
  (query m))

(cl:ensure-generic-function 'manager-val :lambda-list '(m))
(cl:defmethod manager-val ((m <QueryServiceRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-msg:manager-val is deprecated.  Use rosjava_custom_srv-msg:manager instead.")
  (manager m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <QueryServiceRequest>) ostream)
  "Serializes a message object of type '<QueryServiceRequest>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'query))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'query))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'manager))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'manager))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <QueryServiceRequest>) istream)
  "Deserializes a message object of type '<QueryServiceRequest>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'query) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'query) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<QueryServiceRequest>)))
  "Returns string type for a message object of type '<QueryServiceRequest>"
  "rosjava_custom_srv/QueryServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'QueryServiceRequest)))
  "Returns string type for a message object of type 'QueryServiceRequest"
  "rosjava_custom_srv/QueryServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<QueryServiceRequest>)))
  "Returns md5sum for a message object of type '<QueryServiceRequest>"
  "c87ac28ec8f021755cccae1836d04e07")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'QueryServiceRequest)))
  "Returns md5sum for a message object of type 'QueryServiceRequest"
  "c87ac28ec8f021755cccae1836d04e07")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<QueryServiceRequest>)))
  "Returns full string definition for message of type '<QueryServiceRequest>"
  (cl:format cl:nil "string query~%string manager~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'QueryServiceRequest)))
  "Returns full string definition for message of type 'QueryServiceRequest"
  (cl:format cl:nil "string query~%string manager~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <QueryServiceRequest>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'query))
     4 (cl:length (cl:slot-value msg 'manager))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <QueryServiceRequest>))
  "Converts a ROS message object to a list"
  (cl:list 'QueryServiceRequest
    (cl:cons ':query (query msg))
    (cl:cons ':manager (manager msg))
))
