/**@author  Accenture
* @Created Date 2018-05-16
* @version  1.0
* @description This test class for NS_AssociatedAccountTriggerHelper and AssociatedAccountTrigger.
*/ 
@isTest(SeeAllData=false)
private class NS_AssociatedAccountTriggerHelperTest {
    /*When an Associated Account is created with same Account name and Contact name, it throws duplicate error*/
    @isTest
    static void insertAssociatedAccountTest(){
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(19,sysprof.Id);
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserSupport);
        User atest = UserTestFactory.createUser(13,agentprof.Id);
        atest.UserRoleId = NS_StaticVariablesUtility.userRole;
        update atest;
        
        System.runAs( admin ){ 
            system.test.StartTest();
            ContactTestFactory.enableContactTrigger();
            AssociatedAccountTestFactory.enableAssocAccountTrigger();
        }
        System.runAs( atest ){
            Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
            Contact con = new Contact(
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =:NS_StaticVariablesUtility.conRecordType AND 
                            SobjectType =:NS_StaticVariablesUtility.sObj Limit 1].id,
            FirstName='TEST',
            LastName='USER',
            AccountId= acc.id,
            Email ='user.test'+acc.id+'@gmail.com',
            NS_CustomerAccnt__c= '');
            insert con;
            
            
            //Contact con = ContactTestFactory.createContactRecord(acc.id,NS_StaticVariablesUtility.CONST_BLANK);
            acc=  [SELECT Id,name FROM Account LIMIT 1];
             

            
           Contact con1 = [SELECT Id,firstname,lastname,MobilePhone,Phone,OtherPhone,HomePhone,
                  AccountId FROM Contact where AccountId=:acc.id LIMIT 1];
        
            /* Verifying if Associated Account record is auto created after contact updation.*/
            NS_AssociatedAccount__c assoc = [SELECT NS_CellPhone__c,NS_WorkPhone__c,NS_OtherPhone1__c,
                     NS_OtherPhone2__c,NS_AccName__c,NS_ConName__c,NS_AccountName__c, NS_ContactName__c,NS_PrimaryAccount__c 
                     FROM NS_AssociatedAccount__c where NS_AccountName__c=:con.AccountId  LIMIT 1];
            
            system.assertEquals(con.MobilePhone,assoc.NS_CellPhone__c);
            system.assertEquals(con.Phone,assoc.NS_WorkPhone__c);
            system.assertEquals(con.OtherPhone,assoc.NS_OtherPhone1__c);
            system.assertEquals(con.HomePhone,assoc.NS_OtherPhone2__c);
            system.assertEquals(acc.name,assoc.NS_AccName__c);
            system.assertEquals(con.firstname+' '+con.lastname,assoc.NS_ConName__c);
            system.assertEquals(con.Id,assoc.NS_ContactName__c);
            system.assertEquals(con.AccountId,assoc.NS_AccountName__c);
            system.assertEquals(true,assoc.NS_PrimaryAccount__c);
            try{
                NS_AssociatedAccount__c assoc1 = AssociatedAccountTestFactory.buildAssociatedAccountRecord(acc.id,con.id);
                 
                Database.insert(assoc1,false);
                system.assertEquals(null, assoc1.Id);
                system.test.StopTest();
            }
            catch(DMLException exp){
                boolean expVal = exp.getMessage().contains('An Associated Account with same')?true:false;
                system.Assert(true,expVal); 
            } 
        }
    }
    /*When an Associated Account is updated with same Account name and Contact name, it throws duplicate error*/
    @isTest
    static void updateAssociatedAccountTest(){
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(19,sysprof.Id);
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserSupport);
        User atest = UserTestFactory.createUser(13,agentprof.Id);
        atest.UserRoleId = NS_StaticVariablesUtility.userRole;
        update atest;
        
        System.runAs( admin ){ 
            system.test.StartTest();
            ContactTestFactory.enableContactTrigger();
            AssociatedAccountTestFactory.enableAssocAccountTrigger();
        }
        System.runAs( atest ){
            Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
            Contact con = ContactTestFactory.createContactRecord(acc.id,NS_StaticVariablesUtility.CONST_BLANK);
            acc=  [SELECT Id,name FROM Account LIMIT 1];
            con = [SELECT Id,firstname,lastname,MobilePhone,Phone,OtherPhone,HomePhone,
                   AccountId FROM Contact where AccountId=:acc.id LIMIT 1];
            NS_AssociatedAccount__c assoc = [SELECT NS_CellPhone__c,NS_WorkPhone__c,NS_OtherPhone1__c,
                     NS_OtherPhone2__c,NS_AccName__c,NS_ConName__c,NS_AccountName__c, NS_ContactName__c,NS_PrimaryAccount__c 
                     FROM NS_AssociatedAccount__c where NS_AccountName__c=:con.AccountId  LIMIT 1];
            system.assertEquals(con.MobilePhone,assoc.NS_CellPhone__c);
            system.assertEquals(con.Phone,assoc.NS_WorkPhone__c);
            system.assertEquals(con.OtherPhone,assoc.NS_OtherPhone1__c);
            system.assertEquals(con.HomePhone,assoc.NS_OtherPhone2__c);
            system.assertEquals(acc.name,assoc.NS_AccName__c);
            system.assertEquals(con.firstname+' '+con.lastname,assoc.NS_ConName__c);
            system.assertEquals(con.Id,assoc.NS_ContactName__c);
            system.assertEquals(con.AccountId,assoc.NS_AccountName__c);
            system.assertEquals(true,assoc.NS_PrimaryAccount__c);
            
            Account acc1 = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Automotive);
            con = [SELECT Id,AccountId FROM Contact LIMIT 1];
            NS_AssociatedAccount__c assoc1 = AssociatedAccountTestFactory.buildAssociatedAccountRecord(acc1.id,con.id);
            Database.insert(assoc1,false);
     
            system.assertNotEquals(null, assoc1.Id);
            /* Verifying if Associated Account record is auto created after contact updation.*/
            acc1=  [SELECT Id,name FROM Account where name=:NS_StaticVariablesUtility.Automotive LIMIT 1];
            assoc1 = [SELECT NS_AccountName__c, NS_ContactName__c,NS_PrimaryAccount__c 
                      FROM NS_AssociatedAccount__c where NS_AccountName__c=:acc1.Id  LIMIT 1];
            system.assertEquals(con.id,assoc1.NS_ContactName__c);
            system.assertEquals(acc1.id,assoc1.NS_AccountName__c);
            system.assertEquals(false,assoc1.NS_PrimaryAccount__c);
            
            try{
                assoc1.NS_AccountName__c =acc.id;
                Database.update(assoc1,false);
                system.test.StopTest();
            }
            catch(DMLException exp){
                system.assertEquals(acc.id, assoc1.NS_AccountName__c);
                boolean expVal = exp.getMessage().contains('An Associated Account with same')?true:false;
                system.Assert(true,expVal); 
            }
        }
    }
}