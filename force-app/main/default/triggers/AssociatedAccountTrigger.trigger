/*Associated Account Trigger to restrict duplicate Associated Account record creation and updation*/
trigger AssociatedAccountTrigger on NS_AssociatedAccount__c (before insert,before update,after insert,after update) {
    try{ 
        if(Trigger.isBefore){  
            if(Trigger.isInsert){
               NS_AssociatedAccountTriggerHelper.beforeAssociatedAccountInsert(Trigger.new);
            }
            if(Trigger.isUpdate){
               NS_AssociatedAccountTriggerHelper.beforeAssociatedAccountUpdate(Trigger.newMap, Trigger.oldMap);
            }        
        }
    }
     catch(Exception exp){
        NS_StaticVariablesUtility.createExceptionRecord(exp,NS_StaticVariablesUtility.CONST_BLANK,NS_StaticVariablesUtility.CONST_BLANK);
    }
}