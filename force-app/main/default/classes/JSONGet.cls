//Author: Mark Collier 
public class JSONGet extends JSONLocator{ 
    public JSONGet(Serial jso) { 
        globalJSONSerial = jso; 
        nodePath = getLocations(); 
    } 
    public void execute(){ 
        localJSONSerial = new Serial(globalJSONSerial.text,nodePath.get(0)); 
        for(Integer i=1;i<nodePath.size();i++){ 
            localJSONSerial = new Serial(getLocalObject(),nodePath.get(i)); 
        } 
    } 
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
    public override Object doLocationNoIndex(){ 
        Map<String,Object> jmap = localJSONSerial.getMap(); 
        if(jmap==null) return null; 
        return jmap.get(localJSONSerial.getLocation()); 
    } 
    public override Object doNoLocationOrIndex(){ 
        return globalJSONSerial.getObject(); 
    } 
}