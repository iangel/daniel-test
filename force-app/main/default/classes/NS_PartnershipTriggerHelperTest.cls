/**@author  Accenture
* @Created Date 2018-05-21
* @version  1.0
* @description This test class for NS_PartnershipTriggerHelper and NSPartnershipTrigger.
*/ 
@isTest(SeeAllData=false)
private class NS_PartnershipTriggerHelperTest {
    /*When a Partnership record is created with existing Customer,Primary Partner Contact and Type combination, it throws duplicate error*/
    @isTest
    static void insertPartnershipTest(){
        Profile adminProf = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,adminProf.Id);
        Profile repProf = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
        User rep= UserTestFactory.createUser(13,repProf.Id); 
        System.runAs(admin ){ 
            NS_TriggerSettings__c triggerSettings = new NS_TriggerSettings__c(Name= NS_StaticVariablesUtility.partnershipTrigger); 
            triggerSettings.NS_IsActive__c = true;
            system.test.StartTest();
            Database.insert(triggerSettings,false);
            Account onlineAcc = AccountTestFactory.createOnlineAccountRecord(NS_StaticVariablesUtility.Name);
            AccountTestFactory.accountShare(onlineAcc.Id,rep.Id,NS_StaticVariablesUtility.readAccess,
                                            NS_StaticVariablesUtility.readAccess,
                                            NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.rowCause);
            system.test.StopTest();
            system.assertNotEquals(null, onlineAcc.Id);
        }
        System.runAs(rep){
            
                
                NS_TriggerSettings__c customSet = new NS_TriggerSettings__c(Name= 'ActiveNSPartnershipTrigger'); 
        customSet.NS_IsActive__c = true;
        Database.insert(customSet,false);
            Account onlineAccount = [SELECT id FROM Account WHERE name = 'Name' limit 1];
            Account nonOnlineAccount = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
            system.assertNotEquals(null, nonOnlineAccount.Id);
            Contact contact = ContactTestFactory.createContactRecord(nonOnlineAccount.id,NS_StaticVariablesUtility.CONST_BLANK);
            system.assertNotEquals(null, contact.Id);
            NS_Partnership__c partner = NSPartnershipTestFactory.buildNSPartnershipRecord(
                onlineAccount.Id,nonOnlineAccount.Id,contact.Id,NS_StaticVariablesUtility.partnershipType1);
            NS_Partnership__c partner1 = NSPartnershipTestFactory.createNSPartnershipRecord(partner);
            system.assertNotEquals(null, partner1.Id);
            try{
                NS_Partnership__c partner2 = NSPartnershipTestFactory.buildNSPartnershipRecord(
                    onlineAccount.Id,nonOnlineAccount.Id,contact.Id,NS_StaticVariablesUtility.partnershipType1);  
                NS_Partnership__c partner3 = NSPartnershipTestFactory.createNSPartnershipRecord(partner2);
                system.assertEquals(null, partner3.Id);
            }
            catch(DMLException exp){
                boolean expVal = exp.getMessage().contains('This partnership already exists')?true:false;
                system.Assert(true,expVal); 
            }
        }
    }
    
    /*When a Partnership record is updated with existing Customer,Primary Partner Contact and Type combination, it throws duplicate error*/
    @isTest
    static void updatePartnershipTest(){
        system.test.StartTest();
        Profile adminProf = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,adminProf.Id);
        Profile repProf = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
        User rep = UserTestFactory.createUser(13,repProf.Id); 
        System.runAs( admin ){ 
            NS_TriggerSettings__c triggerSettings = new NS_TriggerSettings__c(Name= NS_StaticVariablesUtility.partnershipTrigger); 
            triggerSettings.NS_IsActive__c = true;
            Database.insert(triggerSettings,false);
            Account onlineAcc = AccountTestFactory.createOnlineAccountRecord(NS_StaticVariablesUtility.Name);
            AccountTestFactory.accountShare(onlineAcc.Id,rep.Id,NS_StaticVariablesUtility.readAccess,
                                            NS_StaticVariablesUtility.readAccess,
                                            NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.rowCause);
            system.assertNotEquals(null, onlineAcc.Id);
        }
        System.runAs(rep){
            Account onlineAccount = [SELECT id FROM Account WHERE name = :NS_StaticVariablesUtility.Name limit 1];
            Account nonOnlineAccount = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name); 
            system.assertNotEquals(null, nonOnlineAccount.Id);
            Contact contact = ContactTestFactory.createContactRecord(nonOnlineAccount.id,NS_StaticVariablesUtility.CONST_BLANK);  
            system.assertNotEquals(null, contact.Id);
            NS_Partnership__c partner = NSPartnershipTestFactory.buildNSPartnershipRecord(
                onlineAccount.Id,nonOnlineAccount.Id,contact.Id,NS_StaticVariablesUtility.partnershipType1);
            NS_Partnership__c partner1 = NSPartnershipTestFactory.createNSPartnershipRecord(partner);
            system.assertNotEquals(null, partner1.Id);
            NS_Partnership__c partner2 = NSPartnershipTestFactory.buildNSPartnershipRecord(
                onlineAccount.Id,nonOnlineAccount.Id,contact.Id,NS_StaticVariablesUtility.partnershipType2);  
            NS_Partnership__c partner3 = NSPartnershipTestFactory.createNSPartnershipRecord(partner2);
            system.assertNotEquals(null, partner3.Id);  
            try{
                partner2.NS_PartnershipType__c=NS_StaticVariablesUtility.partnershipType1;
                Database.update(partner2);
            }
            catch(DMLException exp){
                system.assertNotEquals(null, partner2.Id);
                boolean expVal = exp.getMessage().contains('This partnership already exists')?true:false;
                system.Assert(true,expVal); 
            }
        }
        system.test.StopTest();
    }
    /*During partnership data load, if records to be loaded contain any duplicate data,it throws duplicate error*/
    @isTest
    static void insertBulkPartnershipTest(){
        Profile adminProf = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,adminProf.Id);
        Profile repProf = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
        User rep = UserTestFactory.createUser(13,repProf.Id); 
        List<NS_Partnership__c> partnerList =new List<NS_Partnership__c>();
        System.runAs(admin ){ 
            NS_TriggerSettings__c triggerSettings = new NS_TriggerSettings__c(Name= NS_StaticVariablesUtility.partnershipTrigger); 
            triggerSettings.NS_IsActive__c = true;
            system.test.StartTest();
            Database.insert(triggerSettings,false);
            Account onlineAcc = AccountTestFactory.createOnlineAccountRecord(NS_StaticVariablesUtility.Name);
            AccountTestFactory.accountShare(onlineAcc.Id,rep.Id,NS_StaticVariablesUtility.readAccess,
                                            NS_StaticVariablesUtility.readAccess,
                                            NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.rowCause);
            system.test.StopTest();
            system.assertNotEquals(null, onlineAcc.Id);
        }
        System.runAs(rep){
            Account onlineAccount = [SELECT id FROM Account WHERE name = 'Name' limit 1];
            Account nonOnlineAccount = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
            system.assertNotEquals(null, nonOnlineAccount.Id);
            Contact con = ContactTestFactory.createContactRecord(nonOnlineAccount.id,NS_StaticVariablesUtility.CONST_BLANK);
            system.assertNotEquals(null, con.Id);
            for(Integer i=0;i<=3;i++){
                NS_Partnership__c partner = NSPartnershipTestFactory.buildNSPartnershipRecord(
                    onlineAccount.Id,nonOnlineAccount.Id,con.Id,NS_StaticVariablesUtility.partnershipType1);
                partnerList.add(partner);
            }
            try{
                NSPartnershipTestFactory.createBulkNSPartnershipRecord(partnerList);
            }
            catch(DMLException exp){
                boolean expVal = exp.getMessage().contains('Duplicate record found for Customer Account:')?true:false;
                system.Assert(true,expVal); 
            }
        }
    }
}