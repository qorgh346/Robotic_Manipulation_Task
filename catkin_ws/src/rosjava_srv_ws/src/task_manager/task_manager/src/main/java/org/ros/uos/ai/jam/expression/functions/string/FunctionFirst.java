package org.ros.uos.ai.jam.expression.functions.string;

import java.util.StringTokenizer;

import org.ros.uos.ai.jam.Goal;
import org.ros.uos.ai.jam.Interpreter;
import org.ros.uos.ai.jam.exception.AgentRuntimeException;
import org.ros.uos.ai.jam.expression.Binding;
import org.ros.uos.ai.jam.expression.Expression;
import org.ros.uos.ai.jam.expression.Function;
import org.ros.uos.ai.jam.expression.Value;

public class FunctionFirst implements Function {
	
	public String getName() {
		return "first";
	}

	public Value execute(Interpreter interpreter, Goal currentGoal, Binding binding, Expression... args) throws AgentRuntimeException {
		//
		// First token in string
		// [Modified from Chip McVey at Johns Hopkins University's Applied Physics Lab]
		//
		int arity = (args != null) ? args.length : 0;
		if ((arity == 0) || (arity > 2)) {
			System.out.println("Invalid number of arguments: " + arity + " to function \"" + getName() + "\"\n");
			return Value.FALSE;
		}

		String bigString = args[0].eval(binding).getString();
		StringTokenizer st = new StringTokenizer(bigString);

		Value result = null;
		if (st.hasMoreTokens()) {
			result = new Value(st.nextToken());
		} else {
			return Value.FALSE;
		}

		if (arity == 1) {
			return result;
		} else { // (arity == 2)
			binding.setValue(args[1], result);
		}
		
		return Value.TRUE;
	}
}
