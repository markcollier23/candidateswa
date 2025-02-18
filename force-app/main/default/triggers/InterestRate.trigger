//Author: Mark Collier 
//Purpose: To ensure latest bank details are updated based on the interest rates they provide in saving accounts.  
trigger InterestRate on Interest_Rate__c (after insert){ 
	new InterestRateTriggerHandler(Trigger.old,Trigger.new); 
}