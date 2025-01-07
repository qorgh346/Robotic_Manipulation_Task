;; Auto-generated. Do not edit!


(when (boundp 'rosjava_custom_srv::JamService)
  (if (not (find-package "ROSJAVA_CUSTOM_SRV"))
    (make-package "ROSJAVA_CUSTOM_SRV"))
  (shadow 'JamService (find-package "ROSJAVA_CUSTOM_SRV")))
(unless (find-package "ROSJAVA_CUSTOM_SRV::JAMSERVICE")
  (make-package "ROSJAVA_CUSTOM_SRV::JAMSERVICE"))
(unless (find-package "ROSJAVA_CUSTOM_SRV::JAMSERVICEREQUEST")
  (make-package "ROSJAVA_CUSTOM_SRV::JAMSERVICEREQUEST"))
(unless (find-package "ROSJAVA_CUSTOM_SRV::JAMSERVICERESPONSE")
  (make-package "ROSJAVA_CUSTOM_SRV::JAMSERVICERESPONSE"))

(in-package "ROS")





(defclass rosjava_custom_srv::JamServiceRequest
  :super ros::object
  :slots (_path ))

(defmethod rosjava_custom_srv::JamServiceRequest
  (:init
   (&key
    ((:path __path) "")
    )
   (send-super :init)
   (setq _path (string __path))
   self)
  (:path
   (&optional __path)
   (if __path (setq _path __path)) _path)
  (:serialization-length
   ()
   (+
    ;; string _path
    4 (length _path)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _path
       (write-long (length _path) s) (princ _path s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _path
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _path (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass rosjava_custom_srv::JamServiceResponse
  :super ros::object
  :slots (_res ))

(defmethod rosjava_custom_srv::JamServiceResponse
  (:init
   (&key
    ((:res __res) "")
    )
   (send-super :init)
   (setq _res (string __res))
   self)
  (:res
   (&optional __res)
   (if __res (setq _res __res)) _res)
  (:serialization-length
   ()
   (+
    ;; string _res
    4 (length _res)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _res
       (write-long (length _res) s) (princ _res s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _res
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _res (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass rosjava_custom_srv::JamService
  :super ros::object
  :slots ())

(setf (get rosjava_custom_srv::JamService :md5sum-) "31d2fe905e359df0b2a8510339b9b736")
(setf (get rosjava_custom_srv::JamService :datatype-) "rosjava_custom_srv/JamService")
(setf (get rosjava_custom_srv::JamService :request) rosjava_custom_srv::JamServiceRequest)
(setf (get rosjava_custom_srv::JamService :response) rosjava_custom_srv::JamServiceResponse)

(defmethod rosjava_custom_srv::JamServiceRequest
  (:response () (instance rosjava_custom_srv::JamServiceResponse :init)))

(setf (get rosjava_custom_srv::JamServiceRequest :md5sum-) "31d2fe905e359df0b2a8510339b9b736")
(setf (get rosjava_custom_srv::JamServiceRequest :datatype-) "rosjava_custom_srv/JamServiceRequest")
(setf (get rosjava_custom_srv::JamServiceRequest :definition-)
      "string path
---
string res

")

(setf (get rosjava_custom_srv::JamServiceResponse :md5sum-) "31d2fe905e359df0b2a8510339b9b736")
(setf (get rosjava_custom_srv::JamServiceResponse :datatype-) "rosjava_custom_srv/JamServiceResponse")
(setf (get rosjava_custom_srv::JamServiceResponse :definition-)
      "string path
---
string res

")



(provide :rosjava_custom_srv/JamService "31d2fe905e359df0b2a8510339b9b736")


