//Author: Mark Collier 
public abstract class JSONLocator{ 
    public Serial globalJSONSerial = new Serial('{}',0,new List<String>()); 
    public Serial localJSONSerial = new Serial('{}',0,new List<String>()); 
    public List<String> nodePath = new List<String>(); 
    public virtual List<String> getLocations(){ 
        return globalJSONSerial.nodeLocationInterestedIn.split(':'); 
    } 
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
    public virtual List<Object> getLocalList(){ 
        return new Serial(getLocalObject(),0,'').getList(); 
    } 
    public virtual Map<String,Object> getLocalMap(){ 
        return new Serial(getLocalObject(),0,'').getMap(); 
    } 
    public virtual String getLocalString(){ 
        return new Serial(getLocalObject(),0,'').text; 
    } 
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
    public virtual Object doLocationNoIndex(){ 
        try{ 
            Map<String, Object> jsonMap = localJSONSerial.getMap(); 
            jsonMap.remove(localJSONSerial.getLocation()); 
            return jsonMap; 
        }catch(Exception e){ 
            return localJSONSerial.getObject(); 
        } 
    } 
    public virtual Object doNoLocationOrIndex(){ 
        return ''; 
    } 
    public virtual String getNodePath(Integer lastIndex){ 
        String path = nodePath[0]; 
        for(Integer i=1;i<=lastIndex;i++) path+=':'+nodePath[i]; 
        return path; 
    } 
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