public class AccountUtils {
    public static List<Account> accountsByState(String state) {
        return [SELECT id,Name FROM Account WHERE BillingState=:state];
    }
}