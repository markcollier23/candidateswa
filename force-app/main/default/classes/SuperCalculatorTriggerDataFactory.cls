//Author: Mark Collier 
//Purpose: To prepare the necessary data required for a single SuperannuationCalculator__c record. 
public class SuperCalculatorTriggerDataFactory extends Random{ 
	//Allows you to control the nature of how random the variable values ought to be. 
	public SuperCalculatorTriggerDataFactory(String random){ 
		randomString = random; 
	} 
	//The purpose of the method below is to allow the retrieval of a SuperannuationCalculator__c record which contains a Saleforce Id 
	public SuperannuationCalculator__c insertSuperannuationCalculator(){ 
		SuperannuationCalculator__c instance = retrieveSuperannuationCalculator(); 
		insert instance; 
		return instance; 
	} 
	//The purpose of the method below is to allow the retrieval of a SuperannuationCalculator__c record which does not contain a Saleforce Id 
	public SuperannuationCalculator__c retrieveSuperannuationCalculator(){ 
		SuperannuationCalculator__c instance = new SuperannuationCalculator__c(); 
		return instance; 
	} 
}