package org.ros.uos.ai.jam;

import org.ros.uos.ai.jam.expression.Relation;

public interface WorldModelChangeListener {
	public void worldModelChanged(Relation[] retracted, Relation asserted);
}
