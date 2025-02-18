public class AddPrimaryContact implements Queueable {
    private Contact record;
    private String state;
    
    public AddPrimaryContact(Contact record, String state){
        this.record = record;
        this.state = state;
    }
    
    public void execute(QueueableContext context){
        List <Account> accounts = [SELECT BillingState FROM Account WHERE BillingState = :this.state LIMIT 200];
        List <Contact> contacts = new List<Contact>();
        for(Account a:accounts){
            Contact c = this.record.clone();
            c.AccountId = a.id;
            contacts.add(c);
        }
        insert contacts;
    }
}