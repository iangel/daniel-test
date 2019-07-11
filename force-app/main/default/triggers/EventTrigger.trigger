/*Event Trigger to fire on before Event Creation or Updation*/
Trigger EventTrigger on Event(before insert, before update,after insert,after update) {
         if(Trigger.isBefore){
            if(Trigger.isInsert || Trigger.isUpdate){
                NS_EventTriggerHelper.filterInactiveContacts(Trigger.new);
            }
        }

}