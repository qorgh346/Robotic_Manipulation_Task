//  -*- Mode: Java -*-
//////////////////////////////////////////////////////////////////////////////
//  
//  $Id: MaintainGoalAction.java,v 1.1 2006/07/22 07:03:12 semix2 Exp $
//  $Source: /home/CVS/semix2/jam-060722/uos/ai/jam/MaintainGoalAction.java,v $
//  
//  File              : MaintainGoalAction.java
//  Original author(s): Jaeho Lee <jaeho@uos.ac.kr>
//                    : Marcus J. Huber <marcush@irs.home.com>
//  Created On        : Tue Sep 30 14:21:47 1997
//  Last Modified By  : Jaeho Lee <jaeho@david>
//  Last Modified On  : Mon Sep  6 17:54:01 2004
//  Update Count      : 22
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

package org.ros.uos.ai.jam.plan.action;

import java.io.*;

import org.ros.uos.ai.jam.Interpreter;
import org.ros.uos.ai.jam.exception.AgentRuntimeException;
import org.ros.uos.ai.jam.expression.Binding;
import org.ros.uos.ai.jam.expression.Expression;
import org.ros.uos.ai.jam.expression.Relation;

/**
 * 
 * A built-in JAM primitive action for perpetually keeping a state expression
 * true.
 * 
 * @author Jaeho Lee
 * @author Marc Huber
 * @version 1.1
 * 
 */

public class MaintainGoalAction extends GoalAction implements Serializable {
	private static final long serialVersionUID = -917905587093317171L;

	//
	// Members
	//

	//
	// Constructors
	//

	/**
	 * Primary constructor
	 * 
	 */
	public MaintainGoalAction(String name, Relation goal, Expression utility,
			Interpreter interpreter) {
		super(name, goal, utility, interpreter);
		_actType = ACT_MAINTAIN;
	}

	//
	// Member functions
	//
	
	public MaintainGoalAction eval(Binding b) throws AgentRuntimeException {
		return new MaintainGoalAction(_name, new Relation(_goal, b), _utility != null ? _utility.eval(b) : null, _interpreter);
	}
	
	public boolean isExecutableAction() {
		return false;
	}

	/**
	 * Display information about the goal
	 * 
	 */
	public void format(PrintStream s, Binding b) {
		formatArgs(s, b, "MAINTAIN ", ";");
	}

}
