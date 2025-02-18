/** 
* Name: MapFactory 
* Purpose: To enable api requests to be called. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
public abstract class MapFactory{ 
    public List<SObject> records = new List<SObject>(); //the list of records retrieved from the query is used to reduce the number of SOQL queries. 
    public Map<Object,List<SObject>> idMap = new Map<Object,List<SObject>>();//Used to reduce the CPU time. 
    public Object key = 'Enter key here';//Used to group the records by a specific value. 
	/** 
	* Name: query 
	* Purpose: The purpose of the following method is to override and return the preferred SOQL query e.g [SELECT Id FROM Account]. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public virtual List<SObject> query(){ 
        return records;//do your query here 
    } 
	/** 
	* Name: getKey 
	* Purpose: The purpose of the following method is to override and return the preferred way to group the list above. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public virtual Object getKey(SObject instance){ 
        return key; 
    } 
	/** 
	* Name: retrieveAll 
	* Purpose: The purpose of the following method is to ensure a SOQL query is only executed if it is really needed. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public virtual List<SObject> retrieveAll(){ 
        if(isEmpty(records)){ 
            records = query(); 
        } 
        return records; 
    } 
	/** 
	* Name: retrieveMap 
	* Purpose: The purpose of the following method is to perform the grouping of a List of records by a specific key. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public virtual Map<Object,List<SObject>> retrieveMap(){ 
        System.debug('Start retrieveMap for loop:'); 
        for(SObject instance:retrieveAll()){ 
            System.debug('[RETRIEVEMAP FOR LOOP] instance = '+instance); 
            add(instance); 
        } 
        System.debug('End retrieveMap for loop:'); 
        return idMap; 
    } 
	/** 
	* Name: add 
	* Purpose: The pupose of the following method is to add an SObject record to a group within the map as specified by the getKey() method. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public virtual Map<Object,List<SObject>> add(SObject instance){ 
        System.debug('[INSIDE ADD] instance = '+instance); 
        List<SObject> related = new List<SObject>(); 
        key = getKey(instance); 
        System.debug('[INSIDE ADD] key = '+key); 
        if(idMap.containsKey(key)){ 
            related = idMap.get(key); 
           System.debug('[INSIDE ADD][INSIDE IF] related = '+related); 
        } 
        related.add(instance); 
        System.debug('[INSIDE ADD] related = '+related); 
        idMap.put(key,related); 
        System.debug('[INSIDE ADD] idMap = '+idMap); 
        return idMap; 
    } 
	/** 
	* Name: addAll 
	* Purpose: The pupose of the following method is to add a list of SObject records to a group within the map as specified by the getKey() method. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public virtual Map<Object,List<SObject>> addAll(List<SObject> instances){ 
        for(SObject instance:instances){ 
            add(instance); 
        } 
        return idMap; 
    } 
	/** 
	* Name: isEmpty 
	* Purpose: The purpose of the following method is to check whether a specified list of SObjects are empty. 
	*  
	* Who            When           Ref            What                      
	* ---------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            Method has been created.  
	* ---------------------------------------------------------------------- 
	**/ 
    public virtual Boolean isEmpty(List<SObject> objects){ 
        if(objects==null){ 
            return true; 
        } 
        return objects.size()<1; 
    } 
}