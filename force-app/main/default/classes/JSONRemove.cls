//Author: Mark Collier 
public class JSONRemove extends JSONLocator { 
    public JSONRemove(Serial jso) { 
        globalJSONSerial = jso; 
        nodePath = getLocations(); 
    } 
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
    public Object remove(Integer index){ 
        localJSONSerial = new Serial(getGlobalObject(index-1),nodePath[index]); 
        return getLocalObject(); 
    } 
    public Object add(Object node,String path,Object value){ 
        JSONAdd removedNodePath = new JSONAdd(new Serial(node,path,value)); 
        return removedNodePath.execute(); 
    } 
    public Object retrieve(){ 
        JSONGet jget = new JSONGet(globalJSONSerial); 
        jget.execute(); 
        return jget.getLocalObject(); 
    } 
    public virtual Serial get(Integer i){ 
        JSONGet jget = new JSONGet(new Serial(globalJSONSerial.text,getNodePath(i))); 
        if(jget.globalJSONSerial.nodeLocationInterestedIn=='')jget.globalJSONSerial.text = '{}'; 
        jget.execute(); 
        Object doOperation = jget.getLocalObject(); 
        localJSONSerial = new Serial('',nodePath[i],doOperation); 
        return new Serial(getLocalString(),nodePath[i],doOperation); 
    } 
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