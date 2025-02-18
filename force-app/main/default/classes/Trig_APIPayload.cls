/** 
* Name: Trig_APIPayload 
* Purpose: To enable api requests to be called. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
public class Trig_APIPayload implements TriggerInterface{  
	private Map<Object,List<SObject>> apiHeaderMap = new Map<Object,List<SObject>>(); 
	private Map<Object,List<SObject>> apiParameterMap = new Map<Object,List<SObject>>(); 
	/** 
	* Name: beforeInsert 
	* Purpose: To perform the necessary operations upon the creation of an API Payload Handler record. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
	public void beforeInsert(List<SObject> newRecords){  
	}    
	/** 
	* Name: beforeUpdate 
	* Purpose: To perform the necessary operations upon the deletion of an API Payload Handler record. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
	public void beforeUpdate(Map<Id, SObject> mapNewRecords, Map<Id, SObject> mapOldRecords){    
	}    
	/** 
	* Name: beforeDelete 
	* Purpose: To perform the necessary operations upon the deletion of an API Payload Handler record. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
	public void beforeDelete(Map<Id, SObject> mapOldRecords){    
	}    
	/** 
	* Name: afterInsert 
	* Purpose: To perform the necessary operations upon the insertion of an API Payload Handler record. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
	public void afterInsert(Map<Id, SObject> mapNewRecords){    
		cloneParentHeadersAndParameters(mapNewRecords.keySet()); 
	}  
	/** 
	* Name: afterUpdate 
	* Purpose: To perform the necessary operations upon after you have updated an API Payload Handler record. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
	public void afterUpdate(Map<Id, SObject> mapNewRecords, Map<Id, SObject> mapOldRecords){  
		afterInsert(mapNewRecords);  
		List<DualAPI> calloutAPIList = fillOut(mapNewRecords.keySet()); 
		for(DualAPI calloutAPI:calloutAPIList){ 
			calloutAPI.apiRequest.setAPIrequestHandlerId(calloutAPI.apiRequestId); 
			Map<String,String> headers = calloutAPI.apiRequest.getHeaders(); 
			for(String key:headers.keySet()){ 
				String value = headers.get(key).substringBetween('[', ']'); 
				if(String.isNotBlank(value)){ 
					calloutAPI.apiRequest.setParameter(value); 
				} 
			} 
			UtilHttpClass token = calloutAPI.tokenRequest; 
			if(token==null){ 
				//Perform the Salesforce API Request without a token. 
				System.enqueueJob(new SalesforceRequest(new SalesforceAPIRequest(),calloutAPI.apiRequest)); 
			}else{ 
				//Perform the API Request for the Token first and then perform the Salesforce API Request using the token. 
				token.setParameter(calloutAPI.apiRequest); 
				token.setAPIrequestHandlerId(calloutAPI.tokenRequestId); 
				System.enqueueJob(new SalesforceRequest(new SalesforceToken(),token)); 
			} 
		} 
	} 
	@future() 
	/** 
	* Name: cloneParentHeadersAndParameters 
	* Purpose: To perform the necessary operations upon after you have updated an API Payload Handler record. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
	public static void cloneParentHeadersAndParameters(Set<Id> apiRequestSet){ 
		new Trig_APIPayload().getDualAPIList(apiRequestSet, new CheckClone()); 
		List<API_Payload_Handler__c> apiRequestList = new List<API_Payload_Handler__c>(); 
		for(API_Payload_Handler__c apiRequest:[SELECT Id,Parent__c FROM API_Payload_Handler__c WHERE Id IN: apiRequestSet]){ 
			apiRequest.Parent__c = null; 
			apiRequestList.add(apiRequest); 
		} 
		TriggerFactory.bypassHandler(Trig_APIPayload.class); 
		update apiRequestList; 
		TriggerFactory.removeBypassHandler(Trig_APIPayload.class); 
	} 
	/** 
	* Name: fillOut 
	* Purpose: To retrieve a list of API requests and their tokens. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
	public List<DualAPI> fillOut(Set<Id> apiRequestIds){ 
		Map<Id,Id> tokenMap = new Map<Id,Id>(); 
		for(DualAPI calloutAPI:getDualAPIList(apiRequestIds,new Token())){ 
			tokenMap.put(calloutAPI.tokenRequestId,calloutAPI.apiRequestId); 
		} 
		Map<Id,DualAPI> apiRequestMap = new Map<Id,DualAPI>(); 
		for(DualAPI calloutAPI:getDualAPIList(apiRequestIds,new HttpUtility())){ 
			apiRequestMap.put(calloutAPI.apiRequestId,calloutAPI); 
		} 
		for(DualAPI token:getDualAPIList(tokenMap.keySet(),new HttpUtility())){ 
			Id apiRequestId = tokenMap.get(token.apiRequestId); 
			DualAPI combine = apiRequestMap.get(apiRequestId); 
			combine.tokenRequest = token.apiRequest; 
			combine.tokenRequestId = token.apiRequestId; 
			apiRequestMap.put(apiRequestId,combine); 
		} 
		List<DualAPI> output = new List<DualAPI>(); 
		for(Id apiRequestId:apiRequestMap.keySet()){ 
			output.add(apiRequestMap.get(apiRequestId)); 
		} 
		return output; 
	} 
	/** 
	* Name: getDualAPIList 
	* Purpose: To invoke a process which has already sorted API Request callouts with their headers and parameters. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
	public List<DualAPI> getDualAPIList(Set<Id> apiRequestIds,Process populator){ 
		List<DualAPI> dualAPIList = new List<DualAPI>(); 
		Set<Id> apiRequestSet = new Set<Id>(); 
		List<API_Payload_Handler__c> apiRequestList = new List<API_Payload_Handler__c>(); 
		for(API_Payload_Handler__c apiRequest:[SELECT Id,Endpoint__c,Method__c,Body__c,Parent__c FROM API_Payload_Handler__c WHERE Id IN: apiRequestIds]){ 
			apiRequestSet.add(apiRequest.Id); 
			apiRequestSet.add(apiRequest.Parent__c); 
			apiRequestList.add(apiRequest); 
		} 
		if(apiHeaderMap.size()==0 && apiParameterMap.size()==0){ 
			HeaderMap mapOfHeaders = new HeaderMap(apiRequestSet); 
			ParameterMap mapOfParameters = new ParameterMap(apiRequestSet); 
			apiHeaderMap = mapOfHeaders.retrieveMap(); 
			apiParameterMap = mapOfParameters.retrieveMap(); 
		} 
		for(API_Payload_Handler__c apiRequest:apiRequestList){ 
			List<SObject> headerList = apiHeaderMap.get(apiRequest.Id); 
			List<SObject> parameterList = apiParameterMap.get(apiRequest.Id); 
			dualAPIList.add(populator.getDualAPI(apiRequest,headerList,parameterList)); 
		} 
		return dualAPIList; 
	} 
	/** 
	* Name: DualAPI 
	* Purpose: To store the API request details of both the token and the callout. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
	public class DualAPI{ 
		public Id tokenRequestId; 
		public Id apiRequestId; 
		public UtilHttpClass tokenRequest; 
		public UtilHttpClass apiRequest; 
	}    
	/** 
	* Name: CheckClone 
	* Purpose: To perform the necessary operations required to transfer Headers, Parameters and Payloads accross to a new API Request. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
	public class CheckClone implements Process{ 
		/** 
		*Name: getDualAPI 
		*Purpose: To provide a method to be invoked by the Process Interface in order to obtain the correct set of Headers, Parameters and Payloads for the new API Request. 
		* 
		*Who            When           Ref            What                    
		*-------------------------------------------------------------------- 
		*Mark Collier   10/12/2024     API            API_Payload_Handler__c  
		*-------------------------------------------------------------------- 
		**/ 
		public DualAPI getDualAPI(API_Payload_Handler__c apiRequest,List<SObject> headerList,List<SObject> parameterList){ 
			if(String.isNotBlank(String.valueOf(apiRequest.Parent__c))){ 
				headerList = new List<SObject>(); 
				parameterList = new List<SObject>(); 
				List<Parameter__c> newHeaders = new List<Parameter__c>(); 
				List<Parameter__c> newParameters = new List<Parameter__c>(); 
				List<Payload__c> newPayloads = new List<Payload__c>(); 
				for(Parameter__c oldHeader:[SELECT Id,Name,Value__c,Auth_token__c FROM Parameter__c WHERE API_Payload_Handler__c =: apiRequest.Parent__c]){ 
					newHeaders.add(new Parameter__c(Name=oldHeader.Name,Value__c=oldHeader.Value__c,Auth_token__c=oldHeader.Auth_token__c,API_Payload_Handler__c=apiRequest.Id)); 
				} 
				for(Parameter__c oldParameter:[SELECT Id,Name,Value__c,Auth_token__c FROM Parameter__c WHERE API_Payload_Handler__c =: apiRequest.Parent__c]){ 
					newParameters.add(new Parameter__c(Name=oldParameter.Name,Value__c=oldParameter.Value__c,Auth_token__c=oldParameter.Auth_token__c,API_Payload_Handler__c=apiRequest.Id,Order__c=oldParameter.Order__c)); 
				} 
				for(Payload__c oldPayload:[SELECT Id,Name,Request_Body__c,API_Payload_Handler__c FROM Payload__c WHERE API_Payload_Handler__c =: apiRequest.Parent__c]){ 
					newPayloads.add(new Payload__c(Request_Body__c=oldPayload.Request_Body__c,API_Payload_Handler__c=apiRequest.Id)); 
				} 
				insert newPayloads; 
				insert newHeaders; 
				insert newParameters; 
			} 
			return new DualAPI(); 
		} 
	} 
	/**    
	* Name: Token 
	* Purpose: To provide a mapping of the API token and the API callout.   
	**/     
	public class Token implements Process{ 
		/** 
		*Name: getDualAPI 
		*Purpose: To provide a method to be invoked by the Process Interface in order to obtain a mapping of the API token and the API callout. 
		* 
		*Who            When           Ref            What                    
		*-------------------------------------------------------------------- 
		*Mark Collier   10/12/2024     API            API_Payload_Handler__c  
		*-------------------------------------------------------------------- 
		**/ 
		public DualAPI getDualAPI(API_Payload_Handler__c apiRequest,List<SObject> headerList,List<SObject> parameterList){ 
			DualAPI calloutAPI = new DualAPI(); 
			Map<Object,Object> tokenAPIRequestMap = new Map<Object,Object>(); 
			List<SObject> headerAndParameterList = new List<SObject>(); 
			if(headerList!=null && headerList.size()>0){ 
				headerAndParameterList.addAll(headerList); 
			} 
			if(parameterList!=null && parameterList.size()>0){ 
				headerAndParameterList.addAll(parameterList); 
			} 
			Set<Id> authToken = new Set<Id>(); 
			for(SObject headerParameter:headerAndParameterList){ 
				if(String.isNotBlank(String.valueOf(headerParameter.get('Auth_token__c')))){ 
					authToken.add((Id)headerParameter.get('Auth_token__c')); 
				} 
			} 
			if(authToken.size()==1){ 
				for(Id authTokenId:authToken){ 
					calloutAPI.tokenRequestId = authTokenId; 
					calloutAPI.apiRequestId = apiRequest.Id; 
				} 
			} 
			return calloutAPI; 
		} 
	} 
	/** 
	* Name: HttpUtility 
	* Purpose: To convert API_Payload_Handler__c records into a UtilHttpClass instance. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
	public class HttpUtility implements Process{ 
		/** 
		*Name: getDualAPI 
		*Purpose: To provide a method to be invoked by the Process Interface in order to obtain the UtilHttpClass instance of an API Request. 
		* 
		*Who            When           Ref            What                    
		*-------------------------------------------------------------------- 
		*Mark Collier   10/12/2024     API            API_Payload_Handler__c  
		*-------------------------------------------------------------------- 
		**/ 
		public DualAPI getDualAPI(API_Payload_Handler__c apiRequest,List<SObject> headerList,List<SObject> parameterList){ 
			DualAPI calloutAPI = new DualAPI(); 
			calloutAPI.apiRequestId = apiRequest.Id; 
			calloutAPI.apiRequest = convert(apiRequest, headerList, parameterList); 
			List<String> payloads = new List<String>(); 
			for(Payload__c payload:[SELECT Id,Request_Body__c FROM Payload__c WHERE API_Payload_Handler__c =: apiRequest.Id]){ 
				payloads.add(payload.Request_Body__c); 
			} 
			calloutAPI.apiRequest.setRequestBodies(payloads); 
			return calloutAPI; 
		} 
	/** 
	* Name: convert 
	* Purpose: To provide the relevant API Request information within the UtilHttpClass based upon an API_Payload_Handler__c record. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
		public UtilHttpClass convert(API_Payload_Handler__c record,List<SObject> headerList,List<SObject> parameterList){ 
			String endpointURL = record.Endpoint__c; 
			String joinCharacter = '?'; 
			if(parameterList!=null && parameterList.size()>0){ 
				Map<Integer,Parameter__c> parameterMap = new Map<Integer,Parameter__c>(); 
				Integer largest = 0; 
				Integer smallest = 999; 
				for(Parameter__c param:(List<Parameter__c>)parameterList){ 
					Integer order = Math.round(param.Order__c); 
					smallest = smallest<order?smallest:order; 
					largest = largest>order?largest:order; 
					parameterMap.put(order,param); 
				} 
				for(Integer i=smallest;i<=largest;i++){ 
					if(parameterMap.containsKey(i)){ 
						Parameter__c param = parameterMap.get(i); 
						endpointURL+=joinCharacter+param.Name+'='+param.Value__c; 
						if(joinCharacter=='?'){ 
							joinCharacter = '&'; 
						} 
					} 
				} 
			} 
			UtilHttpClass apiRequest = new UtilHttpClass(); 
			apiRequest.setEndpoint(endpointURL); 
			apiRequest.setBodyRequest(record.Body__c); 
			apiRequest.setMethod(record.Method__c); 
			apiRequest.setAPIrequestHandlerId(record.Id); 
			if(headerList!=null && headerList.size()>0){ 
				for(Parameter__c header:(List<Parameter__c>)headerList){ 
					String value = header.Value__c; 
					apiRequest.addHeaderParam(header.Name,value.replace('{!$Credential.SessionId}',UserInfo.getSessionId())); 
				} 
			} 
			return apiRequest; 
		} 
	} 
	/** 
	* Name: Process 
	* Purpose: To allow multiple processes to be utilised within the context of a single API Payload Handler record. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
	public Interface Process{ 
		DualAPI getDualAPI(API_Payload_Handler__c apiRequest,List<SObject> headerList,List<SObject> parameterList); 
	} 
	/** 
	* Name: afterDelete 
	* Purpose: To peform the necessary operations upon after you have deleted an API Payload Handler record. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
	public void afterDelete(Map<Id, SObject> mapOldRecords){    
	}    
	/** 
	* Name: afterUndelete 
	* Purpose: To peform the necessary operations upon after you undo your deletion. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
	public void afterUndelete(Map<Id, SObject> mapNewRecords){    
	} 
}