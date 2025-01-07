/*
 * Copyright (C) 2011 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */

package org.ros.rosjava_task_manager;

import org.ros.namespace.GraphName;
import org.ros.node.AbstractNodeMain;
import org.ros.node.ConnectedNode;
import org.ros.node.NodeConfiguration;
import org.ros.node.NodeMain;
import org.ros.node.service.ServiceResponseBuilder;
import org.ros.node.service.ServiceServer;
import org.ros.node.service.ServiceClient;
import org.ros.node.service.ServiceResponseListener;
import org.ros.node.topic.Publisher;
import org.ros.node.topic.Subscriber;
import org.ros.concurrent.CancellableLoop;
import org.ros.exception.RemoteException;
import org.ros.exception.RosRuntimeException;
import org.ros.exception.ServiceNotFoundException;
import org.ros.internal.message.RawMessage;
import org.ros.message.MessageFactory;
import org.ros.message.MessageListener;

import geometry_msgs.*;
import sensor_msgs.*;
import vision_msgs.*;
import moveit_msgs.*;
import shape_msgs.*;
import rosjava_custom_srv.*;
import std_msgs.*;
import org.ros.uos.ai.jam.*;
import org.ros.uos.ai.jam.expression.*;
import org.ros.uos.ai.jam.parser.JAMParser;
import org.ros.uos.ai.jam.plan.action.GoalAction;

import java.io.File;
import java.time.LocalDateTime;
import java.util.*;
import java.io.Console;

/**
 * A simple {@link ServiceServer} {@link NodeMain}. The original code is created
 * by:
 *
 * @author damonkohler@google.com (Damon Kohler) The custom implementation is
 *         created by v.s.moisiadis@gmail.com(Vasileios Moisiadis)
 */
public class TaskManager extends AbstractNodeMain {
    static private Interpreter interpreter;
    private ProtocolManager protocolManager;
    static private ConnectedNode cn;
    static public boolean waitingQuery;
    static public boolean waitingAction;
    static private java.lang.String queryResults[];
    static private int actionResult;
    static ActionGoalMsg lastGoalMsg;
    static int lastGoalPart; // 0 = mobile, 1 = arm, 2 = hand
    static Subscriber<std_msgs.String> goalSubscriber;
    static Publisher<ActionGoalMsg> armActionGoalPublisher;
    static Publisher<ActionGoalMsg> handActionGoalPublisher;
    static Publisher<ActionGoalMsg> baseActionGoalPublisher;
    static Subscriber<ActionResultMsg> actionResultSubscriber;
    static Publisher<QueryServiceRequest> queryPublisher;
    static Subscriber<QueryServiceResponse> querySubscriber;

    static Subscriber<Monitor> monitorSubscriber;
    static Publisher<MonitorServiceRequest> monitorRequestor;
    static Subscriber<MonitorServiceResponse> monitorReceiver;
    static private NodeConfiguration nodeConfiguration;
    static public MessageFactory messageFactory;
    private int status;
    private Scanner scan;

    // static Publisher<std_msgs.String> planPublisher;
    // static Publisher<std_msgs.String> goalPublisher;

    @Override
    public GraphName getDefaultNodeName() {
        return GraphName.of("task_manager");
    }

    @Override
    public void onStart(final ConnectedNode connectedNode) {  // start Tm 
        cn = connectedNode;
        waitingQuery = false;
        waitingAction = false;
        nodeConfiguration = NodeConfiguration.newPrivate();
        messageFactory = nodeConfiguration.getTopicMessageFactory();
        goalSubscriber = cn.newSubscriber("GUIManager/goal", std_msgs.String._TYPE);
        armActionGoalPublisher = cn.newPublisher("arm_action_cmd", ActionGoalMsg._TYPE);
        handActionGoalPublisher = cn.newPublisher("gripper_action_cmd", ActionGoalMsg._TYPE);
        baseActionGoalPublisher = cn.newPublisher("mobilebase_action_cmd", ActionGoalMsg._TYPE); // x 
        actionResultSubscriber = cn.newSubscriber("action_state", ActionResultMsg._TYPE);

        queryPublisher = cn.newPublisher("context_manager/query/reception", QueryServiceRequest._TYPE);
        querySubscriber = cn.newSubscriber("context_manager/query/provision_for_tm", QueryServiceResponse._TYPE);
        monitorSubscriber = cn.newSubscriber("context_manager/monitor", Monitor._TYPE);                                   //monitor > dummy
        monitorRequestor = cn.newPublisher("context_manager/monitor/reception", MonitorServiceRequest._TYPE);
        monitorReceiver = cn.newSubscriber("context_manager/monitor/provision_for_tm", MonitorServiceResponse._TYPE);
        scan = new Scanner(System.in);

        // planPublisher = cn.newPublisher("task_manager_gui/plan_topic", std_msgs.String._TYPE);
        // goalPublisher = cn.newPublisher("task_manager_gui/goal_topic", std_msgs.String._TYPE);
        
        goalSubscriber.addMessageListener(new MessageListener<std_msgs.String>(){
            @Override
            public void onNewMessage(std_msgs.String message){
                java.lang.String goal = message.getData();
                LinkedList<Expression> expList = new LinkedList<>();
                expList.add(new Value(goal));
                WorldModelTable worldModel = interpreter.getWorldModel();
                worldModel.assertFact(worldModel.newRelation("bringAnItem", expList), null);
            }
        }, 10);

        actionResultSubscriber.addMessageListener(new MessageListener<ActionResultMsg>() {
            @Override
            public void onNewMessage(ActionResultMsg message) {
                actionResult = message.getActionStatus();
                if(actionResult == 1 || actionResult == 2) return;
                if(actionResult != 3) {
                    System.out.println("received action state By AM : " + actionResult);
                    try {  
                        Thread.sleep(5000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    System.out.println("re-publish action goal message.");
                    switch(lastGoalPart) {
                        case 0:
                            baseActionGoalPublisher.publish(lastGoalMsg);
                            break;
                        case 1:
                            armActionGoalPublisher.publish(lastGoalMsg);
                            break;
                        case 2:
                            handActionGoalPublisher.publish(lastGoalMsg);
                            break;
                    }
                }
                if(actionResult == 3) {
                    requestDelay("3000");
                    waitingAction = false;
                }
            }
        }, 10);

        ServiceClient<PoseServiceRequest, PoseServiceResponse> poseClient;
        ServiceClient<PathServiceRequest, PathServiceResponse> pathClient;
        try {
            poseClient = cn.newServiceClient("tamp_interface/pose_generation", PoseService._TYPE);
            pathClient = cn.newServiceClient("tamp_interface/motion_planning", PathService._TYPE);
        } catch (ServiceNotFoundException e) {
            throw new RosRuntimeException(e);
        }
        protocolManager = new ProtocolManager();
        protocolManager.setPoseClient(poseClient);
        protocolManager.setPathClient(pathClient);
        protocolManager.setMessageFactory(messageFactory);
        cn.newServiceServer("task_manager/jam_service", JamService._TYPE, 
        new ServiceResponseBuilder<JamServiceRequest, JamServiceResponse>() {
            @Override
            public void build(JamServiceRequest request, JamServiceResponse response) {
                try {
                    interpreter = new Interpreter();
                    File jamFolder = new File(request.getPath());
                    if(!jamFolder.isDirectory()){
                        response.setRes("The path is not a folder.");
                        return;
                    }
                    for(File planFile : jamFolder.listFiles()){
                        if(planFile.isDirectory()){
                            continue;
                        }
                        JAMParser.parseFile(interpreter, planFile);
                    }
                    WorldModelTable worldModel = interpreter.getWorldModel();
                    interpreter.setPlanFolder(request.getPath());
                    LinkedList<Expression> expList1 = new LinkedList<Expression>();
                    expList1.add(new Value(protocolManager));
                    worldModel.assertFact(worldModel.newRelation("ProtocolManager", expList1), null);
                    Scanner sc = new Scanner(System.in);
                    LinkedList<Expression> expList2 = new LinkedList<Expression>();
                    expList2.add(new Value(sc));
                    worldModel.assertFact(worldModel.newRelation("Scanner", expList2), null);
                    List<java.lang.String> standardHandPose = new ArrayList<>();
                    standardHandPose.add("[1.735, 0.343, ...]");
                    LinkedList<Expression> expList3 = new LinkedList<Expression>();
                    expList3.add(new Value("jacoHand01"));
                    expList3.add(new Value(standardHandPose));
                    worldModel.assertFact(worldModel.newRelation("standardHandPose", expList3), null);
                    
                    interpreter.run();
                    response.setRes("Finish");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.setRes("Error in planning!");
                }
            }
        });

        cn.newServiceServer("task_manager/assert_fact", PredicateService._TYPE, 
        new ServiceResponseBuilder<PredicateServiceRequest, PredicateServiceResponse>() {
            @Override
            public void build(PredicateServiceRequest request, PredicateServiceResponse response) {
                java.lang.String info = "";
                boolean isOk = true;
                List<java.lang.String> predicates = request.getPredicate();
                List<java.lang.String> param1 = request.getParam1();
                List<java.lang.String> param2 = request.getParam2();
                List<java.lang.String> param3 = request.getParam3();
                List<java.lang.String> param4 = request.getParam4();
                try {
                    for(int i = 0 ; i < predicates.size() ; ++i){
                        assertFact(predicates.get(i), param1.get(i), param2.get(i), param3.get(i), param4.get(i));
                        // info += "\nAssert Facts : " + predicates.get(i) + "(";
                        // LinkedList<Expression> expList = new LinkedList<>();

                        // if(!param1.get(i).equals("")) {
                        //     expList.add(new Value(param1.get(i)));
                        //     info += "'" + param1.get(i) + "'";
                        // }
                        // if(!param2.get(i).equals("")) {
                        //     expList.add(new Value(param2.get(i)));
                        //     info += ", '" + param2.get(i) + "'";
                        // }
                        // if(!param3.get(i).equals("")) {
                        //     expList.add(new Value(param3.get(i)));
                        //     info += ", '" + param3.get(i) + "'";
                        // }
                        // if(!param4.get(i).equals("")) {
                        //     expList.add(new Value(param4.get(i)));
                        //     info += ", '" + param4.get(i) + "'";
                        // }
                        // info += ")";
                        // WorldModelTable worldModel = interpreter.getWorldModel();
                        // worldModel.assertFact(worldModel.newRelation(predicates.get(i), expList), null);
                    }
                } catch (Exception e) {
                    isOk = false;
                } finally {
                    response.setResult((isOk)?0:-1);
                    //cn.getLog().info(java.lang.String.format(((isOk)?"Success changing world model.":"Error in changing world model.") + info));
                }
            }
        });
        
        cn.newServiceServer("task_manager/assert_poses", PosesService._TYPE, 
        new ServiceResponseBuilder<PosesServiceRequest, PosesServiceResponse>() {
            @Override
            public void build(PosesServiceRequest request, PosesServiceResponse response) {
                java.lang.String info = "";
                boolean isOk = true;
                java.lang.String predicate = request.getPredicate();
                java.lang.String param1 = request.getParam1();
                java.lang.String param2 = request.getParam2();
                List<ActionGoalMsg> param3 = request.getParam3();
                java.lang.String param4 = request.getParam4();
                try {
                    info += "\nAssert Poses : " + predicate + "(";
                    LinkedList<Expression> expList = new LinkedList<>();
                    
                    expList.add(new Value(param1));
                    info += "'" + param1 + "'";
                    
                    expList.add(new Value(param2));
                    info += ", '" + param2 + "'";
                    
                    expList.add(new Value(param3));
                    info += ", [";
                    for(int i = 0 ; i < param3.size() ; ++i){
                        info += "'" + param3.get(i).toString() + "'";
                        if(i != param3.size() - 1) info += ", ";
                    }
                    info += "])";
                    WorldModelTable worldModel = interpreter.getWorldModel();
                    worldModel.assertFact(worldModel.newRelation(predicate, expList), null);
                } catch (Exception e) {
                    isOk = false;
                } finally {
                    response.setResult((isOk)?0:-1);
                    // cn.getLog().info(java.lang.String.format(((isOk)?"Success asserting poses in world model.":"Error in asserting poses in world model.") + info));
                }
            }
        });

        cn.newServiceServer("task_manager/assert_pose", PathService._TYPE, 
        new ServiceResponseBuilder<PathServiceRequest, PathServiceResponse>() {
            @Override
            public void build(PathServiceRequest request, PathServiceResponse response) {
                java.lang.String info = "";
                boolean isOk = true;
                java.lang.String predicate = request.getPredicate();
                java.lang.String param1 = request.getParam1();
                ActionGoalMsg param2 = request.getParam2();
                List<ActionGoalMsg> param3 = request.getParam3();
                java.lang.String param4 = request.getParam4();
                try {
                    info += "\nAssert Pose : " + predicate + "(";
                    LinkedList<Expression> expList = new LinkedList<>();
                    
                    expList.add(new Value(param1));
                    info += "'" + param1 + "'";
                    
                    expList.add(new Value(param2));
                    info += ", '" + param2.toString() + "'";
                    
                    expList.add(new Value(param3.get(0)));
                    info += ", '" + param3.get(0).toString() + "')";
                    WorldModelTable worldModel = interpreter.getWorldModel();
                    worldModel.assertFact(worldModel.newRelation(predicate, expList), null);
                } catch (Exception e) {
                    isOk = false;
                } finally {
                    response.setResult((isOk)?0:-1);
                    // cn.getLog().info(java.lang.String.format(((isOk)?"Success asserting pose in world model.":"Error in asserting pose in world model.") + info));
                }
            }
        });

        monitorSubscriber.addMessageListener(new MessageListener<Monitor>() {
      
            @Override
            public void onNewMessage(Monitor message) {
                java.lang.String info=null;
                boolean isOk = true;
                try{
              LinkedList<Expression> expList = new LinkedList<>();
              java.lang.String predicate = message.getPredicate();
              java.lang.String param1 = message.getParam1();
              java.lang.String param2 = message.getParam2();
              java.lang.String param3 = message.getParam3();
              java.lang.String param4 = message.getParam4();
                if(!param1.equals("") && param1 != null) {
                    expList.add(new Value(param1));
                 //   info += "'" + param1.get(i) + "'";
                }
                if(!param2.equals("")&& param2 != null) {
                    expList.add(new Value(param2));
                 //   info += ", '" + param2.get(i) + "'";
                }
                if(!param3.equals("")&& param3 != null) {
                    expList.add(new Value(param3));
                  //  info += ", '" + param3.get(i) + "'";
                }
                if(!param4.equals("")&& param4 != null) {
                    expList.add(new Value(param4));
                  //  info += ", '" + param4.get(i)) + "'";
                }


              info = "Monitor : " + message.getPredicate()+ " " + message.getParam1() + " " + message.getParam2()
                  + " " + message.getParam3() + " " + message.getParam4();
              interpreter.getWorldModel().assertFact(interpreter.getWorldModel().newRelation(predicate,expList),null);
            }
            catch(Exception e){
                isOk = false;
            }
            cn.getLog().info(java.lang.String.format(((isOk)?"Success changing world model.":"Error in changing world model.") + info));
              if(message.getStatus() == 2)
                status=0;
            }
          });

        querySubscriber.addMessageListener(new MessageListener<QueryServiceResponse>() {
			@Override
			public void onNewMessage(QueryServiceResponse response) {
                // System.out.println("querySubscriber received result");
                // System.out.println(response.getResult());
				queryResults = response.getResult().split("-/#/-");
                waitingQuery = false;
			}
        });
        
        monitorReceiver.addMessageListener(new MessageListener<MonitorServiceResponse>() {

        @Override
        public void onNewMessage(MonitorServiceResponse response) {
            java.lang.String info = "Monitor : " + response.getPredicate() + " " + response.getParam1() + " " + response.getParam2()
            + " " + response.getParam3() + " " + response.getParam4();

            //connectedNode.getLog().info(java.lang.String.format("The response is : "+ info +response.getStatus()));
      
        }
        });

        //   its dummy ===========================================================
        //   final MonitorServiceRequest mRequest = monitorRequestor.newMessage();
        //   final QueryServiceRequest qRequest = questioner.newMessage();
          
        //   while (true) {
        //     try{
        //     Thread.sleep(1500);
        //     }catch(Exception e){e.printStackTrace();}
        //     //qRequest.setQuery("assert(a)");
        //     //qRequest.setManager("TaskManager");
        //     //questioner.publish(qRequest);
        //     setMessage(mRequest,scan.nextLine());
        //     mRequest.setManager("TaskManager");
        //     status=mRequest.getStatus();
        //     monitorRequestor.publish(mRequest);
        //     while(status == 2){
        //       Thread.yield();
        //     }
        //   }
    }

    static public int requestMoveArm(ActionGoalMsg armActionGoalMsg){
        lastGoalMsg = armActionGoalMsg;
        lastGoalPart = 1;
        armActionGoalPublisher.publish(armActionGoalMsg);
        waitingAction = true;
        while(waitingAction) {System.out.print("");}
        return actionResult;
    }

    static public int requestMoveHand(ActionGoalMsg handActionGoalMsg){
        lastGoalMsg = handActionGoalMsg;
        lastGoalPart = 2;
        handActionGoalPublisher.publish(handActionGoalMsg);
        waitingAction = true;
        while(waitingAction) {System.out.print("");}
        return actionResult;
    }

    static public int requestMoveBase(ActionGoalMsg baseActionGoalMsg){
        lastGoalMsg = baseActionGoalMsg;
        lastGoalPart = 0;
        baseActionGoalPublisher.publish(baseActionGoalMsg);
        waitingAction = true;
        while(waitingAction) {System.out.print("");}
        return actionResult;
    }

    static public java.lang.String[] requestFullStateDescription(java.lang.String predicate, java.lang.String param1, java.lang.String param2, java.lang.String param3,
    java.lang.String param4){
	
        QueryServiceRequest queryServiceRequest = queryPublisher.newMessage();
	/*queryServiceRequest.setQuery("empty_test(A,B)");
	queryServiceRequest.setManager("TaskManager");
	queryPublisher.publish(queryServiceRequest);

	try{
		Thread.sleep(6);
	}catch(Exception e){}
	
	queryServiceRequest = queryPublisher.newMessage();*/
        java.lang.String query = predicate + "(";
        int paramCount = 0;
        if(!param1.equals("")){
            query += param1;
        }
        if(!param2.equals("")){
            query += ", " + param2;
        }
        if(!param3.equals("")){
            query += ", " + param3;
        }
        if(!param4.equals("")){
            query += ", " + param4;
        }
        query += ")";
        // System.out.println("query is : " + query);
        queryServiceRequest.setQuery(query); // query format : predicate(param1, param2, param3, param4)
        queryServiceRequest.setManager("TaskManager");
        waitingQuery = true;
        queryPublisher.publish(queryServiceRequest);
        while(waitingQuery){System.out.print("");} // wait for get results
        // System.out.println("I'm received " + queryResults.length);
        java.lang.String results[] = new java.lang.String[queryResults.length];
        if(queryResults[0].equals("True")){
            results[0] = query;
		// if(predicate.contains("Perception")) System.out.println("True : " + query);
        // if(predicate.contains("currentObjectPose")) System.out.println("True : " + query);
        // if(predicate.contains("hand")) System.out.println("True : " + query);
	    // if(predicate.contains("graspedBy")) System.out.println("True : " + query);
        if(predicate.contains("Physical")) System.out.println("True : " + query);
            assertFact(predicate, param1, param2, param3, param4);
            //System.out.println("True :" + query);
        } else if (queryResults[0].equals("False")){
            results[0] = "";
		// if(predicate.contains("Perception")) System.out.println("False : " + query);
        // if(predicate.contains("currentObjectPose")) System.out.println("False : " + query);
        // if(predicate.contains("hand")) System.out.println("False : " + query);
	    // if(predicate.contains("graspedBy")) System.out.println("False : " + query);
        if(predicate.contains("Physical")) System.out.println("False : " + query);
            //System.out.println("False :" + query);
        } else { // result which contains variables
            //System.out.println("Variable Query");
            for(int i = 0 ; i < queryResults.length ; ++i){
                results[i] = query;
                for(java.lang.String exp : queryResults[i].split("-/-/-")){
                    java.lang.String arr[] = exp.split("-/@/-"); // [0] : variable, [1] : value
                    results[i] = results[i].replace(arr[0], arr[1]);
                }
            //System.out.println(results[i]);
		    // if(predicate.contains("Perception")) System.out.println(results[i]);
            // if(predicate.contains("currentObjectPose")) System.out.println(results[i]);
            // if(predicate.contains("hand")) System.out.println(results[i]);
		    // if(predicate.contains("graspedBy")) System.out.println(results[i]);
            if(predicate.contains("Physical")) System.out.println(results[i]);
                assertFact(results[i]);
            }
        }
        return results;
    }

    private static void assertFact(java.lang.String query) {
        //System.out.println(query);
        LinkedList<Expression> expList = new LinkedList<>();
        java.lang.String arr[] = query.split("\\(");
        arr[1] = arr[1].substring(0, arr[1].length() - 1); // clean ')'
        java.lang.String param[] = arr[1].split(",");
        for(int i = 0 ; i < param.length ; ++i) {
            expList.add(new Value(param[i].trim()));
        }
        WorldModelTable worldModel = interpreter.getWorldModel();
        worldModel.assertFact(worldModel.newRelation(arr[0], expList), null);
    }

    private static void assertFact(java.lang.String predicate, java.lang.String param1, java.lang.String param2, java.lang.String param3,
    java.lang.String param4){
        LinkedList<Expression> expList = new LinkedList<>();
        if(!param1.equals("")) expList.add(new Value(param1));
        if(!param2.equals("")) expList.add(new Value(param2));
        if(!param3.equals("")) expList.add(new Value(param3));
        if(!param4.equals("")) expList.add(new Value(param4));
        WorldModelTable worldModel = interpreter.getWorldModel();
        worldModel.assertFact(worldModel.newRelation(predicate, expList), null);
    }

    private void setMessage(MonitorServiceRequest request, java.lang.String param) {
        java.lang.String[] params = param.split(" ");
    
        request.setPredicate(params[0]);
        request.setParam1(params[1]);
        request.setParam2(params[2]);
        request.setParam3(params[3]);
        request.setParam4(params[4]);
        request.setStatus(Integer.parseInt(params[5]));
      }

    static void requestGoalTopic(){
        try {
            IntentionStructure intentionStructure = interpreter.getIntentionStructure();
            List<Goal> goals = intentionStructure.getStacks();
            java.lang.String result = "";
            for(int i = 0 ; i < goals.size() ; ++i){
                Goal goal = goals.get(i);
                GoalAction goalAction = goal.getGoalAction();
                result += Integer.toString(goalAction.getType()) + "-/@/-";
                result += goal.getName() + "-/@/-";
                result += ((goalAction.getUtility() == null)?"0":goalAction.getUtility().toString()) + "-/@/-";
                result += Integer.toString(goal.getStatus());
                if(i != goals.size() - 1) result += "-/-/-";
            }
            std_msgs.String goalMsg = messageFactory.newFromType(std_msgs.String._TYPE);
            goalMsg.setData(result);
            // goalPublisher.publish(goalMsg);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    static void requestPlanTopic(java.lang.String currentPlan){
        std_msgs.String planMsg = messageFactory.newFromType(std_msgs.String._TYPE);
        planMsg.setData(currentPlan);
        // planPublisher.publish(planMsg);
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

    //   static void requestPrintCurrentGoal(){
    //       try {
    //           IntentionStructure intentionStructure = interpreter.getIntentionStructure();
    //           Goal goal = intentionStructure.getCurrentGoal();
    //           System.out.println("Currnet Goal : " + goal.getName());
    //       } catch (Exception e) {
    //           return;
    //       }
    //   }
}    
