/** 
* Name: TriggerInterface
* Purpose: To allow for a Trigger framework to be used when records in Salesforce are modified.
* 
* Who            When           Ref            What            
* -------------------------------------------------------------
* Mark Collier   13/04/2025     trans          All             
* -------------------------------------------------------------
**/
public interface TriggerInterface {
    /* Below methods are called during a specific trigger context. */
    void beforeInsert(List<SObject> newRecords);
    void beforeUpdate(Map<Id, SObject> mapNewRecords, Map<Id, SObject> mapOldRecords);
    void beforeDelete(Map<Id, SObject> mapOldRecords);
    void afterInsert(Map<Id, SObject> mapNewRecords);
    void afterUpdate(Map<Id, SObject> mapNewRecords, Map<Id, SObject> mapOldRecords);
    void afterDelete(Map<Id, SObject> mapOldRecords);
    void afterUndelete(Map<Id, SObject> mapNewRecords);
}