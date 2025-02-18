/** 
* Name: ParameterMap 
* Purpose: To retrieve a map of Parameters corresponding to their related API_Payload_Handler__c ids. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
public class ParameterMap extends MapFactory{  
	private Set<Id> filteredTerms = new Set<Id>(); 
	/** 
	* Name: ParameterMap 
	* Purpose: Constructor used to control and direct the neccessary operations for this Apex Class. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Constructor was created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public ParameterMap(Set<Id> filteredTermsParameter){ 
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
		List<Parameter__c> headers = [SELECT Id, Name, Value__c, Auth_token__c, API_Payload_Handler__c,Order__c FROM Parameter__c WHERE API_Payload_Handler__c IN : filteredTerms]; 
		List<SObject> ahr = new List<SObject>(); 
		Set<Id> tokenSet = new Set<Id>(); 
		for(Parameter__c header:headers){ 
			tokenSet.add(header.Auth_token__c); 
			ahr.add(header); 
		}  
		ahr.addAll([SELECT Id, Name, Value__c, Auth_token__c, API_Payload_Handler__c,Order__c FROM Parameter__c WHERE API_Payload_Handler__c IN: tokenSet]); 
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
		Parameter__c record = (Parameter__c)instance;  
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
	public Map<Id,List<Parameter__c>> getMap(){  
		Map<Id,List<Parameter__c>> theMap = new Map<Id,List<Parameter__c>>();  
		retrieveMap();  
		for(Object keyObject:idMap.keySet()){  
			theMap.put((Id)keyObject,(List<Parameter__c>)idMap.get(keyObject));  
		}  
		return theMap;  
	}  
}