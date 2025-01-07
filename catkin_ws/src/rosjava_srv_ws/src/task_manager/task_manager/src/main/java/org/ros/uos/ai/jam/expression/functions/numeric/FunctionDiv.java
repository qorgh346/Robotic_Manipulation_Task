package org.ros.uos.ai.jam.expression.functions.numeric;

import org.ros.uos.ai.jam.Goal;
import org.ros.uos.ai.jam.Interpreter;
import org.ros.uos.ai.jam.exception.AgentRuntimeException;
import org.ros.uos.ai.jam.expression.Binding;
import org.ros.uos.ai.jam.expression.Expression;
import org.ros.uos.ai.jam.expression.Function;
import org.ros.uos.ai.jam.expression.Value;

public class FunctionDiv implements Function {

	public String getName() {
		return "/";
	}

	public Value execute(Interpreter interpreter, Goal currentGoal, Binding binding, Expression... args) throws AgentRuntimeException {
		//
		// Division
		//
		int arity = (args != null) ? args.length : 0;
		if (arity == 0) {
			System.out.println("Invalid number of arguments: " + arity + " to function \"" + getName() + "\"\n");
			return Value.FALSE;
		}

		Value result = args[0].eval(binding);
		for (int i=1; i<arity; i++) {
			result = result.div(args[i].eval(binding));
		}
		
		return result;
	}
}
