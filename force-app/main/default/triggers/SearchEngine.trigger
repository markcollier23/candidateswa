/** 
* Name: SearchEngine
* Purpose: To find a piece of text.
* 
* Who            When           Ref            What             
* --------------------------------------------------------------
* Mark Collier   05/05/2025                    Search_Engine__c 
* --------------------------------------------------------------
**/
trigger SearchEngine on Search_Engine__c (after delete, after insert, after undelete, after update, before insert, before update) {
	if ((Boolean)DynamicLabel.get('ActivateSearchEngine__c')){
		TriggerFactory.createAndExecuteHandler(Trig_SearchEngine.class);
	}
}
