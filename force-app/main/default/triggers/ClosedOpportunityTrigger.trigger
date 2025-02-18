trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
    List<Task> tasks = new List<Task>();
    for (Opportunity o : Trigger.New){
        if(o.StageName=='Closed Won'){
           tasks.add(new Task(Subject='Follow Up Test Task',WhatId=o.Id));
        }
    }
    insert tasks;
}