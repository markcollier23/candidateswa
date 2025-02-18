//Author: Mark Collier 
//Purpose: //Purpose: To insert, update or delete an Account.  
public class AccountDataRaptor extends AccountDataRaptorLoad{  
	public Map<Id,Account> getIds(JSONObject records){ 
		return getIds(JSONtoList(records)); 
	} 
	public Map<Id, Account> getIds(List<Account> records){ 
		return new Map<Id, Account>(records); 
	} 
	public Map<String,Id> getDandbCompanyNames(){ 
		Map<String,DandbCompany> recordMap = AccountDataRaptorExtract.getDandbCompanyNames(); 
		Map<String,Id> recordIdMap = new Map<String,Id>(); 
		for(String recordName:recordMap.keySet()){ 
			recordIdMap.put(recordName,recordMap.get(recordName).Id); 
		} 
		return recordIdMap; 
	} 
	public Map<String,Account> getDandbCompanyNames(List<Account> records){ 
		Map<String,Id> recordMap = getDandbCompanyNames(); 
		Map<Id,Account> recordIdMap = getDandbCompanyIds(records); 
		Map<String,Account> result = new Map<String,Account>(); 
		for(String recordName:recordMap.keySet()){ 
			result.put(recordName,recordIdMap.get(recordMap.get(recordName))); 
		} 
		return result; 
	} 
	public Map<String,Account> getDandbCompanyNames(JSONObject records){ 
		return getDandbCompanyNames(JSONtoList(records)); 
	} 
	public Map<Id,Account> getDandbCompanyIds(JSONObject records){ 
		return getDandbCompanyIds(JSONtoList(records)); 
	} 
	public Map<Id,Account> getDandbCompanyIds(List<Account> records){ 
		Map<Id,Account> recordMap = new Map<Id,Account>(); 
		for(Account record:records){ 
			recordMap.put(record.DandbCompanyId,record); 
		} 
		return recordMap; 
	} 
	public Map<String,Account> getNames(JSONObject records){ 
		return getNames(JSONtoList(records)); 
	} 
	public Map<String,Account> getNames(List<Account> records){ 
		Map<String,Account> recordMap = new Map<String,Account>(); 
		for(Account record:records){ 
			recordMap.put(record.Name,record); 
		} 
		return recordMap; 
	} 
	public Map<String,Account> getRegioncs(JSONObject records){ 
		return getRegioncs(JSONtoList(records)); 
	} 
	public Map<String,Account> getRegioncs(List<Account> records){ 
		Map<String,Account> recordMap = new Map<String,Account>(); 
		for(Account record:records){ 
			recordMap.put(record.Region__c,record); 
		} 
		return recordMap; 
	} 
	public Map<String,Account> getPhones(JSONObject records){ 
		return getPhones(JSONtoList(records)); 
	} 
	public Map<String,Account> getPhones(List<Account> records){ 
		Map<String,Account> recordMap = new Map<String,Account>(); 
		for(Account record:records){ 
			recordMap.put(record.Phone,record); 
		} 
		return recordMap; 
	} 
}