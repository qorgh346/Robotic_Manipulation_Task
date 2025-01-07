package org.ros.uos.ai.jam.exception;

import org.ros.uos.ai.jam.Interpreter;
import org.ros.uos.ai.jam.expression.Binding;
import org.ros.uos.ai.jam.plan.constructor.PlanConstruct;
import org.ros.uos.ai.jam.plan.constructor.PlanRuntimeState;

/**
 * Global catch�� ���� exception�� ó���ϴ� ��ü
 * 
 * @author	Hyunju Shin <jetzt82@gmail.com>
 * @since	2.0
 * @update	2.0
 */
class GlobalExceptionHandler {
	private final Interpreter			interpreter;
	private final Binding				binding;
	private final PlanRuntimeState		body;
	
	GlobalExceptionHandler(Interpreter interpreter, Binding binding, PlanConstruct construct) {
		this.interpreter	= interpreter;
		this.binding		= binding;
		this.body			= construct.newRuntimeState();
	}
	
	public void execute() {
		int returnVal = PlanRuntimeState.PLAN_CONSTRUCT_COMPLETE;
		while (true) {
			try {
				returnVal = this.body.execute(this.binding, null, null);
			} catch (AgentRuntimeException e) {
				this.interpreter.getExceptionManager().throwException(e);
			}

			switch (returnVal) {
			case PlanRuntimeState.PLAN_CONSTRUCT_FAILED:	return;
			case PlanRuntimeState.PLAN_CONSTRUCT_COMPLETE:	return;
			case PlanRuntimeState.PLAN_CONSTRUCT_INCOMP:	break;
			}
		}
	}
}
