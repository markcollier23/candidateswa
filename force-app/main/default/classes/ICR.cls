public class ICR implements Formula{
    public Decimal getBalance(Decimal currentBalance, Balance__c balanceEntry, SuperannuationCalculator__c calculator){
        Decimal icrPercent = SuperCalculatorCheckRecursive.percent(calculator.ICR__c);
        balanceEntry.afterICR__c = currentBalance-(currentBalance-balanceEntry.afterContribution__c)*icrPercent;
        return balanceEntry.afterICR__c;
    }
}