/** 
* Name: UtilHttpClass 
* Purpose: An object oriented apex class for holding API request details. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
public class UtilHttpClass{     
    private String endpoint;     
    private Map<String, String> headers = new Map<String, String>();     
    private String bodyRequest;     
    private Blob blobBodyRequest;     
    private String name;     
    private String method;     
    private boolean useBlobBody = false;   
    private Boolean logAPIRequest = true;   
    private String responseBody;   
    private Integer statusCode = 500;   
    private Object parameter;  
    private Id apiRequestHandlerId;  
    private List<String> requestBodies = new List<String>();  
    private List<String> endpoints = new List<String>(); 
    private Boolean maskStrings = true; 
    private IntegrationLog log = (IntegrationLog)DynamicLabel.get('DefaultIntegrationLog__c',false);  
    private SObject record = log.getNewRecord(null,null,String.valueOf(DateTime.now()),true);  
	/** 
	* Name: 	insertRecord 
	* Purpose: 	To insert the required Integration Log record . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public SObject insertRecord(HttpRequest req,HttpResponse res,String message, Boolean saveLog){ 
		record = log.getNewRecord(req, res, message, saveLog); 
		setEndpoint(req.getEndpoint()); 
		setBodyRequest(req.getBody()); 
		setMethod(req.getMethod()); 
		setStatusCode(res.getStatusCode()); 
		setResponseBody(res.getBody()); 
		setName(message); 
		if(saveLog && record.Id==null && String.valueOf(record.getSObjectType())!='LogEntry__c'){ 
			insert record; 
		} 
		return record; 
	} 
	/** 
	* Name: put 
	* Purpose: To set a field value to the record associated with the API request. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public SObject put(String fieldNames,Integer maxlen,Object value){ 
		if(String.isNotBlank(String.valueOf(value))){
			String valueString = String.valueOf(value).left(maxlen); 
			for(String fieldName:fieldNames.split(',')){ 
				record.put(fieldName,String.valueOf(value).length()>maxlen?valueString:value); 
			} 
		}
		return record; 
	} 
	/** 
	* Name: setAPIrequestHandlerId 
	* Purpose: To set the API Payload Handler Id. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public SObject setAPIrequestHandlerId(Id apiRequestHandler){  
        this.apiRequestHandlerId = apiRequestHandler;  
        return put('API_Payload_Handler__c',255,this.apiRequestHandlerId);  
    }  
	/** 
	* Name: useBlobBody 
	* Purpose: To indicate whether to use the alternative Type serving the same purpose as the request body. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public SObject useBlobBody (Boolean useBlobBody) {     
        this.useBlobBody = useBlobBody;     
        return record;     
    }   
	/** 
	* Name: setEndpoint 
	* Purpose: Universal Resource Locator of the endpoint URL that the API request is directed at. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public SObject setEndpoint (String endpoint) {     
        this.endpoint = mask(endpoint);     
        return put(log.getEndPointField(),log.getEndPointFieldSize(),this.endpoint);     
    }   
	/** 
	* Name: addHeaderParam 
	* Purpose: Avenue to allow headers to be set for the API request. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public SObject addHeaderParam(String param, String value) {     
        this.headers.put(param, value);     
        return record;     
    }   
	/** 
	* Name: addHeaders 
	* Purpose: Avenue to set all the headers for the API request. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public SObject addHeaders(Map<String, String> headers) {     
        this.headers.putAll(headers);     
        return record;     
    }   
	/** 
	* Name: setBodyRequest 
	* Purpose: Avenue to set the request body of this API Request. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public SObject setBodyRequest (String bodyRequest) {     
        this.bodyRequest = mask(bodyRequest);     
        return put(log.getRequestBodyField(),log.getRequestBodyFieldSize(),this.bodyRequest);     
    }   
	/** 
	* Name: setEndpoints 
	* Purpose: To allow multiple endpoints to be stored within this API Request. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public SObject setEndpoints(List<String> endpoints) {    
        this.endpoints = endpoints;     
        return record;     
    }     
	/** 
	* Name: setRequestBodies 
	* Purpose: To allow multiple request bodies to be stored within this API Request . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public SObject setRequestBodies(List<String> requestBodies) {    
        this.requestBodies = requestBodies;     
        return record;     
    }   
	/** 
	* Name: setBlobBodyRequest 
	* Purpose: Avenue to set the Request Body of an alternative type . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public SObject setBlobBodyRequest (Blob blobBodyRequest) {     
        this.blobBodyRequest = blobBodyRequest;     
        return record;     
    }     
	/** 
	* Name: setName 
	* Purpose: Avenue to set a name for the certificate that could be used for this API Request . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public SObject setName (String name) {     
        this.name = mask(name);     
        return put(log.getNameField(),log.getNameFieldSize(),this.name);     
    }         
	/** 
	* Name: setMethod 
	* Purpose: To set the method ie GET, PUT, POST for the API Request . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public SObject setMethod (String method) {     
        this.method = method;     
        return put(log.getMethodField(),log.getMethodFieldSize(),method);     
    }   
	/** 
	* Name: setResponseBody 
	* Purpose: If required, save the response of this request as a parameter . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public SObject setResponseBody(String responseParameter) {   
		this.responseBody = mask(responseParameter); 
        return put(log.getResponseBodyField(),log.getResponseBodyFieldSize(),this.responseBody);   
    } 
	/** 
	* Name: mask 
	* Purpose: 	To mask certain characters within the String. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public String mask(String responseParameter){ 
		String maskResponse,maskSignature; 
		if(String.isBlank(responseParameter)){ 
			responseParameter = ''; 
		}else{ 
			if(maskStrings){ 
				maskResponse = responseParameter.substringBetween('"access_token":"','"');   
				if(String.isBlank(maskResponse)){  
					maskResponse = responseParameter.substringBetween('"AccessToken":"','"');   
				}  
				maskSignature = responseParameter.substringBetween('"signature":"','"');  
			} 
		} 
		return responseParameter.replace(maskResponse==null?'xxxxxxxx':maskResponse,'xxxxxxxx').replace(maskSignature==null?'xxxxxxxx':maskSignature,'xxxxxxxx');  
	}   
	/** 
	* Name: setStatusCode 
	* Purpose: To set a status code of the response received from this API Request . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public SObject setStatusCode(Integer statusCodeParameter){   
        this.statusCode = statusCodeParameter;   
        record.put(log.getStatusCodeField(),this.statusCode);   
        return record; 
    }       
	/** 
	* Name: setParameter 
	* Purpose: To set any additional required parameters for this API Request . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public SObject setParameter(Object inputParameter){   
        this.parameter = inputParameter;   
        return record;   
    }    
	/** 
	* Name: setMasking 
	* Purpose: To indicate whether certain strings need to be masked.. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public SObject setMasking(Boolean mask){  
        this.maskStrings = mask;  
        return record;  
    }  
	/** 
	* Name: getMasking 
	* Purpose: To indicate whether certain strings need to be masked.. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public Boolean getMasking(){  
        return this.maskStrings;  
    }  
	/** 
	* Name: getEndpoint 
	* Purpose: To retrieve the Universal Resource Locator (endpoint URL) of this API Request . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public String getEndpoint() {     
        return endpoint;     
    }   
	/** 
	* Name: getEndpoints 
	* Purpose: To allow multiple endpoints to be stored within this API Request . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public List<String> getEndpoints() {    
        this.endpoints = endpoints;     
        return endpoints;     
    }       
	/** 
	* Name: getHeaders 
	* Purpose: To retrieve the headers for this API request . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public Map<String, String> getHeaders () {     
        return headers;     
    }   
	/** 
	* Name: getBodyRequest 
	* Purpose: To retrieve the request body of this API Request. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public String getBodyRequest () {     
        return bodyRequest;     
    }    
	/** 
	* Name: getRequestBodies 
	* Purpose: To retrieve a list of request bodies of this API Request . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public List<String> getRequestBodies(){   
        return requestBodies;   
    }   
	/** 
	* Name: getBlobBodyRequest 
	* Purpose: To retrieve the request body of an alternative type . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public Blob getBlobBodyRequest () {     
        return blobBodyRequest;     
    }     
	/** 
	* Name: getName 
	* Purpose: To retrieve the name of the certificate that may be used in this API Request . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public String getName () {     
        return name;     
    }     
	/** 
	* Name: getMethod 
	* Purpose: To retrieve the method ie GET, PUT, POST method for this API Request . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public String getMethod () {     
        return method;     
    }     
	/** 
	* Name: useBlobBody 
	* Purpose: To find out whether blob request bodies are being used for this API Request . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public boolean getUseBlobBody() {     
        return useBlobBody;     
    }   
	/** 
	* Name: getResponseBody 
	* Purpose: If required, save the response of this request as a parameter . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public String getResponseBody() {     
        return responseBody;   
    }       
	/** 
	* Name: getStatusCode 
	* Purpose: To retrieve the status code of this API Request . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public Integer getStatusCode(){   
        return statusCode;   
    }   
	/** 
	* Name: getParamater 
	* Purpose: To retrieve the additional parameter used within this API Request . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public Object getParameter(){   
        return parameter;   
    }   
	/** 
	* Name: getAPIrequestHandlerId 
	* Purpose: To retrieve the API Payload Handler Id . 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public Id getAPIrequestHandlerId(){  
        return apiRequestHandlerId;  
    }  
}