/** 
* Name: SitecoreCustomerService 
* Purpose: To allow an API request to be submitted in Salesforce in order to create Account records. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   19/11/2024     99354076       Account          
* ------------------------------------------------------------- 
**/ 
@RestResource(urlMapping='/SitecoreCustomerService/') 
global with sharing class SitecoreCustomerService{ 
	private DateTime x = null; 
	/** 
	* Name: SitecoreCustomerService 
	* Purpose: Constructor used to control and direct the neccessary operations for this Apex Class. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Constructor was created.  
	* ---------------------------------------------------------------------- 
	**/ 
	global SitecoreCustomerService(DateTime xParameter){ 
		x = xParameter; 
	} 
	@HttpPost 
	/** 
	* Name: post 
	* Purpose: Method where the API request would be submitted under the POST method.. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
	global static void post(){ 
		RestResponse response = RestContext.response; 
		String req = System.RestContext.request.requestBody.toString(); 
		String endpoint = URL.getOrgDomainURL().toExternalForm()+'/services/apexrest/SitecoreCustomerService/'; 
		String res; 
		try{ 
			res = '{"status":"Success"}'; 
			response.statusCode = 200; 
			IntegrationLogClass.createLog(req,res,res,'Success',200,endpoint,'POST'); 
		}catch(Exception e){ 
			res = '{"errorMessage":"'+e.getMessage()+'","stackTrace":"'+e.getStackTraceString()+'"}'; 
			response.statusCode = 500; 
			IntegrationLogClass.createLog(req,res,res,'Fail',500,endpoint,'POST'); 
		} 
		response.responseBody = Blob.valueOf(res); 
	} 
}