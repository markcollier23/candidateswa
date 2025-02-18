@IsTest
public class AddPrimaryContactTest {
	@testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        for(Integer i=0;i<50;i++){
            accounts.add(new Account(Name='Account '+i,BillingState='NY'));
            accounts.add(new Account(Name='Account '+i,BillingState='CA'));
        }
        insert accounts;
    }
    static testmethod void testQueueable(){
        AddPrimaryContact apc = new AddPrimaryContact(new Contact(MailingState='CA'),'CA');
        Test.startTest();
        	System.enqueueJob(apc);
        Test.stopTest();
        
    }
}