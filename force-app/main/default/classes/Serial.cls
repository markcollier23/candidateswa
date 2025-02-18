<<<<<<< HEAD
//Author: Mark Collier 
//Purpose: To perform type conversions for a particular JSON text.  
=======
/** 
* Name: Serial 
* Purpose: To perform type conversions for a particular JSON text. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
public class Serial{  
	public String text = '{}';  
	public String nodeLocationInterestedIn = '';  
	public Object valueToBeAssignedToNodeLocation = '';  
<<<<<<< HEAD
	//Constructor designed for adding values to a JSON object. 
=======
	/** 
	* Name: Serial 
	* Purpose: Constructor designed for adding values to a JSON object. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
	public Serial(String textParameter,String nodeLocationInterestedInParameter,Object valueToBeAssignedToNodeLocationParameter){  
		text = textParameter;  
		nodeLocationInterestedIn = nodeLocationInterestedInParameter;  
		valueToBeAssignedToNodeLocation = valueToBeAssignedToNodeLocationParameter;  
<<<<<<< HEAD
	}  
	//Constructor designed for retrieving values from a JSON object. 
=======
	} 
	/** 
	* Name: Serial 
	* Purpose: Constructor designed for retrieving values from a JSON object. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
	public Serial(String textParameter,String nodeLocationInterestedInParameter){  
		text = textParameter;  
		nodeLocationInterestedIn = nodeLocationInterestedInParameter;  
	}  
<<<<<<< HEAD
	//Constructor designed for adding values to a JSON object. 
=======
	/** 
	* Name: Serial 
	* Purpose: Constructor designed for adding values to a JSON object.. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
	public Serial(Object textParameter,String nodeLocationInterestedInParameter,Object valueToBeAssignedToNodeLocationParameter){  
		text = JSON.serialize(textParameter);  
		nodeLocationInterestedIn = nodeLocationInterestedInParameter;  
		valueToBeAssignedToNodeLocation = valueToBeAssignedToNodeLocationParameter;  
	}  
<<<<<<< HEAD
	//Constructor designed for retrieving values from a JSON object. 
=======
	/** 
	* Name: Serial 
	* Purpose: Constructor designed for retrieving values from a JSON object.. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
	public Serial(Object textParameter,String nodeLocationInterestedInParameter){  
		text = JSON.serialize(textParameter);  
		nodeLocationInterestedIn = nodeLocationInterestedInParameter;  
	}  
<<<<<<< HEAD
	//Constructor designed for adding values to a JSON object. 
=======
	/** 
	* Name: Serial 
	* Purpose: Constructor designed for adding values to a JSON object.. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
	public Serial(String textParameter,Integer index,Object valueToBeAssignedToNodeLocationParameter){  
		text = textParameter;  
		nodeLocationInterestedIn = '|'+index;  
		valueToBeAssignedToNodeLocation = valueToBeAssignedToNodeLocationParameter;  
	}  
<<<<<<< HEAD
	//Constructor designed for retrieving values from a JSON object. 
=======
	/** 
	* Name: Serial 
	* Purpose: Constructor designed for retrieving values from a JSON object.. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
	public Serial(String textParameter,Integer index){  
		text = textParameter;  
		nodeLocationInterestedIn = '|'+index;  
	}   
<<<<<<< HEAD
	//Constructor designed for adding values to a JSON object. 
=======
	/** 
	* Name: Serial 
	* Purpose: Constructor designed for adding values to a JSON object.. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
	public Serial(Object textParameter,Integer index,Object valueToBeAssignedToNodeLocationParameter){  
		text = JSON.serialize(textParameter);  
		nodeLocationInterestedIn = '|'+index;  
		valueToBeAssignedToNodeLocation = valueToBeAssignedToNodeLocationParameter;  
	}  
<<<<<<< HEAD
	//Constructor designed for retrieving values from a JSON object. 
=======
	/** 
	* Name: Serial 
	* Purpose: Constructor designed for retrieving values from a JSON object.. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
	public Serial(Object textParameter,Integer index){  
		text = JSON.serialize(textParameter);  
		nodeLocationInterestedIn = '|'+index;  
	} 
<<<<<<< HEAD
=======
	/** 
	* Name: getObject 
	* Purpose: To return the JSON payload as an Object. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
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
<<<<<<< HEAD
=======
	/** 
	* Name: getList 
	* Purpose: To return the JSON payload as a List. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
	public List<Object> getList(){ 
		if(isList()){ 
			return (List<Object>)getObject(); 
		} 
		return null; 
	} 
<<<<<<< HEAD
=======
	/** 
	* Name: getMap 
	* Purpose: To return the JSON payload as a Map. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
	public Map<String,Object> getMap(){ 
		if(!isList() && isMap()) { 
			return (Map<String,Object>)getObject(); 
		} 
		return null; 
	} 
<<<<<<< HEAD
=======
	/** 
	* Name: isList 
	* Purpose: To determine whether the json payload is a List. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
	public boolean isList(){ 
		try{ 
			List<Object> convertToAList = (List<Object>)getObject(); 
			return convertToAList!=null; 
		}catch(Exception e){ 
			return false; 
		} 
	} 
<<<<<<< HEAD
=======
	/** 
	* Name: isMap 
	* Purpose: To determine whether the json payload is a Map. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
	public boolean isMap(){ 
		try{ 
			Map<String,Object> convertToAMap = (Map<String,Object>)getObject(); 
			return convertToAMap!=null; 
		}catch(Exception e){ 
			return false; 
		} 
	} 
<<<<<<< HEAD
=======
	/** 
	* Name: isEmpty 
	* Purpose: To determine whether the json payload has no values. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
	public boolean isEmpty(){ 
		if(text==null){ 
			return true; 
		} 
		String check = text.replace('\"','').replace('\"','').replace('{','').replace('}','').replace('[','').replace(']',''); 
		return check==''||check=='null'; 
	} 
<<<<<<< HEAD
	public boolean hasNoIndexOrLocation(){ 
		return nodeLocationInterestedIn==''; 
	} 
=======
	/** 
	* Name: hasNoIndexOrLocation 
	* Purpose: To determine whether the json payload is a json payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public boolean hasNoIndexOrLocation(){ 
		return nodeLocationInterestedIn==''; 
	} 
	/** 
	* Name: hasIndex 
	* Purpose: To determine whether the json payload is a json payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
	public boolean hasIndex(){ 
		List<String> locIndex = nodeLocationInterestedIn.split('\\|'); 
		return locIndex.size()==2; 
	} 
<<<<<<< HEAD
=======
	/** 
	* Name: hasLocation 
	* Purpose: To determine whether the json payload is a json payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
	public boolean hasLocation(){ 
		List<String> locIndex = nodeLocationInterestedIn.split('\\|'); 
		return locIndex.get(0)!=''; 
	} 
<<<<<<< HEAD
	public boolean hasIndexNoLocation(){ 
		return hasIndex() && !hasLocation(); 
	} 
	public boolean hasLocationNoIndex(){ 
		return hasLocation() && !hasIndex(); 
	} 
	public boolean hasLocationAndIndex(){ 
		return hasLocation() && hasIndex(); 
	} 
=======
	/** 
	* Name: hasIndexNoLocation 
	* Purpose: To determine whether the json payload is a json payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public boolean hasIndexNoLocation(){ 
		return hasIndex() && !hasLocation(); 
	} 
	/** 
	* Name: hasLocationNoIndex 
	* Purpose: To determine whether the json payload is a json payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public boolean hasLocationNoIndex(){ 
		return hasLocation() && !hasIndex(); 
	} 
	/** 
	* Name: hasLocationAndIndex 
	* Purpose: To determine whether the json payload is a json payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
	public boolean hasLocationAndIndex(){ 
		return hasLocation() && hasIndex(); 
	} 
	/** 
	* Name: getIndex 
	* Purpose: To retrieve the index we are interested in. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
	public Integer getIndex(){ 
		System.assert(hasIndex(),'The node location '+nodeLocationInterestedIn+' does not have an index in '+text); 
		return Integer.valueOf(nodeLocationInterestedIn.split('\\|').get(1)); 
	} 
<<<<<<< HEAD
=======
	/** 
	* Name: getIndex 
	* Purpose: To retrieve the location we are interested in. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
	public String getLocation(){ 
		System.assert(hasLocation(),'The node location we are meant to be interested in is empty!'); 
		return nodeLocationInterestedIn.split('\\|').get(0); 
	} 
}