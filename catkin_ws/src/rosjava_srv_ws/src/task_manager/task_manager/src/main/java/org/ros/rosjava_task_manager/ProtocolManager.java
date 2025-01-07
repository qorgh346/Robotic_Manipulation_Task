package org.ros.rosjava_task_manager;

import org.ros.namespace.GraphName;
import org.ros.node.AbstractNodeMain;
import org.ros.node.ConnectedNode;
import org.ros.node.NodeMain;
import org.ros.node.service.ServiceResponseBuilder;
import org.ros.node.service.ServiceServer;
import org.ros.node.service.ServiceClient;
import org.ros.node.service.ServiceResponseListener;
import org.ros.exception.RemoteException;
import org.ros.exception.RosRuntimeException;
import org.ros.exception.ServiceNotFoundException;
import org.ros.message.*;
import rosjava_custom_srv.*;
import geometry_msgs.*;
import sensor_msgs.*;
import vision_msgs.*;
import std_msgs.*;
import org.ros.uos.ai.jam.Interpreter;
import org.ros.uos.ai.jam.JAM;
import org.ros.uos.ai.jam.WorldModelTable;
import org.ros.uos.ai.jam.expression.*;
import org.ros.uos.ai.jam.parser.JAMParser;
import java.io.File;
import java.util.*;
import java.io.Console;

public class ProtocolManager {
    private ServiceClient<PoseServiceRequest, PoseServiceResponse> poseClient;
    private ServiceClient<PathServiceRequest, PathServiceResponse> pathClient;
    private MessageFactory messageFactory;

    public int result = 0;
    public boolean isOK = false;

    public void setPoseClient(ServiceClient<PoseServiceRequest, PoseServiceResponse> poseClient){
        this.poseClient = poseClient;
    }
    public void setPathClient(ServiceClient<PathServiceRequest, PathServiceResponse> pathClient){
        this.pathClient= pathClient;
    }
    public void setMessageFactory(MessageFactory messageFactory) {
        this.messageFactory = messageFactory;
    }


    public int requestPoseGeneration(java.lang.String predicate, java.lang.String param1, java.lang.String param2, java.lang.String param3,
    java.lang.String param4){
        PoseServiceRequest poseRequest = poseClient.newMessage();
        poseRequest.setPredicate(predicate);
        poseRequest.setParam1(param1);
        poseRequest.setParam2(param2);
        poseRequest.setParam3(param3);
        poseRequest.setParam4(param4);
        System.out.println("callPoseGeneration: " + predicate + "(" + param1 + ", " + param2 + ", " + param3 + ", " + param4 + ")");
        poseClient.call(poseRequest, new ServiceResponseListener<PoseServiceResponse>(){
            @Override
            public void onSuccess(PoseServiceResponse response) {
                result = response.getResult();
                isOK = true;
            }
            
            @Override
            public void onFailure(RemoteException e) {
                throw new RosRuntimeException(e);
            }
        });
        while(!isOK){System.out.print("");}
        isOK = false;
        System.out.println();
        return result;
    }

    public int requestMotionPlanning(java.lang.String predicate, java.lang.String param1, java.lang.String param2, List<ActionGoalMsg> param3,
    java.lang.String param4){
        PathServiceRequest pathRequest = pathClient.newMessage();
        pathRequest.setPredicate(predicate);
        pathRequest.setParam1(param1);
        pathRequest.setParam2(convertActionGoalMsg(param2));
        pathRequest.setParam3(param3);
        pathRequest.setParam4(param4);
        System.out.println("callMotionPlanning: " + predicate + "(" + param1 + ", " + param2 + ", " + param3 + ", " + param4 + ")");
        pathClient.call(pathRequest, new ServiceResponseListener<PathServiceResponse>(){
            @Override
            public void onSuccess(PathServiceResponse response){
                result = response.getResult();
                isOK = true;
            }

            @Override
            public void onFailure(RemoteException e){
                throw new RosRuntimeException(e);
            }
        });
        while(!isOK){System.out.print("");}
        isOK = false;
        return result;
    }

    private ActionGoalMsg convertActionGoalMsg(java.lang.String input){
        try {
        input = input.substring(1, input.length() - 1);
        java.lang.String arr[] = input.split("-/!/-"); // 0,1,2 : position  3,4,5,6 = quaternion
        ActionGoalMsg actionGoalMsg = messageFactory.newFromType(ActionGoalMsg._TYPE);
        PoseStamped poseStamped = messageFactory.newFromType(PoseStamped._TYPE);
        Pose pose = messageFactory.newFromType(Pose._TYPE);
        Point point = messageFactory.newFromType(Point._TYPE);
        point.setX(Double.parseDouble(arr[0]));
        point.setY(Double.parseDouble(arr[1]));
        point.setZ(Double.parseDouble(arr[2]));
        Quaternion quaternion = messageFactory.newFromType(Quaternion._TYPE);
        quaternion.setX(Double.parseDouble(arr[3]));
        quaternion.setY(Double.parseDouble(arr[4]));
        quaternion.setZ(Double.parseDouble(arr[5]));
        quaternion.setW(Double.parseDouble(arr[6]));
        pose.setPosition(point);
        pose.setOrientation(quaternion);
        poseStamped.setPose(pose);
        actionGoalMsg.setTargetPose(poseStamped);
        return actionGoalMsg;
        } catch(Exception e) {
            e.printStackTrace();
        }
       return null;
    }

    // public int requestMoveHand(int targetBody, int actionGoal, List<java.lang.String> obstacle_ids, List<vision_msgs.BoundingBox3D> obstacles, 
    // sensor_msgs.JointState targetJointState){
    //     TaskManager.requestMoveHand(targetBody, actionGoal, obstacle_ids, obstacles, targetJointState);
    //     return 1;
    // }

    // public int requestGrasp(int targetBody, int actionGoal){
    //     TaskManager.requestGrasp(targetBody, actionGoal);
    //     return 1;
    // }

    // public int requestMoveBase(int targetBody, int actionGoal, List<java.lang.String> obstacle_ids, List<vision_msgs.BoundingBox3D> obstacles, 
    // geometry_msgs.Pose targetPose){
    //     TaskManager.requestMoveBase(targetBody, actionGoal, obstacle_ids, obstacles, targetPose);
    //     return 1;
    // }

    // public int requestFullStateDescription(java.lang.String predicate, java.lang.String param1, java.lang.String param2, java.lang.String param3, 
    // java.lang.String param4){
    //     return 1;
    // }

    public int requestMoveArm(ActionGoalMsg armActionGoalMsg){
        return TaskManager.requestMoveArm(armActionGoalMsg);
    }
      
    public int requestMoveHand(ActionGoalMsg handActionGoalMsg){
        return TaskManager.requestMoveHand(handActionGoalMsg);
    }

    public int requestMoveBase(ActionGoalMsg baseActionGoalMsg){
        return TaskManager.requestMoveBase(baseActionGoalMsg);
    }
    
    public java.lang.String[] requestFullStateDescription(java.lang.String predicate, java.lang.String param1, java.lang.String param2, java.lang.String param3,
    java.lang.String param4){
        return TaskManager.requestFullStateDescription(predicate, param1, param2, param3, param4);
    }
   
    public void requestDelay(java.lang.String msec){
        try {
        Thread.sleep(Integer.parseInt(msec));
        } catch (NumberFormatException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public int requestStandardArm(){
        ActionGoalMsg standardArmMsg = messageFactory.newFromType(ActionGoalMsg._TYPE);
        standardArmMsg.setActionType(1);
        return TaskManager.requestMoveArm(standardArmMsg);
    }

    public int requestStandardGripper(){
        ActionGoalMsg standardGripperMsg = messageFactory.newFromType(ActionGoalMsg._TYPE);
        standardGripperMsg.setActionType(1);
        return TaskManager.requestMoveHand(standardGripperMsg);
    }

    public void requestGoalTopic(){
        TaskManager.requestGoalTopic();
    }

    public void requestPlanTopic(java.lang.String currentPlan){
        TaskManager.requestPlanTopic(currentPlan);
    }
}