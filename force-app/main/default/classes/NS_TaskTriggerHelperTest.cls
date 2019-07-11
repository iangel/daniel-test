/**@author  Accenture
* @Created Date 2018-02-22
* @version  1.0
* @description This test class for NS_TaskTriggerHelper and TaskTrigger.
*/ 
@isTest(SeeAllData=false)
private class NS_TaskTriggerHelperTest {
    
    /*Creating task with inactive contact name.*/
    @isTest static void taskCreateWithInactiveContact(){
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        System.runAs( admin ){ 
            ContactTestFactory.enableContactTrigger();
            TaskTestFactory.enableTaskTrigger();
        }
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
        Profile prof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserSupport);
        User atest = UserTestFactory.createUser(13,agentprof.Id);
        User utest = UserTestFactory.createUser(24,prof.Id);  
        Account accTest = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.NAME); 
        Contact con2 = ContactTestFactory.createContactRecord(accTest.id,NS_StaticVariablesUtility.CONST_BLANK);
        ContactShare conshare = ContactTestFactory.contactShare(con2.Id, atest.id, NS_StaticVariablesUtility.editAccess, NS_StaticVariablesUtility.rowCause);
        system.test.startTest(); 
        system.runAs(utest){ 
            con2.NS_ContactStatus__c =NS_StaticVariablesUtility.conInactiveStatus;
            Database.update(con2,false);
        }
        Task obtsk = TaskTestFactory.createTaskRecord(NS_StaticVariablesUtility.NAME);
        system.runAs(atest){ 
            try{
                obtsk.WhoId=con2.Id;
                //Database.insert(obtsk,false);
                insert obtsk;
                system.test.stopTest();
            }
            catch(DMLException exp){
                system.assertNotEquals(null, con2.Id);
                boolean expVal = exp.getMessage().contains(Label.NS_TaskErrorMessage)?true:false;
                system.Assert(true,expVal); 
            }
        }
    }
    /*Updating task with inactive contact name.*/
    @isTest static void taskUpdateWithInactiveContact(){
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        System.runAs( admin ){ 
            ContactTestFactory.enableContactTrigger();
            TaskTestFactory.enableTaskTrigger();
        }
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
        Profile prof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserSupport);
        User atest = UserTestFactory.createUser(11,agentprof.Id);
        User utest = UserTestFactory.createUser(21,prof.Id);
        Account accTest = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.NAME); 
        system.test.startTest();
        Contact con1 = ContactTestFactory.createContactRecord(accTest.id,NS_StaticVariablesUtility.CONST_BLANK);
        ContactShare conshare = ContactTestFactory.contactShare(con1.Id, atest.id, NS_StaticVariablesUtility.editAccess, NS_StaticVariablesUtility.rowCause);
        Task tsk = TaskTestFactory.createTaskRecord(NS_StaticVariablesUtility.NAME); 
        system.runAs(atest){
            tsk.WhoId=con1.Id;
            Database.insert(tsk,false);
        }
        system.runAs(utest){ 
            con1.NS_ContactStatus__c =NS_StaticVariablesUtility.conInactiveStatus;
            Database.update(con1,false);
            try{
                Database.update(tsk,false);
                system.test.stopTest();
            }
            catch(DMLException exp){
                boolean expVal = exp.getMessage().contains(Label.NS_TaskErrorMessage)?true:false;
                system.Assert(true,expVal);
            }
        }
    }    
    /* Updating cases associated to a new task/updated task */
    @isTest static void caseUpdateTest(){
        system.test.StartTest();
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(17,sysprof.Id);
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);        	
        User atest = UserTestFactory.createUser(13,agentprof.Id); 
        UserTestFactory.assignUserQueue(atest);
        System.runAs( admin ){   
           ContactTestFactory.enableContactTrigger();
           TaskTestFactory.enableTaskTrigger();
           Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name); 
           AccountTestFactory.accountShare(acc.Id,atest.Id,NS_StaticVariablesUtility.editAccess,
                                        NS_StaticVariablesUtility.editAccess,
                                        NS_StaticVariablesUtility.editAccess,NS_StaticVariablesUtility.rowCause); 
           Contact con = ContactTestFactory.createContactRecord(acc.Id, NS_StaticVariablesUtility.NAME); 
           ContactTestFactory.contactShare(con.Id, atest.id, NS_StaticVariablesUtility.editAccess, NS_StaticVariablesUtility.rowCause); 
        }
        
        system.runAs(atest){
            
            Account acc = [select ID from Account where name = :NS_StaticVariablesUtility.Name LIMIT 1];
            Contact con = [select ID from Contact where AccountId= :acc.Id  LIMIT 1];
            Case cas = CaseTestFactory.createCase('Cash Hold','Accounting/Waybilling',acc.Id, con.Id);
            Database.insert(cas,false);
            System.assertNotEquals('null', (String)cas.Id);
            system.assertEquals(NS_StaticVariablesUtility.NS_NEW ,cas.Status);      
            Task tsk = TaskTestFactory.createTaskRecord(NS_StaticVariablesUtility.NAME);         
        	Database.insert(tsk,false);
            tsk.WhatId=cas.Id;
            Database.update(tsk,false);  
            update tsk;
            System.assertNotEquals(null, tsk.Id);
            System.assertNotEquals(atest.Id, cas.OwnerID); 
            cas.NS_AssignedTo__c=null;
            system.assertEquals(cas.NS_AssignedTo__c ,null);
            Database.update(cas,false);
            System.test.StopTest();  
            
            }    
                           
        
    }
    /*prevent deletion of completed task for OSS Rep*/
    @isTest static void preventDeleteTask(){
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        System.runAs( admin ){             
            TaskTestFactory.enableTaskTrigger();
        }
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);        
        User atest = UserTestFactory.createUser(11,agentprof.Id);        
        Task tsk = TaskTestFactory.createTaskRecord(NS_StaticVariablesUtility.NAME);     
                       
        system.runAs(atest){             
            try{            
            	Database.insert(tsk,false);
                tsk.Status=NS_StaticVariablesUtility.NS_COMPLETED;
                Database.update(tsk,false);
                Database.delete(tsk.Id);
                system.test.stopTest();
            }
            catch(DMLException exp){
                boolean expVal = exp.getMessage().contains(Label.TaskDeleteMessage)?true:false;
                system.Assert(true,expVal);
            }
        }
    } 
    
    
    /* Updating status of a task */
    @isTest static void updateStatusTest(){
        system.test.StartTest();
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(17,sysprof.Id);
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);        	
        User atest = UserTestFactory.createUser(13,agentprof.Id); 
        UserTestFactory.assignUserQueue(atest);
        System.runAs( admin ){   
           ContactTestFactory.enableContactTrigger();
           TaskTestFactory.enableTaskTrigger();
           Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name); 
           AccountTestFactory.accountShare(acc.Id,atest.Id,NS_StaticVariablesUtility.editAccess,
                                        NS_StaticVariablesUtility.editAccess,
                                        NS_StaticVariablesUtility.editAccess,NS_StaticVariablesUtility.rowCause); 
           Contact con = ContactTestFactory.createContactRecord(acc.Id, NS_StaticVariablesUtility.NAME); 
           ContactTestFactory.contactShare(con.Id, atest.id, NS_StaticVariablesUtility.editAccess, NS_StaticVariablesUtility.rowCause); 
        }
        
        system.runAs(atest){
            Account acc = [select ID from Account where name = :NS_StaticVariablesUtility.Name LIMIT 1];
            Contact con = [select ID from Contact where AccountId= :acc.Id  LIMIT 1];
            Case cas = CaseTestFactory.createCase('Cash Hold','Accounting/Billing',acc.Id, con.Id);
            Database.insert(cas,false);
            System.assertNotEquals('null', (String)cas.Id);
            system.assertEquals(NS_StaticVariablesUtility.NS_NEW ,cas.Status);      
            Task tsk = TaskTestFactory.createTaskRecord(NS_StaticVariablesUtility.NAME);         
        	Database.insert(tsk,false);
            tsk.WhatId=cas.Id;
            tsk.Status='Completed';
            Database.update(tsk,false);
            System.assertEquals('Completed', tsk.Status);
            update tsk;
            System.assertNotEquals(null, tsk.Id);
            System.assertNotEquals(atest.Id, cas.OwnerID); 
            cas.NS_AssignedTo__c=null;            
            system.assertEquals(cas.NS_AssignedTo__c ,null);
            Database.update(cas,false);
            System.test.StopTest();  
            try{
            }    
            catch(DMLException exp){
                boolean expVal = exp.getMessage().contains(Label.NS_TaskErrorMessage)?true:false;
                system.Assert(true,expVal);
            }
        }    
    }
      /* Updating Logical Marker on deletion of Task*/
     @isTest static void updateTaskStatusOnDeleteForOneTaskTest(){
        system.test.StartTest();
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(17,sysprof.Id);
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);        	
        User atest = UserTestFactory.createUser(13,agentprof.Id); 
        UserTestFactory.assignUserQueue(atest);
          System.runAs( admin ){   
           ContactTestFactory.enableContactTrigger();
           TaskTestFactory.enableTaskTrigger();
           Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name); 
           AccountTestFactory.accountShare(acc.Id,atest.Id,NS_StaticVariablesUtility.editAccess,
                                        NS_StaticVariablesUtility.editAccess,
                                        NS_StaticVariablesUtility.editAccess,NS_StaticVariablesUtility.rowCause); 
           Contact con = ContactTestFactory.createContactRecord(acc.Id, NS_StaticVariablesUtility.NAME); 
           ContactTestFactory.contactShare(con.Id, atest.id, NS_StaticVariablesUtility.editAccess, NS_StaticVariablesUtility.rowCause); 
          }
           system.runAs(atest){
            Account acc = [select ID from Account where name = :NS_StaticVariablesUtility.Name LIMIT 1];
            Contact con = [select ID from Contact where AccountId= :acc.Id  LIMIT 1];
            Case cas = CaseTestFactory.createCase('Cash Hold','Accounting/Waybilling',acc.Id, con.Id);
            //Database.insert(cas,false);
            insert cas;
            System.assertNotEquals('null', (String)cas.Id);
            Task tsk = TaskTestFactory.createTaskRecord(NS_StaticVariablesUtility.NAME);  
            tsk.WhatId=cas.Id;
        	Database.insert(tsk,false);
               system.debug('WWW:'+tsk.WhatId + cas.Id);
               try{
                   tsk.Status='Closed';
                   update tsk;
                    Database.delete(tsk.Id);                   
                    system.test.stopTest();
               }
               catch(DMLException exp){
                boolean expVal = exp.getMessage().contains(Label.TaskDeleteMessage)?true:false;
                system.Assert(true,expVal);
            }
           }
     }
    
    @isTest static void updateTaskStatusOnDeleteForMultipleTaskTest(){
        system.test.StartTest();
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(17,sysprof.Id);
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);        	
        User atest = UserTestFactory.createUser(13,agentprof.Id); 
        UserTestFactory.assignUserQueue(atest);
          System.runAs( admin ){   
           ContactTestFactory.enableContactTrigger();
           TaskTestFactory.enableTaskTrigger();
           Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name); 
           AccountTestFactory.accountShare(acc.Id,atest.Id,NS_StaticVariablesUtility.editAccess,
                                        NS_StaticVariablesUtility.editAccess,
                                        NS_StaticVariablesUtility.editAccess,NS_StaticVariablesUtility.rowCause); 
           Contact con = ContactTestFactory.createContactRecord(acc.Id, NS_StaticVariablesUtility.NAME); 
           ContactTestFactory.contactShare(con.Id, atest.id, NS_StaticVariablesUtility.editAccess, NS_StaticVariablesUtility.rowCause); 
          }
           system.runAs(atest){
            Account acc = [select ID from Account where name = :NS_StaticVariablesUtility.Name LIMIT 1];
            Contact con = [select ID from Contact where AccountId= :acc.Id  LIMIT 1];
            Case cas = CaseTestFactory.createCase('Cash Hold','Accounting/Billing',acc.Id, con.Id);
            Database.insert(cas,false);
            System.assertNotEquals('null', (String)cas.Id);    
            Task tsk1 = TaskTestFactory.createTaskRecord(NS_StaticVariablesUtility.NAME);  
            tsk1.WhatId=cas.Id;
        	Database.insert(tsk1,false);
            Task tsk2 = TaskTestFactory.createTaskRecord(NS_StaticVariablesUtility.NAME);  
            tsk2.WhatId=cas.Id;
            Database.insert(tsk2,false);
               try{
                    Database.delete(tsk1.Id);
                    system.test.stopTest();
                   system.debug('IN DELETE:');
               }
               catch(DMLException exp){
                boolean expVal = exp.getMessage().contains(Label.TaskDeleteMessage)?true:false;
                system.Assert(true,expVal);
                   system.debug('IN DELETE CATCH:');
            }
           }
     }
}