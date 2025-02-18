public class AccountProcessor {
	@future
    public static void countContacts(List<Id> accountIds){
        List <Account> accts = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIds];
        for(Account a : accts){
            a.Number_Of_Contacts__c = a.Contacts.size();
        }
        update accts;
    }
}