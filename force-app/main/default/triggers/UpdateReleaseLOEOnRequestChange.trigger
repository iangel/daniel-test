/**
   @Author - Shashank Singhal
   
   @name - UpdateReleaseLOEOnRequestChange 
   
   @CreateDate - 01/27/2014
   
   @Description - Trigger to update the estimates on Release for which an associated Request is inserted, updated or Deleted. 
                  This trigger calls the methods of the helper class UpdateReleaseLOE_HelperClass.
                  
   @Version - 1.0
   
   @reference - None
  */
trigger UpdateReleaseLOEOnRequestChange on Request__c (after update, after insert, after delete) {
    
    if(Trigger.isAfter)
    {
        // If a record inserted or updated
        if(Trigger.isInsert || Trigger.isUpdate)
        {
            // pass trigger.new
            UpdateReleaseLOE_HelperClass.updateRelease(trigger.New);
        }
        
        // if record is deleted
        if(Trigger.isDelete)
        {
            // pass trigger.old
            UpdateReleaseLOE_HelperClass.updateRelease(trigger.Old);
        }
    }
    
    
}