;; Auto-generated. Do not edit!


(when (boundp 'rosjava_custom_srv::QueryServiceRequest)
  (if (not (find-package "ROSJAVA_CUSTOM_SRV"))
    (make-package "ROSJAVA_CUSTOM_SRV"))
  (shadow 'QueryServiceRequest (find-package "ROSJAVA_CUSTOM_SRV")))
(unless (find-package "ROSJAVA_CUSTOM_SRV::QUERYSERVICEREQUEST")
  (make-package "ROSJAVA_CUSTOM_SRV::QUERYSERVICEREQUEST"))

(in-package "ROS")
;;//! \htmlinclude QueryServiceRequest.msg.html


(defclass rosjava_custom_srv::QueryServiceRequest
  :super ros::object
  :slots (_query _manager ))

(defmethod rosjava_custom_srv::QueryServiceRequest
  (:init
   (&key
    ((:query __query) "")
    ((:manager __manager) "")
    )
   (send-super :init)
   (setq _query (string __query))
   (setq _manager (string __manager))
   self)
  (:query
   (&optional __query)
   (if __query (setq _query __query)) _query)
  (:manager
   (&optional __manager)
   (if __manager (setq _manager __manager)) _manager)
  (:serialization-length
   ()
   (+
    ;; string _query
    4 (length _query)
    ;; string _manager
    4 (length _manager)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _query
       (write-long (length _query) s) (princ _query s)
     ;; string _manager
       (write-long (length _manager) s) (princ _manager s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _query
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _query (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _manager
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _manager (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get rosjava_custom_srv::QueryServiceRequest :md5sum-) "c87ac28ec8f021755cccae1836d04e07")
(setf (get rosjava_custom_srv::QueryServiceRequest :datatype-) "rosjava_custom_srv/QueryServiceRequest")
(setf (get rosjava_custom_srv::QueryServiceRequest :definition-)
      "string query
string manager

")



(provide :rosjava_custom_srv/QueryServiceRequest "c87ac28ec8f021755cccae1836d04e07")


