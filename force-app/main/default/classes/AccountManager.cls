@RestResource(urlMapping='/Account/*')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        String accountID = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        return [SELECT id,name FROM Account WHERE id= :accountID];
    }
    @HttpPost
    global static ID createAccount(String name){
        Account accountRecord = new Account(Name=name);
        insert accountRecord;
        Contact contactRecord = new Contact(lastName=name, AccountId = accountRecord.id);
        insert contactRecord;
        return accountRecord.Id;
    }
}