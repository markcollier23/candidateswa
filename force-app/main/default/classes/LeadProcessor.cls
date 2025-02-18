global class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful {
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT LeadSource FROM Lead');
    }
    global void execute(Database.BatchableContext bc, List<Lead> leads){
        for(Lead lead:leads){
            lead.LeadSource = 'Dreamforce';
        }
        update leads;
    }
     global void finish(Database.BatchableContext bc){
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
         System.debug(job);
    }    
}