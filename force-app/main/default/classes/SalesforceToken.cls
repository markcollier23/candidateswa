/** 
* Name: SalesforceToken 
* Purpose: To allow Salesforce API requests to be submitted given certain details provided by the Connected App. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
public class SalesforceToken implements RestServiceClient{    
	/** 
	* Name: 	beforeAPIRequest 
	* Purpose: 	To obtain the information required to perform an API Request into a Salesforce environment . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public UtilHttpClass beforeAPIRequest(UtilHttpClass payload){  
        payload.setMasking(false); 
        return payload;  
    }  
	/** 
	* Name: 	afterAPIRequest 
	* Purpose: 	To obtain the information required after an API request is submitted . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public UtilHttpClass afterAPIRequest(UtilHttpClass payload){  
        List<String> requestBodies = payload.getRequestBodies();  
        if(requestBodies.size()==0){  
            requestBodies.add(payload.getBodyRequest());  
        }   
        payload.setRequestBodies(requestBodies); 
        List<String> response = new List<String>(); 
        response.add(payload.getResponseBody()); 
        payload.setEndpoints(response); 
        payload.setMasking(true); 
        return payload; 
    } 
	/** 
	* Name: 	finalAPIRequests 
	* Purpose: 	To perform the necessary actions required after the below series of API requests have been submitted . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public List<UtilHttpClass> finalAPIRequests(List<UtilHttpClass> payloads){ 
        UtilHttpClass payload = new UtilHttpClass(); 
        List<UtilHttpClass> result = new List<UtilHttpClass>(); 
        for(UtilHttpClass apiRequest:payloads){ 
            payloads.add(apiRequest); 
            result.add((UtilHttpClass)apiRequest.getParameter()); 
        } 
        RestServiceClientBatch apiRequest = new RestServiceClientBatch(payload.getRequestBodies());  
        UtilHttpClass nextAPIRequest = (UtilHttpClass)payload.getParameter();  
        JSONObject response = new JSONObject(payload.getEndpoints().get(0));  
        String key = String.valueOf(nextAPIRequest.getParameter());  
        String token = response.get(key);  
        if(payload.getStatusCode()==200){  
            apiRequest = new RestServiceClientBatch(nextAPIRequest.getRequestBodies());  
            Map<String,String> headMap = nextAPIRequest.getHeaders();  
            for(String headerKey:headMap.keySet()){  
                String headerValue = headMap.get(headerKey);  
                nextAPIRequest.addHeaderParam(headerKey, headerValue.replace('['+key+']',token.replace(String.fromCharArray(new Integer[]{ 34 }),'')));  
                System.debug(nextAPIRequest);  
            }  
            apiRequest.payloadHandler = new SalesforceAPIRequest();  
            apiRequest.payloadDetails = nextAPIRequest;  
            if(String.isNotBlank(payload.getEndpoint())){      
                apiRequest.endPointAfter = nextAPIRequest.getEndpoint();      
            }      
            Database.executeBatch(apiRequest,1);  
        }else{  
            if(String.isBlank(token) && payload.getName()==null){  
                payload.setName('Try Again');  
                new SalesforceRequest(new SalesforceToken(),payload).send(); 
            }  
        }  
        return result;  
    }  
}