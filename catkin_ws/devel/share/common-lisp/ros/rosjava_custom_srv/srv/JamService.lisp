; Auto-generated. Do not edit!


(cl:in-package rosjava_custom_srv-srv)


;//! \htmlinclude JamService-request.msg.html

(cl:defclass <JamService-request> (roslisp-msg-protocol:ros-message)
  ((path
    :reader path
    :initarg :path
    :type cl:string
    :initform ""))
)

(cl:defclass JamService-request (<JamService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <JamService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'JamService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosjava_custom_srv-srv:<JamService-request> is deprecated: use rosjava_custom_srv-srv:JamService-request instead.")))

(cl:ensure-generic-function 'path-val :lambda-list '(m))
(cl:defmethod path-val ((m <JamService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-srv:path-val is deprecated.  Use rosjava_custom_srv-srv:path instead.")
  (path m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <JamService-request>) ostream)
  "Serializes a message object of type '<JamService-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'path))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <JamService-request>) istream)
  "Deserializes a message object of type '<JamService-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'path) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'path) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<JamService-request>)))
  "Returns string type for a service object of type '<JamService-request>"
  "rosjava_custom_srv/JamServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'JamService-request)))
  "Returns string type for a service object of type 'JamService-request"
  "rosjava_custom_srv/JamServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<JamService-request>)))
  "Returns md5sum for a message object of type '<JamService-request>"
  "31d2fe905e359df0b2a8510339b9b736")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'JamService-request)))
  "Returns md5sum for a message object of type 'JamService-request"
  "31d2fe905e359df0b2a8510339b9b736")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<JamService-request>)))
  "Returns full string definition for message of type '<JamService-request>"
  (cl:format cl:nil "string path~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'JamService-request)))
  "Returns full string definition for message of type 'JamService-request"
  (cl:format cl:nil "string path~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <JamService-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'path))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <JamService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'JamService-request
    (cl:cons ':path (path msg))
))
;//! \htmlinclude JamService-response.msg.html

(cl:defclass <JamService-response> (roslisp-msg-protocol:ros-message)
  ((res
    :reader res
    :initarg :res
    :type cl:string
    :initform ""))
)

(cl:defclass JamService-response (<JamService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <JamService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'JamService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosjava_custom_srv-srv:<JamService-response> is deprecated: use rosjava_custom_srv-srv:JamService-response instead.")))

(cl:ensure-generic-function 'res-val :lambda-list '(m))
(cl:defmethod res-val ((m <JamService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosjava_custom_srv-srv:res-val is deprecated.  Use rosjava_custom_srv-srv:res instead.")
  (res m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <JamService-response>) ostream)
  "Serializes a message object of type '<JamService-response>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'res))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'res))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <JamService-response>) istream)
  "Deserializes a message object of type '<JamService-response>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'res) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'res) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<JamService-response>)))
  "Returns string type for a service object of type '<JamService-response>"
  "rosjava_custom_srv/JamServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'JamService-response)))
  "Returns string type for a service object of type 'JamService-response"
  "rosjava_custom_srv/JamServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<JamService-response>)))
  "Returns md5sum for a message object of type '<JamService-response>"
  "31d2fe905e359df0b2a8510339b9b736")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'JamService-response)))
  "Returns md5sum for a message object of type 'JamService-response"
  "31d2fe905e359df0b2a8510339b9b736")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<JamService-response>)))
  "Returns full string definition for message of type '<JamService-response>"
  (cl:format cl:nil "string res~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'JamService-response)))
  "Returns full string definition for message of type 'JamService-response"
  (cl:format cl:nil "string res~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <JamService-response>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'res))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <JamService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'JamService-response
    (cl:cons ':res (res msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'JamService)))
  'JamService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'JamService)))
  'JamService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'JamService)))
  "Returns string type for a service object of type '<JamService>"
  "rosjava_custom_srv/JamService")