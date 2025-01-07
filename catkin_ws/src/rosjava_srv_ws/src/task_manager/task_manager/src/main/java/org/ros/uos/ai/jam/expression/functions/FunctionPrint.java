package org.ros.uos.ai.jam.expression.functions;

import org.ros.uos.ai.jam.Goal;
import org.ros.uos.ai.jam.Interpreter;
import org.ros.uos.ai.jam.exception.AgentRuntimeException;
import org.ros.uos.ai.jam.expression.Binding;
import org.ros.uos.ai.jam.expression.Expression;
import org.ros.uos.ai.jam.expression.Function;
import org.ros.uos.ai.jam.expression.Value;

public class FunctionPrint implements Function {
	
	public String getName() {
		return "print";
	}

	public Value execute(Interpreter interpreter, Goal currentGoal, Binding binding, Expression... args) throws AgentRuntimeException {
		//
		// Output information to standard output
		//
		int arity = (args != null) ? args.length : 0;
		if (arity == 0) {
			System.out.println("Invalid number of arguments: " + arity + " to function \"" + getName() + "\"\n");
			return Value.FALSE;
		}

		for (Expression arg : args) {
			arg.print(System.out, binding);
		}
		
		return Value.TRUE;
	}
}
