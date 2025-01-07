
(cl:in-package :asdf)

(defsystem "rosjava_custom_srv-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :moveit_msgs-msg
               :sensor_msgs-msg
)
  :components ((:file "_package")
    (:file "ActionGoalMsg" :depends-on ("_package_ActionGoalMsg"))
    (:file "_package_ActionGoalMsg" :depends-on ("_package"))
    (:file "ActionResultMsg" :depends-on ("_package_ActionResultMsg"))
    (:file "_package_ActionResultMsg" :depends-on ("_package"))
    (:file "ActionState" :depends-on ("_package_ActionState"))
    (:file "_package_ActionState" :depends-on ("_package"))
    (:file "ArmAction" :depends-on ("_package_ArmAction"))
    (:file "_package_ArmAction" :depends-on ("_package"))
    (:file "MainServiceRequest" :depends-on ("_package_MainServiceRequest"))
    (:file "_package_MainServiceRequest" :depends-on ("_package"))
    (:file "Monitor" :depends-on ("_package_Monitor"))
    (:file "_package_Monitor" :depends-on ("_package"))
    (:file "MonitorServiceRequest" :depends-on ("_package_MonitorServiceRequest"))
    (:file "_package_MonitorServiceRequest" :depends-on ("_package"))
    (:file "MonitorServiceResponse" :depends-on ("_package_MonitorServiceResponse"))
    (:file "_package_MonitorServiceResponse" :depends-on ("_package"))
    (:file "QueryServiceRequest" :depends-on ("_package_QueryServiceRequest"))
    (:file "_package_QueryServiceRequest" :depends-on ("_package"))
    (:file "QueryServiceResponse" :depends-on ("_package_QueryServiceResponse"))
    (:file "_package_QueryServiceResponse" :depends-on ("_package"))
  ))