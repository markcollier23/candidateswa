//Author: Mark Collier 
//Purpose: To test that we have achieved the following goal: 
//	-  To predict the balance of your Superannuation in the future. 
@isTest 
public class SuperCalculatorTriggerTest{ 
	//The purpose of this method is to ensure tests are covered and errors in the trigger are detected early. 
	@isTest 
	public static void insertTest(){ 
		SuperCalculatorCheckRecursive.clear(); 
		SuperannuationCalculator__c record; 
		Test.startTest();//All dml statements should be isolated within here in case there are future, start, execute or finish methods being called within the trigger. 
			record = new SuperCalculatorTriggerDataFactory('SuperCalculatorTriggerDataFactory').insertSuperannuationCalculator(); 
		Test.stopTest();//This will wait for the code above to finish even if there exists a seperate process or thread inside then it will execute the code before afterwards: 
		//TODO: Assertion Statements 
	} 
	//The purpose of this method is to ensure tests are covered and errors in the trigger are detected early. 
	@isTest 
	public static void updateTest(){ 
		SuperCalculatorCheckRecursive.clear(); 
		SuperannuationCalculator__c record; 
		Test.startTest();//All dml statements should be isolated within here in case there are future, start, execute or finish methods being called within the trigger. 
			record = new SuperCalculatorTriggerDataFactory('SuperCalculatorTriggerDataFactory').insertSuperannuationCalculator(); 
			update record; 
		Test.stopTest();//This will wait for the code above to finish even if there exists a seperate process or thread inside then it will execute the code before afterwards: 
		//TODO: Assertion Statements 
	} 
	//The purpose of this method is to test the randomness of SuperCalculatorTriggerDataFactory.cls 
	@isTest 
	public static void testDataFactory(){ 
		SuperCalculatorTriggerDataFactory dataFactory = new SuperCalculatorTriggerDataFactory('SuperCalculatorTriggerDataFactory'); 
		SuperannuationCalculator__c record = dataFactory.insertSuperannuationCalculator(); 
		System.debug(record); 
		System.debug(dataFactory.getRandomInteger(30)); 
		System.debug(dataFactory.getRandomString(30)); 
		System.debug(dataFactory.getRandomDate(30)); 
		System.debug(dataFactory.getRandomTime(30)); 
		System.debug(dataFactory.getRandomDateTime(30)); 
		System.debug(dataFactory.getRandomInteger(24)); 
		System.debug(dataFactory.getRandomString(24)); 
		System.debug(dataFactory.getRandomDate(24)); 
		System.debug(dataFactory.getRandomTime(24)); 
		System.debug(dataFactory.getRandomDateTime(24)); 
		System.debug(dataFactory.SetOf(record.Id)); 
		System.debug(dataFactory.SetOf(record.Name)); 
		System.debug(dataFactory.ListOf(record.Id)); 
		System.debug(dataFactory.ListOf(record.Name)); 
	} 
}