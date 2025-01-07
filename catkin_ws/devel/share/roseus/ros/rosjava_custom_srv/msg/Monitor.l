;; Auto-generated. Do not edit!


(when (boundp 'rosjava_custom_srv::Monitor)
  (if (not (find-package "ROSJAVA_CUSTOM_SRV"))
    (make-package "ROSJAVA_CUSTOM_SRV"))
  (shadow 'Monitor (find-package "ROSJAVA_CUSTOM_SRV")))
(unless (find-package "ROSJAVA_CUSTOM_SRV::MONITOR")
  (make-package "ROSJAVA_CUSTOM_SRV::MONITOR"))

(in-package "ROS")
;;//! \htmlinclude Monitor.msg.html


(defclass rosjava_custom_srv::Monitor
  :super ros::object
  :slots (_predicate _param1 _param2 _param3 _param4 _status ))

(defmethod rosjava_custom_srv::Monitor
  (:init
   (&key
    ((:predicate __predicate) "")
    ((:param1 __param1) "")
    ((:param2 __param2) "")
    ((:param3 __param3) "")
    ((:param4 __param4) "")
    ((:status __status) 0)
    )
   (send-super :init)
   (setq _predicate (string __predicate))
   (setq _param1 (string __param1))
   (setq _param2 (string __param2))
   (setq _param3 (string __param3))
   (setq _param4 (string __param4))
   (setq _status (round __status))
   self)
  (:predicate
   (&optional __predicate)
   (if __predicate (setq _predicate __predicate)) _predicate)
  (:param1
   (&optional __param1)
   (if __param1 (setq _param1 __param1)) _param1)
  (:param2
   (&optional __param2)
   (if __param2 (setq _param2 __param2)) _param2)
  (:param3
   (&optional __param3)
   (if __param3 (setq _param3 __param3)) _param3)
  (:param4
   (&optional __param4)
   (if __param4 (setq _param4 __param4)) _param4)
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:serialization-length
   ()
   (+
    ;; string _predicate
    4 (length _predicate)
    ;; string _param1
    4 (length _param1)
    ;; string _param2
    4 (length _param2)
    ;; string _param3
    4 (length _param3)
    ;; string _param4
    4 (length _param4)
    ;; int32 _status
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _predicate
       (write-long (length _predicate) s) (princ _predicate s)
     ;; string _param1
       (write-long (length _param1) s) (princ _param1 s)
     ;; string _param2
       (write-long (length _param2) s) (princ _param2 s)
     ;; string _param3
       (write-long (length _param3) s) (princ _param3 s)
     ;; string _param4
       (write-long (length _param4) s) (princ _param4 s)
     ;; int32 _status
       (write-long _status s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _predicate
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _predicate (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _param1
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _param1 (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _param2
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _param2 (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _param3
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _param3 (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _param4
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _param4 (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _status
     (setq _status (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get rosjava_custom_srv::Monitor :md5sum-) "9d1ca250acdc6ed9b2dc880631a21dcf")
(setf (get rosjava_custom_srv::Monitor :datatype-) "rosjava_custom_srv/Monitor")
(setf (get rosjava_custom_srv::Monitor :definition-)
      "string predicate
string param1
string param2
string param3
string param4

int32 status
")



(provide :rosjava_custom_srv/Monitor "9d1ca250acdc6ed9b2dc880631a21dcf")


