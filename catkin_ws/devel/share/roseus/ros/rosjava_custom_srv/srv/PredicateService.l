;; Auto-generated. Do not edit!


(when (boundp 'rosjava_custom_srv::PredicateService)
  (if (not (find-package "ROSJAVA_CUSTOM_SRV"))
    (make-package "ROSJAVA_CUSTOM_SRV"))
  (shadow 'PredicateService (find-package "ROSJAVA_CUSTOM_SRV")))
(unless (find-package "ROSJAVA_CUSTOM_SRV::PREDICATESERVICE")
  (make-package "ROSJAVA_CUSTOM_SRV::PREDICATESERVICE"))
(unless (find-package "ROSJAVA_CUSTOM_SRV::PREDICATESERVICEREQUEST")
  (make-package "ROSJAVA_CUSTOM_SRV::PREDICATESERVICEREQUEST"))
(unless (find-package "ROSJAVA_CUSTOM_SRV::PREDICATESERVICERESPONSE")
  (make-package "ROSJAVA_CUSTOM_SRV::PREDICATESERVICERESPONSE"))

(in-package "ROS")





(defclass rosjava_custom_srv::PredicateServiceRequest
  :super ros::object
  :slots (_predicate _param1 _param2 _param3 _param4 ))

(defmethod rosjava_custom_srv::PredicateServiceRequest
  (:init
   (&key
    ((:predicate __predicate) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:param1 __param1) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:param2 __param2) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:param3 __param3) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:param4 __param4) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _predicate __predicate)
   (setq _param1 __param1)
   (setq _param2 __param2)
   (setq _param3 __param3)
   (setq _param4 __param4)
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
   ;;
   self)
  )

(defclass rosjava_custom_srv::PredicateServiceResponse
  :super ros::object
  :slots (_result ))

(defmethod rosjava_custom_srv::PredicateServiceResponse
  (:init
   (&key
    ((:result __result) 0)
    )
   (send-super :init)
   (setq _result (round __result))
   self)
  (:result
   (&optional __result)
   (if __result (setq _result __result)) _result)
  (:serialization-length
   ()
   (+
    ;; int32 _result
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _result
       (write-long _result s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _result
     (setq _result (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass rosjava_custom_srv::PredicateService
  :super ros::object
  :slots ())

(setf (get rosjava_custom_srv::PredicateService :md5sum-) "aedf4a39ef72018907356ccb3fd7b3f3")
(setf (get rosjava_custom_srv::PredicateService :datatype-) "rosjava_custom_srv/PredicateService")
(setf (get rosjava_custom_srv::PredicateService :request) rosjava_custom_srv::PredicateServiceRequest)
(setf (get rosjava_custom_srv::PredicateService :response) rosjava_custom_srv::PredicateServiceResponse)

(defmethod rosjava_custom_srv::PredicateServiceRequest
  (:response () (instance rosjava_custom_srv::PredicateServiceResponse :init)))

(setf (get rosjava_custom_srv::PredicateServiceRequest :md5sum-) "aedf4a39ef72018907356ccb3fd7b3f3")
(setf (get rosjava_custom_srv::PredicateServiceRequest :datatype-) "rosjava_custom_srv/PredicateServiceRequest")
(setf (get rosjava_custom_srv::PredicateServiceRequest :definition-)
      "string[] predicate
string[] param1
string[] param2
string[] param3
string[] param4
---
int32 result

")

(setf (get rosjava_custom_srv::PredicateServiceResponse :md5sum-) "aedf4a39ef72018907356ccb3fd7b3f3")
(setf (get rosjava_custom_srv::PredicateServiceResponse :datatype-) "rosjava_custom_srv/PredicateServiceResponse")
(setf (get rosjava_custom_srv::PredicateServiceResponse :definition-)
      "string[] predicate
string[] param1
string[] param2
string[] param3
string[] param4
---
int32 result

")



(provide :rosjava_custom_srv/PredicateService "aedf4a39ef72018907356ccb3fd7b3f3")


