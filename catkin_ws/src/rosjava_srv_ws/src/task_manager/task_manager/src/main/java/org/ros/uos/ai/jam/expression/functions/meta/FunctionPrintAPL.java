package org.ros.uos.ai.jam.expression.functions.meta;

import org.ros.uos.ai.jam.Goal;
import org.ros.uos.ai.jam.Interpreter;
import org.ros.uos.ai.jam.exception.AgentRuntimeException;
import org.ros.uos.ai.jam.expression.Binding;
import org.ros.uos.ai.jam.expression.Expression;
import org.ros.uos.ai.jam.expression.Function;
import org.ros.uos.ai.jam.expression.Value;
import org.ros.uos.ai.jam.plan.APL;

public class FunctionPrintAPL implements Function {
	
	public String getName() {
		return "printAPL";
	}

	public Value execute(Interpreter interpreter, Goal currentGoal, Binding binding, Expression... args) throws AgentRuntimeException {
		//
		// Print the passed-in APL
		//
		int arity = (args != null) ? args.length : 0;
		if (arity != 1) {
			System.out.println("Invalid number of arguments: " + arity + " to function \"" + getName() + "\"\n");
			return Value.FALSE;
		}

		Expression exp = args[0];
		APL a = (APL) exp.eval(binding).getObject();
		a.print(System.out);

		return Value.TRUE;
	}
}
