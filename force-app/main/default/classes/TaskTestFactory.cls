public class TaskTestFactory {
    /*Create test task Record*/
    public static Task createTaskRecord(String subject){
        Task obTask=new Task(
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =: NS_StaticVariablesUtility.tskRecordType 
                            AND SobjectType =: NS_StaticVariablesUtility.tskObj].id,
            Subject=subject,
            ActivityDate = Date.today(),
            Status='New',
            Priority='Normal',
            Description='Test');
        return obTask;
    }
    /*Enable Task Trigger Settings*/
    public static void enableTaskTrigger()
    {
        NS_TriggerSettings__c cs1 = new NS_TriggerSettings__c(Name= NS_StaticVariablesUtility.tskTrigger); 
            cs1.NS_IsActive__c = true;
            Database.insert(cs1,false);
    }
}