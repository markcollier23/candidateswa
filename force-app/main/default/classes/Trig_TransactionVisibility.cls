/** 
* Name: Trig_TransactionVisibility
* Purpose: To ensure that we can report on the appropriate number of Transaction records.
* 
* Who            When           Ref            What                      
* -----------------------------------------------------------------------
* Mark Collier   30/04/2025     trans          Transaction_Visibility__c 
* -----------------------------------------------------------------------
**/
public class Trig_TransactionVisibility implements TriggerInterface {
	/**
	* Name: beforeInsert
	* Purpose: To control and direct the necessary operations and actions required to be processed in the event that Transaction_Visibility__c records are inserted, updated or deleted.
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   30/04/2025     trans          Method was created. 
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
	* Mark Collier   30/04/2025     trans          Method was created. 
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
	* Mark Collier   30/04/2025     trans          Method was created. 
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
	* Mark Collier   30/04/2025     trans          Method was created. 
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
	* Mark Collier   30/04/2025     trans          Method was created. 
	* -----------------------------------------------------------------
	**/
	public void afterUpdate(Map<Id, SObject> mapNewRecords, Map<Id, SObject> mapOldRecords){
		System.enqueueJob(new TransactionVisibility(mapNewRecords.keySet()));
	}
	/**
	* Name: afterDelete
	* Purpose: .
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   30/04/2025     trans          Method was created. 
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
	* Mark Collier   30/04/2025     trans          Method was created. 
	* -----------------------------------------------------------------
	**/
	public void afterUndelete(Map<Id, SObject> mapNewRecords){
	}
}
