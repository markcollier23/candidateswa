public class Contribution implements Formula{
    public Decimal getBalance(Decimal currentBalance, Balance__c balanceEntry, SuperannuationCalculator__c calculator){
        //System.debug(currentBalance+','+calculator.Contribution__c);
        balanceEntry.afterContribution__c = currentBalance+calculator.Contribution__c;
        return balanceEntry.afterContribution__c;
    }
}