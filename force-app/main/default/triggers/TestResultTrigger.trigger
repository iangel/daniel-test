trigger TestResultTrigger on Test_Result__c (before update,before insert,after insert,after update) {
	if(trigger.isAfter){
        if(trigger.isUpdate){
            system.debug(' after update');
            TestResultTriggerHelper.updateStatusOnTestScenario(Trigger.new);
        }
        if(trigger.isInsert){
            system.debug(' after insert');
            TestResultTriggerHelper.updateStatusOnTestScenario(Trigger.new);
        }
    }  
}