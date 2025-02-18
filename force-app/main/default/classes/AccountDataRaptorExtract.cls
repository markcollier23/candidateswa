//Author: Mark Collier 
//Purpose: //Purpose: To insert, update or delete an Account.  
public class AccountDataRaptorExtract{  
	public static JSONObject jsonRecords; 
	public static List<Account> soqlRecords; 
	public static JSONObject listToJSON(List<Account> records){ 
		jsonRecords = new JSONObject('[]'); 
		for(Account record:records){ 
			JSONObject instance = new JSONObject('{}'); 
			JSONObject quickConvert = new JSONObject(record); 
			instance.add(quickConvert.get('DandbCompanyId').replace('"','').replace('"',''),'DandbCompanyId:value'); 
			instance.add('DandbCompany','DandbCompanyId:type'); 
			instance.add(new List<String>(getDandbCompanyNames().keySet()),'DandbCompanyId:picklistValues'); 
			instance.add(quickConvert.get('Name').replace('"','').replace('"',''),'Name:value'); 
			instance.add('Text','Name:type'); 
			instance.add(picklistValues(Account.Name.getDescribe()),'Name:picklistValues'); 
			instance.add(quickConvert.get('Region__c').replace('"','').replace('"',''),'Region__c:value'); 
			instance.add('Picklist','Region__c:type'); 
			instance.add(picklistValues(Account.Region__c.getDescribe()),'Region__c:picklistValues'); 
			instance.add(quickConvert.get('Phone').replace('"','').replace('"',''),'Phone:value'); 
			instance.add('Phone','Phone:type'); 
			instance.add(picklistValues(Account.Phone.getDescribe()),'Phone:picklistValues'); 
			instance.add(quickConvert.get('Id').replace('"','').replace('"',''),'Id:value'); 
			instance.add('Id','Id:type'); 
			instance.add(picklistValues(Account.Id.getDescribe()),'Id:picklistValues'); 
			jsonRecords.add(instance.text); 
		} 
		return jsonRecords;	 
	} 
	public static void query(){ 
		soqlRecords = [SELECT DandbCompanyId,Name,Region__c,Phone,Id FROM Account WHERE Name LIKE : '%%']; 
		get(new Map<Id,Account>(soqlRecords).keySet()); 
	} 
	@future 
	public static void get(Set<Id> ids){ 
		soqlRecords = [SELECT DandbCompanyId,Name,Region__c,Phone,Id FROM Account WHERE Id IN : ids]; 
		jsonRecords = listToJSON(soqlRecords); 
	} 
	public static void find(JSONObject fieldValues){ 
		soqlRecords = [SELECT DandbCompanyId,Name,Region__c,Phone,Id FROM Account WHERE Name LIKE : '%%' 
		AND Name LIKE :'%'+fieldValues.get('Name').replace('"','').replace('"','')+'%' 
		AND Region__c LIKE :'%'+fieldValues.get('Region__c').replace('"','').replace('"','')+'%' 
		AND Phone LIKE :'%'+fieldValues.get('Phone').replace('"','').replace('"','')+'%' 
		]; 
		get(new Map<Id,Account>(soqlRecords).keySet()); 
	} 
	public static List<String> picklistValues(Schema.DescribeFieldResult field){ 
		List<String> picklist = new List<String>(); 
		for(Schema.PicklistEntry pick:field.getPicklistValues()){ 
			picklist.add(pick.getValue()); 
		} 
		return picklist; 
	} 
	public static Map<String,DandbCompany> getDandbCompanyNames(){ 
		List<DandbCompany> recordList = [SELECT Name FROM DandbCompany]; 
		Map<String,DandbCompany> recordMap = new Map<String,DandbCompany>(); 
		for(DandbCompany record:recordList){ 
			recordMap.put(record.Name,record); 
		} 
		return recordMap; 
	} 
}