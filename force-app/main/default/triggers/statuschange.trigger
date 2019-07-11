trigger statuschange on Request__c (before update, before insert) {
    
    if(Trigger.isBefore)
    {
        // If a record inserted or updated
        if(Trigger.isInsert)            
        {
            // pass trigger.new
            clsTimeSpentOnStatus.fnBeforeInsertTimeSpentOnStatus(Trigger.new);
              system.debug('---hello2---');
           
        }
        
    
       else if(Trigger.isUpdate)
        {
            clsTimeSpentOnStatus.fnBeforeUpdateTimeSpentOnStatus(Trigger.new,Trigger.old,Trigger.newMap,Trigger.oldmap);  
            system.debug('---hello3---');
            clsTimeSpentOnStatus.fnBeforeUpdateTimeSpentOnStatus1(Trigger.new,Trigger.old,Trigger.newMap,Trigger.oldmap);
            system.debug('---hello4---');
            clsTimeSpentOnStatus.fnBeforeUpdateTimeSpentOnStatus2(Trigger.new,Trigger.old,Trigger.newMap,Trigger.oldmap);
            system.debug('---hello5---');
            clsTimeSpentOnStatus.fnBeforeUpdateTimeSpentOnStatus3(Trigger.new,Trigger.old,Trigger.newMap,Trigger.oldmap);
            system.debug('---hello6---');
            // pass trigger.old
            //clsTimeSpentOnStatus.fnBeforeInsertTimeSpentOnStatus();
            //clsTimeSpentOnStatus.fnBeforeUpdateTimeSpentOnStatus(trigger.Old);
            //clsTimeSpentOnStatus.fnBeforeUpdateTimeSpentOnStatus1(trigger.Old);
            //clsTimeSpentOnStatus.fnBeforeUpdateTimeSpentOnStatus2(trigger.Old);
            //clsTimeSpentOnStatus.fnBeforeUpdateTimeSpentOnStatus3(trigger.Old);
        }
    }
    
    
}