package org.ros.uos.ai.jam.plan.action;

import java.io.PrintStream;

import org.ros.uos.ai.jam.Goal;
import org.ros.uos.ai.jam.exception.AgentRuntimeException;
import org.ros.uos.ai.jam.expression.Binding;
import org.ros.uos.ai.jam.expression.Expression;

public class ObjectInvokeAction extends Action {
	private static final long serialVersionUID = 1L;
	
	private final Expression			_expression;
	
	public ObjectInvokeAction(Expression expression) {
		_expression = expression;
	}
	
	public boolean isExecutableAction() {
		return true;
	}

	public int execute(Binding b, Goal currentGoal) throws AgentRuntimeException {
		_expression.eval(b);
		return ACT_SUCCEEDED;
	}
	
	public void format(PrintStream s, Binding b) {
		s.print("OBJECT_INVOKE: ");
		_expression.format(s, b);
	}
}
