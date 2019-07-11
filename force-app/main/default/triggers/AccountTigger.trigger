trigger AccountTigger on Account (after insert, after update, before delete) {

    try{
        /********** part of R2 changes by Moumita on 3/12/19 *******/
        // purpose: on Account deletion, delete related "account relation" records at the same time
        if(Trigger.isBefore){
           if(Trigger.isDelete){
               NS_AccountRelationTriggerHelper.DeleteAccountRelations(trigger.old);
           }
            
        }
        /********** end of part of R2 changes by Moumita on 3/12/19 *******/

        if(Trigger.isAfter){
            if(Trigger.isInsert){
                /*
                    Bharadwaj comment: When offline account is inserted, contact is always created. Hence moving the call to contact trigger.
                */
                NS_IntegrationHelper.onANIInsert(Trigger.newMap);
            }
            if(Trigger.isUpdate){
                /*
                    Bharadwaj comment: Update call may be needed in case of offline account update.
                */
                NS_IntegrationHelper.onANIUpdate(Trigger.newMap, Trigger.oldMap);
                NS_IntegrationHelper.onCustomerVDNUpdate(Trigger.newMap, Trigger.oldMap);
            }
        }
    }
    catch(Exception exp){
        NS_StaticVariablesUtility.createExceptionRecord(exp,NS_StaticVariablesUtility.CONST_BLANK,NS_StaticVariablesUtility.CONST_BLANK);
    }
}