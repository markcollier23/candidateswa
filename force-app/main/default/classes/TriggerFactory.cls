/** 
* Name: TriggerFactory 
* Purpose: To instantiate, direct and control the necessary operations required to invoke the relevant Trigger. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   10/12/2024     API            All              
* ------------------------------------------------------------- 
**/ 
public class TriggerFactory { 
    // Set to bypass Trigger Handlers 
    private static Set<Type> bypassHandlerSet = new Set<Type>(); 
	/** 
	* Name: createAndExecuteHandler 
	* Purpose: To allow for logging and tracking of API requests to occur within this Salesforce Org. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
    public static void createAndExecuteHandler(Type vType) { 
        // mechanism to bypass Handler 
        if(bypassHandlerSet.contains(vType)){ 
            return; 
        } 
        else { 
            // Get a handler appropriate to the object being processed 
            TriggerInterface handler = (TriggerInterface) vtype.newInstance(); 
            execute(handler); 
        } 
    } 
	/** 
	* Name: execute 
	* Purpose: To perform the operations required to invoke the relevant Trigger. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
    private static void execute(TriggerInterface handler) { 
        if(Trigger.isBefore) { 
            if(Trigger.isInsert) { 
                handler.beforeInsert(Trigger.New); 
            } 
            else if(Trigger.isUpdate) { 
                handler.beforeUpdate(Trigger.NewMap, Trigger.OldMap); 
            } 
            else if(Trigger.isDelete) { 
                handler.beforeDelete(Trigger.OldMap); 
            } 
        } 
        else { 
            if(Trigger.isInsert) { 
                handler.afterInsert(Trigger.NewMap); 
            } 
            else if(Trigger.isUpdate) { 
                handler.afterUpdate(Trigger.NewMap, Trigger.OldMap); 
            } 
            else if(Trigger.isDelete) { 
                handler.afterDelete(Trigger.OldMap); 
            } 
            else if(Trigger.isUndelete) { 
                handler.afterUndelete(Trigger.NewMap); 
            } 
        } 
    } 
	/** 
	* Name: bypassHandler 
	* Purpose: Allows you to bypass the Trigger Handler and the execution of this trigger. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
    public static void bypassHandler(Type vType){ 
        bypassHandlerSet.add(vType); 
    } 
	/** 
	* Name: removeBypassHandler 
	* Purpose: Allows you to remove a Trigger Handler from the bypass set. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
    public static void removeBypassHandler(Type vType){ 
        bypassHandlerSet.remove(vType); 
    } 
	/** 
	* Name: removeAllBypassHandlers 
	* Purpose: Allows you to remove all Trigger Handlers from the bypass set. 
	*  
	* Who            When           Ref            What                    
	* -------------------------------------------------------------------- 
	* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
	* -------------------------------------------------------------------- 
	**/ 
    public static void removeAllBypassHandlers(){ 
        bypassHandlerSet.clear(); 
    } 
}