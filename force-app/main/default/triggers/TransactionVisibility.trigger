/** 
* Name: TransactionVisibility
* Purpose: To ensure that we can report on the appropriate number of Transaction records.
* 
* Who            When           Ref            What                      
* -----------------------------------------------------------------------
* Mark Collier   30/04/2025     trans          Transaction_Visibility__c 
* -----------------------------------------------------------------------
**/
trigger TransactionVisibility on Transaction_Visibility__c (after delete, after insert, after undelete, after update, before insert, before update) {
	if ((Boolean)DynamicLabel.get('ActivateTransactionVisibility__c')){
		TriggerFactory.createAndExecuteHandler(Trig_TransactionVisibility.class);
	}
}
