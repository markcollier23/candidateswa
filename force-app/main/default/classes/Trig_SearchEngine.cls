/** 
* Name: Trig_SearchEngine
* Purpose: To find a piece of text.
* 
* Who            When           Ref            What             
* --------------------------------------------------------------
* Mark Collier   05/05/2025                    Search_Engine__c 
* --------------------------------------------------------------
**/
public class Trig_SearchEngineimplements TriggerInterface {
	/**
	* Name: beforeInsert
	* Purpose: To control and direct the necessary operations and actions required to be processed in the event that Search_Engine__c records are inserted, updated or deleted.
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   05/05/2025                    Method was created. 
	* -----------------------------------------------------------------
	**/
	public void beforeInsert(List<SObject> newRecords){
	}
	/**
	* Name: beforeUpdate
	* Purpose: .
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   05/05/2025                    Method was created. 
	* -----------------------------------------------------------------
	**/
	public void beforeUpdate(Map<Id, SObject> mapNewRecords, Map<Id, SObject> mapOldRecords){
	}
	/**
	* Name: beforeDelete
	* Purpose: .
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   05/05/2025                    Method was created. 
	* -----------------------------------------------------------------
	**/
	public void beforeDelete(Map<Id, SObject> mapOldRecords){
	}
	/**
	* Name: afterInsert
	* Purpose: .
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   05/05/2025                    Method was created. 
	* -----------------------------------------------------------------
	**/
	public void afterInsert(Map<Id, SObject> mapNewRecords){
	}
	/**
	* Name: afterUpdate
	* Purpose: .
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   05/05/2025                    Method was created. 
	* -----------------------------------------------------------------
	**/
	public void afterUpdate(Map<Id, SObject> mapNewRecords, Map<Id, SObject> mapOldRecords){
	}
	/**
	* Name: afterDelete
	* Purpose: .
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   05/05/2025                    Method was created. 
	* -----------------------------------------------------------------
	**/
	public void afterDelete(Map<Id, SObject> mapOldRecords){
	}
	/**
	* Name: afterUndelete
	* Purpose: .
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   05/05/2025                    Method was created. 
	* -----------------------------------------------------------------
	**/
	public void afterUndelete(Map<Id, SObject> mapNewRecords){
	}
}
