//Author: Mark Collier 
//Purpose: To predict the balance of your Superannuation in the future. 
trigger SuperCalculator on SuperannuationCalculator__c (after insert, after update){ 
	new SuperCalculatorTriggerHandler(Trigger.old,Trigger.new); 
}