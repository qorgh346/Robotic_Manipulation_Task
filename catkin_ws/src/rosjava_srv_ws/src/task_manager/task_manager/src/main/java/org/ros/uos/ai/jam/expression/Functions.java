//  -*- Mode: Java -*-
//////////////////////////////////////////////////////////////////////////////
//  
//  $Id: Functions.java,v 1.1 2006/07/22 07:03:12 semix2 Exp $
//  $Source: /home/CVS/semix2/jam-060722/uos/ai/jam/Functions.java,v $
//  
//  File              : Functions.java
//  Original author(s): Jaeho Lee <jaeho@uos.ac.kr>
//                    : Marcus J. Huber <marcush@irs.home.com>
//  Created On        : Tue Sep 30 14:21:59 1997
//  Last Modified By  : Jaeho Lee <jaeho@david>
//  Last Modified On  : Mon Sep  6 17:54:01 2004
//  Update Count      : 21
//  
//  Copyright (C) 1997-2004 Jaeho Lee and Marcus J. Huber.
//  
//////////////////////////////////////////////////////////////////////////////
//
//  JAM agent architecture
//
//  Copyright (C) 1997-2004 Jaeho Lee and Marcus J. Huber.
//  
//  Permission is granted to copy and redistribute this software so long
//  as no fee is charged, and so long as the copyright notice above, this
//  grant of permission, and the disclaimer below appear in all copies
//  made.
//  
//  This software is provided as is, without representation as to its
//  fitness for any purpose, and without warranty of any kind, either
//  express or implied, including without limitation the implied
//  warranties of merchantability and fitness for a particular purpose.
//  Jaeho Lee and Marcus J. Huber shall not be liable for any damages,
//  including special, indirect, incidental, or consequential damages,
//  with respect to any claim arising out of or in connection with the
//  use of the software, even if they have been or are hereafter advised
//  of the possibility of such damages.
// 
//////////////////////////////////////////////////////////////////////////////

package org.ros.uos.ai.jam.expression;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import org.ros.uos.ai.jam.Goal;
import org.ros.uos.ai.jam.Interpreter;
import org.ros.uos.ai.jam.exception.AgentRuntimeException;
import org.ros.uos.ai.jam.expression.functions.FunctionExec;
import org.ros.uos.ai.jam.expression.functions.FunctionExit;
import org.ros.uos.ai.jam.expression.functions.FunctionFail;
import org.ros.uos.ai.jam.expression.functions.FunctionIsNotNull;
import org.ros.uos.ai.jam.expression.functions.FunctionIsNull;
import org.ros.uos.ai.jam.expression.functions.FunctionLoadPlan;
import org.ros.uos.ai.jam.expression.functions.FunctionNoop;
import org.ros.uos.ai.jam.expression.functions.FunctionParseString;
import org.ros.uos.ai.jam.expression.functions.FunctionPrint;
import org.ros.uos.ai.jam.expression.functions.communication.FunctionCheckpointAgent;
import org.ros.uos.ai.jam.expression.functions.communication.FunctionCheckpointAgentToFile;
import org.ros.uos.ai.jam.expression.functions.communication.FunctionConnectToAgentAsClient;
import org.ros.uos.ai.jam.expression.functions.communication.FunctionConnectToAgentAsServer;
import org.ros.uos.ai.jam.expression.functions.communication.FunctionDequeueMessage;
import org.ros.uos.ai.jam.expression.functions.communication.FunctionRecvMessage;
import org.ros.uos.ai.jam.expression.functions.communication.FunctionSendMessage;
import org.ros.uos.ai.jam.expression.functions.debug.FunctionPrintIntentionStructure;
import org.ros.uos.ai.jam.expression.functions.debug.FunctionPrintWorldModel;
import org.ros.uos.ai.jam.expression.functions.debug.FunctionSetShowAPL;
import org.ros.uos.ai.jam.expression.functions.debug.FunctionSetShowGoalList;
import org.ros.uos.ai.jam.expression.functions.debug.FunctionSetShowIntentionStructure;
import org.ros.uos.ai.jam.expression.functions.debug.FunctionSetShowWorldModel;
import org.ros.uos.ai.jam.expression.functions.exception.FunctionGetExceptionCause;
import org.ros.uos.ai.jam.expression.functions.exception.FunctionGetExceptionMessage;
import org.ros.uos.ai.jam.expression.functions.exception.FunctionGetExceptionName;
import org.ros.uos.ai.jam.expression.functions.exception.FunctionGetExceptionOccuredTime;
import org.ros.uos.ai.jam.expression.functions.exception.FunctionGetExceptionPackageName;
import org.ros.uos.ai.jam.expression.functions.exception.FunctionGetExceptionSimpleName;
import org.ros.uos.ai.jam.expression.functions.meta.FunctionGetAPLElement;
import org.ros.uos.ai.jam.expression.functions.meta.FunctionGetAttributeValue;
import org.ros.uos.ai.jam.expression.functions.meta.FunctionGetCurrentGoal;
import org.ros.uos.ai.jam.expression.functions.meta.FunctionGetCurrentPlan;
import org.ros.uos.ai.jam.expression.functions.meta.FunctionGetPlanAttributes;
import org.ros.uos.ai.jam.expression.functions.meta.FunctionIntendAPLElement;
import org.ros.uos.ai.jam.expression.functions.meta.FunctionPrintAPL;
import org.ros.uos.ai.jam.expression.functions.meta.FunctionPrintAPLElement;
import org.ros.uos.ai.jam.expression.functions.meta.FunctionPrintGoal;
import org.ros.uos.ai.jam.expression.functions.meta.FunctionPrintPlan;
import org.ros.uos.ai.jam.expression.functions.meta.FunctionSelectRandomAPLElement;
import org.ros.uos.ai.jam.expression.functions.numeric.FunctionAbs;
import org.ros.uos.ai.jam.expression.functions.numeric.FunctionAdd;
import org.ros.uos.ai.jam.expression.functions.numeric.FunctionDiv;
import org.ros.uos.ai.jam.expression.functions.numeric.FunctionMod;
import org.ros.uos.ai.jam.expression.functions.numeric.FunctionMul;
import org.ros.uos.ai.jam.expression.functions.numeric.FunctionSub;
import org.ros.uos.ai.jam.expression.functions.relation.FunctionAnd;
import org.ros.uos.ai.jam.expression.functions.relation.FunctionEQ;
import org.ros.uos.ai.jam.expression.functions.relation.FunctionGE;
import org.ros.uos.ai.jam.expression.functions.relation.FunctionGT;
import org.ros.uos.ai.jam.expression.functions.relation.FunctionLE;
import org.ros.uos.ai.jam.expression.functions.relation.FunctionLT;
import org.ros.uos.ai.jam.expression.functions.relation.FunctionNE;
import org.ros.uos.ai.jam.expression.functions.relation.FunctionNot;
import org.ros.uos.ai.jam.expression.functions.relation.FunctionOr;
import org.ros.uos.ai.jam.expression.functions.string.FunctionFirst;
import org.ros.uos.ai.jam.expression.functions.string.FunctionLast;
import org.ros.uos.ai.jam.expression.functions.string.FunctionRest;
import org.ros.uos.ai.jam.expression.functions.string.FunctionStrLen;
import org.ros.uos.ai.jam.expression.functions.test.FunctionCreateNewTestClassObject;
import org.ros.uos.ai.jam.expression.functions.utility.FunctionGetTime;
import org.ros.uos.ai.jam.expression.functions.utility.FunctionSleep;


public class Functions implements Serializable {
	private static final long serialVersionUID = -2439637025727964873L;

	private static final Map<String, Function>			_systemFunctions;
	private static final Map<String, Function>			_userFunctions;

	static {
		_systemFunctions 	= new HashMap<String, Function>();
		_userFunctions		= new HashMap<String, Function>();
		initSystemFunctions();
	}
	
	private Functions() {
		//
	}

	public static void addFunction(Function function) {
		_userFunctions.put(function.getName(), function);
	}
	
	public static void removeFunction(String functionName) {
		_userFunctions.remove(functionName);
	}
	
	public static Value execute(String name, Interpreter interpreter, Goal currentGoal,
			Binding binding, Expression... args) throws AgentRuntimeException {
		Function function = _systemFunctions.get(name);
		if (function == null) {
			function = _userFunctions.get(name);
		}
		return (function != null) ? function.execute(interpreter, currentGoal, binding, args) : Value.UNDEFINED;
	}
	
	private static void addSystemFunction(Function function) {
		_systemFunctions.put(function.getName(), function);
	}
	
	private static void initSystemFunctions() {
		addSystemFunction(new FunctionExec());
		addSystemFunction(new FunctionExit());
		addSystemFunction(new FunctionFail());
		addSystemFunction(new FunctionNoop());
		addSystemFunction(new FunctionParseString());
		addSystemFunction(new FunctionPrint());
		addSystemFunction(new FunctionLoadPlan());
		
		// communication
		
		addSystemFunction(new FunctionCheckpointAgent());
		addSystemFunction(new FunctionCheckpointAgentToFile());
		addSystemFunction(new FunctionConnectToAgentAsClient());
		addSystemFunction(new FunctionConnectToAgentAsServer());
		addSystemFunction(new FunctionRecvMessage());
		addSystemFunction(new FunctionSendMessage());
		addSystemFunction(new FunctionDequeueMessage());

		// debug
		
		addSystemFunction(new FunctionPrintIntentionStructure());
		addSystemFunction(new FunctionPrintWorldModel());
		addSystemFunction(new FunctionSetShowAPL());
		addSystemFunction(new FunctionSetShowGoalList());
		addSystemFunction(new FunctionSetShowIntentionStructure());
		addSystemFunction(new FunctionSetShowWorldModel());
		
		// meta
		
		addSystemFunction(new FunctionGetAPLElement());
		addSystemFunction(new FunctionGetAttributeValue());
		addSystemFunction(new FunctionGetCurrentGoal());
		addSystemFunction(new FunctionGetCurrentPlan());
		addSystemFunction(new FunctionGetPlanAttributes());
		addSystemFunction(new FunctionIntendAPLElement());
		addSystemFunction(new FunctionPrintAPL());
		addSystemFunction(new FunctionPrintAPLElement());
		addSystemFunction(new FunctionPrintGoal());
		addSystemFunction(new FunctionPrintPlan());
		addSystemFunction(new FunctionSelectRandomAPLElement());
		
		// numeric
		
		addSystemFunction(new FunctionAbs());
		addSystemFunction(new FunctionAdd());
		addSystemFunction(new FunctionDiv());
		addSystemFunction(new FunctionMod());
		addSystemFunction(new FunctionMul());
		addSystemFunction(new FunctionSub());
		
		// relation
		
		addSystemFunction(new FunctionAnd());
		addSystemFunction(new FunctionEQ());
		addSystemFunction(new FunctionGE());
		addSystemFunction(new FunctionGT());
		addSystemFunction(new FunctionLE());
		addSystemFunction(new FunctionLT());
		addSystemFunction(new FunctionNE());
		addSystemFunction(new FunctionNot());
		addSystemFunction(new FunctionOr());
		
		// string
		
		addSystemFunction(new FunctionFirst());
		addSystemFunction(new FunctionLast());
		addSystemFunction(new FunctionRest());
		addSystemFunction(new FunctionStrLen());
		
		// utility
		
		addSystemFunction(new FunctionGetTime());
		addSystemFunction(new FunctionSleep());
		addSystemFunction(new FunctionIsNull());
		addSystemFunction(new FunctionIsNotNull());
		
		// test
		
		addSystemFunction(new FunctionCreateNewTestClassObject());
		
		// exception
		
		addSystemFunction(new FunctionGetExceptionMessage());
		addSystemFunction(new FunctionGetExceptionName());
		addSystemFunction(new FunctionGetExceptionOccuredTime());
		addSystemFunction(new FunctionGetExceptionPackageName());
		addSystemFunction(new FunctionGetExceptionSimpleName());
		addSystemFunction(new FunctionGetExceptionCause());
		
	}
}
