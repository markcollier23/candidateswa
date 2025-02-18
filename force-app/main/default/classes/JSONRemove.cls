<<<<<<< HEAD
//Author: Mark Collier 
public class JSONRemove extends JSONLocator { 
=======
/** 
* Name: JSONRemove 
* Purpose: Apex Class responsible for deleting data from a JSON payload. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
public class JSONRemove extends JSONLocator { 
	/** 
	* Name: JSONRemove 
	* Purpose: Constructor used to control and direct the neccessary operations for this Apex Class. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public JSONRemove(Serial jso) { 
        globalJSONSerial = jso; 
        nodePath = getLocations(); 
    } 
<<<<<<< HEAD
=======
	/** 
	* Name: execute 
	* Purpose: To execute the process of deleting data from a JSON payload. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public Object execute(){ 
        if(retrieve()==null){ 
            return globalJSONSerial.getObject(); 
        } 
        Object value = remove(nodePath.size()-1); 
        Object remover = ''; 
        for(Integer i = nodePath.size()-2;i>=0;i--){ 
            remover = remove(i); 
            value = add(remover,nodePath[i],value); 
        } 
        return value; 
    } 
<<<<<<< HEAD
=======
	/** 
	* Name: remove 
	* Purpose: Remove a node within this existing json payload based on an index value in the list. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public Object remove(Integer index){ 
        localJSONSerial = new Serial(getGlobalObject(index-1),nodePath[index]); 
        return getLocalObject(); 
    } 
<<<<<<< HEAD
=======
	/** 
	* Name: add 
	* Purpose: To add a particular value to a node that may have had the path removed.. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public Object add(Object node,String path,Object value){ 
        JSONAdd removedNodePath = new JSONAdd(new Serial(node,path,value)); 
        return removedNodePath.execute(); 
    } 
<<<<<<< HEAD
=======
	/** 
	* Name: retrieve 
	* Purpose: To retrieve the existing global payload as an Object type.. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
>>>>>>> 7f59af60845f5b4952492f38fab5d498479ca08b
    public Object retrieve(){ 
        JSONGet jget = new JSONGet(globalJSONSerial); 
        jget.execute(); 
        return jget.getLocalObject(); 
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
    public virtual Serial get(Integer i){ 
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
    public virtual Object getGlobalObject(Integer i){ 
        Object jsonText; 
        if(i<0){ 
            jsonText = globalJSONSerial.text; 
        }else{ 
            jsonText = get(i).valueToBeAssignedToNodeLocation; 
        } 
        return jsonText; 
    } 
}