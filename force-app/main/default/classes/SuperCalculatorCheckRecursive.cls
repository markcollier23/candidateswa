//Author: Mark Collier 
//Purpose: To manage the state of the trigger on the object SuperannuationCalculator__c 
//The intent and purpose of the trigger was: To predict the balance of your Superannuation in the future. 
public class SuperCalculatorCheckRecursive{ 
    public static Set<Id> setOfIds = new Set<Id>();//This used so that you can save a list of record ids that have already been touched in this trigger. 
    public static Set<String> setOfNames = new Set<String>();//This used so that you can save a list of record ids that have already been touched in this trigger. 
	public static boolean TriggerOn = true;//This gives you the option to mute the trigger from executing the code in the TriggerHandler. 
    public static List<SuperannuationCalculator__c> oldList = new List<SuperannuationCalculator__c>(); 
    public static List<SuperannuationCalculator__c> newList = new List<SuperannuationCalculator__c>(); 
	//The purpose of this method is to allow assignment of the lists to be done through parameters. 
	public static void populateLists(List<SuperannuationCalculator__c> oldListParameter,List<SuperannuationCalculator__c> newListParameter){ 
		oldList = oldListParameter;//This is what the list of records looked like before the transaction occured. 
		newList = newListParameter;//This is what the list of records looked like after the transaction occured. 
	} 
	//This purpose of this method is allow the trigger to run again for the records that have already been used. 
	public static void clear(){ 
		setOfIds = new Set<Id>(); 
		setOfNames = new Set<String>(); 
	}
	public static Decimal percent(Decimal x){
        if(x>0)x=x/100;
        return x;
    } 
}