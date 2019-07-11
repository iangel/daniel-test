/**
   @Author - Amrita Pandey
   
   @name - PMO_Task 
   
   @CreateDate - 12/20/2013
   
   @Description - Trigger to create new IDC tasks records (object - IDC_Task__c) based on custom setting PMO_TaskAssignment.
                  The class also creates new defect records (object - Defect__c) based on custom setting PMO_TaskAssignment 
                  and custom settings PMO_CreateDefect__c. This trigger calls the methods of the helper class PMO_TaskAssignment
                  
   @Version - 1.0
   
   @reference - None
  */
trigger PMO_Task on IDC_Task__c (after update) 
{
    
    if (!Trigger.new.isempty())
    {
        // List of IDC Task which have been completed
        List<IDC_Task__c> idcTaskList = new List<IDC_Task__c>();
        
        for (IDC_Task__c currentTask:Trigger.new)
        {
            
            if (Trigger.oldMap.get(currentTask.Id).Status__c != Trigger.newMap.get(currentTask.Id).Status__c && currentTask.Status__c == 'Completed') 
            {
                
                // Adding records in the list
                idcTaskList.add(currentTask);
            }
        }
    
        if (!idcTaskList.isempty()) 
        {
            
            // Calling method which creates new IDC Tasks
            PMO_Task_Assignment.PMO_Task_Assignment(idcTaskList);
        }
    }
}