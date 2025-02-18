<<<<<<< HEAD
//Author: Mark Collier 
=======
/** 
* Name: JSONLocator 
* Purpose: Abstract class which allows maps and strings to be created based on information on Serial.cls. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
public abstract class JSONLocator{ 
    public Serial globalJSONSerial = new Serial('{}',0,new List<String>()); 
    public Serial localJSONSerial = new Serial('{}',0,new List<String>()); 
    public List<String> nodePath = new List<String>(); 
<<<<<<< HEAD
    public virtual List<String> getLocations(){ 
        return globalJSONSerial.nodeLocationInterestedIn.split(':'); 
    } 
=======
	/** 
	* Name: getLocations 
	* Purpose: Return the list of locations in the path that is required. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public virtual List<String> getLocations(){ 
        return globalJSONSerial.nodeLocationInterestedIn.split(':'); 
    } 
	/** 
	* Name: getLocalObject 
	* Purpose: Return the json object found as an Object. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public virtual Object getLocalObject(){ 
        if(localJSONSerial.hasLocationAndIndex()) 
            return doLocationAndIndex(); 
        if(localJSONSerial.hasIndexNoLocation()) 
            return doIndexNoLocation(); 
        if(localJSONSerial.hasLocationNoIndex()) 
            return doLocationNoIndex(); 
        if(localJSONSerial.hasNoIndexOrLocation()) 
            return doNoLocationOrIndex(); 
        return null; 
    } 
<<<<<<< HEAD
    public virtual List<Object> getLocalList(){ 
        return new Serial(getLocalObject(),0,'').getList(); 
    } 
    public virtual Map<String,Object> getLocalMap(){ 
        return new Serial(getLocalObject(),0,'').getMap(); 
    } 
    public virtual String getLocalString(){ 
        return new Serial(getLocalObject(),0,'').text; 
    } 
=======
	/** 
	* Name: getLocalList 
	* Purpose: Return the json object found as a List. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public virtual List<Object> getLocalList(){ 
        return new Serial(getLocalObject(),0,'').getList(); 
    } 
	/** 
	* Name: getLocalMap 
	* Purpose: Return the json object found as a Map. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public virtual Map<String,Object> getLocalMap(){ 
        return new Serial(getLocalObject(),0,'').getMap(); 
    } 
	/** 
	* Name: getLocalString 
	* Purpose: Return the json object found as a String. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public virtual String getLocalString(){ 
        return new Serial(getLocalObject(),0,'').text; 
    } 
	/** 
	* Name: doLocationAndIndex 
	* Purpose: Return the json object found assuming the path has a location and index. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public virtual Object doLocationAndIndex(){ 
        try{ 
            Map<String, Object> jsonMap = localJSONSerial.getMap(); 
            String key = localJSONSerial.getLocation(); 
            localJSONSerial = new Serial(jsonMap.get(key),localJSONSerial.getIndex()); 
            jsonMap.put(key,doIndexNoLocation()); 
            return jsonMap; 
        }catch(Exception e){ 
            return localJSONSerial.getObject(); 
        } 
    } 
<<<<<<< HEAD
=======
	/** 
	* Name: doIndexNoLocation 
	* Purpose: Return the json object found assuming the path has a location and index. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public virtual Object doIndexNoLocation(){ 
		List<Object> jsonList = new List<Object>(); 
		if(!localJSONSerial.isEmpty()){ 
			jsonList = localJSONSerial.getList(); 
			if(jsonList!=null && jsonList.size()>localJSONSerial.getIndex()){ 
				jsonList.remove(localJSONSerial.getIndex());  
			} 
		} 
        return jsonList; 
    } 
<<<<<<< HEAD
=======
	/** 
	* Name: doLocationNoIndex 
	* Purpose: Return the json object found assuming the path has a location and index. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public virtual Object doLocationNoIndex(){ 
        try{ 
            Map<String, Object> jsonMap = localJSONSerial.getMap(); 
            jsonMap.remove(localJSONSerial.getLocation()); 
            return jsonMap; 
        }catch(Exception e){ 
            return localJSONSerial.getObject(); 
        } 
    } 
<<<<<<< HEAD
    public virtual Object doNoLocationOrIndex(){ 
        return ''; 
    } 
=======
	/** 
	* Name: doNoLocationOrIndex 
	* Purpose: Return the json object found assuming the path has no location nor index. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public virtual Object doNoLocationOrIndex(){ 
        return ''; 
    } 
	/** 
	* Name: getNodePath 
	* Purpose: Return a particular part of the Node Path.. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public virtual String getNodePath(Integer lastIndex){ 
        String path = nodePath[0]; 
        for(Integer i=1;i<=lastIndex;i++) path+=':'+nodePath[i]; 
        return path; 
    } 
<<<<<<< HEAD
=======
	/** 
	* Name: concatMap 
	* Purpose: To concatenate 2 nodes into a map object. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public virtual Object concatMap(Serial mapSerial,Serial valueSerial,boolean inThisOrder){ 
        if(mapSerial.isEmpty()) 
            return valueSerial.getObject(); 
        if(valueSerial.isEmpty()) 
            return mapSerial.getObject(); 
        Map<String,Object> jsonMap = mapSerial.getMap(); 
        if(valueSerial.isMap()){ 
            Map<String,Object> valueMap = valueSerial.getMap(); 
            jsonMap.putAll(valueMap); 
            return jsonMap; 
        } 
        if(inThisOrder)return concatList(mapSerial, valueSerial); 
        return concatList(valueSerial,mapSerial); 
    } 
<<<<<<< HEAD
=======
	/** 
	* Name: concatMap 
	* Purpose: To concatenate 2 nodes into a list object. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public virtual Object concatList(Serial localSerial,Serial valueSerial){ 
        List<Object> local = new List<Object>(); 
        if(!localSerial.isEmpty()) 
            if(localSerial.isList()){ 
                local = localSerial.getList(); 
            }else{ 
                local.add(localSerial.getObject()); 
            } 
        if(valueSerial.isEmpty()) 
            return local; 
        if(valueSerial.isList()){ 
            local.addAll(valueSerial.getList()); 
            return local; 
        } 
        local.add(valueSerial.getObject()); 
        return local; 
    } 
}