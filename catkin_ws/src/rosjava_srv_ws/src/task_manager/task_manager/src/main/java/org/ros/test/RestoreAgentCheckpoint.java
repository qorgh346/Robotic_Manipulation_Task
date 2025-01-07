//  -*- Mode: Java -*-
//////////////////////////////////////////////////////////////////////////////
//  
//  $Id: RestoreAgentCheckpoint.java,v 1.1 2006/07/22 07:03:12 semix2 Exp $
//  $Source: /home/CVS/semix2/jam-060722/uos/ai/jam/RestoreAgentCheckpoint.java,v $
//  
//  File              : RestoreAgentCheckpoint.java
//  Author(s)         : marcush <marcush@irs.home.com>
//  
//  Description       : Read a checkpoint file and restart the JAM
//                      agent from where it was saved.
//  
//  Original author(s): marcush <marcush@irs.home.com>
//  Organization      : Intelligent Reasoning Systems
//  Created On        : Tue Nov  3 09:42:04 1998
//  Last Modified By  : Jaeho Lee <jaeho@david>
//  Last Modified On  : Mon Sep  6 17:52:32 2004
//  Update Count      : 12
//  
//  Copyright (C) 1998 Intelligent Reasoning Systems.
//  
//////////////////////////////////////////////////////////////////////////////

package org.ros.test;

import java.io.*;
//import java.util.*;

import org.ros.uos.ai.jam.IntentionStructure;
import org.ros.uos.ai.jam.Interpreter;
import org.ros.uos.ai.jam.JAM;
import org.ros.uos.ai.jam.WorldModelTable;
import org.ros.uos.ai.jam.expression.Functions;
import org.ros.uos.ai.jam.plan.Plan;
import org.ros.uos.ai.jam.plan.PlanTable;

//import org.ros.uos.ai.jam.*;

public class RestoreAgentCheckpoint {
	@SuppressWarnings("unused")
	public static void main(String argv[]) {
		FileInputStream fis;
		ObjectInputStream in;

		JAM agent = new JAM();
		Interpreter interp = new Interpreter();
		
		WorldModelTable wm;
		PlanTable plib;
		Plan obs;
		IntentionStructure is;
		Functions sys;
		Functions user;
		Object o;

		try {
			fis = new FileInputStream(argv[0]);
			in = new ObjectInputStream(fis);

			interp = (Interpreter) in.readObject();
			JAM.run(interp);
		} catch (Exception e) {
			System.out.println("Error *" + e
					+ "* reading Jam! agent checkpoing file!");
			e.printStackTrace();
		}
	}
}
