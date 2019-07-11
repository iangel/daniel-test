/**@author  Accenture
* @Created Date 2018-03-19
* @version  1.0
* @description This test class for NS_ContactTriggerHelper and ContactTrigger.
*/ 
@isTest(SeeAllData=false)
private class NS_ContactTriggerHelperTest {
    
    /*When OSS Reps creates and updates a Contact record*/
    @isTest
    static void insertContactTest(){
        system.test.StartTest();
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        System.runAs( admin ){ 
            ContactTestFactory.enableContactTrigger();
            AssociatedAccountTestFactory.enableAssocAccountTrigger();
        }
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
        User atest = UserTestFactory.createUser(13,agentprof.Id);
        atest.UserRoleId = NS_StaticVariablesUtility.userRole;
        update atest;
         
        system.assertNotEquals(null, atest.Associated_Business_Unit__c);
        String conMailingAddress=' ';
        String conPhysicalAddress=' ';
        system.runAs(admin){
            Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name); 
            system.assertNotEquals(null, acc.Id);
            Account acc1 = AccountTestFactory.createDummyAccountRecord(NS_StaticVariablesUtility.accName);
            Contact con = ContactTestFactory.buildContactRecord(acc.id,NS_StaticVariablesUtility.CONST_BLANK);
            con.LastName = NS_StaticVariablesUtility.MANUAL;
            ContactTestFactory.insertContactRecord(con);
            Contact con1 = ContactTestFactory.buildContactRecord(acc.id,NS_StaticVariablesUtility.CONST_BLANK);
            con1.LastName = NS_StaticVariablesUtility.Active; 
            con1.Email = NS_StaticVariablesUtility.Email12; 
            con1.NS_BusinessUnit__c = NS_StaticVariablesUtility.Automotive;
            ContactTestFactory.insertContactRecord(con1);
            //Contact con2 = ContactTestFactory.createContactRecord(acc1.id,NS_StaticVariablesUtility.Automotive);
            Contact con2 = ContactTestFactory.createContactRecord(null,NS_StaticVariablesUtility.Automotive);
            
            
            acc = [SELECT Id,NS_MailingAddressDetails__c,NS_PhysicalAddressDetails__c from Account where Id =:acc.id LIMIT 1];
            con = [SELECT Id,RecordType.DeveloperName,FirstName,LastName,AccountId,NS_TextBusinessUnit__c,NS_BusinessUnit__c,
                   owner.name,MailingAddress,OtherAddress FROM Contact where LastName=:NS_StaticVariablesUtility.MANUAL LIMIT 1];
            con1 = [SELECT Id,FirstName,LastName,Email,AccountId,NS_TextBusinessUnit__c,NS_BusinessUnit__c 
                    FROM Contact where Email =:NS_StaticVariablesUtility.Email12 LIMIT 1];
          //  con2 = [SELECT Id, Account.Name FROM Contact where Account.Name= null AND 
            //        NS_CustomerAccnt__c=:NS_StaticVariablesUtility.Automotive LIMIT 1];
             con2 = [SELECT Id,Account.Name FROM Contact where 
                 NS_CustomerAccnt__c=:NS_StaticVariablesUtility.Automotive LIMIT 1];     
                    
            Address addr1=con.MailingAddress;
            conMailingAddress=addr1.getStreet()+' '+addr1.getCity()+' '+addr1.getState()+' '+addr1.getCountry()
                              +' '+addr1.getPostalCode();
            Address addr2=con.OtherAddress;
            conPhysicalAddress = addr2.getStreet()+' '+addr2.getCity()+' '+addr2.getState()+' '+addr2.getCountry()
                               +' '+addr2.getPostalCode();
            system.assertEquals(atest.Associated_Business_Unit__c,con.NS_BusinessUnit__c);
            system.assertNotEquals(atest.Associated_Business_Unit__c,con1.NS_BusinessUnit__c);
            system.assertEquals(atest.Associated_Business_Unit__c,con.NS_TextBusinessUnit__c);
            system.assertEquals(NS_StaticVariablesUtility.Automotive,con1.NS_TextBusinessUnit__c);
            system.assertEquals(null,con2.Account.Name);
            system.assertEquals(NS_StaticVariablesUtility.integrationUserName,con.Owner.Name);
            system.assertEquals(NS_StaticVariablesUtility.conRecordType,con.RecordType.DeveloperName);
            system.assertEquals(acc.NS_MailingAddressDetails__c,conMailingAddress);
            system.assertEquals(acc.NS_PhysicalAddressDetails__c,conPhysicalAddress);
            con.NS_ContactStatus__c = NS_StaticVariablesUtility.deactivationStatus;
            ContactTestFactory.updateContactRecord(con);
            con = [SELECT Id,NS_ContactStatus__c,RecordType.DeveloperName,AccountId FROM Contact where AccountId =:acc.id LIMIT 1];
            system.assertEquals(NS_StaticVariablesUtility.deactivationStatus,con.NS_ContactStatus__c);    
            system.assertEquals(NS_StaticVariablesUtility.conRecordType,con.RecordType.DeveloperName);
        }
        System.test.StopTest();
    }
    
    /*When OSS Support creates and updates a Contact record*/
    @isTest
    static void updateContactTest(){
        system.test.StartTest();
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,agentprof.Id);
        System.runAs( admin ){ 
            ContactTestFactory.enableContactTrigger();
            AssociatedAccountTestFactory.enableAssocAccountTrigger();
        }
        Profile prof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserSupport);
        User utest = UserTestFactory.createUser(24,prof.Id); 
        utest.UserRoleId = NS_StaticVariablesUtility.userRoleSupport;
        update utest;
        system.assertNotEquals(null, utest.Associated_Business_Unit__c);
        system.runAs(admin){
            Account acc1 = AccountTestFactory.createDummyAccountRecord(NS_StaticVariablesUtility.accName);
            Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name); 
            Contact con = ContactTestFactory.createContactRecord(acc.id,NS_StaticVariablesUtility.CONST_BLANK);
            con.NS_ContactStatus__c =NS_StaticVariablesUtility.conInactiveStatus;
            con.NS_BusinessUnit__c=NS_StaticVariablesUtility.Automotive;
            ContactTestFactory.updateContactRecord(con);
            con = [SELECT Id,NS_ContactStatus__c,RecordType.DeveloperName,Name,AccountId,NS_TextBusinessUnit__c,NS_BusinessUnit__c
                   FROM Contact where AccountId =:acc.id LIMIT 1];
          
            system.assertEquals(NS_StaticVariablesUtility.conInactiveStatus,con.NS_ContactStatus__c);
            system.assertEquals(NS_StaticVariablesUtility.Automotive,con.NS_BusinessUnit__c);
            system.assertEquals(NS_StaticVariablesUtility.conInactiveRecordType,con.RecordType.DeveloperName);
            system.assertEquals(con.NS_BusinessUnit__c,con.NS_TextBusinessUnit__c);

            con.NS_ContactStatus__c = NS_StaticVariablesUtility.Active;
            ContactTestFactory.updateContactRecord(con);
            con = [SELECT Id,NS_ContactStatus__c,RecordType.DeveloperName FROM Contact where AccountId =:acc.id LIMIT 1];
            system.assertEquals(NS_StaticVariablesUtility.Active,con.NS_ContactStatus__c);
            system.assertEquals(NS_StaticVariablesUtility.conRecordType,con.RecordType.DeveloperName);
            
            con.AccountId = null;
            con.NS_CustomerAccnt__c = NS_StaticVariablesUtility.Automotive;
            ContactTestFactory.updateContactRecord(con);
            acc1 = [SELECT Id,Name from Account where NS_External_ID__c=:NS_StaticVariablesUtility.dummyExternalID  LIMIT 1];
            con = [SELECT Id,Account.Name FROM Contact where AccountId = :NS_StaticVariablesUtility.Blank  LIMIT 1]; 
            system.assertEquals(null,con.Account.Name);
        }
        System.test.StopTest();
    }
    /*When a Contact record is created, Associated Account should get created*/
    @isTest
    static void createAssociatedAccountTest(){
        system.test.StartTest();
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        System.runAs( admin ){ 
            ContactTestFactory.enableContactTrigger();
            AssociatedAccountTestFactory.enableAssocAccountTrigger();
        }
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
        User atest = UserTestFactory.createUser(13,agentprof.Id);
     
        System.runAs(admin){
        Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name); 
        Contact con=ContactTestFactory.createContactRecord(acc.id,NS_StaticVariablesUtility.CONST_BLANK);
       
            acc = [SELECT Id,Name from Account LIMIT 1];
            con = [SELECT Id,AccountId FROM Contact where AccountId=:acc.id LIMIT 1];
            NS_AssociatedAccount__c assoc = [SELECT NS_AccountName__c, NS_ContactName__c,NS_PrimaryAccount__c 
                     FROM NS_AssociatedAccount__c LIMIT 1];
            system.assertEquals(con.Id,assoc.NS_ContactName__c);
            system.assertEquals(con.AccountId,assoc.NS_AccountName__c);
            system.assertEquals(true,assoc.NS_PrimaryAccount__c);
            system.test.StopTest();
        }
    }
    
    /*When an orphan contact is created,a Dummy Account gets assigned to Contact AccountId,
     * Associated Account gets created with a Dummy Account*/
    @isTest
    static void updateOrphanContact(){
        system.test.StartTest();
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        System.runAs( admin ){ 
            ContactTestFactory.enableContactTrigger();
            AssociatedAccountTestFactory.enableAssocAccountTrigger();
        }
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
        User atest = UserTestFactory.createUser(13,agentprof.Id);
      
        System.runAs(admin){
        Account acc1 = AccountTestFactory.createDummyAccountRecord(NS_StaticVariablesUtility.accName);
        //Contact con =ContactTestFactory.createContactRecord(null,NS_StaticVariablesUtility.NAME);
            
        Contact con =ContactTestFactory.createContactRecord(acc1.id,NS_StaticVariablesUtility.NAME);
       
        /*Updating contact's Contact name and blank Account name with existing Account.*/
        acc1 = [SELECT Id,Name from Account where NS_External_ID__c=:NS_StaticVariablesUtility.dummyExternalID  LIMIT 1];            
        con =  [SELECT Id,AccountId,FirstName,Lastname,MobilePhone,Phone,OtherPhone,HomePhone FROM Contact 
                where AccountId=:acc1.id LIMIT 1];
          
        system.assertEquals(acc1.id,con.AccountId); 
        
        /* Verifying if Associated Account record is auto created with Dummy Account after contact is saved.*/
      
            NS_AssociatedAccount__c assoc = [SELECT NS_AccountName__c, NS_ContactName__c,NS_AccountRole__c,NS_PrimaryAccount__c,
                                             NS_CellPhone__c,NS_WorkPhone__c,NS_OtherPhone1__c,NS_OtherPhone2__c,NS_ConName__c 
                                             FROM NS_AssociatedAccount__c where NS_ContactName__c =:con.id LIMIT 1];
            system.assertEquals(con.id,assoc.NS_ContactName__c);
            system.assertEquals(acc1.id,assoc.NS_AccountName__c);
            system.assertEquals(true,assoc.NS_PrimaryAccount__c);
            system.assertEquals(con.MobilePhone,assoc.NS_CellPhone__c);
            system.assertEquals(con.Phone,assoc.NS_WorkPhone__c);
            system.assertEquals(con.OtherPhone,assoc.NS_OtherPhone1__c);
            system.assertEquals(con.HomePhone,assoc.NS_OtherPhone2__c);
            system.assertEquals(con.firstname+' '+con.lastname,assoc.NS_ConName__c);
            system.test.StopTest();
        }
    }
    /*When an existing contact record is updated, Associated Account also should get updated*/
    @isTest
    static void updateContactWithAccount(){
        system.test.StartTest();
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        System.runAs( admin ){ 
            ContactTestFactory.enableContactTrigger();
            AssociatedAccountTestFactory.enableAssocAccountTrigger();
        }
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
        User atest = UserTestFactory.createUser(13,agentprof.Id);
       
        System.runAs(admin){    
            Account acctest=AccountTestFactory.createOnlineAccountRecord(NS_StaticVariablesUtility.Automotive);
            Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
            Account acc1 = AccountTestFactory.createOnlineAccountRecord(NS_StaticVariablesUtility.EquipmentSummary);   
            Contact testcon = ContactTestFactory.createContactRecord(acc.id,NS_StaticVariablesUtility.CONST_BLANK);
            NS_AssociatedAccount__c assoctest1 = AssociatedAccountTestFactory.insertAssociatedAccountRecord(acc1.id,testcon.id);
            /*Updating contact's Account name with different Account name and contact name*/
            acctest = [SELECT Id,Name FROM Account where Name =:NS_StaticVariablesUtility.Automotive LIMIT 1];
            testcon = [SELECT Id,AccountId,FirstName,NS_PrefConMethd__c FROM Contact where AccountId=:acc.Id LIMIT 1]; 
            testcon.AccountId = acctest.id;
            testcon.FirstName = NS_StaticVariablesUtility.NAME;
            testcon.LastName = NS_StaticVariablesUtility.Success;
            testcon.MobilePhone = '7809567891';
            testcon.NS_PrefConMethd__c = 'Mobile Phone';
            ContactTestFactory.updateContactRecord(testcon);
            acctest = [SELECT Id,Name FROM Account where Name =:NS_StaticVariablesUtility.Automotive LIMIT 1];
            acc1 = [SELECT Id,Name FROM Account where Name =:NS_StaticVariablesUtility.EquipmentSummary LIMIT 1];
            testcon = [SELECT Id,FirstName,LastName,MobilePhone,Phone,OtherPhone,HomePhone,NS_PrefConMethd__c,
                       AccountId FROM Contact where NS_PrefConMethd__c='Mobile Phone' LIMIT 1];
            system.assertEquals(acctest.id,testcon.AccountId); 
            system.assertEquals(NS_StaticVariablesUtility.NAME.toUpperCase(),testcon.FirstName);
            
            /*Verifying if Primary Associated Account record is updated after contact updation.*/
            NS_AssociatedAccount__c assoctest = [SELECT NS_AccountName__c, NS_ContactName__c,NS_AccountRole__c,NS_PrimaryAccount__c,
                                                 NS_CellPhone__c,NS_WorkPhone__c,NS_OtherPhone1__c,NS_OtherPhone2__c,NS_ConName__c 
                                                 FROM NS_AssociatedAccount__c where NS_AccountName__c =:acctest.id LIMIT 1];
            system.assertEquals(testcon.id,assoctest.NS_ContactName__c);
            system.assertEquals(testcon.AccountId,assoctest.NS_AccountName__c);
            system.assertEquals(true,assoctest.NS_PrimaryAccount__c);
            system.assertEquals(testcon.MobilePhone,assoctest.NS_CellPhone__c);
            system.assertEquals(testcon.Phone,assoctest.NS_WorkPhone__c);
            system.assertEquals(testcon.OtherPhone,assoctest.NS_OtherPhone1__c);
            system.assertEquals(testcon.HomePhone,assoctest.NS_OtherPhone2__c);
            system.assertEquals(testcon.firstname+' '+testcon.lastname,assoctest.NS_ConName__c);
            /*Verifying if other Associated Account record is updated after contact updation.*/
            assoctest1 = [SELECT NS_AccountName__c, NS_ContactName__c,NS_AccountRole__c,NS_PrimaryAccount__c,
                          NS_CellPhone__c,NS_WorkPhone__c,NS_OtherPhone1__c,NS_OtherPhone2__c,
                          NS_ConName__c FROM NS_AssociatedAccount__c where NS_AccountName__c =:acc1.id LIMIT 1];
            system.assertEquals(false,assoctest1.NS_PrimaryAccount__c);
            system.assertEquals(testcon.MobilePhone,assoctest1.NS_CellPhone__c);
            system.assertEquals(testcon.Phone,assoctest1.NS_WorkPhone__c);
            system.assertEquals(testcon.OtherPhone,assoctest1.NS_OtherPhone1__c);
            system.assertEquals(testcon.HomePhone,assoctest1.NS_OtherPhone2__c);
            system.assertEquals(testcon.firstname+' '+testcon.lastname,assoctest1.NS_ConName__c);
            
            testcon.MobilePhone = null;
            ContactTestFactory.updateContactRecord(testcon);
            testcon = [SELECT MobilePhone,NS_PrefConMethd__c,AccountId FROM Contact 
                       where AccountId =:acctest.id LIMIT 1];
            assoctest = [SELECT NS_CellPhone__c from NS_AssociatedAccount__c where NS_AccountName__c =:acctest.id LIMIT 1];
            assoctest1 = [SELECT NS_CellPhone__c from NS_AssociatedAccount__c where NS_AccountName__c =:acc1.id LIMIT 1];
            system.assertEquals(null,testcon.NS_PrefConMethd__c);
            system.assertEquals(null,assoctest1.NS_CellPhone__c);
            system.assertEquals(null,assoctest.NS_CellPhone__c);
        }
        system.test.StopTest();
    }
    
    
        @isTest
    static void deleteAssocAccountOnMergeTest(){
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
       /* Profile prof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserSupport);
        User utest = UserTestFactory.createUser(24,prof.Id); */
        System.runAs( admin ){ 
            system.test.StartTest();
            ContactTestFactory.enableContactTrigger();
            Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
            Contact con = ContactTestFactory.createContactRecord(acc.id,NS_StaticVariablesUtility.CONST_BLANK);
            NS_TriggerSettings__c customSet1 = new NS_TriggerSettings__c();
            customSet1.Name=NS_StaticVariablesUtility.assocTrigger;
            customSet1.NS_IsActive__c=false;
            Database.insert(customSet1,false);
            try{       
                String ascConJSON='{"attributes":{"type":"NS_AssociatedAccount__c"},"NS_AccountName__c":"'+acc.Id+'","NS_ContactName__c":"'+con.Id+'","CreatedDate":"2019-01-07T08:00:00.000+0000","LastModifiedDate":"2019-01-08T08:00:00.000+0000"}';
                NS_AssociatedAccount__c assoctest1 = (NS_AssociatedAccount__c) JSON.deserialize(ascConJSON, NS_AssociatedAccount__c.class );                
                database.insert(assoctest1,false);
                Integer assocAccounts = [SELECT count() 
                                         FROM NS_AssociatedAccount__c where NS_AccountName__c=: acc.Id and NS_ContactName__c=: con.Id];
                system.assertEquals(2,assocAccounts);
                con.Phone='9173520';
                ContactTestFactory.updateContactRecord(con);
              /*  Map<Id,Contact> ConMap = new Map<Id,Contact>();
                ConMap.put(con.id,con);
                NS_ContactTriggerHelper.deleteAssocAccountOnMerge(ConMap);*/
                system.test.StopTest();
            }
            catch(exception ex){
            }
        }
    }
    
    
    @isTest
    static void autoPopulateContactAddressTest(){
         system.test.StartTest();
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        System.runAs( admin ){ 
            ContactTestFactory.enableContactTrigger();
            AssociatedAccountTestFactory.enableAssocAccountTrigger();
        }
            System.runAs(admin){   
            Account testAcc = AccountTestFactory.createAccountRecord1(NS_StaticVariablesUtility.Name);
            system.assertNotEquals(null, testAcc.id);
            Contact testCon = ContactTestFactory.createContactRecord(testAcc.id,NS_StaticVariablesUtility.CONST_BLANK); 
            system.assertEquals(testCon.AccountId, testAcc.Id);
            Account testAcc1 = AccountTestFactory.createAccountRecord2(NS_StaticVariablesUtility.Name);
            system.assertNotEquals(null, testAcc.id);
            Contact testCon1 = ContactTestFactory.createContactRecord(testAcc1.id,NS_StaticVariablesUtility.CONST_BLANK); 
            system.assertEquals(testCon1.AccountId, testAcc1.Id);
            system.test.StopTest();
            }
    }
}