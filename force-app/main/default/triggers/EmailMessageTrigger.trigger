/*EmailMessageTrigger to check if deleteion is allowed*/
trigger EmailMessageTrigger on EmailMessage (before insert , before update, after update, after delete , after insert,before delete){

        if(Trigger.isBefore && Trigger.isDelete){
            NS_EmailMessageTriggerHelper.preventDeletionEmailMessage(Trigger.old);
        }

}