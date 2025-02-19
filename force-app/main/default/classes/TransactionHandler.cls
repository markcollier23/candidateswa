public class TransactionHandler {
    public TransactionHandler(){
        absoluteAll();
    }
    public List<Transactions__c> query(){
        return [SELECT Debit__c FROM Transactions__c];
    }
    public void absoluteAll(){
        List<Transactions__c> empty = new List<Transactions__c>();
        for(Transactions__c cost:query()){
            if(cost.Debit__c<0){
                cost.Debit__c = - cost.Debit__c;
                empty.add(cost);
            }
        }
        update empty;
    }
}