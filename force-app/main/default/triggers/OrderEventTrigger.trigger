trigger OrderEventTrigger on Order_Event__e (after insert) {
    List<Task> tasks = new List<Task>();
    for(Order_Event__e event:Trigger.New){
        if(event.Has_Shipped__c){
            String subj = 'Follow up on shipped order ' + event.Order_Number__c;
            tasks.add(new Task(Subject = subj,Priority = 'Medium',OwnerId = event.CreatedById));
        }
    }
    insert tasks;
}