/** 
* Name: Vote 
* Purpose: To automatically create bill or TD records upon the creation or edition of a Vote record. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   14/11/2024     2024Election   Vote__c          
* ------------------------------------------------------------- 
**/ 
trigger Vote on Vote__c (after delete, after insert, after undelete, after update, before insert, before update) { 
	if ((Boolean)DynamicLabel.get('ActivateVote__c')){ 
		TriggerFactory.createAndExecuteHandler(VoteHandler.class); 
	} 
}