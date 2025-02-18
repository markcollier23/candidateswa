/** 
* Name: IntegrationLog 
* Purpose: Interface for interacting with this orgs API Request logging object. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
public interface IntegrationLog{ 
	SObject getNewRecord(HttpRequest req,HttpResponse res,String message,Boolean saveLog); 
	String getNameField(); 
	Integer getNameFieldSize(); 
	String getStatusCodeField(); 
	Integer getStatusCodeFieldSize(); 
	String getEndpointField(); 
	Integer getEndpointFieldSize(); 
	String getResponseBodyField(); 
	Integer getResponseBodyFieldSize(); 
	String getRequestBodyField(); 
	Integer getRequestBodyFieldSize(); 
	String getMethodField(); 
	Integer getMethodFieldSize(); 
}