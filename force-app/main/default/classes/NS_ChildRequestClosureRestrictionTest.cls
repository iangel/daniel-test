@isTest (SeeAllData=false)
private class NS_ChildRequestClosureRestrictionTest {
        static testmethod void childCaseInsertUpdate()
    {
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        Case cs1 = new Case();
        Case cs2 = new Case();
        User atest;
        
         System.runAs( admin ){ 
            NS_TriggerSettings__c cs = new NS_TriggerSettings__c(Name= NS_StaticVariablesUtility.caseTrigger); 
            cs.NS_IsActive__c = true;
            insert cs;
            Profile agent = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
            atest = UserTestFactory.createUser(21,agent.Id);
            UserTestFactory.assignUserQueue(atest);
            
        }
        system.test.StartTest();
        Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
        AccountTestFactory.accountShare(acc.Id,atest.Id,NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.rowCause);
               
        
        System.runAs(admin) {                           
            cs1 = CaseTestFactory.createCaseRecord('US Customs & Border Patrol','Tracing',acc.Id);            
            insert cs1;  
            
            cs2 = CaseTestFactory.createChildCaseRecord('US Customs & Border Patrol','Tracing',acc.Id,cs1.id);             
            insert cs2;   
                                  
            try{
            cs1.status='NS_Closed';            
            update cs1;   
              
            Ns_ChildCaseController.getChildcase(cs1.id);
            }
            catch(Exception e)
            {
               String message = e.getMessage();
                
               system.assert(message.contains('All Internal Requests associated to this case must be closed in order to close this case.'), 'message=' + message); 
                
            }
             
            }
        system.test.StopTest();
        
    }
    
     static testmethod void childCaseInsertUpdate1()
    {
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        Case cs1 = new Case();
        
        User atest;
        
         System.runAs( admin ){ 
            NS_TriggerSettings__c cs = new NS_TriggerSettings__c(Name= NS_StaticVariablesUtility.caseTrigger); 
            cs.NS_IsActive__c = true;
            insert cs;
            Profile agent = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
            atest = UserTestFactory.createUser(21,agent.Id);
            UserTestFactory.assignUserQueue(atest);
            
        }
        system.test.StartTest();
        Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
        AccountTestFactory.accountShare(acc.Id,atest.Id,NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.rowCause);
               
        
        System.runAs(admin) {                           
            cs1 = CaseTestFactory.createCaseRecord('US Customs & Border Patrol','Tracing',acc.Id);            
            insert cs1; 
            cs1.Status=NS_StaticVariablesUtility.NS_CLOSED;
            update cs1;
            system.assertEquals(cs1.status,NS_StaticVariablesUtility.NS_CLOSED);
             
         Ns_ChildCaseController.getChildcase(cs1.id);
            
        }   
        
    system.test.StopTest();
    
    }
       static testmethod void childCaseInsertUpdate2()
    {
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        Case cs1 = new Case();
        
        User atest;
        
         System.runAs( admin ){ 
            NS_TriggerSettings__c cs = new NS_TriggerSettings__c(Name= NS_StaticVariablesUtility.caseTrigger); 
            cs.NS_IsActive__c = true;
            insert cs;
            Profile agent = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
            atest = UserTestFactory.createUser(21,agent.Id);
            UserTestFactory.assignUserQueue(atest);
            
        }
        system.test.StartTest();
        Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
        AccountTestFactory.accountShare(acc.Id,atest.Id,NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.rowCause);
               
        
        System.runAs(admin) {                           
            cs1 = CaseTestFactory.createCaseRecord('US Customs & Border Patrol','Tracing',acc.Id);            
            insert cs1; 
            system.assertEquals(cs1.status,NS_StaticVariablesUtility.NEW_TXT);             
            Ns_ChildCaseController.getChildcase(cs1.id);
            
        }   
         system.test.StopTest();
    
    
    }


}