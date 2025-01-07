//  -*- Mode: Java -*-
//////////////////////////////////////////////////////////////////////////////
//  
//  $Id: Exit.java,v 1.1 2006/07/22 07:03:12 semix2 Exp $
//  $Source: /home/CVS/semix2/jam-060722/uos/ai/jam/primitives/Exit.java,v $
//  
//  File              : Exit.java
//  Author(s)         : marcush <marcush@irs.home.com>
//  
//  Description       : 
//  
//  Original author(s): marcush <marcush@irs.home.com>
//  Organization      : Intelligent Reasoning Systems
//  Created On        : Fri Oct  2 13:59:41 1998
//  Last Modified By  : Jaeho Lee <jaeho@david>
//  Last Modified On  : Mon Sep  6 17:52:31 2004
//  Update Count      : 4
//  
//  Copyright (C) 1998 Intelligent Reasoning Systems.
//  
//////////////////////////////////////////////////////////////////////////////

package org.ros.uos.ai.jam.plan.action.primitives;

import java.util.List;

import org.ros.uos.ai.jam.Goal;
import org.ros.uos.ai.jam.exception.AgentRuntimeException;
import org.ros.uos.ai.jam.expression.Binding;
import org.ros.uos.ai.jam.expression.Expression;
import org.ros.uos.ai.jam.expression.Value;
import org.ros.uos.ai.jam.plan.action.PrimitiveAction;

public class Exit implements PrimitiveAction {

	//
	// Cause the agent to exit immediately.
	//
	public Value execute(String name, int arity, List<Expression> args, Binding binding, Goal currentGoal) throws AgentRuntimeException {
		System.exit(0);
		return Value.TRUE;
	}
}
