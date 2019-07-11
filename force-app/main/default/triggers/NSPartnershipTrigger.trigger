/*NSPartnershipTrigger Trigger to fire before NS Partnership Record Creation or Updation*/
trigger NSPartnershipTrigger on NS_Partnership__c (before insert,before update) {

        if(Trigger.isBefore){ 
            if(Trigger.isInsert){
                NS_PartnershipTriggerHelper.duplicatePartnershipCheckOnInsert(Trigger.new);
            }
            if(Trigger.isUpdate){
                NS_PartnershipTriggerHelper.duplicatePartnershipCheckOnUpdate(Trigger.newMap, Trigger.oldMap);
            }   
        }


    
}