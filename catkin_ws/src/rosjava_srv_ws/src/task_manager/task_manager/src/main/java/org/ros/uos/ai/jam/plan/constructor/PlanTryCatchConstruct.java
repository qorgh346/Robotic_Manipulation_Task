package org.ros.uos.ai.jam.plan.constructor;

public class PlanTryCatchConstruct extends PlanConstruct {
	private static final long serialVersionUID = -3621947784978704122L;

	private final PlanConstruct				tryConstruct;
	private final PlanTryCatchEntry[]		catchList;
	
	public PlanTryCatchConstruct(PlanConstruct tryConstruct, PlanTryCatchEntry[] catchList) {
		this.tryConstruct	= tryConstruct;
		this.catchList		= catchList;
		
		if (!checkCatchList()) {
			throw new IllegalArgumentException("Illegal catch Exception!");
		}
	}
	
	private boolean checkCatchList() {
		if (this.catchList.length <= 0) return false;
		
		int length = this.catchList.length;
		for (int i=0; i<length; i++) {
			String ni = this.catchList[i].getExceptionName();
			for (int j=i+1;j<length; j++) {
				String nj = this.catchList[j].getExceptionName();
				if (ni.equalsIgnoreCase(nj)) return false;
			}
		}
		
		return true;
	}

	public PlanConstruct getTryPlanConstruct() {
		return this.tryConstruct;
	}
	
	public PlanTryCatchEntry[] getCatchEntry() {
		return this.catchList;
	}

	@Override
	public PlanRuntimeState newRuntimeState() {
		return new PlanRuntimeTryCatchState(this);
	}
}
