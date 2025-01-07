package org.ros.uos.ai.jam.expression.functions.debug;

import org.ros.uos.ai.jam.Goal;
import org.ros.uos.ai.jam.Interpreter;
import org.ros.uos.ai.jam.exception.AgentRuntimeException;
import org.ros.uos.ai.jam.expression.Binding;
import org.ros.uos.ai.jam.expression.Expression;
import org.ros.uos.ai.jam.expression.Function;
import org.ros.uos.ai.jam.expression.Value;

public class FunctionPrintWorldModel implements Function {
	
	public String getName() {
		return "printWorldModel";
	}

	public Value execute(Interpreter interpreter, Goal currentGoal, Binding binding, Expression... args) throws AgentRuntimeException {
		//
		// Display current world model state
		//
		interpreter.getWorldModel().print(System.out);
		return Value.TRUE;
	}
}
