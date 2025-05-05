/** 
* Name: BigObjectArchiver
* Purpose: To convert a custom object records into big object records.
* 
* Who            When           Ref            What            
* -------------------------------------------------------------
* Mark Collier   30/04/2025     trans                          
* -------------------------------------------------------------
**/
global class BigObjectArchiver implements Database.Batchable<SObject>, Database.AllowsCallouts, Database.Stateful {
	private List<Id> recordIds = new List<Id>();
	public BigObjectArchiverHandler archiver = null;
	/**
	* Name: BigObjectArchiver
	* Purpose: Constructor used to control and direct the neccessary operations for this Apex Class.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   30/04/2025     trans          Constructor was created. 
	* ----------------------------------------------------------------------
	**/
	global BigObjectArchiver(SObject custom,SObject big,Map<String,String> positiveMap,Map<String,String> negativeMap,String conditionField,DateTime startDateParameter,DateTime endDateParameter){
		archiver = new BigObjectArchiverHandler(custom,big,conditionField,positiveMap,negativeMap);
		archiver.startDate = startDateParameter.date();
		archiver.endDate = endDateParameter.date();
	}
	/**
	* Name: BigObjectArchiver
	* Purpose: Constructor used to control and direct the neccessary operations for this Apex Class.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   30/04/2025     trans          Constructor was created. 
	* ----------------------------------------------------------------------
	**/
	global BigObjectArchiver(SObject custom,SObject big,String conditionField,DateTime startDateParameter,DateTime endDateParameter){
		archiver = new BigObjectArchiverHandler(custom,big,conditionField);
		archiver.startDate = startDateParameter.date();
		archiver.endDate = endDateParameter.date();
	}
	/**
	* Name: start
	* Purpose: To return the total volume of data which is to be partitioned.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   30/04/2025     trans          Method has been created. 
	* ----------------------------------------------------------------------
	**/
	global Database.QueryLocator start(Database.BatchableContext bc) {
		System.debug('start');
		Set<String> bigObjectFields = Schema.getGlobalDescribe().get(archiver.bigObjectName).getDescribe().fields.getMap().keySet();
		Set<String> objectFields = Schema.getGlobalDescribe().get(archiver.objectName).getDescribe().fields.getMap().keySet();
		Map<String,String> overlapMap = new Map<String,String>();
		for(String field:bigObjectFields){
			if(objectFields.contains(field) && !archiver.notIncludedFields.contains(field)){
				overlapMap.put(field,field);
			}
		}
		archiver.fields = overlapMap.keySet();
		Set<Map<String,String>> includeFields = new Set<Map<String,String>>{overlapMap,archiver.positiveBigToPositiveCustom,archiver.negativeBigToPositiveCustom};
		String query = 'SELECT Id,CreatedById';
		for(Map<String,String> fieldMap:includeFields){
			for(String field:fieldMap.keySet()){
				if(!archiver.notIncludedFields.contains(field)){
					query+=','+fieldMap.get(field);
				}
			}
		}
		query+=' FROM '+archiver.objectName+' WHERE ';
		Date startDate = archiver.startDate;
		Date endDate = archiver.endDate;
		if(archiver.startDate!=archiver.endDate && String.isNotBlank(archiver.conditionField)){
			query+=archiver.conditionField+' <: startDate OR '+archiver.conditionField+' >: endDate ';
		}
		System.debug(query);
		return Database.getQueryLocator(query);
	}
	/**
	* Name: start
	* Purpose: To execute the code below for every portion returned by the start method i.e if the batch size = 100 and the start method returns 200 records then this method will be executed twice..
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   30/04/2025     trans          Method has been created. 
	* ----------------------------------------------------------------------
	**/
	global void execute(Database.BatchableContext bc, List<SObject> records){
		archiver.bigRecord.Id = null;
		String properties = JSON.serialize(archiver.bigRecord).replace(',"Id":null','');
		System.debug(properties);
		List<SObject> bigRecords = new List<SObject>();
		Set<String> attributes = archiver.getJSON(archiver.bigObjectName);
		for(SObject record:records){
			SObject big = (SObject)JSON.deserialize(properties, SObject.class);
			for(String field:archiver.fields){
				big.put(field,record.get(field));
			}
			String attribute = JSON.serialize(big);
			try{
				for(String field:archiver.positiveBigToPositiveCustom.keySet()){
					big.put(field,record.get(archiver.positiveBigToPositiveCustom.get(field)));
				}
			}catch(Exception e){
				System.debug(e);
			}
			try{
				for(String field:archiver.negativeBigToPositiveCustom.keySet()){
					big.put(field,-(Decimal)record.get(archiver.negativeBigToPositiveCustom.get(field)));
				}
			}catch(Exception e){
				System.debug(e);
			}
			if(!attributes.contains(attribute)){
				bigRecords.add(big);
			}
		}
		Database.insertImmediate(bigRecords);
	}
	/**
	* Name: finish
	* Purpose: To perform the post implementation code when all batch items have been executed.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   30/04/2025     trans          Method has been created. 
	* ----------------------------------------------------------------------
	**/
	global void finish(Database.BatchableContext bc){
		System.debug('finish');
		Date startDate = archiver.startDate;
		Date endDate = archiver.endDate;
		List<SObject> records = Database.query(archiver.getQuery(archiver.objectName));
		delete records;
		System.enqueueJob(archiver);
	}
	
}
