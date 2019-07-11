public with sharing class EventTestFactory {
    /*Create test event Record*/
    public static Event createEventRecord(String subject){
        Event obEvent=new Event(
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =:NS_StaticVariablesUtility.evtRecordType
                            AND SobjectType =:NS_StaticVariablesUtility.evtObj Limit 1].id,
            Subject=subject,
            StartDateTime =System.now(),
            EndDateTime =System.now().AddDays(1),
            Description='Test');
        return obEvent;
    }
    /*Enable Event Trigger Settings*/
    public static void enableEventTrigger()
    {
        NS_TriggerSettings__c cs1 = new NS_TriggerSettings__c(Name= NS_StaticVariablesUtility.evtTrigger); 
        cs1.NS_IsActive__c = true;
        Database.insert(cs1,false); 
    }
}