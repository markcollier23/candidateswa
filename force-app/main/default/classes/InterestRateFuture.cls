//Author: Mark Collier 
//Purpose: To ensure latest bank details are updated based on the interest rates they provide in saving accounts. 
public class InterestRateFuture{ 
	//Method available for use by a process builder 
	@InvocableMethod 
	public static void invoke(List<Interest_Rate__c> records){
        Set<Id> ids = new Set<Id>();
        for(Interest_Rate__c rate:records){
            ids.add(rate.Id);
        }
		futureMethod(ids); 
	} 
	//Future method which utilises variables contained in InterestRateCheckRecursive to address the following: 
		//Purpose: To ensure latest bank details are updated based on the interest rates they provide in saving accounts. 
	@future 
	public static void futureMethod(Set<Id> rateIds){ 
		Map<String,Interest_Rate__c> rateMap = getInterestRateMap(new List<Id>(rateIds));
		System.debug('[InterestRateFuture.futureMethod] rateMap = '+rateMap);
        Map<String,Bank__c> bankMap = getBankMap(rateMap.values());
		List<Interest_Rate__c> rates = new List<Interest_Rate__c>();
		for(Bank__c bank:bankMap.values()){
			System.debug('[InterestRateFuture.futureMethod][FOR bank in banks] bank = '+bank);
			Interest_Rate__c rate = rateMap.get(bank.URL__c);
            if(rate!=null){
				System.debug('[InterestRateFuture.futureMethod][FOR bank in banks] rateMap.get(bank.URL__c) = '+rateMap.get(bank.URL__c));
                rate.Bank__c = bank.Id;
                rates.add(rate);
				System.debug('[InterestRateFuture.futureMethod][FOR bank in banks] rates = '+rates);
            }
		}
		update rates;
	}
	public static Map<String,Interest_Rate__c>  getInterestRateMap(List<Id> rateIds){
		List<Interest_Rate__c> rates = [SELECT Id, URL__c, Button_URL__c, Base_Interest__c, Conditions__c, Date__c, Saving_Account__c, Total_Interest__c,Bank__c FROM Interest_Rate__c WHERE Id IN : rateIds];
		Map<String,Interest_Rate__c> rateMap = new Map<String,Interest_Rate__c>();
		for(Interest_Rate__c interestRate:rates){
			String buttonURL = '/';
			if(interestRate.Button_URL__c!=null){
				buttonURL = interestRate.Button_URL__c;
			}
			buttonURL = buttonURL.replace(' ','%20');
			String slash = '/';
			if(buttonURL.charAt(0)==slash.charAt(0)){
				interestRate.URL__c = 'https://www.canstar.com.au'+buttonURL;
			}else{
				interestRate.URL__c = buttonURL;
			}
			rateMap.put(interestRate.URL__c,interestRate);
		}
		update rateMap.values();
		return rateMap;
	}
    public static Map<String,Bank__c> getBankMap(List<Interest_Rate__c> rates){
		//System.debug('[InterestRateFuture.getBanks] rates = '+rates);
		List<Bank__c> banks = [SELECT Id,URL__c FROM Bank__c];
		Map<String,Bank__c> bankMap = new Map<String,Bank__c>();
		for(Bank__c bank:banks){
			bankMap.put(bank.URL__c,bank);
		}
		//System.debug('[InterestRateFuture.getBanks] bankMap = '+bankMap);
        for(Interest_Rate__c rate:rates){
			Bank__c bank;
			if(bankMap.containsKey(rate.URL__c)){
				bank = getBank(rate, bankMap.get(rate.URL__c));
			}else{
				bank = getBank(rate, new Bank__c());
			}
            bankMap.put(rate.URL__c,bank);
        }
		upsert bankMap.values();
        return bankMap;
    }
	public static Bank__c getBank(Interest_Rate__c rate,Bank__c bank){
		bank.URL__c = rate.URL__c;
		bank.Base_Interest__c = rate.Base_Interest__c;
		bank.Conditions__c = rate.Conditions__c;
		bank.Date__c = rate.Date__c;
		bank.Saving_Account__c = rate.Saving_Account__c;
		bank.Total_Interest__c = rate.Total_Interest__c;
		return bank;
	} 
}