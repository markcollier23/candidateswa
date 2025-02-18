/** 
* Name: HeaderMap 
* Purpose: To retrieve a map of Headers corresponding to their related API_Payload_Handler__c ids. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
public class HeaderMap extends MapFactory{  
	private Set<Id> filteredTerms = new Set<Id>(); 
	/** 
	* Name: HeaderMap 
	* Purpose: Constructor used to control and direct the neccessary operations for this Apex Class. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Constructor was created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public HeaderMap(Set<Id> filteredTermsParameter){ 
		filteredTerms = filteredTermsParameter; 
	} 
	/** 
	* Name: query 
	* Purpose: To retrieve the required data in order to create the necessary map. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
	public override List<SObject> query(){  
		List<Header__c> headers = [SELECT Id, Name, Value__c, Auth_token__c, API_Payload_Handler__c FROM Header__c WHERE API_Payload_Handler__c IN : filteredTerms]; 
		List<SObject> ahr = new List<SObject>(); 
		Set<Id> tokenSet = new Set<Id>(); 
		for(Header__c header:headers){ 
			tokenSet.add(header.Auth_token__c); 
			ahr.add(header); 
		}  
		ahr.addAll([SELECT Id, Name, Value__c, Auth_token__c, API_Payload_Handler__c FROM Header__c WHERE API_Payload_Handler__c IN: tokenSet]); 
		return ahr; 
	}  
	/** 
	* Name: getKey 
	* Purpose: To determine the key which groups the list of records. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
	public override Object getKey(SObject instance){  
		Header__c record = (Header__c)instance;  
		return record.API_Payload_Handler__c;  
	}  
	/** 
	* Name: getMap 
	* Purpose: To retrieve the correct data types for the grouping of a List of records by a specific key. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
	public Map<Id,List<Header__c>> getMap(){  
		Map<Id,List<Header__c>> theMap = new Map<Id,List<Header__c>>();  
		retrieveMap();  
		for(Object keyObject:idMap.keySet()){  
			theMap.put((Id)keyObject,(List<Header__c>)idMap.get(keyObject));  
		}  
		return theMap;  
	}  
}