/** 
* Name: httpUtilityClass 
* Purpose: An object oriented apex class for holding API request details. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   19/11/2024     99354076       All              
* ------------------------------------------------------------- 
**/ 
public class httpUtilityClass {    
    private String endpoint;    
    private Map<String, String> headers = new Map<String, String>();    
    private String bodyRequest;    
    private Blob blobBodyRequest;    
    private String certificateName;    
    private String method;    
    private boolean useBlobBody = false;  
    private Boolean logAPIRequest = true;  
    private String responseBody;  
    private Integer statusCode = 500;  
    private Object parameter; 
    private Id apiRequestHandlerId; 
    private List<String> payloads = new List<String>();  
	/** 
	* Name: setAPIrequestHandlerId 
	* Purpose: To set the API Payload Handler Id. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public httpUtilityClass setAPIrequestHandlerId(Id apiRequestHandler){ 
        this.apiRequestHandlerId = apiRequestHandler; 
        return this; 
    } 
	/** 
	* Name: useBlobBody 
	* Purpose: To indicate whether to use the alternative Type serving the same purpose as the request body. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public httpUtilityClass useBlobBody (Boolean useBlobBody) {    
        this.useBlobBody = useBlobBody;    
        return this;    
    }  
	/** 
	* Name: setEndpoint 
	* Purpose: Universal Resource Locator of the endpoint URL that the API request is directed at. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public httpUtilityClass setEndpoint (String endpoint) {    
        this.endpoint = endpoint;    
        return this;    
    }  
	/** 
	* Name: addHeaderParam 
	* Purpose: Avenue to allow headers to be set for the API request. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public httpUtilityClass addHeaderParam(String param, String value) {    
        this.headers.put(param, value);    
        return this;    
    }  
	/** 
	* Name: addHeaders 
	* Purpose: Avenue to set all the headers for the API request. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public httpUtilityClass addHeaders(Map<String, String> headers) {    
        this.headers.putAll(headers);    
        return this;    
    }  
	/** 
	* Name: setBodyRequest 
	* Purpose: Avenue to set the request body of this API Request. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public httpUtilityClass setBodyRequest (String bodyRequest) {    
        this.bodyRequest = bodyRequest;    
        return this;    
    }    
	/** 
	* Name: setRequestBodies 
	* Purpose: To allow multiple request bodies to be stored within this API Request. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public httpUtilityClass setRequestBodies(List<String> requestBodies) {    
        this.payloads = requestBodies;    
        return this;    
    }  
	/** 
	* Name: setBlobBodyRequest 
	* Purpose: Avenue to set the Request Body of an alternative type. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public httpUtilityClass setBlobBodyRequest (Blob blobBodyRequest) {    
        this.blobBodyRequest = blobBodyRequest;    
        return this;    
    }    
	/** 
	* Name: setCertificateName 
	* Purpose: Avenue to set a name for the certificate that could be used for this API Request. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public httpUtilityClass setCertificateName (String certificateName) {    
        this.certificateName = certificateName;    
        return this;    
    }        
	/** 
	* Name: setMethod 
	* Purpose: To set the method i.e. GET, PUT, POST for the API Request. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public httpUtilityClass setMethod (String method) {    
        this.method = method;    
        return this;    
    }  
	/** 
	* Name: setResponseBody 
	* Purpose: If required, save the response of this request as a parameter. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public httpUtilityClass setResponseBody(String responseParameter) {    
        this.responseBody = responseParameter;    
        return this;    
    }  
	/** 
	* Name: setStatusCode 
	* Purpose: To set a status code of the response received from this API Request. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public httpUtilityClass setStatusCode(Integer statusCodeParameter){  
        this.statusCode = statusCodeParameter;  
        return this;  
    }      
	/** 
	* Name: setParameter 
	* Purpose: To set any additional required parameters for this API Request. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public httpUtilityClass setParameter(Object inputParameter){  
        this.parameter = inputParameter;  
        return this;  
    }   
	/** 
	* Name: getEndpoint 
	* Purpose: To retrieve the Universal Resource Locator (endpoint URL) of this API Request. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public String getEndpoint () {    
        return endpoint;    
    }      
	/** 
	* Name: getHeaders 
	* Purpose: To retrieve the headers for this API request. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public Map<String, String> getHeaders () {    
        return headers;    
    }  
	/** 
	* Name: getBodyRequest 
	* Purpose: To retrieve the request body of this API Request. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public String getBodyRequest () {    
        return bodyRequest;    
    }   
	/** 
	* Name: getRequestBodies 
	* Purpose: To retrieve a list of request bodies of this API Request. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public List<String> getRequestBodies(){  
        return payloads;  
    }  
	/** 
	* Name: getBlobBodyRequest 
	* Purpose: To retrieve the request body of an alternative type. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public Blob getBlobBodyRequest () {    
        return blobBodyRequest;    
    }    
	/** 
	* Name: getCertificateName 
	* Purpose: To retrieve the name of the certificate that may be used in this API Request. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public String getCertificateName () {    
        return certificateName;    
    }    
	/** 
	* Name: getMethod 
	* Purpose: To retrieve the method i.e. GET, PUT, POST method for this API Request. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public String getMethod () {    
        return method;    
    }    
	/** 
	* Name: useBlobBody 
	* Purpose: To find out whether blob request bodies are being used for this API Request. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public boolean getUseBlobBody() {    
        return useBlobBody;    
    }  
	/** 
	* Name: getResponseBody 
	* Purpose: If required, save the response of this request as a parameter. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public String getResponseBody() {    
        return responseBody;  
    }      
	/** 
	* Name: getStatusCode 
	* Purpose: To retrieve the status code of this API Request. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public Integer getStatusCode(){  
        return statusCode;  
    }  
	/** 
	* Name: getParamater 
	* Purpose: To retrieve the additional parameter used within this API Request. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public Object getParameter(){  
        return parameter;  
    }  
	/** 
	* Name: getAPIrequestHandlerId 
	* Purpose: To retrieve the API Payload Handler Id. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
    public Id getAPIrequestHandlerId(){ 
        return apiRequestHandlerId; 
    } 
}