package org.ros.uos.ai.jam.expression.functions.communication;

import java.io.PrintStream;

import org.ros.uos.ai.jam.Goal;
import org.ros.uos.ai.jam.Interpreter;
import org.ros.uos.ai.jam.exception.AgentRuntimeException;
import org.ros.uos.ai.jam.expression.Binding;
import org.ros.uos.ai.jam.expression.Expression;
import org.ros.uos.ai.jam.expression.Function;
import org.ros.uos.ai.jam.expression.Value;

public class FunctionSendMessage implements Function {
	
	public String getName() {
		return "sendMessage";
	}

	public Value execute(Interpreter interpreter, Goal currentGoal, Binding binding, Expression... args) throws AgentRuntimeException {
		//
		// Send a string-encoded message to another agent
		// IN:PrintWriter outputStream
		// IN:String message
		//
		int arity = (args != null) ? args.length : 0;
		if (arity != 2) {
			System.out.println("Invalid number of arguments: " + arity + " to function \"" + getName() + "\"\n");
			return Value.FALSE;
		}

		Expression exp = args[0];
		// PrintWriter sOut = (PrintWriter) exp.eval(binding).getObject();
		PrintStream sOut = (PrintStream) exp.eval(binding).getObject();

		exp = args[1];
		String message = exp.eval(binding).getString();
		sOut.println(message);

		return Value.TRUE;
	}
}
