package org.ros.uos.ai.jam.expression.functions.debug;

import org.ros.uos.ai.jam.Goal;
import org.ros.uos.ai.jam.Interpreter;
import org.ros.uos.ai.jam.JAM;
import org.ros.uos.ai.jam.exception.AgentRuntimeException;
import org.ros.uos.ai.jam.expression.Binding;
import org.ros.uos.ai.jam.expression.Expression;
import org.ros.uos.ai.jam.expression.Function;
import org.ros.uos.ai.jam.expression.Value;

public class FunctionSetShowAPL implements Function {
	
	public String getName() {
		return "setShowAPL";
	}

	public Value execute(Interpreter interpreter, Goal currentGoal, Binding binding, Expression... args) throws AgentRuntimeException {
		//
		// Turn debug information on/off
		//
		int arity = (args != null) ? args.length : 0;
		if (arity != 1) {
			System.out.println("Invalid number of arguments: " + arity + " to function \"" + getName() + "\"\n");
			return Value.FALSE;
		}

		Expression exp = args[0];
		JAM.setShowAPL(exp.eval(binding).isTrue());
		System.out.println("Showing APL reasoning: " + JAM.getShowAPL());

		return Value.TRUE;
	}
}
