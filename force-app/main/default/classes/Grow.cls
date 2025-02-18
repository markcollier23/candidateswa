public class Grow implements Formula{
    public Decimal getBalance(Decimal currentBalance, Balance__c balanceEntry, SuperannuationCalculator__c calculator){
        Decimal growthRate = SuperCalculatorCheckRecursive.percent(calculator.GrowthRate__c);
        balanceEntry.afterGrowth__c = currentBalance*(1+growthRate);
        return balanceEntry.afterGrowth__c;
    }
}