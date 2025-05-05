/** 
* Name: BigObjectArchiverHandler
* Purpose: To populate all the related custom object records that are derived from BigObjects.
* 
* Who            When           Ref            What            
* -------------------------------------------------------------
* Mark Collier   01/05/2025     trans          All             
* -------------------------------------------------------------
**/
public class BigObjectArchiverHandler implements Queueable, Database.AllowsCallouts {
	public SObject customRecord = null;
	public SObject bigRecord = null;
	public String bigObjectName = '';
	public String objectName = '';
	public String conditionField = '';
	public Set<String> fields = new Set<String>();
	public Map<String,String> positiveBigToPositiveCustom = new Map<String,String>();
	public Map<String,String> negativeBigToPositiveCustom = new Map<String,String>();
	public Date startDate = null;
	public Date endDate = null;
	public List<String> notIncludedFields = new String[]{'id','createdbyid','createddate','systemmodstamp'};
	/**
	* Name: BigObjectArchiverHandler
	* Purpose: Constructor used to control and direct the neccessary operations for this Apex Class.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   01/05/2025     trans          Constructor was created. 
	* ----------------------------------------------------------------------
	**/
	public BigObjectArchiverHandler(SObject customRecordParameter,SObject bigRecordParameter,String conditionFieldParameter,Map<String,String> positiveBigToPositiveCustomParameter,Map<String,String> negativeBigToPositiveCustomParameter){
		customRecord = customRecordParameter;
		bigRecord = bigRecordParameter;
		objectName = String.valueOf(customRecordParameter.getSObjectType());
		bigObjectName = String.valueOf(bigRecordParameter.getSObjectType());
		conditionField = conditionFieldParameter;
		positiveBigToPositiveCustom = positiveBigToPositiveCustomParameter;
		negativeBigToPositiveCustom = negativeBigToPositiveCustomParameter;
	}
	/**
	* Name: BigObjectArchiverHandler
	* Purpose: Constructor used to control and direct the neccessary operations for this Apex Class.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   01/05/2025     trans          Constructor was created. 
	* ----------------------------------------------------------------------
	**/
	public BigObjectArchiverHandler(SObject customRecordParameter,SObject bigRecordParameter,String conditionFieldParameter){
		customRecord = customRecordParameter;
		bigRecord = bigRecordParameter;
		objectName = String.valueOf(customRecordParameter.getSObjectType());
		bigObjectName = String.valueOf(bigRecordParameter.getSObjectType());
		conditionField = conditionFieldParameter;
	}
	/**
	* Name: execute
	* Purpose: To perform the operation of creating the necessary Transaction__c records.
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   01/05/2025     trans          Method was created. 
	* -----------------------------------------------------------------
	**/
	public void execute(QueueableContext context) {
		List<SObject> records = new List<SObject>();
		String customRecordAttributes = JSON.serialize(customRecord);
		Set<String> attributes = getJSON(bigObjectName);
		for(SObject big:Database.query(getQuery(bigObjectName))){
			DateTime endDateTime = DateTime.newInstance(endDate,UtilDateTime.getTime('0:0:0','h:m:s'));
			if((DateTime)big.get('Date__c')<endDateTime){
				SObject record = (SObject)JSON.deserialize(customRecordAttributes,SObject.class);
				for(String field:fields){
					if(!notIncludedFields.contains(field) && !positiveBigToPositiveCustom.containsKey(field) && !negativeBigToPositiveCustom.containsKey(field)){
						try{
							record.put(field,big.get(field));
						}catch(Exception e){
							Date value = UtilDateTime.getDate(String.valueOf(big.get(field)), 'YYYY-MM-DD');
							record.put(field,value);
						}
					}
				}
				String attribute = JSON.serialize(record);
				if(!attributes.contains(attribute)){
					for(String field:positiveBigToPositiveCustom.keySet()){
						record.put(positiveBigToPositiveCustom.get(field),big.get(field));
					}
					for(String field:negativeBigToPositiveCustom.keySet()){
						record.put(negativeBigToPositiveCustom.get(field),-(Decimal)big.get(field));
					}
					records.add(record);
				}
			}
		}
		insert records;
	}
	/**
	* Name: getJSON
	* Purpose: To find unique record.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   30/04/2025     trans          Method has been created. 
	* ----------------------------------------------------------------------
	**/
	public Set<String> getJSON(String recordObject){
		String query = getQuery(recordObject);
		Set<String> attributes = new Set<String>();
		for(SObject record:Database.query(query)){
			record.Id = null;
			attributes.add(JSON.serialize(record));
		}
		return attributes;
	}
	/**
	* Name: getQuery
	* Purpose: To perform a query.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   30/04/2025     trans          Method has been created. 
	* ----------------------------------------------------------------------
	**/
	public String getQuery(String recordObject){
		String query = 'SELECT Id,CreatedById';
		String conditions = '';
		for(String field:fields){
			if(!notIncludedFields.contains(field)){
				query+=','+field;
			}
		}
		query+=' FROM '+recordObject+' WHERE '+conditions;
		if(String.isNotBlank(conditionField)){
			if(recordObject.contains('__b')){
				query+=conditionField+' >=: startDate ';
			}else{
				query+=conditionField+' <: startDate OR '+conditionField+' >: endDate ';
			}
		}
		System.debug(query);
		return query;
	}
}
