public class Tax implements Formula{
    public Decimal getBalance(Decimal currentBalance, Balance__c balanceEntry, SuperannuationCalculator__c calculator){
        Decimal taxPercent = SuperCalculatorCheckRecursive.percent(calculator.Tax__c);
        balanceEntry.afterTax__c = currentBalance - (balanceEntry.afterContribution__c - balanceEntry.start__c)*taxPercent;
        return balanceEntry.afterTax__c;
    }
}