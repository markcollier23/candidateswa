/** 
* Name: EnhancementHandler 
* Purpose: To automatically send an email on update of an enhancement record. 
*  
* Who            When           Ref            What             
* ------------------------------------------------------------- 
* Mark Collier   12/12/2023                    SObject   
* ------------------------------------------------------------- 
**/ 
public class EnhancementHandler implements TriggerInterface { 
	/** 
	* Name: beforeInsert 
	* Purpose: To control and direct the necessary operations and actions required to be processed in the event that SObject records are inserted, updated or deleted. 
	*  
	* Who            When           Ref            What                 
	* ----------------------------------------------------------------- 
	* Mark Collier   12/12/2023                    Method was created.  
	* ----------------------------------------------------------------- 
	**/ 
	public void beforeInsert(List<SObject> newRecords){ 
		
    } 
	/** 
	* Name: beforeUpdate 
	* Purpose: . 
	*  
	* Who            When           Ref            What                 
	* ----------------------------------------------------------------- 
	* Mark Collier   12/12/2023                    Method was created.  
	* ----------------------------------------------------------------- 
	**/ 
	public void beforeUpdate(Map<Id, SObject> mapNewRecords, Map<Id, SObject> mapOldRecords){ 
		
    } 
	/** 
	* Name: beforeDelete 
	* Purpose: . 
	*  
	* Who            When           Ref            What                 
	* ----------------------------------------------------------------- 
	* Mark Collier   12/12/2023                    Method was created.  
	* ----------------------------------------------------------------- 
	**/ 
	public void beforeDelete(Map<Id, SObject> mapOldRecords){ 
		
    } 
	/** 
	* Name: afterInsert 
	* Purpose: . 
	*  
	* Who            When           Ref            What                 
	* ----------------------------------------------------------------- 
	* Mark Collier   12/12/2023                    Method was created.  
	* ----------------------------------------------------------------- 
	**/ 
	public void afterInsert(Map<Id, SObject> mapNewRecords){ 
		
    } 
	/** 
	* Name: afterUpdate 
	* Purpose: . 
	*  
	* Who            When           Ref            What                 
	* ----------------------------------------------------------------- 
	* Mark Collier   12/12/2023                    Method was created.  
	* ----------------------------------------------------------------- 
	**/ 
	public void afterUpdate(Map<Id, SObject> mapNewRecords, Map<Id, SObject> mapOldRecords){ 
        for(SObject record:mapNewRecords.values()){
            String subject = record.get('Name')+': '+record.get('Jira_Ref__c')+' - '+record.get('Work_Desc__c');
            String body='<h1>Checkpoint Goal</h1>';
            body+='Success Criteria:<br>'+record.get('Success_Criteria__c')+'<br><br>';
            for(Release__c change:[SELECT Id,Production_Deployment__c FROM Release__c WHERE Id =: (Id)record.get('Release__c')]){
                DateTime releaseDate = DateTime.newInstance(change.Production_Deployment__c,DateTime.now().time());
                body+='When Measured: <br>'+ releaseDate.format('MMMM YYYY')+'<br><br>';
            }
            body+='Measurement:<br><br><ul><li>Expects more: '+record.get('Expects_more__c')+'</li><li>Achieves: '+record.get('Achieves__c')+'</li><li>Exceeds: '+record.get('Exceeds__c')+'</li></ul>';
            body+='<br>Progress:<br>'+record.get('Progress__c');
            body+='<br><h1><a href="https://cloud.workhuman.com/conversations/?client=ibmcorp&setCAG=false#/ibmcorp/14658623/assessments/simple-table/assessment/a34cce2f-534c-49d0-983f-38e149d701f5">Performance Reflection</a>';
            body+='</h1><br>For more information regarding the relation of this to IBM\'s culture formula, please see this below:<br><br><ul>';
            body+='<li>Purpose: As part of the IBM purpose, we promote and support our team to be catalysts of change, improvement and progression therefore by '+record.get('Purpose__c')+'</li>';
            body+='<li>Value: As part of IBM values, we are keen to implement and dedicate innovation that matters for our clients. '+record.get('Value__c')+'</li>';
            body+='<li>Growth Behaviour: I have embraced a growth mindset and have been open and willing to take onboard feedback regarding '+record.get('Growth_Behaviour__c')+'</li>';
            body+='<li>Skills: '+record.get('Skills__c')+'</li>';
            body+='<li>Focus Area: '+record.get('Focus_Area__c')+' </li>';
            body+='</ul><br><h1><a href="https://cloud.workhuman.com/conversations/?client=ibmcorp&setCAG=false#/ibmcorp/14658623/assessments/simple-table/assessment/2da5fe3b-7c2f-48f7-a5eb-8b587c297193">Project Reflection</a>';
            body+='</h1><br>'+record.get('Success_Criteria__c');
            body+='<br>I have provided a positive impact to '+record.get('Deliver_with_impact__c');
            body+='<br>In terms of trust, I have '+record.get('Build_client_trust__c');
            body+='<br>In terms of innovation, I have '+record.get('Innovate_with_purpose__c');
            body+='<br>In terms of the embracement of different perspectives, I have '+record.get('Embrace_diverse_perspectives__c');
            body+='<br>In terms of collaboration, I have '+record.get('Collaborate_to_succeed__c');
            body+='<br>From a Growth Mindset point of view, I have '+record.get('Grow_with_endless_curiosity__c');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {getEmail(subject,body)});
        }
            
    } 
	/** 
	* Name: afterDelete 
	* Purpose: . 
	*  
	* Who            When           Ref            What                 
	* ----------------------------------------------------------------- 
	* Mark Collier   12/12/2023                    Method was created.  
	* ----------------------------------------------------------------- 
	**/ 
	public void afterDelete(Map<Id, SObject> mapOldRecords){ 
		
    } 
	/** 
	* Name: afterUndelete 
	* Purpose: . 
	*  
	* Who            When           Ref            What                 
	* ----------------------------------------------------------------- 
	* Mark Collier   12/12/2023                    Method was created.  
	* ----------------------------------------------------------------- 
	**/ 
	public void afterUndelete(Map<Id, SObject> mapNewRecords){ 
		
    } 
    /** 
	*Name: getEmail
	*Purpose: To enable the retrieval of email messages so that they can be used for sending information to users assigned as Apex Exception Email users. 
	* 
	*Who            When           Ref            What             
	*------------------------------------------------------------- 
	*COLLIEM1       31/08/2023     RITM0808543    LoginHistory     
	*------------------------------------------------------------- 
	**/ 
	public Messaging.SingleEmailMessage getEmail(String subject,String body){
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		List<String> toAddresses = new List<String>();
        for(ApexEmailNotification emailNotification : [SELECT Id, UserId, User.Email, Email FROM ApexEmailNotification]) {
        	if(emailNotification.UserId == NULL) { 
        		toAddresses.add(emailNotification.Email);
			}
			else {
        		toAddresses.add(emailNotification.User.Email);
        	}
        }
		toAddresses.add('markcollier2@gmail.com');
		System.debug(toAddresses);
		mail.setToAddresses(toAddresses);
		mail.setSubject(subject);
		mail.setHtmlBody(body);
		return mail;
	}
}