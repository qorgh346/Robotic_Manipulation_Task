
(cl:in-package :asdf)

(defsystem "rosjava_custom_srv-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :rosjava_custom_srv-msg
)
  :components ((:file "_package")
    (:file "JamService" :depends-on ("_package_JamService"))
    (:file "_package_JamService" :depends-on ("_package"))
    (:file "PathService" :depends-on ("_package_PathService"))
    (:file "_package_PathService" :depends-on ("_package"))
    (:file "PoseService" :depends-on ("_package_PoseService"))
    (:file "_package_PoseService" :depends-on ("_package"))
    (:file "PosesService" :depends-on ("_package_PosesService"))
    (:file "_package_PosesService" :depends-on ("_package"))
    (:file "PredicateService" :depends-on ("_package_PredicateService"))
    (:file "_package_PredicateService" :depends-on ("_package"))
  ))