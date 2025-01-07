# Robot Intelligence System
 학부연구생_로봇 지능 체계 실습 프로젝트
 
## Project Description
This project implements a robotic intelligence system supporting object detection and 6-DoF pose estimation for the Kinova Jaco Hand, along with path planning, obstacle avoidance, task planning, and management. The system is designed to work in conjunction with simulation environments like CoppeliaSim.

## Features
- **객체 인식**: Dope 모델 기반
- **경로 계획 및 장애물 회피**: MoveIt 프레임워크 활용
- **작업 계획 수립 및 관리**: Plan Library Jam 활용
- **CoppeliaSim 시뮬레이션**: 환경 지원

## Installation

### Prerequisites
- **Python**: Version 2.7
- **ROS**: Kinetic (Ubuntu 16.04 recommended)
- **CoppeliaSim**: Version 4.2 or compatible

---

### Installation Steps

#### **1. Start ROS Master**
1. Navigate to your catkin workspace:
    ```bash
    cd Robotic_Manipulation_Task/catkin_ws
    source devel/setup.bash
    ```
2. Start the ROS master node:
    ```bash
    roscore
    ```

#### **2. Start CoppeliaSim**
1. Navigate to the CoppeliaSim installation directory:
    ```bash
    cd ~/Downloads/CoppeliaSim_Edu_V4_2_0_Ubuntu16_04
    ```
2. Launch CoppeliaSim:
    ```bash
    ./coppeliaSim.sh
    ```
3. Load the simulation file `twoTables_ver7.ttt`:
    - In CoppeliaSim, go to **File > Open Scene** and select the file from the project directory.

#### **3. Download & Build Dope**
1. Activate your Python environment:
    ```bash
    conda activate dope_env
    ```
2. Clone the Dope repository into the `src` directory of your catkin workspace:
    ```bash
    cd ~/Robotic_Manipulation_Task/catkin_ws/src
    git clone https://github.com/NVlabs/Deep_Object_Pose.git dope
    cd dope
    ```
3. Install dependencies:
    ```bash
    pip install -r requirements.txt
    rosdep install --from-paths src -i --rosdistro kinetic
    sudo apt-get install ros-kinetic-rosbash ros-kinetic-ros-comm
    ```
4. Build the catkin workspace:
    ```bash
    cd ~/Robotic_Manipulation_Task/catkin_ws
    catkin_make
    ```

#### **4. Start Dope Node**
1. Launch the Dope node with the appropriate configuration file:
    ```bash
    roslaunch dope dope.launch config:=/path/to/PM/dope_config.yaml
    ```

#### **5. Start Context Manager (CM)**
1. Run the Context Manager and Listener nodes:
    ```bash
    rosrun context_manager_pkg context_manager org.ros.rosjava_context_manager.ContextManager
    rosrun context_manager_pkg context_manager org.ros.rosjava_context_manager.ContextListener
    ```

#### **6. Start Action Manager (AM)**
1. Execute the pick-and-place demo:
    ```bash
    cd ~/Robotic_Manipulation_Task/catkin_ws/src
    rosrun kinova_arm_moveit_demo pick_place
    ```

#### **7. Start Task Manager (TM)**
1. Run the TAMP interface:
    ```bash
    rosrun task_manager TAMP_interface.py
    ```
2. Start the Task Manager:
    ```bash
    rosrun task_manager task_manager org.ros.rosjava_task_manager.TaskManager
    ```

#### **8. Start Plan Library Jam (Jam)**
1. Start the Jam service for task planning:
    ```bash
    rosservice call /task_manager/jam_service "path: /path/to/Robotic_Manipulation_Task/Jam"
    ```

---


