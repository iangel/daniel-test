/*Task Trigger to fire on before Task Creation or Updation*/
trigger TaskTrigger on Task (before insert, before update,after insert,after update,before delete) {
    try{
        if(Trigger.isBefore){
            if(Trigger.isInsert){
                NS_TaskTriggerHelper.filterInactiveContacts(Trigger.new);
            }
            if(Trigger.isUpdate){
                NS_TaskTriggerHelper.filterInactiveContacts(Trigger.new);
            }
            if(Trigger.isDelete){
                NS_TaskTriggerHelper.preventDeleteCompletedTask(trigger.old);
                 
            } 
        }
        if(Trigger.isAfter){
            if(Trigger.isInsert){
                NS_TaskTriggerHelper.updateCase(Trigger.new); 
                NS_TaskTriggerHelper.updateStatus(Trigger.new); 
			}
            if(Trigger.isUpdate){
                NS_TaskTriggerHelper.updateCase(Trigger.new);
                NS_TaskTriggerHelper.updateStatus(Trigger.new); 
            }
        }
    }
    catch(Exception exp){
        NS_StaticVariablesUtility.createExceptionRecord(exp,NS_StaticVariablesUtility.CONST_BLANK,NS_StaticVariablesUtility.CONST_BLANK);
    }
}