package org.ros.uos.ai.jam.expression.functions.meta;

import org.ros.uos.ai.jam.Goal;
import org.ros.uos.ai.jam.Interpreter;
import org.ros.uos.ai.jam.exception.AgentRuntimeException;
import org.ros.uos.ai.jam.expression.Binding;
import org.ros.uos.ai.jam.expression.Expression;
import org.ros.uos.ai.jam.expression.Function;
import org.ros.uos.ai.jam.expression.Value;
import org.ros.uos.ai.jam.plan.APL;
import org.ros.uos.ai.jam.plan.APLElement;

public class FunctionGetAPLElement implements Function {
	
	public String getName() {
		return "getAPLElement";
	}

	public Value execute(Interpreter interpreter, Goal currentGoal, Binding binding, Expression... args) throws AgentRuntimeException {
		//
		// Select a random APL element
		//
		int arity = (args != null) ? args.length : 0;
		if (arity != 3) {
			System.out.println("Invalid number of arguments: " + arity + " to function \"" + getName() + "\"\n");
			return Value.FALSE;
		}

		Expression exp = args[0];
		APL a = (APL) exp.eval(binding).getObject();
		exp = args[1];
		int num = (int) exp.eval(binding).getLong();

		/*
		 * exJ.jam���� �� function�� ����ϴµ�, ���� JAM�� nth()�� 1���� �����ϴ� �ٶ���
		 * ���� ȣȯ���� ���� get(num) ��� get(num-1)�� �ڵ���.
		 */
		APLElement selectedElement = a.get(num - 1);

		exp = args[2];
		binding.setValue(exp, new Value(selectedElement));

		return Value.TRUE;
	}
}
