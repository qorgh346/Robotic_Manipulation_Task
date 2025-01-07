package org.ros.uos.ai.jam.exception;

public interface ExceptionModelFactory {
	public ExceptionTreeNode newExceptionModel();
	
	public ExceptionTreeNode newExceptionTreeNode(String canonicalName);
}
