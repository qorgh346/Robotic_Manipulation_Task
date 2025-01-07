package org.ros.uos.ai.jam.exception;

import org.ros.uos.ai.jam.expression.Variable;
import org.ros.uos.ai.jam.plan.constructor.PlanConstruct;

public class GlobalCatch {
	public static final GlobalCatch[]	NULL_ARRAY	= new GlobalCatch[0];
	
	private final String			exception;
	private final Variable			bind;
	private final PlanConstruct		body;
	
	public GlobalCatch(String exception, Variable bind, PlanConstruct body) {
		this.exception	= exception;
		this.bind		= bind;
		this.body		= body;
	}
	
	public String			getExceptionName()		{return this.exception;}
	public Variable			getBindVariable()		{return this.bind;}
	public PlanConstruct	getBodyConstruct()		{return this.body;}
}
