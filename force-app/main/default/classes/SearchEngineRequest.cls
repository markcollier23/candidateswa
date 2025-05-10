/** 
* Name: SalesforceAPIRequest 
* Purpose: To allow Salesforce API requests to be modified under a specific context. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
public class SearchEngineRequest implements RestServiceClient{    
	/** 
	* Name: beforeAPIRequest 
	* Purpose: To obtain the information required to perform an API Request into a Salesforce org. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
    public UtilHttpClass beforeAPIRequest(UtilHttpClass payload){  
		payload.setEndpoint('https://trailhead.salesforce.com/'+payload.getEndpoint());
		return payload;
    } 
	/** 
	* Name: afterAPIRequest 
	* Purpose: To obtain the information required after an API request is submitted. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
    public UtilHttpClass afterAPIRequest(UtilHttpClass payload){ 
		Map<String,Id> endpointMap = (Map<String,Id>)payload.getParameter();
		if(endpointMap.containsKey(payload.getEndpoint())){
			Id searchEngineId = endpointMap.get(payload.getEndpoint());
			String searchTerm = [SELECT Id,Name FROM Search_Engine__c WHERE Id =: searchEngineId].Name;
			String body = payload.getResponseBody();
			if(body.contains(searchTerm)){
				insert new Location_Found__c(Search_Engine__c=searchEngineId,URL__c=payload.getEndpoint());
			}
		}
        return payload;  
    }  
	/** 
	* Name: finalAPIRequests 
	* Purpose: To implement the final operations after all API requests have been submitted. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
    public List<UtilHttpClass> finalAPIRequests(List<UtilHttpClass> payloads){ 
		Map<String,Id> endpointMap = new Map<String,Id>();
		for(UtilHttpClass payload:payloads){
			if(payload.getName()!='LAST ENDPOINT'){
				Map<String,Id> parentMap = (Map<String,Id>)payload.getParameter();
				for(String endpoint:parentMap.keySet()){
					for(String address:payload.getResponseBody().split('href="')){
						System.debug(address);
						if(address.contains('</a>')){
							endpointMap.put(address.substringBefore('"'),parentMap.get(endpoint));
						}
					}
				}
			}
		} 
		if(endpointMap.size()>0){
			UtilHttpClass apiRequest = new UtilHttpClass();
			apiRequest.setEndpoints(new List<String>(endpointMap.keySet()));
			apiRequest.setMethod('GET');
			apiRequest.setName('LAST ENDPOINT');
			apiRequest.setParameter(endpointMap);
			SalesforceRequest callout = new SalesforceRequest(new SearchEngineRequest(),apiRequest);
			callout.send();
		}
		return payloads;
    }  
}