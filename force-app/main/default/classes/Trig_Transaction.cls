/** 
* Name: Trig_Transaction
* Purpose: To ensure Transaction records are being uniquely imported.
* 
* Who            When           Ref            What            
* -------------------------------------------------------------
* Mark Collier   13/04/2025     trans          Transactions__c 
* -------------------------------------------------------------
**/
public class Trig_Transaction implements TriggerInterface {
	/**
	* Name: beforeInsert
	* Purpose: To control and direct the necessary operations and actions required to be processed in the event that Transactions__c records are inserted, updated or deleted.
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   13/04/2025     trans          Method was created. 
	* -----------------------------------------------------------------
	**/
	public void beforeInsert(List<SObject> newRecords){
		Set<String> names = new Set<String>();
		Set<Id> newIds = new Set<Id>();
		for(SObject record:newRecords){
			newIds.add((Id)record.get('Id'));
			String name = String.valueOf(record.get('Date__c'))+String.valueOf(record.get('Description__c'));
			record.put('Name',name.left(80));
			names.add(String.valueOf(record.get('Name')));
		}
		delete [SELECT Id FROM Transactions__c WHERE Name IN: names AND Id NOT IN: newIds];
		sortTransactions(newRecords,new Map<Id,SObject>());
	}
	/**
	* Name: beforeUpdate
	* Purpose: .
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   13/04/2025     trans          Method was created. 
	* -----------------------------------------------------------------
	**/
	public void beforeUpdate(Map<Id, SObject> mapNewRecords, Map<Id, SObject> mapOldRecords){
		sortTransactions(mapNewRecords.values(),mapOldRecords);
	}
	public Map<Id,Transaction_Type__c> sortTransactions(List<SObject> records,Map<Id, SObject> mapOldRecords){
		Map<Id,Transaction_Type__c> typeMap = new Map<Id,Transaction_Type__c>([SELECT Id,Name,Category__c FROM Transaction_Type__c WHERE Category__c!='']);
		Transaction_Type__c unidentified = getTransactionType('Unidentified',typeMap,new Transaction_Type__c(Name = 'Unidentified',Category__c='Unidentified'));
		if(String.isBlank(unidentified.Id)){
			insert unidentified;
		}
		for(SObject record:records){
			Id recordId = (Id)record.get('Id');
			Transaction_Type__c transactionType = getTransactionType(String.valueOf(record.get('Description__c')),typeMap,unidentified);
			if(mapOldRecords.containsKey(recordId)){
				SObject oldRecord = mapOldRecords.get(recordId);
				if(String.isBlank(String.valueOf(oldRecord.get('Type__c'))) || (Id)oldRecord.get('Type__c')==unidentified.Id){
					record.put('Type__c',transactionType.Id);
				}
			}else{
				record.put('Type__c',transactionType.Id);
			}
			Decimal debit = (Decimal)record.get('Debit__c');
			if(debit<0){
				record.put('Debit__c',-debit);
			}
		}
		return typeMap;
	}
	public Transaction_Type__c getTransactionType(String description,Map<Id,Transaction_Type__c> typeMap,Transaction_Type__c unidentified){
		for(Id recordId:typeMap.keySet()){
			Transaction_Type__c record = typeMap.get(recordId);
			String name = record.Name;
			if(description.toLowerCase().contains(name.toLowerCase())){
				return record;
			}
		}
		return unidentified;
	}
	/**
	* Name: beforeDelete
	* Purpose: .
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   13/04/2025     trans          Method was created. 
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
	* Mark Collier   13/04/2025     trans          Method was created. 
	* -----------------------------------------------------------------
	**/
	public void afterInsert(Map<Id, SObject> mapNewRecords){
	}
	/**
	* Name: afterUpdate
	* Purpose: .
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   13/04/2025     trans          Method was created. 
	* -----------------------------------------------------------------
	**/
	public void afterUpdate(Map<Id, SObject> mapNewRecords, Map<Id, SObject> mapOldRecords){
	}
	/**
	* Name: afterDelete
	* Purpose: .
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   13/04/2025     trans          Method was created. 
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
	* Mark Collier   13/04/2025     trans          Method was created. 
	* -----------------------------------------------------------------
	**/
	public void afterUndelete(Map<Id, SObject> mapNewRecords){
	}
}
