/** 
* Name: JSONObject 
* Purpose: Apex Class responsible for managing a JSON payload. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
//Purpose: To get and add values to a JSON String.  
public class JSONObject { 
	public String text = '{}';  
	/** 
	* Name: JSONObject 
	* Purpose: Constructor used to control and direct the neccessary operations for this Apex Class. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public JSONObject(String textParameter){  
		text = textParameter;  
	} 
	/** 
	* Name: JSONObject 
	* Purpose: Constructor used to control and direct the neccessary operations for this Apex Class. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public JSONObject(Object obj){ 
		text = new Serial(obj,0).text; 
	} 
	/** 
	* Name: getJSON 
	* Purpose: To return a json payload of type JSONGet. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public JSONGet getJSON(String nodeLocation){ 
		JSONGet jget = new JSONGet(new Serial(text,nodeLocation)); 
		jget.execute(); 
		return jget; 
	} 
	/** 
	* Name: get 
	* Purpose: Retrieve the String of a particular section within the JSON payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public String get(String nodeLocation){ 
		return getJSON(nodeLocation).getLocalString().replace(String.fromCharArray(new Integer[]{ 34 }),''); 
	} 
	/** 
	* Name: getObject 
	* Purpose: Retrieve the Object of a particular section within the JSON payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public Object getObject(String nodeLocation){ 
		return getJSON(nodeLocation).getLocalObject(); 
	} 
	/** 
	* Name: getMap 
	* Purpose: Retrieve the Map of a particular section within the JSON payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public Map<String,Object> getMap(String nodeLocation){ 
		return getJSON(nodeLocation).getLocalMap(); 
	} 
	/** 
	* Name: getList 
	* Purpose: Retrieve the List of a particular section within the JSON payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public List<Object> getList(String nodeLocation){ 
		return getJSON(nodeLocation).getLocalList(); 
	} 
	/** 
	* Name: get 
	* Purpose: Retrieve the String of a particular list item within the JSON payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public String get(Integer nodeIndex){ 
		String nodeLocation = '|'+nodeIndex; 
		return getJSON(nodeLocation).getLocalString(); 
	} 
	/** 
	* Name: getObject 
	* Purpose: Retrieve the Object of a particular list item within the JSON payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public Object getObject(Integer nodeIndex){ 
		String nodeLocation = '|'+nodeIndex; 
		return getJSON(nodeLocation).getLocalObject(); 
	} 
	/** 
	* Name: getMap 
	* Purpose: Retrieve the Map of a particular list item within the JSON payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public Map<String,Object> getMap(Integer nodeIndex){ 
		String nodeLocation = '|'+nodeIndex; 
		return getJSON(nodeLocation).getLocalMap(); 
	} 
	/** 
	* Name: getList 
	* Purpose: Retrieve the List of a particular list item within the JSON payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public List<Object> getList(Integer nodeIndex){ 
		String nodeLocation = '|'+nodeIndex; 
		return getJSON(nodeLocation).getLocalList(); 
	} 
	/** 
	* Name: getObject 
	* Purpose: Retrieve the Object of the JSON payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public Object getObject(){ 
		return getObject(''); 
	} 
	/** 
	* Name: getMap 
	* Purpose: Retrieve the Map of the JSON payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public Map<String,Object> getMap(){ 
		return getMap(''); 
	} 
	/** 
	* Name: getMap 
	* Purpose: Retrieve the List of the JSON payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public List<Object> getList(){ 
		return getList(''); 
	} 
	/** 
	* Name: add 
	* Purpose: To add a particular value to a specific location in the json payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public String add(Object value,String nodeLocation){ 
		Object result = new JSONAdd(new Serial(text,nodeLocation,value)).execute(); 
		text = new Serial(result,'').text; 
		return text; 
	} 
	/** 
	* Name: add 
	* Purpose: To add a particular value to a specific location in the json payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public String add(Object value,Integer nodeLocation){ 
		return add(value,new Serial(text,nodeLocation).nodeLocationInterestedIn); 
	} 
	/** 
	* Name: add 
	* Purpose: To add a value to the json payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public String add(Object value){ 
		return add(value,''); 
	} 
	/** 
	* Name: remove 
	* Purpose: To remove a particular node from the json payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public String remove(String nodeLocation){ 
		Object result = new JSONRemove(new Serial(text,nodeLocation)).execute(); 
		text = new Serial(result,'').text; 
		return text; 
	} 
	/** 
	* Name: remove 
	* Purpose: To remove a particular list item from the json payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public String remove(Integer nodeLocation){ 
		return remove('|'+nodeLocation); 
	} 
	/** 
	* Name: edit 
	* Purpose: To edit a particular node from the json payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public String edit(Object value,String nodeLocation){ 
		Object result = new JSONEdit(new Serial(text,nodeLocation,value)).execute(); 
		text = new Serial(result,'').text; 
		return text; 
	} 
	/** 
	* Name: edit 
	* Purpose: To edit a particular list item from the json payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public String edit(Object value,Integer nodeLocation){ 
		return edit(value, '|'+nodeLocation); 
	} 
}