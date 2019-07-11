/*Contact Trigger to fire on before and after Contact Creation or Updation*/
trigger ContactTrigger on Contact (before insert,before update,after insert,after update,before delete,after delete) {
    try{ 
        if(Trigger.isBefore){  
            if(Trigger.isInsert){
                NS_ContactTriggerHelper.beforeContactInsert(Trigger.new);
            }
            if(Trigger.isUpdate){
                NS_ContactTriggerHelper.beforeContactUpdate(Trigger.newMap, Trigger.oldMap);
            }
            if(Trigger.isDelete){       
                NS_ContactTriggerHelper.deleteAssociationRecordOnTyesWhenContatisDeleted();     
            }         
        }
        if(Trigger.isAfter){
            if(Trigger.isInsert){            
                NS_ContactTriggerHelper.createAssociatedAccount(Trigger.new); 
                NS_IntegrationHelper.invokeManageOnlineCustomerContactOnInsert(Trigger.newMap); 
                NS_IntegrationHelper.onANIInsert(Trigger.newMap);
            }        
            if(Trigger.isUpdate){
                system.debug('***Checking Internal Contact Update Trigger***');
                //NS_OnlineCustomerContactTEP.invokeManageOnlineCustomerContactOnInsertTEP(Trigger.newMap,'Update');//testing
                NS_ContactTriggerHelper.updateAssociatedAccount(Trigger.newMap, Trigger.oldMap);
                NS_IntegrationHelper.deleteTyesContact(Trigger.newMap, Trigger.oldMap);
                NS_IntegrationHelper.invokeManageOnlineCustomerContactOnUpdate(Trigger.newMap, Trigger.oldMap);
                NS_IntegrationHelper.onANIUpdate(Trigger.newMap, Trigger.oldMap);
                NS_OnlineCustomerContactTEP.invokeManageOnlineCustomerContactOnInsertTEP(Trigger.newMap,'Update');
                NS_IntegrationHelper.invoke_ContactUpdate(Trigger.newMap, Trigger.oldMap);
                NS_ContactTriggerHelper.deleteAssocAccountOnMerge(Trigger.newMap);
            } 
            if(Trigger.isDelete){
             
                NS_OnlineCustomerContactTEP.invokeManageOnlineCustomerContactOnInsertTEP(Trigger.oldMap,'Delete');
                NS_IntegrationHelper.invoke_ContactDel(Trigger.oldMap);
            }          
        }
    }
    catch(Exception exp){
        NS_StaticVariablesUtility.createExceptionRecord(exp,NS_StaticVariablesUtility.CONST_BLANK,NS_StaticVariablesUtility.CONST_BLANK);
    }
}