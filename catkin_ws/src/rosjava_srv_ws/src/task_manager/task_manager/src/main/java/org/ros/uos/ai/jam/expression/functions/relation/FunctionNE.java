package org.ros.uos.ai.jam.expression.functions.relation;

import org.ros.uos.ai.jam.Goal;
import org.ros.uos.ai.jam.Interpreter;
import org.ros.uos.ai.jam.exception.AgentRuntimeException;
import org.ros.uos.ai.jam.expression.Binding;
import org.ros.uos.ai.jam.expression.Expression;
import org.ros.uos.ai.jam.expression.Function;
import org.ros.uos.ai.jam.expression.Value;

public class FunctionNE implements Function {
	
	public String getName() {
		return "!=";
	}

	public Value execute(Interpreter interpreter, Goal currentGoal, Binding binding, Expression... args) throws AgentRuntimeException {
		//
		// Inequality
		//
		int arity = (args != null) ? args.length : 0;
		if (arity != 2) {
			System.out.println("Invalid number of arguments: " + arity + " to function \"" + getName() + "\"\n");
			return Value.FALSE;
		}

		Expression exp1 = args[0];
		Expression exp2 = args[1];

		return (!exp1.equals(exp2, binding)) ? Value.TRUE : Value.FALSE;
	}
}
