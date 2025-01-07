;; Auto-generated. Do not edit!


(when (boundp 'rosjava_custom_srv::QueryServiceResponse)
  (if (not (find-package "ROSJAVA_CUSTOM_SRV"))
    (make-package "ROSJAVA_CUSTOM_SRV"))
  (shadow 'QueryServiceResponse (find-package "ROSJAVA_CUSTOM_SRV")))
(unless (find-package "ROSJAVA_CUSTOM_SRV::QUERYSERVICERESPONSE")
  (make-package "ROSJAVA_CUSTOM_SRV::QUERYSERVICERESPONSE"))

(in-package "ROS")
;;//! \htmlinclude QueryServiceResponse.msg.html


(defclass rosjava_custom_srv::QueryServiceResponse
  :super ros::object
  :slots (_result ))

(defmethod rosjava_custom_srv::QueryServiceResponse
  (:init
   (&key
    ((:result __result) "")
    )
   (send-super :init)
   (setq _result (string __result))
   self)
  (:result
   (&optional __result)
   (if __result (setq _result __result)) _result)
  (:serialization-length
   ()
   (+
    ;; string _result
    4 (length _result)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _result
       (write-long (length _result) s) (princ _result s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _result
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _result (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get rosjava_custom_srv::QueryServiceResponse :md5sum-) "c22f2a1ed8654a0b365f1bb3f7ff2c0f")
(setf (get rosjava_custom_srv::QueryServiceResponse :datatype-) "rosjava_custom_srv/QueryServiceResponse")
(setf (get rosjava_custom_srv::QueryServiceResponse :definition-)
      "string result

")



(provide :rosjava_custom_srv/QueryServiceResponse "c22f2a1ed8654a0b365f1bb3f7ff2c0f")


