//Author: Mark Collier 
//Purpose: To update the bills and tds of a particular vote. 
public class VoteUpdate{ 
	//Method available for use by a process builder. 
	@InvocableMethod 
	public static void invoke(List<Vote__c> records){ 
		Set<Id> votes = new Set<Id>();
		for(Vote__c vote:records){
			votes.add(vote.Id);
		}
		futureMethod(votes); 
	} 
	//Future method which utilises variables contained in this class to address the following: 
		//Purpose: To update the bills and tds of a particular vote. 
	@future 
	public static void futureMethod(Set<Id> voteIds){ 
		TriggerFactory.bypassHandler(VoteHandler.class);
		Map<String,Id> tds = getTDs();
		Map<String,Id> bills = getBills();
		List<TD__c> tdList = new List<TD__c>();
		List<Bill__c> billList = new List<Bill__c>();
		for(Vote__c vote:[SELECT Id,Teachta_Dala__c,TD__c,Vote_Summary__c,Vote_Details__c,Bill__c FROM Vote__c WHERE Id IN : voteIds]){
			tdList.add(new TD__c(Name=vote.TD__c));
			billList.add(new Bill__c(Name=vote.Vote_Summary__c,URL__c=vote.Vote_Details__c));
		}
		tdList = new List<TD__c>(new Set<TD__c>(tdList));
		upsert tdList Name;
		billList = new List<Bill__c>(new Set<Bill__c>(billList));
		upsert billList Name;
		Map<String,SObject> tdMap = getRecordNameMap(tdList);
		Map<String,SObject> billMap = getRecordNameMap(billList);
		List<Vote__c> votes = new List<Vote__c>();
		for(Vote__c vote:[SELECT Id,Teachta_Dala__c,TD__c,Vote_Summary__c,Bill__c FROM Vote__c WHERE Id IN : voteIds AND (Teachta_Dala__c='' OR Bill__c='')]){
			TD__c member = (TD__c)tdMap.get(vote.TD__c);
			vote.Teachta_Dala__c = member.Id;
			Bill__c bill = (Bill__c)billMap.get(vote.Vote_Summary__c);
			vote.Bill__c = bill.Id;
			votes.add(vote);
		}
		update votes;
		TriggerFactory.removebypassHandler(VoteHandler.class);
	}
	public static Map<String,SObject> getRecordNameMap(List<SObject> records){
		Map<String,SObject> nameMap = new Map<String,SObject>();
		List<SObject> recordList = new List<SObject>(new Set<SObject>(records));
		for(SObject record:recordList){
			nameMap.put(String.valueOf(record.get('Name')),record);
		}
		return nameMap;
	}
	public static Map<String,Id> getTDs(){
		Map<String,Id> tds = new Map<String,Id>();
		for(TD__c td:[SELECT Id,Name FROM TD__c]){
			tds.put(td.Name,td.Id);
		}
		return tds;
	}
	public static Map<String,Id> getBills(){
		Map<String,Id> bills = new Map<String,Id>();
		for (Bill__c bill : [SELECT Id,Name FROM Bill__c]) {
			bills.put(bill.Name,bill.Id);
		}
		return bills;
	}
}