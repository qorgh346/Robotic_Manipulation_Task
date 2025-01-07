package org.ros.uos.ai.jam.expression.functions.meta;

import org.ros.uos.ai.jam.Goal;
import org.ros.uos.ai.jam.Interpreter;
import org.ros.uos.ai.jam.exception.AgentRuntimeException;
import org.ros.uos.ai.jam.expression.Binding;
import org.ros.uos.ai.jam.expression.Expression;
import org.ros.uos.ai.jam.expression.Function;
import org.ros.uos.ai.jam.expression.Value;

public class FunctionGetCurrentPlan implements Function {
	
	public String getName() {
		return "getCurrentPlan";
	}

	public Value execute(Interpreter interpreter, Goal currentGoal, Binding binding, Expression... args) throws AgentRuntimeException {
		//
		// Get the currently executing Plan
		//
		int arity = (args != null) ? args.length : 0;
		if (arity != 1) {
			System.out.println("Invalid number of arguments: " + arity + " to function \"" + getName() + "\"\n");
			return Value.FALSE;
		}

		Expression exp = args[0];

		if (currentGoal != null && currentGoal.getIntention() != null && currentGoal.getIntention().getPlan() != null) {
			System.out.print("PlanRuntimeSimpleState: current plan is - \"");
			System.out.println(currentGoal.getIntention().getPlan().getName() + "\"");
			binding.setValue(exp, new Value(currentGoal.getIntention().getPlan()));
			return Value.TRUE;
		}

		binding.setValue(exp, new Value((Object) null));
		return Value.TRUE;
	}
}
