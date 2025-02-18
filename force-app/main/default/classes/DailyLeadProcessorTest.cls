@isTest
public class DailyLeadProcessorTest {
    static testmethod void testScheduledJob(){
        List<Lead> leads = new List<Lead>();
        for(Integer i=0;i<200;i++){
            leads.add(new Lead(lastName='Lead '+i,Company='Dreamforce'));
        }
        insert leads;
        Test.startTest();
        	Time now = DateTime.now().time();
        	String s = (now.second()+1)+' ';
        	String min = now.minute()+' ';
        	String h = now.hour()+' ';
        	String d = Date.today().day()+' ';
        	String m = Date.today().month()+' ';
        	System.schedule('ScheduleApexTest',s+min+h+d+m+'?',new DailyLeadProcessor());
        Test.stopTest();
        List<Lead> updatedLeads = [SELECT LeadSource FROM Lead];
        for(Integer i=0;i<200;i++){
            System.assertEquals(updatedLeads.get(i).LeadSource,'Dreamforce');
        }
    }
}