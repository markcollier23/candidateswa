//Author: Mark Collier 
//Purpose: To test that we have achieved the following goal:  
//	- //Purpose: To insert, update and delete Contact records via JSON.  
@isTest (SeeAllData=true) 
public class ContactDataRaptorTest{  
	public static Contact getRecord(){ 
		Contact record = new Contact(); 
		record.AccountId = [SELECT Id FROM Account LIMIT 1].Id; 
		record.lastName = 'Mark'; 
		return record; 
	} 
	//The purpose of this method is to test the update and creation of Account records. 
	@isTest 
	public static void testLoad(){ 
		List<Contact> records = new List<Contact>(); 
		records.add(getRecord()); 
		ContactDataRaptor dataRaptor = new ContactDataRaptor(); 
		JSONObject recordsToLoad = ContactDataRaptorExtract.listToJSON(records); 
		Test.startTest(); 
			dataRaptor.load(recordsToLoad); 
		Test.stopTest(); 
	} 
	//The purpose of this method is to test the retreival of Account records. 
	@isTest 
	public static void testGet(){ 
		Contact record = getRecord();insert record; 
		List<Contact> records = [SELECT Id FROM Contact LIMIT 5]; 
		ContactDataRaptor dataRaptor = new ContactDataRaptor(); 
		Test.startTest(); 
			dataRaptor.extract(new Map<Id,Contact>(records).keySet()); 
		Test.stopTest(); 
		printMaps(dataRaptor); 
		delete record; 
	} 
	//The purpose of this method is to test the extraction of Account records. 
	@isTest 
	public static void testExtract(){ 
		Contact record = getRecord();insert record; 
		ContactDataRaptor dataRaptor = new ContactDataRaptor(); 
		Test.startTest(); 
			dataRaptor.extract(); 
		Test.stopTest(); 
		printMaps(dataRaptor); 
		delete record; 
	} 
	//The purpose of this method is to test the removal of Contact records.  
	@isTest 
	public static void testRemove(){ 
		ContactDataRaptor dataRaptor = new ContactDataRaptor(); 
		dataRaptor.remove(new JSONObject('[]')); 
	} 
	@isTest 
	//The purpose of this method is to test the search of Contact records.  
	public static void testFind(){  
		Contact record = getRecord();insert record; 
		JSONObject querySearch = new JSONObject('{}'); 
		querySearch.add([SELECT Id FROM Account LIMIT 1].Id,'AccountId'); 
		querySearch.add('Mark','lastName'); 
		ContactDataRaptor dataRaptor = new ContactDataRaptor(); 
		Test.startTest(); 
			dataRaptor.extract(querySearch); 
		Test.stopTest(); 
		printMaps(dataRaptor); 
		delete record; 
	} 
	public static void printMaps(ContactDataRaptor dataRaptor){ 
		JSONObject records = ContactDataRaptorExtract.jsonRecords; 
		if(records==null || new Serial(records.text,'').isEmpty()){ 
			System.debug(records); 
		}else{ 
			System.debug(records); 
			System.debug(dataRaptor.getAccountIds(records)); 
			System.debug(dataRaptor.getAccountNames(records)); 
			System.debug(records); 
			System.debug(dataRaptor.getLastNames(records)); 
			System.debug(records); 
			System.debug(dataRaptor.getIds(records)); 
		} 
	} 
}