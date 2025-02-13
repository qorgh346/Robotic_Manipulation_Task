//  -*- Mode: Java -*-
//////////////////////////////////////////////////////////////////////////////
//  
//  $Id: WorldModelAction.java,v 1.1 2006/07/22 07:03:12 semix2 Exp $
//  $Source: /home/CVS/semix2/jam-060722/uos/ai/jam/WorldModelAction.java,v $
//  
//  File              : WorldModelAction.java
//  Original author(s): Jaeho Lee <jaeho@uos.ac.kr>
//                    : Marcus J. Huber <marcush@irs.home.com>
//  Created On        : Tue Sep 30 14:18:54 1997
//  Last Modified By  : Jaeho Lee <jaeho@david>
//  Last Modified On  : Mon Sep  6 17:53:58 2004
//  Update Count      : 29
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

import org.ros.uos.ai.jam.Goal;
import org.ros.uos.ai.jam.Interpreter;
import org.ros.uos.ai.jam.exception.AgentRuntimeException;
import org.ros.uos.ai.jam.expression.Binding;
import org.ros.uos.ai.jam.expression.Relation;

/**
 * 
 * A JAM primitive action modifying the JAM world model
 * 
 * @author Jaeho Lee
 * @author Marc Huber
 * @version 1.1
 * 
 */

public abstract class WorldModelAction extends Action implements Serializable {
	private static final long serialVersionUID = -1074425682029785038L;

	//
	// Members
	//
	protected Relation 				_relation;
	protected Interpreter 			_interpreter;

	//
	// Constructors
	//

	/**
	 * Constructor w/ World Model relation and interpreter (to simplify access
	 * to the agent's World Model) as arguments.
	 * 
	 */
	public WorldModelAction(Relation relation, Interpreter interpreter) {
		super(relation.getName());

		_relation = relation;
		_interpreter = interpreter;
	}

	//
	// Member functions
	//

	public Relation getRelation() {
		return _relation;
	}

	public Interpreter getInterpreter() {
		return _interpreter;
	}

	/**
	 * Perform the necessary world model function.
	 * 
	 */
	public int execute(Binding b, Goal currentGoal) throws AgentRuntimeException {
		return ACT_CANNOT_EXECUTE;
	}

}
