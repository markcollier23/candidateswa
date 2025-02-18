/** 
* Name: SalesforceRequest 
* Purpose: To allow Salesforce API requests to be submitted given certain details provided by the Connected App. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
public class SalesforceRequest implements Queueable, Database.AllowsCallouts {  
    public RestServiceClient handler; 
    public UtilHttpClass apiRequest; 
	/** 
	* Name: SalesforceRequest 
	* Purpose: Constructor used to control and direct the neccessary operations for this Apex Class. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public SalesforceRequest(RestServiceClient handlerParameter,UtilHttpClass apiRequestParameter){ 
        apiRequest = apiRequestParameter; 
        handler = handlerParameter; 
    } 
	/** 
	* Name: execute 
	* Purpose: Use this method to submit multiple API Requests. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public void execute(QueueableContext context) { 
        send(); 
    } 
	/** 
	* Name: send 
	* Purpose: Use this method to submit multiple API Requests. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public UtilHttpClass send(List<String> payloads){   
        System.debug(apiRequest);    
        apiRequest.setRequestBodies(payloads);     
        RestServiceClientBatch batch = new RestServiceClientBatch(payloads);     
        batch.payloadDetails = apiRequest;     
        batch.payloadHandler = handler;     
        if(String.isNotBlank(apiRequest.getEndpoint())){     
            batch.endPointAfter = apiRequest.getEndpoint();     
        }     
        if(payloads.size()>1){ 
            Database.executeBatch(batch,1); 
        }else{ 
            batch.start(null); 
            batch.execute(null, payloads); 
            batch.finish(null); 
        } 
        return batch.payloadDetails;     
    }      
	/** 
	* Name: send 
	* Purpose: Use this to submit a single API request. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public UtilHttpClass send(){     
        List<String> payloads = new List<String>();     
        payloads.add(apiRequest.getBodyRequest());     
        payloads.addAll(apiRequest.getRequestBodies());  
        return send(payloads); 
    }     
}