@IsTest
public class AccountProcessorTest {
    @IsTest
    private static void checkAll(){
        Test.startTest();
        	Account acct = new Account(Name='Test Account', Number_Of_Contacts__c = 0);
        	insert acct;
            Contact c = new Contact(LastName='Greg',AccountId = acct.Id);
            insert c;
            AccountProcessor.countContacts(new List<Id> {acct.Id});
        Test.stopTest();
        Account updatedAcct = [SELECT Number_Of_Contacts__c FROM Account];
        System.assertEquals(1,updatedAcct.Number_Of_Contacts__c);
    }
}