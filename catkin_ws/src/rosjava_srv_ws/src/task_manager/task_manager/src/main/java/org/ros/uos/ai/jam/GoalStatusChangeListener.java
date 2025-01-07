package org.ros.uos.ai.jam;

public interface GoalStatusChangeListener {
	public void statusChanged(Goal goal, int oldStatus, int newStatus);
}
