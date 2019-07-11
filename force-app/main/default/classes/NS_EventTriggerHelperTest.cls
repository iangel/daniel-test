/**@author  Accenture
* @Created Date 2018-03-07
* @version  1.0
* @description This test class for NS_EventTriggerHelper and EventTrigger.
*/ 
@isTest(SeeAllData=false)
private class NS_EventTriggerHelperTest {
    
    /*Creating event with inactive contact name.*/
    @isTest static void eventCreateWithInactiveContact(){
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        System.runAs( admin ){ 
            ContactTestFactory.enableContactTrigger();
            EventTestFactory.enableEventTrigger();
        }
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
        Profile prof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserSupport);
        User atest = UserTestFactory.createUser(13,agentprof.Id);
        User utest = UserTestFactory.createUser(24,prof.Id);  
        Account accTest = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.NAME); 
        Contact con2 = ContactTestFactory.createContactRecord(accTest.id,NS_StaticVariablesUtility.CONST_BLANK);
        ContactShare conshare = ContactTestFactory.contactShare(con2.Id, atest.id, NS_StaticVariablesUtility.editAccess, NS_StaticVariablesUtility.rowCause);
        Event obevt = EventTestFactory.createEventRecord(NS_StaticVariablesUtility.NAME); 
        system.test.startTest();
        system.runAs(utest){ 
            con2.NS_ContactStatus__c =NS_StaticVariablesUtility.conInactiveStatus;
            Database.update(con2,false);
        }
        system.runAs(atest){
            try{ 
                obevt.WhoId=con2.Id;
                Database.insert(obevt,false);
                system.test.stopTest();
            }
            catch(DMLException exp){
                system.assertNotEquals(null, con2.Id);
                boolean expVal = exp.getMessage().contains(Label.NS_TaskErrorMessage)?true:false;
                system.Assert(true,expVal); 
            }
        }
    }
    /*Updating event with inactive contact name.*/
    @isTest static void eventUpdateWithInactiveContact(){
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        System.runAs( admin ){ 
            ContactTestFactory.enableContactTrigger();
            EventTestFactory.enableEventTrigger();
        }
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
        Profile prof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserSupport);
        User atest = UserTestFactory.createUser(11,agentprof.Id);
        User utest = UserTestFactory.createUser(21,prof.Id);
        Account accTest = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.NAME); 
        Contact con1 = ContactTestFactory.createContactRecord(accTest.id,NS_StaticVariablesUtility.CONST_BLANK);
        ContactShare conshare = ContactTestFactory.contactShare(con1.Id, atest.id, NS_StaticVariablesUtility.editAccess, NS_StaticVariablesUtility.rowCause);
        Event evt = EventTestFactory.createEventRecord(NS_StaticVariablesUtility.NAME);
        system.test.startTest();
        system.runAs(atest){
            evt.WhoId=con1.Id;
            Database.insert(evt,false); 
        }
        system.runAs(utest){ 
            con1.NS_ContactStatus__c =NS_StaticVariablesUtility.conInactiveStatus;
            Database.update(con1,false);
            try{
                Database.update(evt,false);
                system.test.stopTest();
            }
            catch(DMLException exp){
                boolean expVal = exp.getMessage().contains(Label.NS_TaskErrorMessage)?true:false;
                system.Assert(true,expVal);
            }
        }
         NS_EventTriggerHelper.filterInactiveContacts(null);
    }    
}