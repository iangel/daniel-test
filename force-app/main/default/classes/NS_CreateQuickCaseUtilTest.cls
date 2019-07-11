/*
Description  : This test class is to test the functionality When a Quick Case record is created.
Developer    : Accenture Solutions
Date         : 2018-05-21

-----------------------------------------------------------------------
Developer name        Date          Description        
-----------------------------------------------------------------------
@Arjun Ghosh    20-06-2018     Added Method to test case for 3pl A/c
*/
@isTest(SeeAllData=false)
private class NS_CreateQuickCaseUtilTest {
 // Test for cases in 3pl & other A/c
    @isTest static void runTest(){
        system.test.StartTest();
        Profile agent = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
       	User testUser = UserTestFactory.createUser(25,agent.Id);  
        system.runAs(testUser){
        Account accPl = AccountTestFactory.getThreePLAccountRecord('Demo');
            accPl.NS_MonitoredAccount__c=true;
            Database.insert(accPl,false);
        Contact con = ContactTestFactory.buildContactRecord(accPl.id,NS_StaticVariablesUtility.CONST_BLANK);
            con.LastName = NS_StaticVariablesUtility.MANUAL;
            ContactTestFactory.insertContactRecord(con);   
        NS_CreateQuickCaseUtil.createCase('OSS Support', 'Internal NS',  '', 
            '','subject', 'description', con.id, accPl.id, accPl.id,'TYES');
        NS_CreateQuickCaseUtil.createCase( '3PL Tracing','Tracing', 
             'NS_Working', 'Medium','subject', 'description', con.id, accPl.id, accPl.id,'');          
        NS_CreateQuickCaseUtil.createCase(null, null, null, null, null,
             null, null, null, null,null);
        NS_CreateQuickCaseUtil.getFocus('Request for 418');
        String result=NS_CreateQuickCaseUtil.getFocus('5');
        System.AssertEquals(null,result);  
        ManageContactAndUserIds__c customSet= new ManageContactAndUserIds__c(Name= testUser.id); 
               customSet.Account_Id__c = accPl.id;
               customSet.Contact_Id__c=con.id;
               customSet.User_Id_del__c=UserInfo.getUserId();
          Database.insert(customSet,false); 
            
        }
    }
    
    static testmethod void NS_createTaskforCaseTest()
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
            Database.insert(cs1, false);
            system.assertEquals(cs1.status,NS_StaticVariablesUtility.NEW_TXT);
            NS_CreateQuickCaseUtil.createTaskforCase(cs1);
           
            
            
        }   
       system.test.stopTest(); 
        
        
    }
     static testmethod void createServiceRequestTest()
    {
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        Case cs1 = new Case();
        
        
        User atest;
        
        System.runAs( admin ){ 
            Profile agent = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
            atest = UserTestFactory.createUser(21,agent.Id);
            UserTestFactory.assignUserQueue(atest);
            
        }
        system.test.StartTest();
        Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
        AccountTestFactory.accountShare(acc.Id,atest.Id,NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.rowCause);
        
        Contact con = ContactTestFactory.createContactRecord(acc.id,'TEST');
        
        
        System.runAs(admin) {      
            String PQ = [select NS_Primary_Queue__c From User Where Id = :UserInfo.getUserId()].NS_Primary_Queue__c ;
            String POID =[Select ID from Group where Name =:PQ][0].id;
            Map<String,String> checkOutput= NS_CreateQuickCaseUtil.createServiceRequest(con.id,POID,'','','','',acc.id,'');  
            system.assertNotEquals(checkOutput,null);
            NS_CreateQuickCaseUtil.getOrigin('Tracing');
        }   
       system.test.stopTest(); 
        
        
    }
    
   

}