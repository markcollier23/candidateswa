public class AccountHandler {
    public static Account insertNewAccount(String nap){
        try {
            Account acct = new Account(Name=nap);
            // Insert the account 
            insert acct;
            return acct;
		} catch (DmlException e) {
   			 return null;
		}
    }
}