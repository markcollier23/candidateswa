/** 
* Name: Trig_SearchEngine
* Purpose: To find a piece of text.
* 
* Who            When           Ref            What             
* --------------------------------------------------------------
* Mark Collier   05/05/2025                    Search_Engine__c 
* --------------------------------------------------------------
**/
public class Trig_SearchEngine implements TriggerInterface {
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
		Map<String,Id> endpointMap = new Map<String,Id>();
		for(Search_Engine__c record:[SELECT Id,URL__c FROM Search_Engine__c WHERE Id IN: mapNewRecords.keySet()]){
			endpointMap.put(record.URL__c,record.Id);
		}
		if(endpointMap.size()==1){
			endpointMap.put('Invoke Batch',null);
		}
		delete [SELECT Id FROM Location_Found__c WHERE Search_Engine__c IN: endpointMap.values()];
		UtilHttpClass apiRequest = new UtilHttpClass();
		apiRequest.setEndpoints(new List<String>(endpointMap.keySet()));
		apiRequest.setMethod('GET');
		apiRequest.setParameter(endpointMap);
		SalesforceRequest callout = new SalesforceRequest(new SearchEngineRequest(),apiRequest);
		callout.send();
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
