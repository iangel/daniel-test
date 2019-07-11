/**@author  Accenture
* @Created Date 2018-02-19
* @version  1.0
* @description This class conatins method to filter out inactive contacts from Tasks.
*/ 
public with sharing class NS_TaskTriggerHelper {
    /** @author  Accenture
*  @description To filter out the inactive contacts from Task
*  @param List of task
*  @return None
*  @throws None
*/ 
    /*Class Name*/ 
    private static final String CLASS_NAME='NS_TaskTriggerHelper';
    /*Method Name*/ 
    private static final String METHOD_NAME='filterInactiveContacts';
    private static final String PREVENT_DELETE_COMPLETED_TASK='preventDeleteCompletedTask';
    private static final String UPDATE_STATUS='updateStatus';
    private static final String UPDATE_CASE='updateCase';
    private static final String UPDATE_TASK_STATUS_ON_CASE='updateTaskStatusOnCase';
    
    /*Filtering Task with Active Contact*/
    public static void filterInactiveContacts(List<Task> taskList){
        NS_TriggerSettings__c setting = NS_TriggerSettings__c.getValues(NS_StaticVariablesUtility.tskTrigger);
        if(setting.NS_IsActive__c){
            Integer count =limits.getLimitQueryRows();
            Set<Id> contactIds = new Set<Id>();        
            Map<Id, Task> taskIdMap = new Map<Id, Task>();  
            Id taskRecordTypeId =  Schema.SObjectType.Task.getRecordTypeInfosByName().
                get(NS_StaticVariablesUtility.taskRT).getRecordTypeId();
            /*Filtering Tasks for Record Type "NS Task" and storing Task Ids matching Contact Ids*/ 
            try{
                for(Task tsk : taskList){           
                    if(tsk.RecordTypeId.equals(taskRecordTypeId)){
                        if(tsk.WhoId != null && tsk.WhoId.getSObjectType()== Contact.SObjectType && !contactIds.contains(tsk.WhoId)){
                            contactIds.add(tsk.WhoId);
                            taskIdMap.put(tsk.WhoId,tsk);
                        }
                        
                    }
                }
                /*Display Error message if Task WhoId equals Inactive Contact Ids*/ 
                for(Contact con: [Select Id,Name,NS_ContactStatus__c from Contact where Id in :contactIds LIMIT:count] ){
                    
                    if(con.NS_ContactStatus__c!= null && NS_StaticVariablesUtility.conInactiveStatus.equalsIgnoreCase(con.NS_ContactStatus__c))
                    {
                        taskIdMap.get(con.Id).addError(con.Name+NS_StaticVariablesUtility.Space+ Label.NS_TaskErrorMessage);
                    }
                }
            }
            catch (Exception exp) {
                //inserting a record in Exception object
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME,METHOD_NAME); 
            }
        }
    } 
    /* Updating cases associated to a new task/updated task */
    public static void updateCase(List<Task> updatedTask){
        NS_TriggerSettings__c setting = NS_TriggerSettings__c.getValues(NS_StaticVariablesUtility.tskTrigger);
        if(setting.NS_IsActive__c){
            try{
                Integer count =limits.getLimitQueryRows();
                Set<Id> caseIds = new Set<Id>();
                List<Case>  csList = new List<Case>();
                for(Task ts:updatedTask){
                    if(Case.SObjectType.getDescribe().getKeyPrefix().equalsIgnoreCase(String.valueOf(ts.WhatId).substring(0,3))){
                        caseIds.add(ts.WhatId);
                    }
                }
                csList = [select Id,NS_Unread_Email__c from Case where Id IN :caseIds LIMIT:count];
                if(!csList.isEmpty()){
                    For(Case cse:csList){
                        If(cse.NS_Unread_Email__c==true){
                            cse.NS_Unread_Email__c=false;
                        }
                    }
                    Database.update(csList,false);
                }
            }
            catch (Exception exp) {
                //inserting a record in Exception object
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME,UPDATE_CASE); 
            }
        }
    }
    /*Logical Marker to identify cases with Open Task*/
    public static void updateStatus(List<Task> updatedTask){
        NS_TriggerSettings__c setting = NS_TriggerSettings__c.getValues(NS_StaticVariablesUtility.tskTrigger);
        if(setting.NS_IsActive__c){
            Set<Id> casewithClosedTasks = new Set<Id>();
            Set<Id> casewithOpenTasks=new  Set<Id> ();
            Integer count =limits.getLimitQueryRows();
            try{
                for(Task ts:updatedTask){
                    if(Case.SObjectType.getDescribe().getKeyPrefix().equalsIgnoreCase(String.valueOf(ts.WhatId).substring(0,3))){
                        if(!ts.IsClosed){  
                            casewithOpenTasks.add(ts.WhatId);
                        }else{
                            casewithClosedTasks.add(ts.WhatId);
                        }
                    }
                }
                for(Task tsk:[Select Id, isClosed, WhatID from Task where WhatId in:casewithClosedTasks LIMIT:count]){
                    if(!tsk.IsClosed){
                        casewithOpenTasks.add(tsk.WhatId);
                    }
                }
                For(Id cseId:casewithClosedTasks){
                    if(casewithOpenTasks.contains(cseId)){
                        casewithClosedTasks.remove(cseId);
                        
                    }
                }
                List<case> listToUpdate= new List<Case>();
                For(Case cse:[Select NS_Open_Tasks__c from Case Where Id IN:casewithOpenTasks OR Id IN:casewithClosedTasks LIMIT:count]){
                    if(casewithOpenTasks.contains(cse.Id)){
                        cse.NS_Open_Tasks__c=true;
                        listToUpdate.add(cse);
                    }
                    else{
                        cse.NS_Open_Tasks__c=false;
                        listToUpdate.add(cse);
                    }
                }
                Database.update(listToUpdate,false);
            }
            catch (Exception exp) {
                //inserting a record in Exception object
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME,UPDATE_STATUS); 
            }
        }
    }
    /*Prevent deletion of past activity from OSS rep*/
    public static void preventDeleteCompletedTask(List<Task> toBeDeletedTask) {
        NS_TriggerSettings__c setting = NS_TriggerSettings__c.getValues(NS_StaticVariablesUtility.tskTrigger);
        if(setting.NS_IsActive__c){
            try{            
                String profileName=[Select Name from Profile where Id=:userinfo.getProfileId() limit 1].Name;            
                for(Task currTask : toBeDeletedTask) {                
                    if(profileName.equalsIgnoreCase(NS_StaticVariablesUtility.UserRep) && currTask.IsClosed){
                        currTask.addError(System.Label.TaskDeleteMessage);
                    }
                }
                system.debug('calling updateTaskStatusOnDelete');
                updateTaskStatusOnDelete(toBeDeletedTask);
            }
            catch(Exception exp){
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, PREVENT_DELETE_COMPLETED_TASK);
            }
        }
    }  
    
    /*Update Logical Marker on deletion of Task*/
    public static void updateTaskStatusOnDelete(List<Task> deletedTask){
        Set<Id> casewithOpenTasks=new  Set<Id> ();
        Integer count =limits.getLimitQueryRows();
        try{
            for(Task ts:deletedTask){
                if(Case.SObjectType.getDescribe().getKeyPrefix().equalsIgnoreCase(String.valueOf(ts.WhatId).substring(0,3))){
                    if(!ts.IsClosed){
                        casewithOpenTasks.add(ts.WhatId);
                    }
                }
            }
            for(Task tsk:[Select Id, isClosed, WhatID from Task where WhatId in:casewithOpenTasks and Id Not IN:deletedTask and IsClosed=false limit:count]){
                If(casewithOpenTasks.contains(tsk.WhatId)){
                    casewithOpenTasks.remove(tsk.WhatId);
                }  
            }
            List<case> listToUpdate= new List<Case>();
            For(Case cse: [Select id,NS_Open_Tasks__c from Case Where Id IN:casewithOpenTasks limit:count]){
            	cse.NS_Open_Tasks__c=false;
                listToUpdate.add(cse);
            }
            if(!listToUpdate.isEmpty()){
                Database.SaveResult[] srList = Database.update(listToUpdate,false);
                NS_Utility.databaseSvResult(srList,UPDATE_TASK_STATUS_ON_CASE,CLASS_NAME);
            }
        }
        catch(Exception exp) {
            //inserting a record in Exception object
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME,UPDATE_TASK_STATUS_ON_CASE); 
        }   
    }
    
}