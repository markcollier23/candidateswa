//Author: Mark Collier 
//Purpose: //Purpose: To insert, update and delete Contact records via JSON.  
public class ContactDataRaptor extends ContactDataRaptorLoad{  
	public Map<Id,Contact> getIds(JSONObject records){ 
		return getIds(JSONtoList(records)); 
	} 
	public Map<Id, Contact> getIds(List<Contact> records){ 
		return new Map<Id, Contact>(records); 
	} 
	public Map<String,Id> getAccountNames(){ 
		Map<String,Account> recordMap = ContactDataRaptorExtract.getAccountNames(); 
		Map<String,Id> recordIdMap = new Map<String,Id>(); 
		for(String recordName:recordMap.keySet()){ 
			recordIdMap.put(recordName,recordMap.get(recordName).Id); 
		} 
		return recordIdMap; 
	} 
	public Map<String,Contact> getAccountNames(List<Contact> records){ 
		Map<String,Id> recordMap = getAccountNames(); 
		Map<Id,Contact> recordIdMap = getAccountIds(records); 
		Map<String,Contact> result = new Map<String,Contact>(); 
		for(String recordName:recordMap.keySet()){ 
			result.put(recordName,recordIdMap.get(recordMap.get(recordName))); 
		} 
		return result; 
	} 
	public Map<String,Contact> getAccountNames(JSONObject records){ 
		return getAccountNames(JSONtoList(records)); 
	} 
	public Map<Id,Contact> getAccountIds(JSONObject records){ 
		return getAccountIds(JSONtoList(records)); 
	} 
	public Map<Id,Contact> getAccountIds(List<Contact> records){ 
		Map<Id,Contact> recordMap = new Map<Id,Contact>(); 
		for(Contact record:records){ 
			recordMap.put(record.AccountId,record); 
		} 
		return recordMap; 
	} 
	public Map<String,Contact> getLastNames(JSONObject records){ 
		return getLastNames(JSONtoList(records)); 
	} 
	public Map<String,Contact> getLastNames(List<Contact> records){ 
		Map<String,Contact> recordMap = new Map<String,Contact>(); 
		for(Contact record:records){ 
			recordMap.put(record.lastName,record); 
		} 
		return recordMap; 
	} 
}