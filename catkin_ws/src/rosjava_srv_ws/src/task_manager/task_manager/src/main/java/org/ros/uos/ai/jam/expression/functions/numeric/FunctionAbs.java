package org.ros.uos.ai.jam.expression.functions.numeric;

import org.ros.uos.ai.jam.Goal;
import org.ros.uos.ai.jam.Interpreter;
import org.ros.uos.ai.jam.exception.AgentRuntimeException;
import org.ros.uos.ai.jam.expression.Binding;
import org.ros.uos.ai.jam.expression.Expression;
import org.ros.uos.ai.jam.expression.Function;
import org.ros.uos.ai.jam.expression.Value;
import org.ros.uos.ai.jam.expression.ValueType;

public class FunctionAbs implements Function {
	
	public String getName() {
		return "abs";
	}

	public Value execute(Interpreter interpreter, Goal currentGoal, Binding binding, Expression... args) throws AgentRuntimeException {
		//
		// Absolute value (of first argument only)
		//
		int arity = (args != null) ? args.length : 0;
		if (arity == 0) {
			System.out.println("Invalid number of arguments: " + arity + " to function \"" + getName() + "\"\n");
			return Value.FALSE;
		}

		Value result = args[0].eval(binding);

		if ((result.type() == ValueType.LONG) || (result.type() == ValueType.REAL)) {
			return (result.getLong() > 0) ? result : result.mul(new Value(-1));
		} else {
			return result;
		}
	}
}
