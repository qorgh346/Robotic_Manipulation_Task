### setup ###
## install ##
rosjava
  sudo apt install openjdk-8-jdk openjfx
  sudo apt-get install ros-kinetic-rosjava

swipl
  sudo add-apt-repository ppa:swi-prolog/stable
  sudo apt-get update
  sudo apt-get install swi-prolog swi-prolog-java

ros package
  ros-kinetic-moveit
  ros-kinetic-move-base-msgs

## env setup ##
swipl
  export SWI_HOME_DIR="/usr/lib/swi-prolog"
  export LD_PRELOAD="$LD_PRELOAD:$SWI_HOME_DIR/lib/x86_64-linux/libswipl.so"
  export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$SWI_HOME_DIR/bin/x86_64-linux/:$SWI_HOME_DIR/lib/x86_64-linux/"


### execute ###
roscore
open coppeliasim 

cm
  rosrun context_manager_pkg context_manager org.ros.rosjava_context_manager.ContextManager
  rosrun context_manager_pkg context_manager org.ros.rosjava_context_manager.ContextListener
am
  run.sh
tm
  rosrun task_manager TAMP_interface.py
  rosrun task_manager task_manager org.ros.rosjava_task_manager.TaskManager

  rosservice call /task_manager/jam_.... "path: /INSERT/PAHT/JAM" 




