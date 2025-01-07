# Robot Intelligence System
 학부연구생_로봇 지능 체계 실습 프로젝트

## Project Description
이 프로젝트는 로봇(Kinova, Jaco Hand)의 객체 인식 및 6-DoF 추정, 경로 계획, 장애물 회피, 작업 계획 수립 및 관리 등을 지원하는 로봇 지능 체계 시스템입니다.

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
1. catkin workspace:
    ```bash
    cd Robotic_Manipulation_Task/catkin_ws
    source devel/setup.bash
    ```
2. Start the ROS master node:
    ```bash
    roscore
    ```

#### **2. Start CoppeliaSim**
1. CoppeliaSim installation :
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
1. Activate Python:
    ```bash
    conda activate dope_env
    ```
2. Clone the Dope repository:
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
1. Launch the Dope node:
    ```bash
    roslaunch dope dope.launch config:=/path/to/PM/dope_config.yaml
    ```

#### **5. Start Context Manager (CM)**
1. Run Context Manager and Listener nodes:
    ```bash
    rosrun context_manager_pkg context_manager org.ros.rosjava_context_manager.ContextManager
    rosrun context_manager_pkg context_manager org.ros.rosjava_context_manager.ContextListener
    ```

#### **6. Start Action Manager (AM)**
1. pick-and-place demo:
    ```bash
    cd ~/Robotic_Manipulation_Task/catkin_ws/src
    rosrun kinova_arm_moveit_demo pick_place
    ```

#### **7. Start Task Manager (TM)**
1. Run TAMP interface:
    ```bash
    rosrun task_manager TAMP_interface.py
    ```
2. Start Task Manager:
    ```bash
    rosrun task_manager task_manager org.ros.rosjava_task_manager.TaskManager
    ```

#### **8. Start Plan Library Jam (Jam)**
1. Start Jam for task planning:
    ```bash
    rosservice call /task_manager/jam_service "path: /path/to/Robotic_Manipulation_Task/Jam"
    ```

---


