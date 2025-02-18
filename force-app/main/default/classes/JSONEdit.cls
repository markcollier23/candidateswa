<<<<<<< HEAD
//Author: Mark Collier 
public class JSONEdit extends JSONLocator{ 
=======
/** 
* Name: JSONEdit 
* Purpose: Apex Class responsible for adding data to a JSON payload. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
public class JSONEdit extends JSONLocator{ 
	/** 
	* Name: JSONEdit 
	* Purpose: Constructor used to control and direct the neccessary operations for this Apex Class. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public JSONEdit(Serial jso) { 
        globalJSONSerial = jso; 
        nodePath = getLocations(); 
    } 
<<<<<<< HEAD
=======
	/** 
	* Name: execute 
	* Purpose: To execute the process of adding data to a JSON payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public Object execute(){ 
        Object valueToIncrementOn = globalJSONSerial.valueToBeAssignedToNodeLocation; 
        for(Integer i=nodePath.size()-1;i>=0;i--){ 
            Serial node = get(i); 
            if(node.hasIndex()){ 
                localJSONSerial = new Serial(getGlobalObject(i-1),node.nodeLocationInterestedIn,valueToIncrementOn); 
            }else{ 
                localJSONSerial = new Serial(node.valueToBeAssignedToNodeLocation,'',valueToIncrementOn); 
                if(localJSONSerial.isList() || localJSONSerial.isMap()){ 
                    localJSONSerial = new Serial('{}',nodePath[i],getLocalObject()); 
                }else{ 
                    localJSONSerial = new Serial(node.text,nodePath[i],valueToIncrementOn); 
                } 
            } 
             String loc = localJSONSerial.nodeLocationInterestedIn; 
             Object val = localJSONSerial.valueToBeAssignedToNodeLocation; 
             Object tex = new JSONRemove(localJSONSerial).execute(); 
             localJSONSerial = new Serial(tex,loc,val); 
            valueToIncrementOn = getLocalObject(); 
        } 
        if (localJSONSerial.hasIndex()) { 
            return valueToIncrementOn; 
        } 
        localJSONSerial = new Serial(globalJSONSerial.text,'',valueToIncrementOn); 
        Object local = getLocalObject(); 
        return local; 
    } 
<<<<<<< HEAD
=======
	/** 
	* Name: doLocationAndIndex 
	* Purpose: To override the return of the json object found assuming the path has a location and index. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public override Object doLocationAndIndex(){ 
        Serial current = localJSONSerial; 
        if(current.isList()){ 
            Map<String,Object> newValue = new Map<String,Object>(); 
            List<Object> currentValue = current.getList(); 
            Integer i = current.getIndex(); 
            localJSONSerial = new Serial(currentValue,i,current.valueToBeAssignedToNodeLocation); 
            newValue.put(current.getLocation(),doIndexNoLocation()); 
            return newValue; 
        } 
        Map<String,Object> insertINTO = localJSONSerial.getMap(); 
        if(insertINTO==null)insertINTO = new Map<String,Object>(); 
        localJSONSerial = new Serial(insertINTO.get(current.getLocation()),current.getIndex(),current.valueToBeAssignedToNodeLocation); 
        insertINTO.put(current.getLocation(),doIndexNoLocation()); 
        localJSONSerial = current; 
        return insertINTO; 
    } 
<<<<<<< HEAD
=======
	/** 
	* Name: doIndexNoLocation 
	* Purpose: To override the return of the json object found assuming the path has an index but no location.. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
	public override Object doIndexNoLocation(){ 
        List<Object> current = new List<Object>(); 
		if(localJSONSerial.isList()){ 
			current = localJSONSerial.getList(); 
		}else{ 
            current.add(localJSONSerial.getMap()); 
        } 
        List<Object> instances = new List<Object>();  
		for(Integer to=0;to<localJSONSerial.getIndex();to++){ 
			try{ 
                instances.add(current[to]); 
			}catch(Exception e){ 
				instances.add(''); 
            } 
		} 
        instances.add(localJSONSerial.valueToBeAssignedToNodeLocation);  
        if(current!=null) 
            for(Integer i = localJSONSerial.getIndex();i<current.size();i++){ 
                instances.add(current[i]); 
            } 
		return instances;  
    }  
<<<<<<< HEAD
=======
	/** 
	* Name: addLocalKeyAndValue 
	* Purpose: To return an additional key value pair. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public Object addLocalKeyAndValue(Object item){ 
        Map<String,Object> itemToAdd = (Map<String,Object>)item; 
        itemToAdd.put(localJSONSerial.getLocation(),localJSONSerial.valueToBeAssignedToNodeLocation); 
        return itemToAdd; 
    } 
<<<<<<< HEAD
=======
	/** 
	* Name: doLocationNoIndex 
	* Purpose: To override the return of the json object found assuming the path has a location but no index. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public override Object doLocationNoIndex(){ 
        Map<String,Object> jsonMap = localJSONSerial.getMap(); 
        if(jsonMap==null){ 
            JSONGet jget = new JSONGet(new Serial('{}',localJSONSerial.nodeLocationInterestedIn,localJSONSerial.valueToBeAssignedToNodeLocation)); 
            jget.execute(); 
            return addLocalKeyAndValue(new Map<String,Object>()); 
        } 
        jsonMap.put(localJSONSerial.getLocation(),localJSONSerial.valueToBeAssignedToNodeLocation); 
        return jsonMap; 
    } 
<<<<<<< HEAD
=======
	/** 
	* Name: doNoLocationOrIndex 
	* Purpose: To override the return of the json object found assuming the path has no location or index. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public override Object doNoLocationOrIndex(){ 
        Serial valueSerial = new Serial(localJSONSerial.valueToBeAssignedToNodeLocation,'',''); 
        if(localJSONSerial.isEmpty() && valueSerial.isEmpty()){ 
            return null; 
        } 
        if(localJSONSerial.isList()){ 
            return concatList(localJSONSerial, valueSerial); 
        } 
        if(localJSONSerial.isMap()){ 
            return concatMap(localJSONSerial, valueSerial,true); 
        } 
        if(valueSerial.isMap()){ 
            return concatMap(valueSerial, localJSONSerial,false); 
        } 
        return concatList(localJSONSerial,valueSerial); 
    } 
<<<<<<< HEAD
=======
	/** 
	* Name: get 
	* Purpose: Retrieve a node within this existing json payload based on an index value in the list. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public Serial get(Integer i){ 
        JSONGet jget = new JSONGet(new Serial(globalJSONSerial.text,getNodePath(i))); 
        if(jget.globalJSONSerial.nodeLocationInterestedIn=='')jget.globalJSONSerial.text = '{}'; 
        jget.execute(); 
        Object doOperation = jget.getLocalObject(); 
        localJSONSerial = new Serial('',nodePath[i],doOperation); 
        return new Serial(getLocalString(),nodePath[i],doOperation); 
    } 
<<<<<<< HEAD
=======
	/** 
	* Name: getGlobalObject 
	* Purpose: Retrieve a global node within this existing json payload based on an index value in the list. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public Object getGlobalObject(Integer i){ 
        Object jsonText; 
        if(i<0){ 
            jsonText = globalJSONSerial.text; 
        }else{ 
            jsonText = get(i).valueToBeAssignedToNodeLocation; 
        } 
        return jsonText; 
    } 
}