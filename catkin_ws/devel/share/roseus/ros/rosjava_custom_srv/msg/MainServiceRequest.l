;; Auto-generated. Do not edit!


(when (boundp 'rosjava_custom_srv::MainServiceRequest)
  (if (not (find-package "ROSJAVA_CUSTOM_SRV"))
    (make-package "ROSJAVA_CUSTOM_SRV"))
  (shadow 'MainServiceRequest (find-package "ROSJAVA_CUSTOM_SRV")))
(unless (find-package "ROSJAVA_CUSTOM_SRV::MAINSERVICEREQUEST")
  (make-package "ROSJAVA_CUSTOM_SRV::MAINSERVICEREQUEST"))

(in-package "ROS")
;;//! \htmlinclude MainServiceRequest.msg.html


(defclass rosjava_custom_srv::MainServiceRequest
  :super ros::object
  :slots (_predicate _param1 _param2 _param3 _param4 _status _manager ))

(defmethod rosjava_custom_srv::MainServiceRequest
  (:init
   (&key
    ((:predicate __predicate) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:param1 __param1) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:param2 __param2) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:param3 __param3) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:param4 __param4) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:status __status) (make-array 0 :initial-element 0 :element-type :integer))
    ((:manager __manager) "")
    )
   (send-super :init)
   (setq _predicate __predicate)
   (setq _param1 __param1)
   (setq _param2 __param2)
   (setq _param3 __param3)
   (setq _param4 __param4)
   (setq _status __status)
   (setq _manager (string __manager))
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
  (:manager
   (&optional __manager)
   (if __manager (setq _manager __manager)) _manager)
  (:serialization-length
   ()
   (+
    ;; string[] _predicate
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _predicate)) 4
    ;; string[] _param1
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _param1)) 4
    ;; string[] _param2
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _param2)) 4
    ;; string[] _param3
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _param3)) 4
    ;; string[] _param4
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _param4)) 4
    ;; int32[] _status
    (* 4    (length _status)) 4
    ;; string _manager
    4 (length _manager)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string[] _predicate
     (write-long (length _predicate) s)
     (dolist (elem _predicate)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _param1
     (write-long (length _param1) s)
     (dolist (elem _param1)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _param2
     (write-long (length _param2) s)
     (dolist (elem _param2)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _param3
     (write-long (length _param3) s)
     (dolist (elem _param3)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _param4
     (write-long (length _param4) s)
     (dolist (elem _param4)
       (write-long (length elem) s) (princ elem s)
       )
     ;; int32[] _status
     (write-long (length _status) s)
     (dotimes (i (length _status))
       (write-long (elt _status i) s)
       )
     ;; string _manager
       (write-long (length _manager) s) (princ _manager s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string[] _predicate
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _predicate (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _predicate i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _param1
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _param1 (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _param1 i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _param2
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _param2 (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _param2 i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _param3
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _param3 (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _param3 i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _param4
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _param4 (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _param4 i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; int32[] _status
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _status (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _status i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; string _manager
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _manager (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get rosjava_custom_srv::MainServiceRequest :md5sum-) "1ab506786d6907c7cafe1222b90fc169")
(setf (get rosjava_custom_srv::MainServiceRequest :datatype-) "rosjava_custom_srv/MainServiceRequest")
(setf (get rosjava_custom_srv::MainServiceRequest :definition-)
      "string[] predicate
string[] param1
string[] param2
string[] param3
string[] param4

int32[] status
string manager

")



(provide :rosjava_custom_srv/MainServiceRequest "1ab506786d6907c7cafe1222b90fc169")


