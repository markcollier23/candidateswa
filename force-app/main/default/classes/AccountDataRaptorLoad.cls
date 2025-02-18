//Author: Mark Collier 
//Purpose: //Purpose: To insert, update or delete an Account.  
public abstract class AccountDataRaptorLoad{ 
	public virtual JSONObject getFieldValues(){ 
		JSONObject fieldValues = new JSONObject('{}'); 
		fieldValues.add('','DandbCompanyId'); 
		fieldValues.add('','Name'); 
		fieldValues.add('','Region__c'); 
		fieldValues.add('','Phone'); 
		return fieldValues; 
	} 
	public virtual JSONObject load(JSONObject records){ 
		upsert JSONtoList(records); 
		return extract(getFieldValues()); 
	} 
	public virtual JSONObject remove(JSONObject records){ 
		delete JSONtoList(records); 
		return extract(getFieldValues()); 
	} 
	public virtual List<JSONObject> getJSONObjectList(JSONObject records){ 
		List<JSONObject> recordList = new List<JSONObject>(); 
		for(Object record:records.getList()){ 
			recordList.add(new JSONObject(record)); 
		} 
		return recordList; 
	} 
	public virtual List<Account> JSONtoList(JSONObject records){ 
		List<Account> instances = new List<Account>(); 
		for(JSONObject record:getJSONObjectList(records)){ 
			Account instance = new Account(); 
			String idString; 
			idString = record.get('DandbCompanyId:value').replace('"','').replace('"',''); 
			if(!new Serial(idString,'').isEmpty()){ 
				instance.DandbCompanyId = (Id)idString; 
			} 
			instance.Name = String.valueOf(record.get('Name:value').replace('"','').replace('"','')); 
			instance.Region__c = String.valueOf(record.get('Region__c:value').replace('"','').replace('"','')); 
			instance.Phone = String.valueOf(record.get('Phone:value').replace('"','').replace('"','')); 
			idString = record.get('Id:value').replace('"','').replace('"',''); 
			if(!new Serial(idString,'').isEmpty()){ 
				instance.Id = (Id)idString; 
			} 
			instances.add(instance); 
		} 
		return instances; 
    } 
    public virtual JSONObject extract(){ 
		AccountDataRaptorExtract.query(); 
		return AccountDataRaptorExtract.jsonRecords; 
	} 
	public virtual JSONObject extract(JSONObject fieldValues){ 
		AccountDataRaptorExtract.find(fieldValues); 
		return AccountDataRaptorExtract.jsonRecords; 
	} 
	public virtual JSONObject extract(Set<Id> ids){ 
		AccountDataRaptorExtract.get(ids); 
		return AccountDataRaptorExtract.jsonRecords; 
	} 
}