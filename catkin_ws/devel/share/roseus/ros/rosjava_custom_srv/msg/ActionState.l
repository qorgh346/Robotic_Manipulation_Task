;; Auto-generated. Do not edit!


(when (boundp 'rosjava_custom_srv::ActionState)
  (if (not (find-package "ROSJAVA_CUSTOM_SRV"))
    (make-package "ROSJAVA_CUSTOM_SRV"))
  (shadow 'ActionState (find-package "ROSJAVA_CUSTOM_SRV")))
(unless (find-package "ROSJAVA_CUSTOM_SRV::ACTIONSTATE")
  (make-package "ROSJAVA_CUSTOM_SRV::ACTIONSTATE"))

(in-package "ROS")
;;//! \htmlinclude ActionState.msg.html


(defclass rosjava_custom_srv::ActionState
  :super ros::object
  :slots (_status ))

(defmethod rosjava_custom_srv::ActionState
  (:init
   (&key
    ((:status __status) 0)
    )
   (send-super :init)
   (setq _status (round __status))
   self)
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:serialization-length
   ()
   (+
    ;; int32 _status
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _status
       (write-long _status s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _status
     (setq _status (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get rosjava_custom_srv::ActionState :md5sum-) "86791dcf1de997ec7de5a0de7e4dcfcc")
(setf (get rosjava_custom_srv::ActionState :datatype-) "rosjava_custom_srv/ActionState")
(setf (get rosjava_custom_srv::ActionState :definition-)
      "int32 status

")



(provide :rosjava_custom_srv/ActionState "86791dcf1de997ec7de5a0de7e4dcfcc")


