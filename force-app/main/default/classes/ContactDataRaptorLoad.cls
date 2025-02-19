//Author: Mark Collier 
//Purpose: //Purpose: To insert, update and delete Contact records via JSON.  
public abstract class ContactDataRaptorLoad{ 
	public virtual JSONObject getFieldValues(){ 
		JSONObject fieldValues = new JSONObject('{}'); 
		fieldValues.add('','AccountId'); 
		fieldValues.add('','lastName'); 
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
	public virtual List<Contact> JSONtoList(JSONObject records){ 
		List<Contact> instances = new List<Contact>(); 
		for(JSONObject record:getJSONObjectList(records)){ 
			Contact instance = new Contact(); 
			String idString; 
			idString = record.get('AccountId:value').replace('"','').replace('"',''); 
			if(new Serial(idString,'').isEmpty()){ 
				idString = 'PlaceHolder'; 
			}else{ 
				instance.AccountId = (Id)idString; 
			} 
			instance.lastName = String.valueOf(record.get('lastName:value').replace('"','').replace('"','')); 
			idString = record.get('Id:value').replace('"','').replace('"',''); 
			if(new Serial(idString,'').isEmpty()){ 
				idString = 'PlaceHolder'; 
			}else{ 
				instance.Id = (Id)idString; 
			} 
			instances.add(instance); 
		} 
		return instances; 
    } 
    public virtual JSONObject extract(){ 
		ContactDataRaptorExtract.query(); 
		return ContactDataRaptorExtract.jsonRecords; 
	} 
	public virtual JSONObject extract(JSONObject fieldValues){ 
		ContactDataRaptorExtract.find(fieldValues); 
		return ContactDataRaptorExtract.jsonRecords; 
	} 
	public virtual JSONObject extract(Set<Id> ids){ 
		ContactDataRaptorExtract.get(ids); 
		return ContactDataRaptorExtract.jsonRecords; 
	} 
}