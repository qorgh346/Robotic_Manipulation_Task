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

    package org.ros.rosjava_context_manager;

    import java.lang.*;
    import java.util.*;
    import java.lang.Integer;
    import org.ros.exception.RemoteException;
    import org.ros.exception.RosRuntimeException;
    import org.ros.exception.ServiceNotFoundException;
    import org.ros.namespace.GraphName;
    import org.ros.node.AbstractNodeMain;
    import org.ros.node.ConnectedNode;
    import org.ros.node.NodeMain;
    import org.ros.node.service.ServiceClient;
    import org.ros.node.service.ServiceResponseBuilder;
    import org.ros.node.service.ServiceResponseListener;
    import rosjava_custom_srv.*;
    import org.apache.commons.logging.Log;
    import org.ros.message.MessageListener;
    import org.ros.node.topic.*;
    import org.ros.internal.message.action.*;
    import org.jpl7.*;
    import java.util.*;
    
    /**
     * A simple {@link ServiceClient} {@link NodeMain}. The original code is created
     * by:
     *
     * @author damonkohler@google.com (Damon Kohler) The custom implementation is
     *         created by v.s.moisiadis@gmail.com(Vasileios Moisiadis)
     */
    public class Client3 extends AbstractNodeMain {
      Scanner scan = new Scanner(System.in);
      //static Subscriber<PredicateServiceRequest> receptionistForPredicate;
      static Publisher<MonitorServiceRequest> requestor;
      static Subscriber<MonitorServiceResponse> receiver;
      //static ServiceClient<MonitorServiceRequest, MonitorServiceResponse> serviceClient;
    
      final static int queueSize = 1000;
      @Override
      public GraphName getDefaultNodeName() {
        return GraphName.of("rosjava_tutorial_custom_custom_services/client2");
      }
    
      /*
      public void setMessage(MonitorServiceRequest request, String param) {
        String[] params = param.split(" ");
    
        request.setPredicate(params[0]);
        request.setParam1(params[1]);
        request.setParam2(params[2]);
        request.setParam3(params[3]);
        request.setParam4(params[4]);
        request.setStatus(Integer.parseInt(params[5]));
      }*/
    
      @Override
      public void onStart(final ConnectedNode connectedNode) {
        Scanner queryInput = new Scanner(System.in);
        
        try {
         // serviceClient = connectedNode.newServiceClient("ContextManager/MonitorService", MonitorService._TYPE);
         //receptionistForPredicate = connectedNode.newPublisher("ContextManager/Predicate/Reception", PredicateServiceRequest._TYPE);
         requestor = connectedNode.newPublisher("context_manager/monitor/reception", MonitorServiceRequest._TYPE);
         receiver = connectedNode.newSubscriber("context_manager/monitor/provision_for_tm",MonitorServiceResponse._TYPE);
         //receiver = connectedNode.newSubscriber("ContextManager/Monitor/Provision", MonitorServiceResponse._TYPE);
        } catch (Exception e) {
          throw new RosRuntimeException(e);
        }

        //test
        receiver.addMessageListener(new MessageListener<MonitorServiceResponse>() {
          @Override
          public void onNewMessage(MonitorServiceResponse response) {
            
            String ans = Parser.text_transPredicate(response);
            connectedNode.getLog().info(String.format("The response is : "+ans));
          }
        }, queueSize);


        /*
        final PredicateServiceRequest request = receptionistForPredicate.newMessage();
        request.setPredicate("currentObjectPerception");
        request.setParam1("Object");
        request.setParam2("Perception");
        request.setParam3("0");
        request.setParam4("0");
        receptionistForPredicate.publish(request);
        */

        try {
          Thread.sleep(2000);
          MonitorServiceRequest request2 = requestor.newMessage();
          request2.setStatus(99);
          request2.setManager("ContextManager");
          requestor.publish(request2);
          Thread.sleep(3000);

        
          
         // String message="";
          //MonitorServiceRequest request = requestor.newMessage();
          //message = queryInput.nextLine();
          //setMessage(request,message);
          
          /*
          request.setPredicate("currentObjectPerception");
          request.setParam1("Object");
          request.setParam2("ObjectPerception");
          request.setParam3("0");
          request.setParam4("0");
          request.setStatus(100);
          request.setManager("ContextManager");
          requestor.publish(request);
          Thread.sleep(2000);
          */

          while(true){
            //Thread.sleep(2000);
            //ContextManager.setMessage(request,scan.nextLine());
            //request.setManager("TaskManager");
    
            String message="";
            MonitorServiceRequest request = requestor.newMessage();
            message = queryInput.nextLine();
            setMessage(request,message);
            requestor.publish(request);
          }

        } catch (Exception e) {
          e.printStackTrace();
        }
      }

      public void setMessage(MonitorServiceRequest request, String query){
        String[] params = query.split(" ");
          request.setPredicate(params[0]);
          request.setParam1(params[1]);
          request.setParam2(params[2]);
          request.setParam3(params[3]);
          request.setParam4(params[4]);
          request.setStatus(100);
          request.setManager("ContextManager");
      }
    }