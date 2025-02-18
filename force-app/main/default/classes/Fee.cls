public class Fee implements Formula{
    public Decimal getBalance(Decimal currentBalance, Balance__c balanceEntry, SuperannuationCalculator__c calculator){
        Decimal feePercent = SuperCalculatorCheckRecursive.percent(calculator.Fee__c);
        balanceEntry.afterFee__c = currentBalance*(1-feePercent)-calculator.FlagFee__c;
        return balanceEntry.afterFee__c;
    }
}