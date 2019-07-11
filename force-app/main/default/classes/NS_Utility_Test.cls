@isTest (SeeAllData=false)
public class NS_Utility_Test {
    
    static testmethod void NS_Utility_casecreation()
    {
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        Case cs1 = new Case();
        string className='NS_Utility_Test';
        string methodName='NS_Utility_casecreation';
        
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
            cs1 = CaseTestFactory.createCaseRecord('','',acc.Id);            
            
            Database.SaveResult srResult = Database.insert(cs1, false);  
            
            system.assertEquals(srResult.isSuccess(),false);
            
            List<Database.SaveResult> srList= new List<Database.SaveResult>();
            srList.add(srResult);            
          
            NS_Utility.databaseSvResult(srList,methodName,className) ; 
            
        }   
        
        
        
    }
    
    static testmethod void NS_Utility_casedel()
    {
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        Profile readOnlyprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.NsreadOnly);
        User readOnly = UserTestFactory.createUserReadonly(14,readOnlyprof.Id);
        Case cs1 = new Case();
        string className='NS_Utility_Test';
        string methodName='NS_Utility_casedel';
        
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
            
            Database.SaveResult srResult = Database.insert(cs1, false);
            List<Database.SaveResult> srList= new List<Database.SaveResult>();
        }
        System.runAs(readOnly) {    
            Database.DeleteResult srResult1 = Database.delete(cs1, false);
            system.assertEquals(srResult1.isSuccess(),false);
            List<Database.DeleteResult> srList1= new List<Database.DeleteResult>();
            
            srList1.add(srResult1);            
            
            
            NS_Utility.databaseDelResult(srList1, methodName,className) ;  
            
        }   
        
        
        
    }
    
}