//Author: Mark Collier 
//Purpose: To ensure latest bank details are updated based on the interest rates they provide in saving accounts.  
public class InterestRateTriggerHandler{ 
	public List<Interest_Rate__c> oldList = new List<Interest_Rate__c>();//This variable is available for use so that we can easily retrieve what the records were before the transaction took place. 
	public List<Interest_Rate__c> newList = new List<Interest_Rate__c>();//This variable is available for use so that we can easily retrieve what the records were after the transaction took place. 
	public InterestRateTriggerHandler(List<Interest_Rate__c> oldListParameter,List<Interest_Rate__c> newListParameter){ 
		oldList = oldListParameter; 
		newList = newListParameter; 
		main(); 
	} 
	//This method is part of the initialisation for this class and will be executed when the class is initialised. 
	public void main(){ 
		//The following contains the entire control of all operations to occur within this trigger: 
		if(InterestRateCheckRecursive.TriggerOn){  
			//A copy of newList is required in order to allow a single Interest_Rate__c record to be writable. 
			List<Interest_Rate__c> newListCopy = new List<Interest_Rate__c>(); 
			if(newList!=null){ 
				for(Interest_Rate__c record:newList){ 
				//The purpose of the if statement below is to ensure that we are only using records that we have already touched before. 
					if(!InterestRateCheckRecursive.setOfNames.contains(record.Name)){ 
						newListCopy.add(record); 
					} 
				} 
			} 
			//A copy of oldList is required in order to allow a single Interest_Rate__c record to be writable. 
			List<Interest_Rate__c> oldListCopy = new List<Interest_Rate__c>(); 
			if(oldList!=null){ 
				for(Interest_Rate__c record:oldList){ 
				//The purpose of the if statement below is to ensure that we are only using records that we have already touched before. 
					if(!InterestRateCheckRecursive.setOfNames.contains(record.Name)){ 
						oldListCopy.add(record.clone()); 
						InterestRateCheckRecursive.setOfNames.add(record.Name); 
					} 
				} 
			} 
			//The purpose of this if statement below is to ensure that our main operations as written below is only called if there exists records that we haven't touched on before. 
			if(oldListCopy.size()>0||newListCopy.size()>0){ 
				InterestRateCheckRecursive.populateLists(oldListCopy,newListCopy); 
				InterestRateFuture.invoke(newListCopy); 
			} 
		} 
	} 
}