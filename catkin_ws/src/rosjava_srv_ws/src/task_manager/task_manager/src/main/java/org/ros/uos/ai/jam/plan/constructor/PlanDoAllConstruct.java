//  -*- Mode: Java -*-
//////////////////////////////////////////////////////////////////////////////
//  
//  $Id: PlanDoAllConstruct.java,v 1.1 2006/07/22 07:03:12 semix2 Exp $
//  $Source: /home/CVS/semix2/jam-060722/uos/ai/jam/PlanDoAllConstruct.java,v $
//  
//  File              : PlanDoAllConstruct.java
//  Original author(s): Jaeho Lee <jaeho@uos.ac.kr>
//                    : Marcus J. Huber <marcush@irs.home.com>
//  Created On        : Tue Sep 30 14:21:34 1997
//  Last Modified By  : Jaeho Lee <jaeho@david>
//  Last Modified On  : Mon Sep  6 17:54:00 2004
//  Update Count      : 17
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

package org.ros.uos.ai.jam.plan.constructor;

import java.io.Serializable;
import java.util.Vector;


/**
 * Represents alternative-path plan components
 * 
 * @author Jaeho Lee
 * @author Marc Huber
 * @version 1.1
 * 
 */

public class PlanDoAllConstruct extends PlanConstruct implements Serializable {
	private static final long serialVersionUID = 1469648878786949194L;
	
	//
	// Members
	//
	protected Vector<PlanConstruct> _branches; // Vector of PlanSequenceConstructs

	//
	// Constructors
	//

	public PlanDoAllConstruct() {
		_branches = new Vector<PlanConstruct>(1, 1);
		_constructType = PLAN_DOALL;
	}

	public PlanDoAllConstruct(PlanSequenceConstruct s) {
		_branches = new Vector<PlanConstruct>(1, 1);
		addBranch(s);

		_constructType = PLAN_DOALL;
	}

	//
	// Member functions
	//

	public Vector<PlanConstruct> getBranches() {
		return _branches;
	}
	
	public int getNumBranches() {
		return _branches.size();
	}

	/**
	 * 
	 * 
	 */
	public PlanRuntimeState newRuntimeState() {
		return new PlanRuntimeDoAllState(this);
	}

	/**
	 * 
	 * 
	 */
	public PlanSequenceConstruct getBranch(int branchnum) {
		return (branchnum >= 0 && branchnum < _branches.size()) ? (PlanSequenceConstruct) _branches
				.elementAt(branchnum)
				: null;
	}

	public void addBranch(PlanConstruct be) {
		if (be != null) {
			if (be.getType() == PLAN_SEQUENCE) {
				_branches.addElement(be);
			} else {
				PlanSequenceConstruct ns;
				ns = new PlanSequenceConstruct(be);
				_branches.addElement(ns);
			}
		}
	}

}
