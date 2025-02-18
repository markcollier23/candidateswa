/** 
* Name: RestServiceClient 
* Purpose: Interface to handle the necessary DML or other operations before and after an API request is submitted. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
public Interface RestServiceClient{ 
	UtilHttpClass beforeAPIRequest(UtilHttpClass payload); 
	UtilHttpClass afterAPIRequest(UtilHttpClass payload); 
	List<UtilHttpClass> finalAPIRequests(List<UtilHttpClass> payload); 
}