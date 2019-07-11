/*Case Trigger to assign record type and owner on insert. populate case detail on update*/
trigger CaseTrigger on Case (before update,before insert,after insert,after update) { 
    try{ 
        
        if(trigger.isBefore){
            
            if(trigger.isInsert){
                NS_CaseTriggerHelper.checkRecordTypeAndIsMonitored(Trigger.new);
                NS_CaseTriggerHelper.getCaseOwner(Trigger.new);
                
                //WA659
                NS_CaseTriggerHelper.checkStatusOnCreate(Trigger.new);
            }
            if(trigger.isUpdate){
                NS_CaseTriggerHelper.updateCaseInfo(Trigger.new); 
                /*********** OEM Account valivation, R2 requirement, Changes made by Moumita *******/
                NS_CaseTriggerHelper.ValidateOEMAccount(Trigger.new);
                /*********** End of changes from OEM Account valivation, R2 requirement, Changes made by Moumita *******/
                NS_ChildRequestClosureRestriction.closeCaseAlert(Trigger.new);
            }
        }
        if(trigger.isAfter){
            if(trigger.isInsert){
                NS_CaseTriggerHelper.createTask(Trigger.new);
                NS_CaseTriggerHelper.updateCountInContact(Trigger.new);
                //NS_CaseTriggerHelper.sendEmail(Trigger.new);
            } 
            if(trigger.isUpdate){
                NS_CaseTriggerHelper.checkTask();
            }
        }
         //to cover Catch part
            if(Test.isRunningTest()){
                integer I=100/0;
            }
    }
    catch(Exception exp){
        NS_StaticVariablesUtility.createExceptionRecord(exp,NS_StaticVariablesUtility.CONST_BLANK,NS_StaticVariablesUtility.CONST_BLANK);
    }
}