;; Auto-generated. Do not edit!


(when (boundp 'rosjava_custom_srv::ActionResultMsg)
  (if (not (find-package "ROSJAVA_CUSTOM_SRV"))
    (make-package "ROSJAVA_CUSTOM_SRV"))
  (shadow 'ActionResultMsg (find-package "ROSJAVA_CUSTOM_SRV")))
(unless (find-package "ROSJAVA_CUSTOM_SRV::ACTIONRESULTMSG")
  (make-package "ROSJAVA_CUSTOM_SRV::ACTIONRESULTMSG"))

(in-package "ROS")
;;//! \htmlinclude ActionResultMsg.msg.html


(defclass rosjava_custom_srv::ActionResultMsg
  :super ros::object
  :slots (_actionStatus ))

(defmethod rosjava_custom_srv::ActionResultMsg
  (:init
   (&key
    ((:actionStatus __actionStatus) 0)
    )
   (send-super :init)
   (setq _actionStatus (round __actionStatus))
   self)
  (:actionStatus
   (&optional __actionStatus)
   (if __actionStatus (setq _actionStatus __actionStatus)) _actionStatus)
  (:serialization-length
   ()
   (+
    ;; int32 _actionStatus
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _actionStatus
       (write-long _actionStatus s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _actionStatus
     (setq _actionStatus (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get rosjava_custom_srv::ActionResultMsg :md5sum-) "d0d63bd7875eb84a563aa44f75268f19")
(setf (get rosjava_custom_srv::ActionResultMsg :datatype-) "rosjava_custom_srv/ActionResultMsg")
(setf (get rosjava_custom_srv::ActionResultMsg :definition-)
      "int32 actionStatus

")



(provide :rosjava_custom_srv/ActionResultMsg "d0d63bd7875eb84a563aa44f75268f19")


