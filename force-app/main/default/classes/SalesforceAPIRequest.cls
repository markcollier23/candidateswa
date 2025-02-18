/** 
* Name: SalesforceAPIRequest 
* Purpose: To allow Salesforce API requests to be modified under a specific context. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
public class SalesforceAPIRequest implements RestServiceClient{    
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
        if(payload.getHeaders()==null || payload.getHeaders().size()==0){ 
            payload.addHeaderParam('Content-Type', 'application/json'); 
            String token = String.valueOf(payload.getParameter()); 
            if(String.isBlank(token)){ 
                token = UserInfo.getSessionId(); 
            } 
            payload.addHeaderParam('Authorization', 'Bearer '+token);   
        } 
        return payload; 
    } 
    /**  
    * Name: afterAPIRequest  
    * Purpose: To obtain the information required after an API request is submitted.  
    *   
    **/   
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
        return payloads;  
    }  
}