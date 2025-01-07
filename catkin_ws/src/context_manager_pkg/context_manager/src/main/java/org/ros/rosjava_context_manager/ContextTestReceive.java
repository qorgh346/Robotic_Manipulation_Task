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
    public class ContextTestReceive extends AbstractNodeMain {
        static Subscriber <QueryServiceResponse> answerer;

        static ConnectedNode connectedNode;
        static Log log;

        @Override
    	public GraphName getDefaultNodeName() {
		    return GraphName.of("context_test_receive");
	    }

        @Override
    	public void onStart(ConnectedNode connectedNode) {
            log = connectedNode.getLog();

            answerer = connectedNode.newSubscriber("context_manager/query/provision_for_tm", QueryServiceResponse._TYPE);

            answerer.addMessageListener(new MessageListener<QueryServiceResponse>() {
		    	@Override
		    	public void onNewMessage(QueryServiceResponse response) {
                    System.out.println("receive");
			    	String ans = response.getResult();
				    System.out.println(ans);
		    	}
		    });
        }
    }
