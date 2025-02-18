//Author: Mark Collier 
//Purpose: To predict the balance of your Superannuation in the future. 
public class SuperCalculatorTriggerHandler{ 
	public List<SuperannuationCalculator__c> oldList = new List<SuperannuationCalculator__c>();//This variable is available for use so that we can easily retrieve what the records were before the transaction took place. 
	public List<SuperannuationCalculator__c> newList = new List<SuperannuationCalculator__c>();//This variable is available for use so that we can easily retrieve what the records were after the transaction took place. 
	public SuperCalculatorTriggerHandler(List<SuperannuationCalculator__c> oldListParameter,List<SuperannuationCalculator__c> newListParameter){ 
		oldList = oldListParameter; 
		newList = newListParameter; 
		main(); 
	} 
	//This method is part of the initialisation for this class and will be executed when the class is initialised. 
	public void main(){ 
		if(SuperCalculatorCheckRecursive.TriggerOn){
			delete [SELECT Id FROM Balance__c WHERE Calculator__c IN: new Map<Id,SuperannuationCalculator__c>(newList).keySet()];
			List<Balance__c> balances = new List<Balance__c>();
			for(SuperannuationCalculator__c calc:newList){
				if(!SuperCalculatorCheckRecursive.setOfIds.contains(calc.Id)){
					Balance__c balance = new Balance__c(start__c = calc.StartingBalance__c, Calculator__c = calc.Id);
					for(String balanceName:getBalanceEntryNames(calc)){
						balance.Name = balanceName;
						Decimal finalBalance = fillOutBalance(balance,new GenerateCalculationSteps(calc));
						balances.add(balance);
						balance = new Balance__c(Calculator__c = calc.Id, start__c=finalBalance);
					}
				}
			}
			insert balances;
		}	
	}
	public Decimal fillOutBalance(Balance__c currentBalance,GenerateCalculationSteps orderOfCalculation){
		Decimal balanceInc = currentBalance.start__c;
		for(String step:orderOfCalculation.steps){
			Formula operation = orderOfCalculation.mapOfSteps.get(step);
			balanceInc = operation.getBalance(balanceInc,currentBalance, orderOfCalculation.calculator);
		}
		return balanceInc;
	}
	public List<String> getBalanceEntryNames(SuperannuationCalculator__c calculator){
		DateList dates = new DateList();
        Integer m = dates.allMonthsMap.get(calculator.startingMonth__c);
        Integer startingYear = (Integer)calculator.startingYear__c;
        Integer size = (Integer)calculator.sizeOfBalance__c;
		DateHandler dateHandle = dates.mapOfDates.get(calculator.startingMonth__c);
		System.debug('m = '+m+'; sy = '+startingYear+';size = '+size);
        return dateHandle.getList(startingYear, m, size);
	}
}