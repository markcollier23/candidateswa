/** 
* Name: Resident
* Purpose: To update this care plan evaluation date whenever the status has changed to completed.
* 
* Who            When           Ref            What            
* -------------------------------------------------------------
* Mark Collier   17/03/2025                    Resident__c     
* -------------------------------------------------------------
**/
trigger Resident on Resident__c (after delete, after insert, after undelete, after update, before insert, before update) {
	if ((Boolean)DynamicLabel.get('ActivateResident__c')){
		TriggerFactory.createAndExecuteHandler(Trig_Resident.class);
	}
}
