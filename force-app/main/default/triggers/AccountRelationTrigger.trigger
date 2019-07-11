trigger AccountRelationTrigger on NS_AccountRelation__c (before insert, after delete) {
    
    try{ 
        
        if(trigger.isBefore){
            if(trigger.isInsert){
                system.debug('Before Insert-->');
                NS_AccountRelationTriggerHelper.DuplicateCheckPrevent(Trigger.new);
                NS_AccountRelationTriggerHelper.InsertMirrorRecord(Trigger.new);
            }
            
        }
        //delete mirror relationship record on one account relation record deletion
        if(trigger.isAfter){
            if(trigger.isDelete){
                system.debug('After Delete-->');
                NS_AccountRelationTriggerHelper.DeleteMirrorRecord(Trigger.old);
            }
            
        }
        
    }
    catch (Exception exp) {
        /*Inserting a record in Exception object*/
        NS_StaticVariablesUtility.createExceptionRecord(exp,NS_StaticVariablesUtility.CONST_BLANK,NS_StaticVariablesUtility.CONST_BLANK);
    }
}