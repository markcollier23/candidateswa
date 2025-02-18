public interface Formula{
    Decimal getBalance(Decimal currentBalance, Balance__c balanceEntry, SuperannuationCalculator__c calculator);
}