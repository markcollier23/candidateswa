/** 
* Name: RestServiceClientBatch 
* Purpose: To allow multiple API requests to be processed. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   11/12/2024     DD-37530     All              
* ------------------------------------------------------------- 
**/ 
global class RestServiceClientBatch implements Database.Batchable<String>, Database.AllowsCallouts, Database.Stateful {   
	public UtilHttpClass payloadDetails = new UtilHttpClass();  
	public RestServiceClient payloadHandler;  
	public static Integer MAX_TIMEOUT = 120000;  
	public String endPointAfter = '';  
	public List<UtilHttpClass> responseList = new List<UtilHttpClass>();  
	public Boolean requestBodyIsNotEmpty = true; 
	private List<String> payloads = new List<String>(); 
	/** 
	* Name: RestServiceClientBatch 
	* Purpose: Constructor used to control and direct the neccessary operations for this Apex Class. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   11/12/2024     DD-37530     Constructor was created.  
	* ---------------------------------------------------------------------- 
	**/ 
	global RestServiceClientBatch(List<String> payloadsParameter){ 
		payloads = payloadsParameter; 
	} 
	/** 
	* Name: 	RestServiceClientBatch 
	* Purpose: 	Constructor used to control and direct the neccessary operations for this Apex Class . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   11/12/2024     DD-37530     Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	global RestServiceClientBatch(String requestBody,String endpointURL){  
		payloads.add(requestBody);  
		endPointAfter = endpointURL; 
	}  
	/** 
	* Name: start 
	* Purpose: To return the total volume of data which is to be partitioned. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   11/12/2024     DD-37530     API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
	global Iterable<String> start(Database.BatchableContext bc) {   
		System.debug('start method');   
		payloadDetails = payloadHandler.beforeAPIRequest(payloadDetails);
		String req = payloadDetails.getBodyRequest();
		if(String.isNotBlank(req)){   
			payloads = new List<String>();   
			payloads.add(req);   
		}  
		if(payloads.size()==0||payloads==null||payloads.get(0)==null){  
			payloads = new List<String>();
			if(String.isNotBlank(payloadDetails.getEndpoint())){
				payloads.add(payloadDetails.getEndpoint()); 
			}  
			for(String endpointUrl:payloadDetails.getEndpoints()){ 
				if(endpointUrl!=payloadDetails.getEndpoint()){
					payloads.add(endpointUrl); 
				}
			} 
			requestBodyIsNotEmpty = false;  
		} 
		if(String.isBlank(payloadDetails.getEndpoint())){ 
			payloadDetails.setEndpoint(endPointAfter); 
		} 
		System.debug('PAYLOADS = '+String.valueOf(payloads));   
		System.debug('PAYLOAD DETAILS ='+String.valueOf(payloadDetails));   
		return payloads;   
	}    
	/** 
	* Name: execute 
	* Purpose: To execute the code below for every portion returned by the start method ie if the batch size = 100 and the start method returns 200 records then this method will be executed twice. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   11/12/2024     DD-37530     Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	global void execute(Database.BatchableContext bc, List<String> requestBodies){    
		System.debug('execute method');   
		Map<String,UtilHttpClass> localMap = new Map<String,UtilHttpClass>();   
		System.debug('REQUEST BODIES = '+requestBodies);  
		System.debug('PAYLOAD DETAILS = '+payloadDetails);   
		for(String payload:requestBodies){    
			System.debug('PAYLOAD = '+payload);   
			HttpRequest request = new HttpRequest();     
			Http http = new Http();     
			UtilHttpClass parameters = IntegrationLogClass.copy(payloadDetails);  
			if(requestBodyIsNotEmpty){  
				parameters.setBodyRequest(payload);  
			}else{ 
				parameters.setEndpoint(payload); 
			}   
			for(String key : parameters.getHeaders().keySet()) {     
				if(key=='Authorization'){  
					System.debug(key+'==****************');    
				}else{  
					System.debug(key+'=='+parameters.getHeaders().get(key));   
				}   
				request.setHeader(key,parameters.getHeaders().get(key));     
			}     
			System.debug('<<REQUEST BODY->>'+parameters.getBodyRequest());     
			request.setTimeout(MAX_TIMEOUT);     
			request.setEndpoint(parameters.getEndpoint());     
			request.setMethod(parameters.getMethod());    
			System.debug(parameters.getMethod());   
			if (parameters.getUseBlobBody()) {     
				request.setBodyAsBlob(parameters.getBlobBodyRequest());     
			} else {     
				if(String.isNotBlank(parameters.getBodyRequest())&&parameters.getMethod()=='POST'){  
					request.setBody(parameters.getBodyRequest());  
				}     
			}      
			System.debug('Request-'+request.toString()); 
			String message = parameters.getName(); 
			try{    
				HttpResponse res = http.send(request);    
				parameters.setResponseBody(res.getBody());    
				parameters.setStatusCode(res.getStatusCode());   
				parameters = payloadHandler.afterAPIRequest(parameters);   
				parameters.setResponseBody(res.getBody());  
				System.debug('STATUS CODE = ' + res.getStatusCode());    
			}catch(Exception e){    
				message = '{"Exception":"'+e.getCause()+'","Error Message":"'+e.getMessage()+'"}'; 
				parameters.setResponseBody(message);    
				parameters.setStatusCode(500);    
			}      
			parameters.insertRecord(IntegrationLogClass.getHttpRequest(parameters),IntegrationLogClass.getHttpResponse(parameters), message, true);  
			SObject record = parameters.setAPIrequestHandlerId(parameters.getAPIrequestHandlerId()); 
			if(String.isNotBlank(String.valueOf(record.get('Id')))){
				update record;
			}
			responseList.add(parameters);    
			System.debug('RESPONSE LIST = '+String.valueOf(responseList));      
		}   
	}    
	/** 
	* Name: finish 
	* Purpose: To perform the post implementation code when all batch items have been executed. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   11/12/2024     DD-37530     Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	global void finish(Database.BatchableContext bc){    
		System.debug('finish method');   
		System.debug('RESPONSE LIST = '+String.valueOf(responseList)); 
		List<UtilHttpClass> apiRequests = new List<UtilHttpClass>(); 
		for(UtilHttpClass payload:responseList){  
			if(String.isNotBlank(endPointAfter)){ 
				payload.setEndpoint(endPointAfter);   
			} 
			System.debug('PAYLOAD = '+payload);   
			apiRequests.add(payload);  
		}   
		for(UtilHttpClass apiRequest:payloadHandler.finalAPIRequests(apiRequests)){
			payloadDetails = apiRequest; 
		}
	}      
}