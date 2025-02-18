//Author: Mark Collier 
//Purpose: To perform type conversions for a particular JSON text.  
public class Serial{  
	public String text = '{}';  
	public String nodeLocationInterestedIn = '';  
	public Object valueToBeAssignedToNodeLocation = '';  
	//Constructor designed for adding values to a JSON object. 
	public Serial(String textParameter,String nodeLocationInterestedInParameter,Object valueToBeAssignedToNodeLocationParameter){  
		text = textParameter;  
		nodeLocationInterestedIn = nodeLocationInterestedInParameter;  
		valueToBeAssignedToNodeLocation = valueToBeAssignedToNodeLocationParameter;  
	}  
	//Constructor designed for retrieving values from a JSON object. 
	public Serial(String textParameter,String nodeLocationInterestedInParameter){  
		text = textParameter;  
		nodeLocationInterestedIn = nodeLocationInterestedInParameter;  
	}  
	//Constructor designed for adding values to a JSON object. 
	public Serial(Object textParameter,String nodeLocationInterestedInParameter,Object valueToBeAssignedToNodeLocationParameter){  
		text = JSON.serialize(textParameter);  
		nodeLocationInterestedIn = nodeLocationInterestedInParameter;  
		valueToBeAssignedToNodeLocation = valueToBeAssignedToNodeLocationParameter;  
	}  
	//Constructor designed for retrieving values from a JSON object. 
	public Serial(Object textParameter,String nodeLocationInterestedInParameter){  
		text = JSON.serialize(textParameter);  
		nodeLocationInterestedIn = nodeLocationInterestedInParameter;  
	}  
	//Constructor designed for adding values to a JSON object. 
	public Serial(String textParameter,Integer index,Object valueToBeAssignedToNodeLocationParameter){  
		text = textParameter;  
		nodeLocationInterestedIn = '|'+index;  
		valueToBeAssignedToNodeLocation = valueToBeAssignedToNodeLocationParameter;  
	}  
	//Constructor designed for retrieving values from a JSON object. 
	public Serial(String textParameter,Integer index){  
		text = textParameter;  
		nodeLocationInterestedIn = '|'+index;  
	}   
	//Constructor designed for adding values to a JSON object. 
	public Serial(Object textParameter,Integer index,Object valueToBeAssignedToNodeLocationParameter){  
		text = JSON.serialize(textParameter);  
		nodeLocationInterestedIn = '|'+index;  
		valueToBeAssignedToNodeLocation = valueToBeAssignedToNodeLocationParameter;  
	}  
	//Constructor designed for retrieving values from a JSON object. 
	public Serial(Object textParameter,Integer index){  
		text = JSON.serialize(textParameter);  
		nodeLocationInterestedIn = '|'+index;  
	} 
	public Object getObject(){ 
		String removeSlash = text.replace('\\\"','"'); 
		removeSlash = removeSlash.replace('"{','{').replace('"[','[').replace('}"','}').replace(']"',']'); 
		removeSlash = removeSlash.replace('"{','{').replace('"[','[').replace('}"','}').replace(']"',']'); 
		String resultText = removeSlash.replace('"{','{').replace('"[','[').replace('}"','}').replace(']"',']'); 
		try{ 
			return JSON.deserializeUntyped(resultText); 
		}catch(Exception NotAJSONObject){ 
			try{ 
				return JSON.deserializeUntyped('['+resultText+']'); 
			}catch(Exception NoQuotesAvailable){ 
				return JSON.deserializeUntyped('["'+resultText+'"]'); 
			} 
		} 
	} 
	public List<Object> getList(){ 
		if(isList()){ 
			return (List<Object>)getObject(); 
		} 
		return null; 
	} 
	public Map<String,Object> getMap(){ 
		if(!isList() && isMap()) { 
			return (Map<String,Object>)getObject(); 
		} 
		return null; 
	} 
	public boolean isList(){ 
		try{ 
			List<Object> convertToAList = (List<Object>)getObject(); 
			return convertToAList!=null; 
		}catch(Exception e){ 
			return false; 
		} 
	} 
	public boolean isMap(){ 
		try{ 
			Map<String,Object> convertToAMap = (Map<String,Object>)getObject(); 
			return convertToAMap!=null; 
		}catch(Exception e){ 
			return false; 
		} 
	} 
	public boolean isEmpty(){ 
		if(text==null){ 
			return true; 
		} 
		String check = text.replace('\"','').replace('\"','').replace('{','').replace('}','').replace('[','').replace(']',''); 
		return check==''||check=='null'; 
	} 
	public boolean hasNoIndexOrLocation(){ 
		return nodeLocationInterestedIn==''; 
	} 
	public boolean hasIndex(){ 
		List<String> locIndex = nodeLocationInterestedIn.split('\\|'); 
		return locIndex.size()==2; 
	} 
	public boolean hasLocation(){ 
		List<String> locIndex = nodeLocationInterestedIn.split('\\|'); 
		return locIndex.get(0)!=''; 
	} 
	public boolean hasIndexNoLocation(){ 
		return hasIndex() && !hasLocation(); 
	} 
	public boolean hasLocationNoIndex(){ 
		return hasLocation() && !hasIndex(); 
	} 
	public boolean hasLocationAndIndex(){ 
		return hasLocation() && hasIndex(); 
	} 
	public Integer getIndex(){ 
		System.assert(hasIndex(),'The node location '+nodeLocationInterestedIn+' does not have an index in '+text); 
		return Integer.valueOf(nodeLocationInterestedIn.split('\\|').get(1)); 
	} 
	public String getLocation(){ 
		System.assert(hasLocation(),'The node location we are meant to be interested in is empty!'); 
		return nodeLocationInterestedIn.split('\\|').get(0); 
	} 
}