/** 
* Name: NebulaLog
* Purpose: Used for interacting with this orgs API Request logging object..
* 
* Who            When           Ref            What            
* -------------------------------------------------------------
* Mark Collier   05/05/2025     SearchEngine   All             
* -------------------------------------------------------------
**/
public class NebulaLog implements IntegrationLog{
	/**
	* Name: getNewRecord
	* Purpose: To retrieve a LogEntry__c record.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   05/05/2025     SearchEngine   Method has been created. 
	* ----------------------------------------------------------------------
	**/
	public SObject getNewRecord(HttpRequest req,HttpResponse res,String message,Boolean saveLog){
		LogEntryEventBuilder logBuilder; 
		if(req!=null && res!=null){ 
			if(res.getStatusCode()==200){ 
				if((Boolean)DynamicLabel.get('TurnOnNebulaSuccessLogs__c')){ 
					logBuilder = Logger.info(message); 
				}else{ 
					saveLog = false; 
				} 
			}else{ 
				if((Boolean)DynamicLabel.get('TurnOnNebulaErrorLogs__c')){ 
					logBuilder = Logger.error(message); 
				}else{ 
					saveLog = false; 
				} 
			} 
			if(saveLog){ 
				logBuilder.setHttpRequestDetails(req); 
				logBuilder.setHttpResponseDetails(res); 
				Logger.saveLog();  
			} 
		} 
		DateTime recentDate = DateTime.now();
		for(SObject recentlyCreated:Database.query('SELECT max(CreatedDate) lastlogFound FROM LogEntry__c')){
			recentDate = (DateTime)recentlyCreated.get('lastlogFound');
		}
		String query = 'SELECT Id,';
		query+=getNameField()+',';
		query+=getEndpointField()+',';
		query+=getMethodField()+',';
		query+=getRequestBodyField()+',';
		query+=getResponseBodyField()+',';
		query+=getStatusCodeField()+' FROM LogEntry__c WHERE CreatedDate =: recentDate';
		List<LogEntry__c> logs = Database.query(query);
		if(logs.size()>0){
			return logs.get(0);
		}
		return new LogEntry__c();
	}
	/**
	* Name: getNameField
	* Purpose: Retrieve the field value of Message__c.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   05/05/2025     SearchEngine   Method has been created. 
	* ----------------------------------------------------------------------
	**/
	public String getNameField(){
		return 'Message__c';
	}
	/**
	* Name: getNameFieldSize
	* Purpose: Retrieve the maximum field size of Message__c.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   05/05/2025     SearchEngine   Method has been created. 
	* ----------------------------------------------------------------------
	**/
	public Integer getNameFieldSize(){
		return LogEntry__c.Message__c.getDescribe().getLength();
	}
	/**
	* Name: getStatusCodeField
	* Purpose: Retrieve the field value of HttpResponseStatusCode__c.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   05/05/2025     SearchEngine   Method has been created. 
	* ----------------------------------------------------------------------
	**/
	public String getStatusCodeField(){
		return 'HttpResponseStatusCode__c';
	}
	/**
	* Name: getStatusCodeFieldSize
	* Purpose: Retrieve the maximum field size of HttpResponseStatusCode__c.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   05/05/2025     SearchEngine   Method has been created. 
	* ----------------------------------------------------------------------
	**/
	public Integer getStatusCodeFieldSize(){
		return LogEntry__c.HttpResponseStatusCode__c.getDescribe().getLength();
	}
	/**
	* Name: getEndpointField
	* Purpose: Retrieve the field value of HttpRequestEndpoint__c.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   05/05/2025     SearchEngine   Method has been created. 
	* ----------------------------------------------------------------------
	**/
	public String getEndpointField(){
		return 'HttpRequestEndpoint__c';
	}
	/**
	* Name: getEndpointFieldSize
	* Purpose: Retrieve the maximum field size of HttpRequestEndpoint__c.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   05/05/2025     SearchEngine   Method has been created. 
	* ----------------------------------------------------------------------
	**/
	public Integer getEndpointFieldSize(){
		return LogEntry__c.HttpRequestEndpoint__c.getDescribe().getLength();
	}
	/**
	* Name: getResponseBodyField
	* Purpose: Retrieve the field value of HttpResponseBody__c.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   05/05/2025     SearchEngine   Method has been created. 
	* ----------------------------------------------------------------------
	**/
	public String getResponseBodyField(){
		return 'HttpResponseBody__c';
	}
	/**
	* Name: getResponseBodyFieldSize
	* Purpose: Retrieve the maximum field size of HttpResponseBody__c.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   05/05/2025     SearchEngine   Method has been created. 
	* ----------------------------------------------------------------------
	**/
	public Integer getResponseBodyFieldSize(){
		return LogEntry__c.HttpResponseBody__c.getDescribe().getLength();
	}
	/**
	* Name: getRequestBodyField
	* Purpose: Retrieve the field value of HttpRequestBody__c.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   05/05/2025     SearchEngine   Method has been created. 
	* ----------------------------------------------------------------------
	**/
	public String getRequestBodyField(){
		return 'HttpRequestBody__c';
	}
	/**
	* Name: getRequestBodyFieldSize
	* Purpose: Retrieve the maximum field size of HttpRequestBody__c.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   05/05/2025     SearchEngine   Method has been created. 
	* ----------------------------------------------------------------------
	**/
	public Integer getRequestBodyFieldSize(){
		return LogEntry__c.HttpRequestBody__c.getDescribe().getLength();
	}
	/**
	* Name: getMethodField
	* Purpose: Retrieve the field value of HttpRequestMethod__c.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   05/05/2025     SearchEngine   Method has been created. 
	* ----------------------------------------------------------------------
	**/
	public String getMethodField(){
		return 'HttpRequestMethod__c';
	}
	/**
	* Name: getMethodFieldSize
	* Purpose: Retrieve the maximum field size of HttpRequestMethod__c.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   05/05/2025     SearchEngine   Method has been created. 
	* ----------------------------------------------------------------------
	**/
	public Integer getMethodFieldSize(){
		return LogEntry__c.HttpRequestMethod__c.getDescribe().getLength();
	}
}
