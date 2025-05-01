/** 
* Name: TransactionVisibility
* Purpose: To verify whether a batch will need to be executed.
* 
* Who            When           Ref            What            
* -------------------------------------------------------------
* Mark Collier   30/04/2025                    All             
* -------------------------------------------------------------
**/
public class TransactionVisibility implements Queueable, Database.AllowsCallouts {
	private Set<Id> recordIds = new Set<Id>();
	/**
	* Name: TransactionVisibility
	* Purpose: Constructor used to control and direct the neccessary operations for this Apex Class.
	* 
	* Who            When           Ref            What                     
	* ----------------------------------------------------------------------
	* Mark Collier   30/04/2025                    Constructor was created. 
	* ----------------------------------------------------------------------
	**/
	public TransactionVisibility(Set<Id> recordIdsParameter){
		recordIds = recordIdsParameter;
	}
	/**
	* Name: execute
	* Purpose: .
	* 
	* Who            When           Ref            What                
	* -----------------------------------------------------------------
	* Mark Collier   30/04/2025                    Method was created. 
	* -----------------------------------------------------------------
	**/
	public void execute(QueueableContext context) {
		Transaction_Visibility__c record = [SELECT Id,Start_Date__c,End_Date__c,Amount__c FROM Transaction_Visibility__c WHERE Id IN: recordIds];
		DateTime startDate = (DateTime)record.Start_Date__c;
		DateTime endDate = (DateTime)record.End_Date__c;
		Transaction__c t = new Transaction__c();
		Transactions__b b = new Transactions__b();
		Map<String,String> creditMap = new Map<String,String>{'Amount__c' => 'Credit__c'};
		Map<String,String> debitMap = new Map<String,String>{'Amount__c' => 'Debit__c'};
		BigObjectArchiver archiver = new BigObjectArchiver(t,b,creditMap,debitMap,'Date__c',startDate,endDate);
		List<SObject> bigObjectRecords = Database.query(archiver.archiver.getQuery('Transactions__b',false));
		TriggerFactory.bypassHandler(Trig_TransactionVisibility.class);
			record.Amount__c = bigObjectRecords.size();
			update record;
		TriggerFactory.removeAllBypassHandlers();
		if(bigObjectRecords.size()<=1000){
			Database.executeBatch(archiver,1000);
		}
	}
}
