@isTest
private class WorkAssignmentTriggerTest {

    static testmethod void test_trigger(){
        
        Request__c reqRec = new Request__c( Mapping__c= 'Case Types');
        reqRec.Request_Title__c = 'Test';
        reqRec.Requirement__c = 'Test';
        reqRec.Request_Description__c ='Test';
        reqRec.Status__c = 'Identify: New Requirement';
        insert reqRec;
        
        Work_Assignment__c waRec = new Work_Assignment__c(Requirement_Number__c=reqRec.Id);
        
        insert waRec;
    }
}