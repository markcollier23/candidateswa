//Author: Mark Collier 
//Purpose: //Purpose: To insert, update and delete Contact records via JSON.  
public class ContactDataRaptorExtract{  
	public static JSONObject jsonRecords; 
	public static List<Contact> soqlRecords; 
	public static JSONObject listToJSON(List<Contact> records){ 
		jsonRecords = new JSONObject('[]'); 
		for(Contact record:records){ 
			JSONObject instance = new JSONObject('{}'); 
			JSONObject quickConvert = new JSONObject(record); 
			instance.add(quickConvert.get('AccountId').replace('"','').replace('"',''),'AccountId:value'); 
			instance.add('Account','AccountId:type'); 
			instance.add(new List<String>(getAccountNames().keySet()),'AccountId:picklistValues'); 
			instance.add(quickConvert.get('lastName').replace('"','').replace('"',''),'lastName:value'); 
			instance.add('Text','lastName:type'); 
			instance.add(picklistValues(Contact.lastName.getDescribe()),'lastName:picklistValues'); 
			instance.add(quickConvert.get('Id').replace('"','').replace('"',''),'Id:value'); 
			instance.add('Id','Id:type'); 
			instance.add(picklistValues(Contact.Id.getDescribe()),'Id:picklistValues'); 
			jsonRecords.add(instance.text); 
		} 
		return jsonRecords;	 
	} 
	public static void query(){ 
		soqlRecords = [SELECT AccountId,lastName,Id FROM Contact WHERE Name LIKE '%%']; 
		get(new Map<Id,Contact>(soqlRecords).keySet()); 
	} 
	@future 
	public static void get(Set<Id> ids){ 
		soqlRecords = [SELECT AccountId,lastName,Id FROM Contact WHERE Id IN : ids]; 
		jsonRecords = listToJSON(soqlRecords); 
	} 
	public static void find(JSONObject fieldValues){ 
		soqlRecords = [SELECT AccountId,lastName,Id FROM Contact WHERE Name LIKE '%%' 
		AND lastName LIKE :'%'+fieldValues.get('lastName').replace('"','').replace('"','')+'%' 
		]; 
		get(new Map<Id,Contact>(soqlRecords).keySet()); 
	} 
	public static List<String> picklistValues(Schema.DescribeFieldResult field){ 
		List<String> picklist = new List<String>(); 
		for(Schema.PicklistEntry pick:field.getPicklistValues()){ 
			picklist.add(pick.getValue()); 
		} 
		return picklist; 
	} 
	public static Map<String,Account> getAccountNames(){ 
		List<Account> recordList = [SELECT Name FROM Account WHERE Name LIKE '%Edge%']; 
		Map<String,Account> recordMap = new Map<String,Account>(); 
		for(Account record:recordList){ 
			recordMap.put(record.Name,record); 
		} 
		return recordMap; 
	} 
}