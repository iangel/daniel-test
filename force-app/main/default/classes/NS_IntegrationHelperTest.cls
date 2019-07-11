/*
Description  : This class covers the unit testing for NS_IntegrationHelper class
Developer    : Accenture Solutions
Date         : 20-06-2018

-----------------------------------------------------------------------
Developer name        Date          Description        
-----------------------------------------------------------------------
@Bharadwaj Urma    20-06-2018     Unit testing methods
*/

@isTest
private class NS_IntegrationHelperTest {
    
    @isTest
    static void AccountWithPhoneInsertTest(){
        system.test.StartTest();
        System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
        
        NS_VDN__c newVdnRec = new NS_VDN__c();
        newVdnRec.NS_VDNDescription__c = 'Test Description';
        newVdnRec.NS_VDNCode__c = '4504';
        Database.insert(newVdnRec);        
        Account acc = AccountTestFactory.getOnlineAccountRecord(NS_StaticVariablesUtility.Name); 
        acc.phone = '1234567890';
        acc.NS_PrimaryVDN__c = newVdnRec.Id;
        Database.insert(acc);
        system.test.StopTest();
    }
    
    @isTest
    static void AccountWithPhoneUpdateTest(){
        system.test.StartTest();
        //System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
        NS_VDN__c newVdnRec = new NS_VDN__c();
        newVdnRec.NS_VDNDescription__c = 'Test Description';
        newVdnRec.NS_VDNCode__c = '4504';
        Database.insert(newVdnRec);
        
        Account acc = AccountTestFactory.getOnlineAccountRecord(NS_StaticVariablesUtility.Name); 
        acc.phone = '1234567890';
        acc.NS_PrimaryVDN__c = newVdnRec.Id;
        Database.insert(acc);
        
        Account accToUpdate = new Account();
        accToUpdate.Id = acc.Id ;
        accToUpdate.phone = '1234567891';
        Database.update(accToUpdate);
        
        system.test.StopTest();
    }
    
    @isTest
    static void AccountWithVDNUpdateTest(){
        system.test.StartTest();
        System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
        NS_VDN__c newVdnRec = new NS_VDN__c();
        newVdnRec.NS_VDNDescription__c = 'Test Description';
        newVdnRec.NS_VDNCode__c = '4504';
        Database.insert(newVdnRec);
        
        NS_VDN__c newVdnRec1 = new NS_VDN__c();
        newVdnRec1.NS_VDNDescription__c = 'Test Description 1';
        newVdnRec1.NS_VDNCode__c = '4502';
        Database.insert(newVdnRec1);
        
        Account acc = AccountTestFactory.getOnlineAccountRecord(NS_StaticVariablesUtility.Name); 
        acc.phone = '1234567890';
        acc.NS_PrimaryVDN__c = newVdnRec.Id;
        Database.insert(acc);
        
        Account accToUpdate = new Account();
        accToUpdate.Id = acc.Id ;
        accToUpdate.NS_PrimaryVDN__c = newVdnRec1.Id;
        Database.update(accToUpdate);
        
        system.test.StopTest();
    }
    
    /*Test Method for ANI sync*/
    @isTest
    static void MaintainContactTest(){
        system.test.StartTest();
        System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,agentprof.Id);
        System.runAs( admin ){ 
            NS_TriggerSettings__c customSet = new NS_TriggerSettings__c(Name= NS_StaticVariablesUtility.conTrigger); 
            customSet.NS_IsActive__c = true;
            Database.insert(customSet,false);
        }
        Profile prof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserSupport);
        User utest = UserTestFactory.createUser(24,prof.Id); 
        utest.UserRoleId = NS_StaticVariablesUtility.userRoleSupport;
        update utest;
        system.runAs(utest){ 
            Account acc = AccountTestFactory.createOnlineAccountRecord(NS_StaticVariablesUtility.Name); 
            Contact con = ContactTestFactory.createContactRecord(acc.id,NS_StaticVariablesUtility.CONST_BLANK);
            system.debug('Con'+con);
            NS_PrimaryContact__c newPC = new NS_PrimaryContact__c();
            newPC.NS_AccountName__c = acc.Id;
            newPC.NS_ContactName__c = con.Id;
            Database.insert(newPC,false);
            
            acc = [SELECT Id,Name from Account];
            con = [SELECT Phone,NS_ContactStatus__c,NS_BusinessUnit__c FROM Contact where Id =:con.id LIMIT 1];
            con.NS_ContactStatus__c =NS_StaticVariablesUtility.conInactiveStatus;
            con.NS_BusinessUnit__c=NS_StaticVariablesUtility.Automotive;
            con.Phone='1234567890';
            Database.update(con,false);
            
        }
        System.test.StopTest();
    }
    
    @isTest
    static void updatePrimaryContactTest(){
        system.test.StartTest();
        System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
        
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
        User atest = UserTestFactory.createUser(13,agentprof.Id);
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        
        System.runAs( admin ){ 
            NS_TriggerSettings__c customSet = new NS_TriggerSettings__c(Name= NS_StaticVariablesUtility.conTrigger); 
            customSet.NS_IsActive__c = false;
            Database.insert(customSet,false);
        }
        system.runAs(atest){
            Account ACCOUNT_NOT_LOADED = AccountTestFactory.createOnlineAccountRecord(NS_StaticVariablesUtility.accName); 
            system.assertNotEquals(null, ACCOUNT_NOT_LOADED.Id);
            
            Account acc = AccountTestFactory.createOnlineAccountRecord(NS_StaticVariablesUtility.Name); 
            system.assertNotEquals(null, acc.Id);
            
            Contact con = ContactTestFactory.buildContactRecord(acc.id,NS_StaticVariablesUtility.CONST_BLANK);
            con.LastName = NS_StaticVariablesUtility.MANUAL;
            Database.insert(con,false);
            system.assertNotEquals(null, con.Id);
            
            Contact con1 = ContactTestFactory.buildContactRecord(acc.id,NS_StaticVariablesUtility.CONST_BLANK);
            con1.LastName = NS_StaticVariablesUtility.MANUAL+'2';
            con1.Email = 'user.test2'+acc.Id+'@gmail.com';
            Database.insert(con1,false);
            system.assertNotEquals(null, con1.Id);
            
            
            NS_PrimaryContact__c newPC = new NS_PrimaryContact__c();
            newPC.NS_AccountName__c = acc.Id;
            newPC.NS_ContactName__c = con.Id;
            Database.insert(newPC,false);
            system.assertNotEquals(null, newPC.Id);
            
            NS_PrimaryContact__c newPC1 = new NS_PrimaryContact__c();
            newPC1.Id = newPC.Id;
            newPC1.NS_ContactName__c = con1.Id;
            Database.update(newPC1,false);
        }
        System.test.StopTest();
    }
    
    @isTest
    static void insertPrimaryContactTest(){
        
        system.test.StartTest();
        System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
        
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
        User atest = UserTestFactory.createUser(13,agentprof.Id);
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        
        System.runAs( admin ){ 
            NS_TriggerSettings__c customSet = new NS_TriggerSettings__c(Name= NS_StaticVariablesUtility.conTrigger); 
            customSet.NS_IsActive__c = false;
            Database.insert(customSet,false);
        }
        system.runAs(atest){
            
            Account ACCOUNT_NOT_LOADED = AccountTestFactory.createOnlineAccountRecord(NS_StaticVariablesUtility.accName); 
            system.assertNotEquals(null, ACCOUNT_NOT_LOADED.Id);
            
            Account acc = AccountTestFactory.createOnlineAccountRecord(NS_StaticVariablesUtility.Name); 
            system.assertNotEquals(null, acc.Id);
            
            Contact con = ContactTestFactory.buildContactRecord(acc.id,NS_StaticVariablesUtility.CONST_BLANK);
            con.LastName = NS_StaticVariablesUtility.MANUAL;
            Database.insert(con,false);
            
            NS_PrimaryContact__c newPC = new NS_PrimaryContact__c();
            newPC.NS_AccountName__c = acc.Id;
            newPC.NS_ContactName__c = con.Id;
            Database.insert(newPC,false);
        }
        System.test.StopTest();
    }
    
    @isTest
    static void insertVDNTest(){
        system.test.StartTest();
        System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
        NS_VDN__c newVdnRec = new NS_VDN__c();
        newVdnRec.NS_VDNDescription__c = 'Test Description';
        newVdnRec.NS_VDNCode__c = '4504';
        Database.insert(newVdnRec);
        system.test.StopTest();
    }
    
    @isTest
    static void updateVDNTest(){
        system.test.StartTest();
        System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
        NS_VDN__c newVdnRec = new NS_VDN__c();
        newVdnRec.NS_VDNDescription__c = 'Test Description';
        newVdnRec.NS_VDNCode__c = '4504';
        insert newVdnRec;
        
        NS_VDN__c updateVdnRec = new NS_VDN__c();
        updateVdnRec.NS_VDNDescription__c = 'Test Description';
        updateVdnRec.NS_VDNCode__c = '4505';
        updateVdnRec.Id = newVdnRec.Id;
        Database.update(updateVdnRec);          
        system.test.StopTest();
    }
/* ================================================
* @Method Name : contactDeleteTest
* @author id: sudipta.b.mukherjee@accenture.com
* @Purpose: This method is used to unit test deleteContactonTyes() in NS_Integration Helper
* @Parameters: String Account Name
* @return: Account
* @Release: Phase-1 Enhancement Request
* @created date: 20-01-2019
==================================================*/ 
    @isTest
    static void contactDeleteTest(){
        system.test.StartTest();
        try{  
            Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
            User admin = UserTestFactory.createUser(14,agentprof.Id);
            System.runAs( admin ){ 
                Account acc = AccountTestFactory.createOnlineServiceAccountRecord(NS_StaticVariablesUtility.Name);  
                Contact con = ContactTestFactory.buildContactRecord(acc.id,NS_StaticVariablesUtility.CONST_BLANK); 
                insert con;
                
                delete con;
                Contact deletedContact = [SELECT Id, IsDeleted FROM Contact WHERE Id = :con.Id ALL ROWS];
                system.assertEquals(deletedContact.IsDeleted, true);           
            }
        }
        catch(Exception e)
        {
            NS_StaticVariablesUtility.createExceptionRecord(e, 'NS_IntegrationHelperTest', 'ContactDelete');
        }
        system.test.StopTest();
    }
   
/* ================================================
* @Method Name : invoke_ContactUpdatePositiveTest
* @author id: arjun.c.ghosh@accenture.com
* @Purpose: This method is used to unit test invoke_ContactUpdate() in NS_Integration Helper
* @Parameters: String Account Name
* @return: Account
* @Release: Phase-1 Enhancement Request
* @created date: 20-01-2019
==================================================*/ 
    @isTest
    static void invoke_ContactUpdatePositiveTest(){
        try{
            system.test.StartTest();
            NS_TriggerSettings__c customSet1 = new NS_TriggerSettings__c();
            customSet1.Name=NS_StaticVariablesUtility.assocTrigger;
            customSet1.NS_IsActive__c=true;
            Database.insert(customSet1,false);
            Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
            User admin = UserTestFactory.createUser(14,agentprof.Id);
            System.runAs( admin ){ 
                Account acc = AccountTestFactory.createOnlineServiceAccountRecord(NS_StaticVariablesUtility.Name);  
                Contact con = ContactTestFactory.buildContactRecord(acc.id,NS_StaticVariablesUtility.CONST_BLANK);  
                Database.insert (con);
                NS_PrimaryContact__c newPC = new NS_PrimaryContact__c();
            	newPC.NS_AccountName__c = acc.Id;
            	newPC.NS_ContactName__c = con.Id;
           		Database.insert(newPC,false);
                Account acc2 = AccountTestFactory.createOnlineServiceAccountRecord(NS_StaticVariablesUtility.SystemAdministratorProfile);  
                con.AccountId=acc2.Id;
                Database.update(con) ; 
                system.test.StopTest();
            }
        }catch(Exception exp){
            NS_StaticVariablesUtility.createExceptionRecord(exp, 'NS_IntegrationHelperTest', 'invoke_ContactUpdateTest');
        }
    }
    
/* ================================================
* @Method Name : invoke_ContactUpdateNegativeTest
* @author id: arjun.c.ghosh@accenture.com
* @Purpose: This method is used to unit test invoke_ContactUpdate() in NS_Integration Helper
* @Parameters: String Account Name
* @return: Account
* @Release: Phase-1 Enhancement Request
* @created date: 20-01-2019
==================================================*/ 
    @isTest
    static void invoke_ContactUpdateNegativeTest(){
        try{
            system.test.StartTest();
            NS_TriggerSettings__c customSet1 = new NS_TriggerSettings__c();
            customSet1.Name=NS_StaticVariablesUtility.assocTrigger;
            customSet1.NS_IsActive__c=true;
            Database.insert(customSet1,false);
            Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
            User admin = UserTestFactory.createUser(14,agentprof.Id);
            System.runAs( admin ){ 
                Account acc = AccountTestFactory.createOnlineServiceAccountRecord(NS_StaticVariablesUtility.Name);  
                Contact con = ContactTestFactory.buildContactRecord(acc.id,NS_StaticVariablesUtility.CONST_BLANK);  
                Database.insert (con);
                NS_PrimaryContact__c newPC = new NS_PrimaryContact__c();
            	newPC.NS_AccountName__c = acc.Id;
            	newPC.NS_ContactName__c = con.Id;
           		Database.insert(newPC,false);                     
                con.Phone='9766857889';                
                Database.update(con) ; 
                system.test.StopTest();
            }
        }catch(Exception exp){
            NS_StaticVariablesUtility.createExceptionRecord(exp, 'NS_IntegrationHelperTest', 'invoke_ContactUpdateTest');
        }
    } 
    
}