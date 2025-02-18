@isTest
public class AccountManagerTest {
    @isTest static void test(){
        id accountId = AccountManager.createAccount('Josef');
        RestRequest request = new RestRequest();
        request.requestURI = 'https://resourceful-raccoon-fu12p1-dev-ed.salesforce.com/services/apexrest/'+accountId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account a = AccountManager.getAccount();
        System.assert(a!=null,'Account is null');
        System.assertEquals('Josef', a.name);
    }
}