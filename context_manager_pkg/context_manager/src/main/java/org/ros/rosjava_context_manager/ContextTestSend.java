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
    public class ContextTestSend extends AbstractNodeMain {
        static Publisher <QueryServiceRequest> questioner;

        static ConnectedNode connectedNode;
        static Log log;
        Scanner scanner = null;
        String tmp = null;

        @Override
    	public GraphName getDefaultNodeName() {
		    return GraphName.of("context_test_send");
	    }

        @Override
    	public void onStart(ConnectedNode connectedNode) {
            log = connectedNode.getLog();

            questioner = connectedNode.newPublisher("context_manager/query/reception", QueryServiceRequest._TYPE);

            try {
                scanner = new Scanner(System.in);

			    while (true) {
                    System.out.print("Input query : ");
                    tmp = scanner.nextLine();

			    	QueryServiceRequest qRequest = questioner.newMessage();
			    	qRequest.setQuery(tmp);
			    	qRequest.setManager("TaskManager");

                    System.out.println("Query : " + qRequest.getQuery() + ", Manager : " + qRequest.getManager());

			    	questioner.publish(qRequest);
		    	}
	    	} catch (Exception e) {
		    	e.printStackTrace();
		    }
        }
    }
