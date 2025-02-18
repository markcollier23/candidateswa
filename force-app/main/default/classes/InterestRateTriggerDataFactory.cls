//Author: Mark Collier 
//Purpose: To prepare the necessary data required for a single Interest_Rate__c record. 
public class InterestRateTriggerDataFactory extends Random{ 
	//Allows you to control the nature of how random the variable values ought to be. 
	public InterestRateTriggerDataFactory(String random){ 
		randomString = random; 
	} 
	//The purpose of the method below is to allow the retrieval of a Interest_Rate__c record which contains a Saleforce Id. 
	public Interest_Rate__c insertInterestRate(){ 
		Interest_Rate__c instance = retrieveInterestRate(); 
		insert instance; 
		return instance; 
	} 
	//The purpose of the method below is to allow the retrieval of a Interest_Rate__c record which does not contain a Saleforce Id. 
	public Interest_Rate__c retrieveInterestRate(){ 
		Interest_Rate__c instance = new Interest_Rate__c();
		return instance; 
	} 
}