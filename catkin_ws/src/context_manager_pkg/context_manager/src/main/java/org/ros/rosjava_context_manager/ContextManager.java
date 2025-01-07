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

    import rosjava_custom_srv.*;

    import java.lang.Integer;
    import java.io.*;
    import java.lang.Thread;
    import org.apache.commons.logging.Log;
    import org.ros.namespace.GraphName;
    import org.ros.exception.*;
    import org.ros.node.AbstractNodeMain;
    import org.ros.node.ConnectedNode;
    import org.ros.node.NodeMain;
    import org.ros.node.service.ServiceResponseBuilder;
    import org.ros.node.service.ServiceServer;
    import org.ros.node.service.ServiceClient;
    import org.ros.node.service.ServiceResponseListener;
    import java.io.Console;
    import org.jpl7.*;
    import org.ros.concurrent.CancellableLoop;
    import org.ros.node.topic.*;
    import org.ros.message.MessageListener;
    
    import java.util.*;
    
    /**
     * A simple {@link ServiceServer} {@link NodeMain}. The original code is created
     * by:
     *
     * @author damonkohler@google.com (Damon Kohler) The custom implementation is
     *         created by v.s.moisiadis@gmail.com(Vasileios Moisiadis)
     */
    public class ContextManager extends AbstractNodeMain {
    
      static int status = -200;
      static Publisher<Monitor> publisherForTM;
      static Subscriber<Monitor> subscriberForPM;
      static Subscriber<MonitorServiceRequest> receptionistForMonitor;
      static Subscriber<QueryServiceRequest> receptionistForQuery;
      static Publisher<QueryServiceResponse> qProviderForTM;
      static Publisher<QueryServiceResponse> qProviderForPM;
      static Publisher<MonitorServiceResponse> mProviderForTM;
      static Publisher<MonitorServiceResponse> mProviderForPM;
      static Subscriber<MainServiceRequest> receptionistForService;
      static Publisher<MainServiceRequest> tmpMainRequestGenerator;
      static Publisher<MonitorServiceRequest> tmpMonitorRequestGenerator;
    
      //***********************************add here by jaeyun 
      //static Publisher<PredicateServiceResponse> pProviderForTM;
      //static Publisher<PredicateServiceResponse> pProviderForCM;
      //static Subscriber<PredicateServiceRequest> receptionistForPredicate;
      
      // static ServiceClient<MonitorServiceRequest, MonitorServiceResponse>
      // serviceClient;
      static ConnectedNode connectedNode;
      static Log log;

      final static int queueSize = 1000;
    
      @Override
      public GraphName getDefaultNodeName() {
        return GraphName.of("context_manager");
      }
    
      /*
       * public static void setMessage(Triple message, String param){ String[] params
       * = param.split(" "); message.setDomain(params[0]);
       * message.setProperty(params[1]); message.setRange(params[2]); }
       */
    
      public static void setMessage(Monitor message, String param) {
        param.replaceAll("\\'","'");
        if (param.contains("monitored") && param.indexOf("monitored") != -1)
          param = param.substring(param.indexOf("monitored ") + "monitored ".length());
    
        String[] params = param.split(" ");
        message.setPredicate(params[0]);
        message.setParam1(params[1]);
        message.setParam2(params[2]);
        message.setParam3(params[3]);
        message.setParam4(params[4]);
    
        if (params[5].contains("'"))
          params[5] = params[5].substring(0, params[5].indexOf("'"));
    
        message.setStatus(Integer.parseInt(params[5]));
      }
    
      public static void setMessage(MonitorServiceRequest message, String param) {
        if (param.contains("monitored") && param.indexOf("monitored") != -1)
          param = param.substring(param.indexOf("monitored ") + "monitored ".length());
    
        String[] params = param.split(" ");
        message.setPredicate(params[0]);
        message.setParam1(params[1]);
        message.setParam2(params[2]);
        message.setParam3(params[3]);
        message.setParam4(params[4]);
    
        if (params[5].contains("'"))
          params[5] = params[5].substring(0, params[5].indexOf("'"));
    
        message.setStatus(Integer.parseInt(params[5]));
      }
    
      public static void copyMessageToRequest(Monitor message, MonitorServiceRequest request) {
        request.setPredicate(message.getPredicate());
        request.setParam1(message.getParam1());
        request.setParam2(message.getParam2());
        request.setParam3(message.getParam3());
        request.setParam4(message.getParam4());
        request.setStatus(message.getStatus());
      }
    
      
      public static void copyQueryToRequest(QueryServiceRequest qRequest, MonitorServiceRequest mRequest) {
        mRequest.setPredicate(qRequest.getQuery());
        mRequest.setManager(qRequest.getManager());
        mRequest.setStatus(101);
      }

      public static void copyQueryToRequest(QueryServiceRequest qRequest, MainServiceRequest mRequest) {
        
         List<String> temp = new ArrayList<String>();
          temp.add(qRequest.getQuery());
          mRequest.setPredicate(temp);

          int[] st = {101};
          mRequest.setStatus(st);

          mRequest.setManager(qRequest.getManager());
      }

      public static void copyRequestToRequest(MonitorServiceRequest monitorRequest, MainServiceRequest mainRequest){
          List<String> temp = new ArrayList<String>();
          temp.add(monitorRequest.getPredicate());
          mainRequest.setPredicate(temp);

          temp = new ArrayList<String>();
          temp.add(monitorRequest.getParam1());
          mainRequest.setParam1(temp);

          temp = new ArrayList<String>();
          temp.add(monitorRequest.getParam2());
          mainRequest.setParam2(temp);

          temp = new ArrayList<String>();
          temp.add(monitorRequest.getParam3());
          mainRequest.setParam3(temp);

          temp = new ArrayList<String>();
          temp.add(monitorRequest.getParam4());
          mainRequest.setParam4(temp);

          int[] st = {monitorRequest.getStatus()};
          mainRequest.setStatus(st);

          mainRequest.setManager(monitorRequest.getManager());
      }
    
      @Override
      public void onStart(final ConnectedNode connectedNode) {
        

        ContextManager.connectedNode = connectedNode;
        ContextManager.log = connectedNode.getLog();
    
        try {
          publisherForTM = connectedNode.newPublisher("context_manager/monitor", Monitor._TYPE);
         
          // for Monitor
          mProviderForTM = connectedNode.newPublisher("context_manager/monitor/provision_for_tm",
              MonitorServiceResponse._TYPE);
          mProviderForPM = connectedNode.newPublisher("context_manager/monitor/provision_for_pm",
              MonitorServiceResponse._TYPE);
    
          // for Query
          qProviderForTM = connectedNode.newPublisher("context_manager/query/provision_for_tm", QueryServiceResponse._TYPE);
          qProviderForPM = connectedNode.newPublisher("context_manager/query/provision_for_pm", QueryServiceResponse._TYPE);
    
          // for Tmp
          tmpMainRequestGenerator = connectedNode.newPublisher("context_manager/main/reception", MainServiceRequest._TYPE);
          tmpMonitorRequestGenerator = connectedNode.newPublisher("context_manager/monitor/reception", MonitorServiceRequest._TYPE);
    
          // for Reception
          receptionistForMonitor = connectedNode.newSubscriber("context_manager/monitor/reception", MonitorServiceRequest._TYPE);
          receptionistForQuery = connectedNode.newSubscriber("context_manager/query/reception", QueryServiceRequest._TYPE);
          receptionistForService = connectedNode.newSubscriber("context_manager/main/reception", MainServiceRequest._TYPE);
    
          //for Predicate
          //pProviderForTM = connectedNode.newPublisher("ContextManager/Predicate/ProvisionForTM", PredicateServiceResponse._TYPE);
          //pProviderForCM = connectedNode.newPublisher("ContextManager/Predicate/ProvisionForPM", PredicateServiceResponse._TYPE);
          //receptionistForPr = connectedNode.newSubscriber("ContextManager/Predicate/Reception", PredicateServiceRequest._TYPE);
    
    
        } catch (Exception e) {
          throw new RosRuntimeException(e);
        }

        System.setOut(new PrintStream(System.out) {
          public void println(String s) {
            System.out.println(s);
            if (s.contains("monitored")) {
              
              monitored(s);
            }
          }
        });

        receptionistForMonitor.addMessageListener(new MessageListener<MonitorServiceRequest>() {
    
          @Override
          public void onNewMessage(MonitorServiceRequest monitorRequest) {
    
            MainServiceRequest mainRequest = tmpMainRequestGenerator.newMessage();
            copyRequestToRequest(monitorRequest, mainRequest);
            tmpMainRequestGenerator.publish(mainRequest);
          }
        }, queueSize);
    
        receptionistForQuery.addMessageListener(new MessageListener<QueryServiceRequest>() {
    
          @Override
          public void onNewMessage(QueryServiceRequest qRequest) {
    
            MainServiceRequest mRequest = tmpMainRequestGenerator.newMessage();
            copyQueryToRequest(qRequest, mRequest);
            tmpMainRequestGenerator.publish(mRequest);
          }
        }, queueSize);
    
        receptionistForService.addMessageListener(new MessageListener<MainServiceRequest>() {
    
          @Override
          public void onNewMessage(MainServiceRequest request) {
    
    for(int i=0;i<request.getPredicate().size();i++){
      TempQuery query = new TempQuery();
      query.setPredicate(request.getPredicate().get(i));
      if(request.getParam1().size()!=0)
      query.setParam1(request.getParam1().get(i));
      if(request.getParam2().size()!=0)
      query.setParam2(request.getParam2().get(i));
      if(request.getParam3().size()!=0)
      query.setParam3(request.getParam3().get(i));
      if(request.getParam4().size()!=0)
      query.setParam4(request.getParam4().get(i));
      //System.out.println(query);
      //if(query.getPredicate().equals("End"))break;
            try {
              switch (request.getStatus()[i]) {
    
              case 8:
                monitor(query);
                break;
              case 4:
                rdf_retract(query);
                break;
              case 3:
                rdf_assert(query);
                break;
              case 0:
                regist1(query);
                break;
              case 2:
                regist2(query);
                break;
              case -1:
                cancel1(query);
                break;
              case -2:
                cancel2(query);
                break;
              case 99:
                initialize();
                break;
              case 100:
                query(query);
                break;
              case 101:
                query2(query);
                break;
              case 102:
                query3(query);
                break;
              //default:
              //  query(request);
              }
            } catch (Exception e) {
              e.printStackTrace();
            }
    
            if (status == 9) {
              ContextManager.log.info("<==============receive success==============>");
              /*QueryServiceResponse response = qProviderForPM.newMessage();
              response.setResult("Done");
    
              if (request.getManager().equals("ContextManager"))
                qProviderForPM.publish(response);
              else if (request.getManager().equals("TaskManager"))
                qProviderForTM.publish(response);*/
            } else if (status != 3 && status!=4) {
              MonitorServiceResponse response = mProviderForPM.newMessage();
              response.setStatus(status);
    
              if (request.getManager().equals("ContextManager"))
                mProviderForPM.publish(response);
              else if (request.getManager().equals("TaskManager"))
                mProviderForTM.publish(response);
            }
            status = 9;
          }
          }
        }, queueSize);
        
      }
    
      public void initialize() {
        String initialize = "consult('/home/Downloads/190816_cmtm_code/cmProlog/prolog/init.pl')";
        Query query = new Query(initialize);
        ContextManager.log.info(initialize + " " + (query.hasSolution() ? "successed" : "failed"));
    
        /*
        initialize = "currentObjectPerception(Object, CurrentPerception)";
        String response = "";
        query = new Query(initialize);
        Map<String,Term>[] getResponse = query.allSolutions();
        ContextManager.log.info("Cancellation------" + " " + getResponse.length);
        for(int i = 0; i < getResponse.length; i++){
          response += getResponse[i];
          ContextManager.log.info("Cancellation" + " " + response);
        }*/
        //ContextManager.log.info("Cancellation" + " " + response);
    
        
        initialize = "consult('/home/Downloads/190816_cmtm_code/cmProlog/prolog/monitor.pl')";
        query = new Query(initialize);
        ContextManager.log.info(initialize + " " + (query.hasSolution() ? "successed" : "failed"));
    
        initialize = "start_monitor";
        query = new Query(initialize);
        ContextManager.log.info(initialize + " " + (query.hasSolution() ? "successed" : "failed"));
        
      }
    /*
      public void query(MonitorServiceRequest request) {
    
        Query query = new Query(request.getPredicate());
    
        status = query.hasSolution() ? 9 : -99;
    
        ContextManager.log.info(request.getPredicate() + " " + (query.hasSolution() ? "successed" : "failed"));
      }
    */
      public void rdf_assert(TempQuery request){//MonitorServiceRequest request) {
          //implement//
        String rdf_assert = "rdf_assert(" + request.getParam1() + "," + request.getPredicate() + "," + request.getParam2() + ")";

	Query query = new Query(rdf_assert);

	status = query.hasSolution() ? 3 : -99;
      }

      public void rdf_retract(TempQuery request){//MonitorServiceRequest request){
        String rdf_retract = "rdf_retractall(" + request.getParam1() + "," + request.getPredicate() + "," + request.getParam2() + ")";
    
        Query query = new Query(rdf_retract);
    
        status = query.hasSolution() ? 4 : -99;
    
        //ContextManager.log.info(rdf_retract + " " + (query.hasSolution() ? "successed" : "failed"));
      }
    
      public void monitor(TempQuery request){//MonitorServiceRequest request) {
        String cancel = "rdf_retractall(" + request.getParam1() + "," + request.getPredicate() + "," + request.getParam2()
            + ",D)";
    
        Query query = new Query(cancel);
    
        status = query.hasSolution() ? 8 : -99;
    
        String monitor = "rdf_assert(" + request.getParam1() + "," + request.getPredicate() + "," + request.getParam2()
            + ")";
    
        query = new Query(monitor);
        ContextManager.log.info(monitor + " " + (query.hasSolution() ? "successed" : "failed"));
        
      }
    
      public void monitored(String params) {
        ContextManager.log.info("Monitored " + params);
        String data = null;
        Monitor message = publisherForTM.newMessage();
        setMessage(message, params);
    
        ContextManager.log.info(message.getPredicate() + " " + message.getParam1() + " " + message.getParam2() + " "
            + message.getParam3() + " " + message.getParam4());
    
        data = "[";
    
        String rdf = "rdf(" + message.getParam1() + "," + message.getPredicate() + "," + message.getParam2() + ")";
        Query query = new Query(rdf);
    
        status = query.hasSolution() ? 1 : -99;
    
        ContextManager.log.info(message.getPredicate() + " " + (query.hasSolution() ? "successed" : "failed"));
    
        String v = null;
    
        if (Character.isUpperCase(message.getParam1().charAt(0)))
          v = message.getParam1();
        else if (Character.isUpperCase(message.getParam2().charAt(0)))
          v = message.getParam2();
    
        if (query.hasSolution()) {
          Map<String, Term>[] solutions = query.allSolutions();
    
          for (int i = 0; i < solutions.length; ++i) {
            data += solutions[i].get(v);
            // ContextManager.log.info(data);
            if (i + 1 < solutions.length)
              data += ",";
          }
        }
    
        data += "]";
    
        if (message.getStatus() == 2) {
          MonitorServiceRequest request = tmpMonitorRequestGenerator.newMessage();
          copyMessageToRequest(message, request);
          request.setStatus(-2);
          tmpMonitorRequestGenerator.publish(request);//cancel2(request);
        }
    
        if (Character.isUpperCase(message.getParam1().charAt(0)))
          message.setParam1(data);
        else if (Character.isUpperCase(message.getParam2().charAt(0)))
          message.setParam2(data);
    
        publisherForTM.publish(message);
      }
    
      public void regist1(TempQuery request){//MonitorServiceRequest request) {
        String cancel = "rdf_retractall(" + request.getParam1() + "," + request.getPredicate() + "," + request.getParam2()
            + ",D)";
    
        Query query = new Query(cancel);
    
        query.hasSolution();
        String regist = "assert(monitor(assert(" + request.getParam1() + "," + request.getPredicate() + ","
            + request.getParam2() + ",D)) :- (" + "jpl_get('java.lang.System',out,O)," + "jpl_call(O,println,[\"'monitored "
            + request.getPredicate() + " " + request.getParam1() + " " + request.getParam2() + " " + request.getParam3()
            + " " + request.getParam4() + " " + 1 + "'\"],Result), rdf_retractall(" + request.getParam1() + ","
            + request.getPredicate() + "," + request.getParam2() + ",D)" + "))";
        query = new Query(regist);
    
        status = query.hasSolution() ? 0 : -99;
    
        ContextManager.log.info("Registration" + " " + (query.hasSolution() ? "successed" : "failed"));
      }
    
      public void regist2(TempQuery request){//MonitorServiceRequest request) {
        String cancel = "rdf_retractall(" + request.getParam1() + "," + request.getPredicate() + "," + request.getParam2()
            + ",D)";
    
        Query query = new Query(cancel);
        query.hasSolution();
        String regist = "assert(monitor(assert(" + request.getParam1() + "," + request.getPredicate() + ","
            + request.getParam2() + ",D)) :- (" + "jpl_get('java.lang.System',out,O)," + "jpl_call(O,println,[\"'monitored "
            + request.getPredicate() + " " + request.getParam1() + " " + request.getParam2() + " " + request.getParam3()
            + " " + request.getParam4() + " " + 2 + "'\"],Result), rdf_retractall(" + request.getParam1() + ","
            + request.getPredicate() + "," + request.getParam2() + ",D)" + "))";
        query = new Query(regist);
    
        status = query.hasSolution() ? 2 : -99;
    
        ContextManager.log.info("Registration" + " " + (query.hasSolution() ? "successed" : "failed"));
      }
    
      public void cancel1(TempQuery request){//MonitorServiceRequest request) {
        String cancel = "rdf_retractall(" + request.getParam1() + "," + request.getPredicate() + "," + request.getParam2()
            + ",D)";
        Query query = new Query(cancel);
        query.hasSolution();
        cancel = "retract(monitor(assert(" + request.getParam1() + "," + request.getPredicate() + "," + request.getParam2()
            + ",D)) :- (" + "jpl_get('java.lang.System',out,O)," + "jpl_call(O,println,[\"'monitored "
            + request.getPredicate() + " " + request.getParam1() + " " + request.getParam2() + " " + request.getParam3()
            + " " + request.getParam4() + " " + 1 + "'\"],Result), rdf_retractall(" + request.getParam1() + ","
            + request.getPredicate() + "," + request.getParam2() + ",D)" + "))";
    
        query = new Query(cancel);
    
        status = query.hasSolution() ? -1 : -99;
    
        ContextManager.log.info("Cancellation" + " " + (query.hasSolution() ? "successed" : "failed"));
      }
    
      public void cancel2(TempQuery request){//MonitorServiceRequest request) {
        String cancel = "rdf_retractall(" + request.getParam1() + "," + request.getPredicate() + "," + request.getParam2()
            + ",D)";
        Query query = new Query(cancel);
        query.hasSolution();
    
        cancel = "retract(monitor(assert(" + request.getParam1() + "," + request.getPredicate() + "," + request.getParam2()
            + ",D)) :- (" + "jpl_get('java.lang.System',out,O)," + "jpl_call(O,println,[\"'monitored "
            + request.getPredicate() + " " + request.getParam1() + " " + request.getParam2() + " " + request.getParam3()
            + " " + request.getParam4() + " " + 2 + "'\"],Result), rdf_retractall(" + request.getParam1() + ","
            + request.getPredicate() + "," + request.getParam2() + ",D)" + "))";
    
        query = new Query(cancel);
    
        status = query.hasSolution() ? -2 : -99;
    
        ContextManager.log.info("Cancellation" + " " + (query.hasSolution() ? "successed" : "failed"));
      }
    
      public void query(TempQuery request){//MonitorServiceRequest request) {
        //String predicateQuery = request.getPredicate() + "(" + request.getParam1 + ")";

	//implement//
	//Parser.java may be used//
	ContextManager.log.info("receive Query: " + request.getPredicate());
	Query query = new Query(request.getPredicate());
        status = 100;

	String results = "";
        Map<String, Term> solutions[] = query.allSolutions();
        for(int i = 0 ; i < solutions.length ; ++i){
          Map<String, Term> solution = solutions[i];
          String result = "";
          if(solution.isEmpty()){        
            result = "True";
          } else {
            if(i != 0){
              result += "-/#/-";
            }
            Set<String> keys = solution.keySet();
            Iterator<String> keyIter = keys.iterator();
            while(keyIter.hasNext()){
              String key = keyIter.next();
              Term value = solution.get(key);

            }

                	
          }

          
          results += result;
        }
     
        if (results.equals("")) {
          results = "False";
        }
        QueryServiceResponse response = qProviderForTM.newMessage();
        response.setResult(results);
        qProviderForTM.publish(response);
      }
    
      public void query2(TempQuery request){//MonitorServiceRequest request){
        ContextManager.log.info("receive Query: " + request.getPredicate());
        Query query = new Query(request.getPredicate());
        status = 101;
        
        String results = "";
        Map<String, Term> solutions[] = query.allSolutions();
        for(int i = 0 ; i < solutions.length ; ++i){
          Map<String, Term> solution = solutions[i];
          String result = "";
          if(solution.isEmpty()){
            result = "True";
          } else {
            if(i != 0){
              result += "-/#/-";
            }
            Set<String> keys = solution.keySet();
            Iterator<String> keyIter = keys.iterator();
            while(keyIter.hasNext()){
              String key = keyIter.next();
              Term value = solution.get(key);
              if(Util.isList(value)) {
                result += key + "-/@/-" + listToString(value);
              } else {
                result += key + "-/@/-" + value.toString();
              }
              
              if(keyIter.hasNext()){
                result += "-/-/-";
              }
            }

          }

          
          results += result;
        }
     
        if (results.equals("")) {
          results = "False";
        }
        QueryServiceResponse response = qProviderForTM.newMessage();
        response.setResult(results);
        qProviderForTM.publish(response);
      }

      public void query3(TempQuery request){//MonitorServiceRequest request){
        Query query = new Query(request.getPredicate());
        status = 102;
        String data;

        //System.out.println(request);

        

        Map<String, Term> solutions[] = query.allSolutions();
        for(int i = 0 ; i < solutions.length ; ++i){

          Map<String, Term> solution = solutions[i];
      
            Set<String> keys = solution.keySet();
            Iterator<String> keyIter = keys.iterator();

            for(int j=0;j<keys.size();j++){
              
              String key = keyIter.next();
              Term value = solution.get(key);
              if(Util.isList(value)) {
                data=listToString(value);
                data=data.replace("-/!/-",",");
              } else { 
                data=value.toString();
              }
            }
          }
        }

     
      private String listToString(Term list) {
      String result = "[";

      Term[] terms = Util.listToTermArray(list);
      for (int i = 0; i < terms.length; ++i) {
         Term term = terms[i];
         if (Util.isList(term)) {
            result += listToString(term);
         } else {
            result += term.toString();
         }
         if (i != terms.length - 1) {
            result += "-/!/-";
         }
      }
      return result + "]";
   }


    }
