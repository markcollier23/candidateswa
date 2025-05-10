/** 
* Name: APIPayload    
* Purpose: To enable api requests to be called.    
*     
* Who            When           Ref            What                       
* --------------------------------------------------------------------    
* Mark Collier   10/12/2024     API            API_Payload_Handler__c     
* Mark Collier   10/12/2024     API            API_Payload_Handler__c    
* Mark Collier   10/12/2024     API            API_Payload_Handler__c   
* Mark Collier   10/12/2024     API            API_Payload_Handler__c  
* Mark Collier   05/05/2025     SearchEngine   API_Payload_Handler__c 
* --------------------------------------------------------------------    
**/    
trigger APIPayload on API_Payload_Handler__c (after delete, after insert, after undelete, after update, before insert, before update) {
	if ((Boolean)DynamicLabel.get('ActivateAPIPayload__c')){
		TriggerFactory.createAndExecuteHandler(Trig_APIPayload.class);
	}
}
