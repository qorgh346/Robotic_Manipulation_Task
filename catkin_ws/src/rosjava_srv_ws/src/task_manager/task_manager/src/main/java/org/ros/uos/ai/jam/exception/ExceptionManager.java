package org.ros.uos.ai.jam.exception;

import java.util.List;

import org.ros.uos.ai.jam.Interpreter;

/**
 * ExceptionManager interface
 * 
 * @author	Hyunju Shin <jetzt82@gmail.com>
 * @since	2.0
 * @update	2.0
 */
public interface ExceptionManager {
	public void setModelFactory(ExceptionModelFactory factory);
	
	public String getRootException();
	
	public String getParentException(String name);
	
	public String getParentException(AgentRuntimeException exception);
	
	public String[] getChildrenExceptions(String name);
	
	public String[] getChildrenExceptions(AgentRuntimeException exception);
	
	public String[] getPathToRoot(String name);
	
	public boolean isAncestor(String parent, String child);
	
	public boolean isAncestor(AgentRuntimeException parent, String child);
	
	public boolean isDescendant(String child, String parent);
	public boolean isDescendantOrEqual(String child, String parent);
	
	
	public boolean isDescendant(AgentRuntimeException child, String parent);
	public boolean isDescendantOrEqual(AgentRuntimeException child, String parent);
	
	
	public boolean addNodeInto(String child, String parent);
	
	public boolean removeNodeFromParent(String child);
	
	public boolean removeAllNode(String parent);
	
	public void throwException(AgentRuntimeException ex);
	
	public AgentRuntimeException[] getAllExceptions();
	
	public void removeAllExceptions();
	
	public void addGlobalCatch(GlobalCatch globalCatch);
	
	public void addAllGlobalCatch(List<GlobalCatch> list);
	
	public void addAllGlobalCatch(GlobalCatch[] list);
	
	public void removeGlobalCatch(GlobalCatch globalCatch);
	
	public GlobalCatch[] getGlobalCatchs();
	
	public void execute(Interpreter interpreter);
}
