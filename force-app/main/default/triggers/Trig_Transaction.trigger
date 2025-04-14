/** 
* Name: Transaction
* Purpose: To ensure Transaction records are being uniquely imported.
* 
* Who            When           Ref            What            
* -------------------------------------------------------------
* Mark Collier   13/04/2025     trans          Transactions__c 
* -------------------------------------------------------------
**/
trigger Trig_Transaction on Transactions__c (after delete, after insert, after undelete, after update, before insert, before update) {
	if ((Boolean)DynamicLabel.get('ActivateTransaction__c')){
		TriggerFactory.createAndExecuteHandler(Trig_Transaction.class);
	}
}
