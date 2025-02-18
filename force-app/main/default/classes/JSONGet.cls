/** 
* Name: JSONGet 
* Purpose: Apex Class responsible for retrieving data from a JSON payload. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
public class JSONGet extends JSONLocator{ 
	/** 
	* Name: JSONGet 
	* Purpose: Constructor used to control and direct the neccessary operations for this Apex Class. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public JSONGet(Serial jso) { 
        globalJSONSerial = jso; 
        nodePath = getLocations(); 
    } 
	/** 
	* Name: execute 
	* Purpose: To execute the process of returning the json node requested. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public void execute(){ 
        localJSONSerial = new Serial(globalJSONSerial.text,nodePath.get(0)); 
        for(Integer i=1;i<nodePath.size();i++){ 
            localJSONSerial = new Serial(getLocalObject(),nodePath.get(i)); 
        } 
    } 
	/** 
	* Name: doLocationAndIndex 
	* Purpose: To override the return of the json object found assuming the path has a location and index. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public override Object doLocationAndIndex(){ 
        Map<String,Object> jmap = localJSONSerial.getMap(); 
        if(jmap==null) return null; 
        List<Object> result = new Serial(jmap.get(localJSONSerial.getLocation()),0).getList(); 
        if(result==null) return null; 
        Integer i = localJSONSerial.getIndex(); 
        try{ 
            return result.get(i); 
        }catch(Exception e){ 
            return null; 
        } 
    } 
	/** 
	* Name: doIndexNoLocation 
	* Purpose: To override the return of the json object found assuming the path has an index but no location.. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public override Object doIndexNoLocation(){ 
        List<Object> result = localJSONSerial.getList(); 
        if(result==null) return null; 
        try{ 
            return result.get(localJSONSerial.getIndex()); 
        }catch(Exception e){ 
            result.add(''); 
            return result.get(0); 
        } 
    } 
	/** 
	* Name: doIndexNoLocation 
	* Purpose: To override the return of the json object found assuming the path has a location but no index.. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public override Object doLocationNoIndex(){ 
        Map<String,Object> jmap = localJSONSerial.getMap(); 
        if(jmap==null) return null; 
        return jmap.get(localJSONSerial.getLocation()); 
    } 
	/** 
	* Name: doNoLocationOrIndex 
	* Purpose: To override the return of the json object found assuming the path has no location or index.. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public override Object doNoLocationOrIndex(){ 
        return globalJSONSerial.getObject(); 
    } 
}