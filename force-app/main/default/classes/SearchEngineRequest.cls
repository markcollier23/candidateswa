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
		List<Location_Found__c> locations = new List<Location_Found__c>();
		Set<Id> searchEngines = new Set<Id>();
        for(UtilHttpClass payload:payloads){
			System.debug(payload);
			for(Id searchEngine:(Set<Id>)payload.getParameter()){
				searchEngines.add(searchEngine);
				for(String address:payload.getResponseBody().split('href="')){
					System.debug(address);
					if(address.contains('</a>')){
						locations.add(new Location_Found__c(Search_Engine__c = searchEngine,URL__c = address.substringBefore('"')));
					}
				}
			}
		} 
		delete [SELECT Id FROM Location_Found__c WHERE Search_Engine__c IN: searchEngines];
		insert locations;
		return payloads;
    }  
}