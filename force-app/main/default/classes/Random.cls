//Author: Mark Collier 
//Purpose: To enable the retrieval of random Apex datatypes. 
public abstract class Random{ 
	public String randomString = 'random string';//allows you to randomise field values 
	//To allow the maximum number of combinations to occur within the minimum possible size for a specific field value. 
	public virtual Integer getMinSize(Integer size){ 
		if(size>randomString.length()){ 
			if(randomString.length()<7)return randomString.length(); 
		} 
		if(size<7) return size; 
		return 7; 
	} 
	//To randomise a field of Data Type: Number 
	public virtual Integer getRandomInteger(Integer size){ 
		Double decimalNumber = 1; 
		size = getMinSize(size); 
		for(Integer i=1;i<=size;i++){ 
			Integer r=randomString.charAt(i-1); 
			decimalNumber+=Math.pow(10,i) * r/Math.pow(10, String.valueOf(r).length()-1); 
		} 
		return Math.round(decimalNumber); 
	} 
	//To randomise a field of Data Type: Date 
	public virtual Date getRandomDate(Integer size){ 
		return Date.today() - getRandomInteger(size); 
	} 
	//To randomise a field of Data Type: Time 
	public virtual Time getRandomTime(Integer size){ 
		return Time.newInstance(1,1,1,getRandomInteger(3)); 
	} 
	//To randomise a field of Data Type: DateTime 
	public virtual DateTime getRandomDateTime(Integer size){ 
		return DateTime.now() - getRandomInteger(size); 
	} 
	//To randomise a field of Data Type: String 
	public virtual String getRandomString(Integer size){ 
		return randomString.left(size); 
	} 
	//To convert a single Id variable into a Set<Id> with a size = 1 
	public virtual Set<Id> SetOf(Id instance){ 
		Set<Id> instances = new Set<Id>(); 
		instances.add(instance); 
		return instances; 
	} 
	//To convert a single String variable into a Set<String> with a size = 1 
	public virtual Set<String> SetOf(String instance){ 
		Set<String> instances = new Set<String>(); 
		instances.add(instance); 
		return instances; 
	} 
	//To convert a single Id variable into a List<Id> with a size = 1 
	public virtual List<Id> ListOf(Id instance){ 
		List<Id> instances = new List<Id>(); 
		instances.add(instance); 
		return instances; 
	} 
	//To convert a single String variable into a List<String> with a size = 1 
	public virtual List<String> ListOf(String instance){ 
		List<String> instances = new List<String>(); 
		instances.add(instance); 
		return instances; 
	} 
}