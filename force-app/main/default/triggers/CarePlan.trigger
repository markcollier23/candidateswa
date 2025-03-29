/** 
* Name: CarePlan
* Purpose: To create a new care plan.
* 
* Who            When           Ref            What            
* -------------------------------------------------------------
* Mark Collier   29/03/2025     hellenic       Care_Plan__c    
* -------------------------------------------------------------
**/
trigger CarePlan on Care_Plan__c (after delete, after insert, after undelete, after update, before insert, before update) {
	if ((Boolean)DynamicLabel.get('ActivateCarePlan__c')){
		TriggerFactory.createAndExecuteHandler(Trig_CarePlan.class);
	}
}
