/** 
* Name: VoteHandler 
* Purpose: To automatically create bill or TD records upon the creation or edition of a Vote record. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   14/11/2024     2024Election   Vote__c         
* ------------------------------------------------------------- 
**/ 
public class VoteHandler implements TriggerInterface{ 
	/** 
	* Name: beforeInsert 
	* Purpose: To control and direct the necessary operations and actions required to be processed in the event that Vote records are inserted, updated or deleted. 
	*  
	* Who            When           Ref            What                 
	* ----------------------------------------------------------------- 
	* Mark Collier   14/11/2024     2024Election   Method was created.  
	* ----------------------------------------------------------------- 
	**/ 
	public void beforeInsert(List<SObject> newRecords){ 
	} 
	/** 
	* Name: beforeUpdate 
	* Purpose:  To control and direct the necessary operations and actions required to be processed in the event that Vote records are inserted, updated or deleted.. 
	*  
	* Who            When           Ref            What                 
	* ----------------------------------------------------------------- 
	* Mark Collier   14/11/2024     2024Election   Method was created.  
	* ----------------------------------------------------------------- 
	**/ 
	public void beforeUpdate(Map<Id, SObject> mapNewRecords, Map<Id, SObject> mapOldRecords){ 
	} 
	/** 
	* Name: beforeDelete 
	* Purpose:  To control and direct the necessary operations and actions required to be processed in the event that Vote records are inserted, updated or deleted.. 
	*  
	* Who            When           Ref            What                 
	* ----------------------------------------------------------------- 
	* Mark Collier   14/11/2024     2024Election   Method was created.  
	* ----------------------------------------------------------------- 
	**/ 
	public void beforeDelete(Map<Id, SObject> mapOldRecords){ 
	} 
	/** 
	* Name: afterInsert 
	* Purpose:  To control and direct the necessary operations and actions required to be processed in the event that Vote records are inserted, updated or deleted.. 
	*  
	* Who            When           Ref            What                 
	* ----------------------------------------------------------------- 
	* Mark Collier   14/11/2024     2024Election   Method was created.  
	* ----------------------------------------------------------------- 
	**/ 
	public void afterInsert(Map<Id, SObject> mapNewRecords){ 
		VoteUpdate.futureMethod(mapNewRecords.keySet());
	} 
	/** 
	* Name: afterUpdate 
	* Purpose:  To control and direct the necessary operations and actions required to be processed in the event that Vote records are inserted, updated or deleted.. 
	*  
	* Who            When           Ref            What                 
	* ----------------------------------------------------------------- 
	* Mark Collier   14/11/2024     2024Election   Method was created.  
	* ----------------------------------------------------------------- 
	**/ 
	public void afterUpdate(Map<Id, SObject> mapNewRecords, Map<Id, SObject> mapOldRecords){ 
		VoteUpdate.futureMethod(mapNewRecords.keySet());
	} 
	/** 
	* Name: afterDelete 
	* Purpose:  To control and direct the necessary operations and actions required to be processed in the event that Vote records are inserted, updated or deleted.. 
	*  
	* Who            When           Ref            What                 
	* ----------------------------------------------------------------- 
	* Mark Collier   14/11/2024     2024Election   Method was created.  
	* ----------------------------------------------------------------- 
	**/ 
	public void afterDelete(Map<Id, SObject> mapOldRecords){ 
	} 
	/** 
	* Name: afterUndelete 
	* Purpose:  To control and direct the necessary operations and actions required to be processed in the event that Vote records are inserted, updated or deleted.. 
	*  
	* Who            When           Ref            What                 
	* ----------------------------------------------------------------- 
	* Mark Collier   14/11/2024     2024Election   Method was created.  
	* ----------------------------------------------------------------- 
	**/ 
	public void afterUndelete(Map<Id, SObject> mapNewRecords){ 
	} 
}