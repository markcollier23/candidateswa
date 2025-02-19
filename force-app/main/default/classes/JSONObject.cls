//Author: Mark Collier 
//Purpose: To get and add values to a JSON String.  
public class JSONObject { 
	public String text = '{}';  
	public JSONObject(String textParameter){  
		text = textParameter;  
	} 
	public JSONObject(Object obj){ 
		text = new Serial(obj,0).text; 
	} 
	public JSONGet getJSON(String nodeLocation){ 
		JSONGet jget = new JSONGet(new Serial(text,nodeLocation)); 
		jget.execute(); 
		return jget; 
	} 
	public String get(String nodeLocation){ 
		return getJSON(nodeLocation).getLocalString(); 
	} 
	public Object getObject(String nodeLocation){ 
		return getJSON(nodeLocation).getLocalObject(); 
	} 
	public Map<String,Object> getMap(String nodeLocation){ 
		return getJSON(nodeLocation).getLocalMap(); 
	} 
	public List<Object> getList(String nodeLocation){ 
		return getJSON(nodeLocation).getLocalList(); 
	} 
	public String get(Integer nodeIndex){ 
		String nodeLocation = '|'+nodeIndex; 
		return getJSON(nodeLocation).getLocalString(); 
	} 
	public Object getObject(Integer nodeIndex){ 
		String nodeLocation = '|'+nodeIndex; 
		return getJSON(nodeLocation).getLocalObject(); 
	} 
	public Map<String,Object> getMap(Integer nodeIndex){ 
		String nodeLocation = '|'+nodeIndex; 
		return getJSON(nodeLocation).getLocalMap(); 
	} 
	public List<Object> getList(Integer nodeIndex){ 
		String nodeLocation = '|'+nodeIndex; 
		return getJSON(nodeLocation).getLocalList(); 
	} 
	public Object getObject(){ 
		return getObject(''); 
	} 
	public Map<String,Object> getMap(){ 
		return getMap(''); 
	} 
	public List<Object> getList(){ 
		return getList(''); 
	} 
	public String add(Object value,String nodeLocation){ 
		Object result = new JSONAdd(new Serial(text,nodeLocation,value)).execute(); 
		text = new Serial(result,'').text; 
		return text; 
	} 
	public String add(Object value,Integer nodeLocation){ 
		return add(value,new Serial(text,nodeLocation).nodeLocationInterestedIn); 
	} 
	public String add(Object value){ 
		return add(value,''); 
	} 
	public String remove(String nodeLocation){ 
		Object result = new JSONRemove(new Serial(text,nodeLocation)).execute(); 
		text = new Serial(result,'').text; 
		return text; 
	} 
	public String remove(Integer nodeLocation){ 
		return remove('|'+nodeLocation); 
	} 
	public String edit(Object value,String nodeLocation){ 
		Object result = new JSONEdit(new Serial(text,nodeLocation,value)).execute(); 
		text = new Serial(result,'').text; 
		return text; 
	} 
	public String edit(Object value,Integer nodeLocation){ 
		return edit(value, '|'+nodeLocation); 
	} 
}