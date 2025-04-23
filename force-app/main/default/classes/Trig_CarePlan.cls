/** 
* Name: Trig_CarePlan
* Purpose: To create a new care plan.
* 
* Who            When           Ref            What            
* -------------------------------------------------------------
* Mark Collier   29/03/2025     hellenic       Care_Plan__c    
* -------------------------------------------------------------
**/
public class Trig_CarePlan implements TriggerInterface {
	/**
	* Name: beforeInsert
	* Purpose: To control and direct the necessary operations and actions required to be processed in the event that Care_Plan__c records are inserted, updated or deleted.
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   29/03/2025     hellenic       Method was created. 
	* -----------------------------------------------------------------
	**/
	public void beforeInsert(List<SObject> newRecords){
		
	}
	/**
	* Name: beforeUpdate
	* Purpose: .
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   29/03/2025     hellenic       Method was created. 
	* -----------------------------------------------------------------
	**/
	public void beforeUpdate(Map<Id, SObject> mapNewRecords, Map<Id, SObject> mapOldRecords){
	}
	/**
	* Name: beforeDelete
	* Purpose: .
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   29/03/2025     hellenic       Method was created. 
	* -----------------------------------------------------------------
	**/
	public void beforeDelete(Map<Id, SObject> mapOldRecords){
	}
	/**
	* Name: afterInsert
	* Purpose: .
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   29/03/2025     hellenic       Method was created. 
	* -----------------------------------------------------------------
	**/
	public void afterInsert(Map<Id, SObject> mapNewRecords){
		populateCarePlan(mapNewRecords.keySet());
	}
	@future(callout=true)
	public static void populateCarePlan(Set<Id> careIds){
		Map<String,String> replaceMap  = new Map<String,String>{
			'Resident' => 'First_Name__c',
			'He' => 'Pronoun__c',
			'Him' => 'Proform__c',
			'His' => 'Proximal__c'
		};
		List<Care_Plan__c> newRecords = new List<Care_Plan__c>();
		Set<String> fields = new Set<String>{'Personal_Goals__c','Personal_Goals_OHAT__c','Personal_Strategies__c','Personal_Strategies_OHAT__c','Continence_Personal_Strategies__c','Nutritional_Risk_Strategies__c','Toileting_Personal_Strategies__c','Foot_Care_1__c','Foot_Care_2__c'};
		Set<Id> residentIds = new Set<Id>();
		Set<Id> carePlanIds = new Set<Id>();
		String carePlanQuery = query(new Set<String>{'General_Care_Plan__c','Resident__c','Care_Plan_ID__c'},'Care_Plan__c')+' WHERE Id IN: careIds';
		Map<Id,SObject> carePlanMap = new Map<Id,SObject>(Database.query(carePlanQuery));
		for(SObject carePlan:carePlanMap.values()){
			residentIds.add((Id)carePlan.get('Resident__c'));
			carePlanIds.add((Id)carePlan.get('General_Care_Plan__c'));
		}
		String general = query(fields,'General_Care_Plan__c')+' WHERE Id IN: carePlanIds';
		String residents = query(new Set<String>(replaceMap.values()),'Resident__c')+' WHERE Id IN: residentIds';
		Map<Id,SObject> generalMap = new Map<Id,SObject>(Database.query(general));
		Map<Id,SObject> residentMap = new Map<Id,SObject>(Database.query(residents));
		List<SObject> aggList = Database.query('SELECT max(Care_Plan_ID__c) maxCarePlanId FROM Care_Plan__c WHERE Resident__c IN: residentIds');
		Integer carePlanNo = 0;
		for(SObject agg:aggList){
			carePlanNo = Math.round((Decimal)agg.get('maxCarePlanId'));
		}
		for(SObject carePlan:carePlanMap.values()){
			SObject gcplan = generalMap.get((Id)carePlan.get('General_Care_Plan__c'));
			SObject resident = residentMap.get((Id)carePlan.get('Resident__c'));
			for(String field:fields){
				String value = String.valueOf(gcplan.get(field));
				if(String.isNotBlank(value)){
					for(String text:replaceMap.keySet()){
						Set<String> replaceWith = new Set<String>{text,text.toLowerCase(),text.toUpperCase()};
						for(String substitute:replaceWith){
							if(String.isNotBlank(substitute)){
								String residentField = replaceMap.get(text);
								String residentValue = String.valueOf(resident.get(residentField));
								if(String.isNotBlank(residentValue)){
									String lowerCaseResidentValue = residentValue.toLowerCase();
									if(residentField=='First_Name__c'){
										lowerCaseResidentValue = residentValue.toLowerCase().capitalize();
										residentValue = lowerCaseResidentValue;
										value = value.replace(' '+substitute,' '+residentValue);
										value = value.replace(substitute+' ',residentValue+' ');
										value = value.replace(substitute+'\'',residentValue+'\'');
									}
									value = value.replace('- '+substitute+' ','- '+residentValue+' ');
									value = value.replace('. '+substitute+' ','. '+residentValue+' ');
									value = value.replace('.'+substitute+' ','.'+residentValue+' ');
									value = value.replace('-'+substitute+' ','-'+residentValue+' ');
									value = value.replace(' '+substitute+' ',' '+lowerCaseResidentValue+' ');
									value = value.replace(' '+substitute+'\'',' '+lowerCaseResidentValue+'\'');
									value = value.replace(' '+substitute+'.',' '+lowerCaseResidentValue+'.');
								}
							}
						}
					}
				}
				carePlan.put(field,value);
				if(String.isBlank(String.valueOf(carePlan.get('Care_Plan_ID__c')))){
					carePlan.put('Care_Plan_ID__c',carePlanNo+1);
				}
			}
			newRecords.add((Care_Plan__c)carePlan);
		}
		TriggerFactory.bypassHandler(Trig_CarePlan.class);
		update newRecords;
		TriggerFactory.removebypassHandler(Trig_CarePlan.class);
	}

	public static String query(Set<String> fields,String objectName){
		String queryString = 'SELECT Id';
		for(String field:fields){
			queryString+=','+field;
		}
		queryString+=' FROM '+objectName;
		return queryString;
	}
	/**
	* Name: afterUpdate
	* Purpose: .
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   29/03/2025     hellenic       Method was created. 
	* -----------------------------------------------------------------
	**/
	public void afterUpdate(Map<Id, SObject> mapNewRecords, Map<Id, SObject> mapOldRecords){
		populateCarePlan(mapNewRecords.keySet());
	}
	/**
	* Name: afterDelete
	* Purpose: .
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   29/03/2025     hellenic       Method was created. 
	* -----------------------------------------------------------------
	**/
	public void afterDelete(Map<Id, SObject> mapOldRecords){
	}
	/**
	* Name: afterUndelete
	* Purpose: .
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   29/03/2025     hellenic       Method was created. 
	* -----------------------------------------------------------------
	**/
	public void afterUndelete(Map<Id, SObject> mapNewRecords){
	}
}
