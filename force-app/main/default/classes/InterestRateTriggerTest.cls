//Author: Mark Collier 
//Purpose: To test that we have achieved the following goal: 
//	-  To ensure latest bank details are updated based on the interest rates they provide in saving accounts. 
@isTest 
public class InterestRateTriggerTest{ 
	//The purpose of this method is to ensure tests are covered and errors in the trigger are detected early. 
	@isTest
	public static void insertTest(){ 
		InterestRateCheckRecursive.clear(); 
        Test.startTest();
			Interest_Rate__c record = new InterestRateTriggerDataFactory('InterestRateTriggerDataFactory').insertInterestRate(); 
			Interest_Rate__c withURL = new InterestRateTriggerDataFactory('InterestRateTriggerDataFactory').retrieveInterestRate();
			withURL.Button_URL__c = '/details?distributor=canstar&table=savingsaccounts&prod_id=-17212351454951650982&co_code=ONE&profile=Bonus Saver&amount=1000';
			insert withURL;
		Test.stopTest();
		new doQuery();
	} 
	public class doQuery extends Random{
		public doQuery(){
			List<Interest_Rate__c> rates = [SELECT Id, Base_Interest__c, Conditions__c, Date__c, Saving_Account__c, Total_Interest__c,Bank__c FROM Interest_Rate__c];
			System.debug('rates = '+rates);
		}
	}
}