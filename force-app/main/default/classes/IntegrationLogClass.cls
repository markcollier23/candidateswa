/** 
* Name: IntegrationLogClass 
* Purpose: To allow for logging and tracking of API requests to occur within this Salesforce Org. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
public class IntegrationLogClass{        
	/** 
	* Name: 	createLog 
	* Purpose: 	To generate a API log record . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public static UtilHttpClass createLog(String requestBody,String responseBody,String message,String status,Integer statusCode,String endPointURL,String method){   
		return createSavedLog(requestBody, responseBody, message, status, statusCode, endPointURL, method, true);  
    }   
	/** 
	* Name: 	createLog 
	* Purpose: 	To generate a API log record based on a specific UtilHttpClass parameter . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public static UtilHttpClass createLog(UtilHttpClass apiRequest,String message){  
		return createSavedLog(apiRequest,message,true);  
	}  
	/** 
	* Name: 	createLog 
	* Purpose: 	To generate a API log record based on a specific HttpRequest or HttpResponse variable . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public static UtilHttpClass createLog(HttpRequest request,HttpResponse response,String message){  
		return createSavedLog(request,response,message,true);  
	}  
	/** 
	* Name: 	createSavedLog 
	* Purpose: 	To generate a API log record with the option of saving it within a single Log record . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public static UtilHttpClass createSavedLog(String requestBody,String responseBody,String message,String status,Integer statusCode,String endPointURL,String method,Boolean saveLog){  
		UtilHttpClass apiRequest = new UtilHttpClass();  
		apiRequest.setBodyRequest(requestBody);  
		apiRequest.setResponseBody(responseBody);  
		apiRequest.setParameter(status);  
		apiRequest.setStatusCode(statusCode);  
		apiRequest.setEndpoint(endPointURL);  
		apiRequest.setMethod(method);  
		apiRequest.setName(message);  
		return createSavedLog(apiRequest, message,saveLog);  
	}  
	/** 
	* Name: 	createSavedLog 
	* Purpose: 	To generate a API log record with the option of saving it within a single Log record . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public static UtilHttpClass createSavedLog(UtilHttpClass apiRequest,String message, Boolean saveLog){  
		HttpRequest request = getHttpRequest(apiRequest);  
		HttpResponse response = getHttpResponse(apiRequest);  
		return createSavedLog(request,response,message,saveLog);  
	}   
	/** 
	* Name: 	createSavedLog 
	* Purpose: 	To generate a API log record with the option of saving it within a single Log record from a given a specific HttpRequest or HttpResponse variable . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public static UtilHttpClass createSavedLog(HttpRequest request,HttpResponse response,String message,Boolean saveLog){  
		UtilHttpClass apiRequest = new UtilHttpClass(); 
		apiRequest.insertRecord(request, response, message, saveLog); 
		return apiRequest;  
	}    
	/** 
	* Name: 	getHttpRequest 
	* Purpose: 	To convert a UtilHttpClass variable into a HttpRequest variable . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public static HttpRequest getHttpRequest(UtilHttpClass apiRequest){  
		HttpRequest req = new HttpRequest();  
		if(String.isNotBlank(String.valueOf(apiRequest.getBodyRequest()))){  
			req.setBody(apiRequest.getBodyRequest());  
		}  
		req.setEndpoint(apiRequest.getEndpoint());  
		req.setMethod(apiRequest.getMethod());  
		return req;  
	}  
	/** 
	* Name: 	getHttpResponse 
	* Purpose: 	To convert a UtilHttpClass variable into a HttpResponse variable . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public static HttpResponse getHttpResponse(UtilHttpClass apiRequest){  
		HttpResponse res = new HttpResponse();  
		res.setStatusCode(apiRequest.getStatusCode());  
		String statusMessage = String.valueOf(apiRequest.getParameter());  
		if(String.isNotBlank(statusMessage)){  
			res.setStatus(statusMessage);  
		}  
		res.setBody(apiRequest.getResponseBody());  
		return res;  
	}  
	/** 
	* Name: 	getRestHeadersMC 
	* Purpose: 	To retrieve a map of rest headers used by Marketing Cloud . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public static Map<String,String> getRestHeadersMC(){       
        final Map<String, String> headers = new Map<String, String>();       
        headers.put('Content-Type', 'text/xml');       
        return headers;       
    }       
	/** 
	* Name: 	copy 
	* Purpose: 	To create a new API Request instance . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public static UtilHttpClass copy(UtilHttpClass payloadDetails){     
		UtilHttpClass deepcopy = new UtilHttpClass();      
		deepcopy.setEndpoint(payloadDetails.getEndpoint());      
		deepcopy.useBlobBody(payloadDetails.getUseBlobBody());      
		deepcopy.addHeaders(payloadDetails.getHeaders());   
		deepcopy.setRequestBodies(payloadDetails.getRequestBodies());      
		deepcopy.setBodyRequest(payloadDetails.getBodyRequest());      
		deepcopy.setBlobBodyRequest(payloadDetails.getBlobBodyRequest());      
		deepcopy.setName(payloadDetails.getName());      
		deepcopy.setMethod(payloadDetails.getMethod());      
		deepcopy.setParameter(payloadDetails.getParameter());   
		deepcopy.setAPIrequestHandlerId(payloadDetails.getAPIrequestHandlerId());     
		return deepcopy;   
    }     
}