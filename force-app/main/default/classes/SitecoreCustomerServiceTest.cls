/** 
* Name: SitecoreCustomerServiceTest 
* Purpose: To test if the purpose of SitecoreCustomerService.cls has been achieved. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   19/11/2024     99354076       Account          
* ------------------------------------------------------------- 
**/ 
@isTest 
public class SitecoreCustomerServiceTest { 
	/** 
	* Name: performCallout 
	* Purpose: To ensure the SitecoreCustomerService.post method is fully covered and tested. 
	*  
	* Who            When           Ref            What             
	* ------------------------------------------------------------- 
	* Mark Collier   19/11/2024     99354076       Account          
	* ------------------------------------------------------------- 
	**/ 
	public static void performCallout(){ 
		String payload = ''; 
		String baseUrl = URL.getOrgDomainURL().toExternalForm(); 
		RestRequest req = new RestRequest(); 
		RestResponse res = new RestResponse(); 
		req.requestURI = baseUrl + '/services/apexrest/SitecoreCustomerService/'; 
		req.httpMethod = 'POST'; 
		req.requestBody = Blob.valueof(payload); 
		RestContext.request = req; 
		RestContext.response= res; 
		SitecoreCustomerService.post(); 
	} 
}