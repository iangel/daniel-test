@isTest
private class NS_CTIMultiMatchHandlerTest{
    /*
        - code coverage for positive test scenario.
    */
    static testmethod void testPositive(){
        String phone = '8348753513';
        String param = 'test';
        String conid = '1'; 
        String conid2 = '2';   
        String conid3 = '3';   
        String conid4 = '4';   
        String conid5 = '5';   
        Integer offset = 10;
        Integer reclmt = 10;
        Integer nameorphn = 10;
        Profile agentprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
        User atest = UserTestFactory.createUser(13,agentprof.Id);
        system.assertNotEquals(null, atest.Associated_Business_Unit__c);
         Contact con;
       Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
        acc.phone = phone;
        Database.update(acc);
         
        AccountTestFactory.accountShare(acc.Id,atest.Id,NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.rowCause);
        system.test.StartTest();
        system.runAs(atest){
            // Insert Contact
            con = ContactTestFactory.createContactRecord(acc.id,NS_StaticVariablesUtility.CONST_BLANK);
        }
        con.FirstName = NS_StaticVariablesUtility.MANUAL;
         con.LastName = NS_StaticVariablesUtility.MANUAL;
        con.phone = phone;
        con.HomePhone=phone;
        con.MobilePhone=phone;
        con.OtherPhone=phone;
        
        Database.update(con);
      
        Map<String,String> myMap= new Map<String,String>();
        myMap.put(acc.Id,con.Id);
        NS_CTIMultiMatchHandler.setPhoneNumber(phone);
        NS_CTIMultiMatchHandler.getAccount();
        NS_CTIMultiMatchHandler.getAccountByName(NS_StaticVariablesUtility.Name);
        NS_CTIMultiMatchHandler.getAccountByPhone(phone);
        NS_CTIMultiMatchHandler.getContactByAccId(acc.Id,phone);
        NS_CTIMultiMatchHandler.getContact();
        NS_CTIMultiMatchHandler.getContactByName('Test');
        NS_CTIMultiMatchHandler.getContactByPhone(phone);
        NS_CTIMultiMatchHandler.runMatchLogic();
        NS_CTIMultiMatchHandler.getMatchedContacts(acc.Id);
        NS_CTIMultiMatchHandler.getMatchedAccounts();
        NS_CTIMultiMatchHandler.getAssociatedAccounts();
        NS_CTIMultiMatchHandler.getAssociatedContacts(acc.Id);
       NS_CTIMultiMatchHandler.associateAccount( myMap);
        NS_CTIMultiMatchHandler.fetchNextRecords(param,offset,nameorphn,reclmt);
        NS_CTIMultiMatchHandler.fetchNextConRecords(param,offset,nameorphn,reclmt);
        NS_CTIMultiMatchHandler.doMapping(acc.Id,con.Id);        
        NS_CTIMultiMatchHandler.saveContactDetails(con.Id,param,conid);
        NS_CTIMultiMatchHandler.saveContactDetails(con.Id,param,conid2);
        NS_CTIMultiMatchHandler.saveContactDetails(con.Id,param,conid3);
        NS_CTIMultiMatchHandler.saveContactDetails(con.Id,param,conid4);
        NS_CTIMultiMatchHandler.saveContactDetails(con.Id,param,conid5);
        NS_CTIMultiMatchHandler.getOfflineAccountId();
       
        System.test.StopTest();
    }
    @isTest 
    static void runTest(){
      NS_CTIMultiMatchHandler.Beginning();
      NS_CTIMultiMatchHandler.Previous(5);
      NS_CTIMultiMatchHandler.Next(5);
      NS_CTIMultiMatchHandler.End(5);
      NS_CTIMultiMatchHandler.conBeginning();
      NS_CTIMultiMatchHandler.conPrevious(5);
      NS_CTIMultiMatchHandler.conNext(5);
      NS_CTIMultiMatchHandler.getTotalPages();
       NS_CTIMultiMatchHandler.getPageNumber();
        NS_CTIMultiMatchHandler.getTotal_size();
       
      }
    @isTest 
    static void customSettingsTest(){
         system.test.StartTest();
        Profile agent = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
       	User testUser = UserTestFactory.createUser(25,agent.Id);  
        system.runAs(testUser){
        Account accPl = AccountTestFactory.getThreePLAccountRecord('Demo');
            accPl.NS_MonitoredAccount__c=true;
            Database.update(accPl,false);
        Contact con = ContactTestFactory.buildContactRecord(accPl.id,NS_StaticVariablesUtility.CONST_BLANK);
            con.LastName = NS_StaticVariablesUtility.MANUAL;
            ContactTestFactory.insertContactRecord(con);   
            ManageContactAndUserIds__c customSet= new ManageContactAndUserIds__c(Name= testUser.id); 
               customSet.Account_Id__c = accPl.id;
               customSet.Contact_Id__c=con.id;
               customSet.User_Id_del__c=UserInfo.getUserId();
           Database.insert(customSet,false); 
          
            NS_DummyAccOrphanCon__c dummy = new NS_DummyAccOrphanCon__c();
            dummy.NS_AccountId__c = '0013D00000VEjBOQA1';
            dummy.Name = 'Dummy Account';
            insert dummy;
            NS_CTIMultiMatchHandler.updateCustomSettings(accPl.id, con.id);
            
          /*   NS_DummyAccOrphanCon__c customsetdummy = new NS_DummyAccOrphanCon__c(Name=NS_StaticVariablesUtility.dummyAccount);
           	   customsetdummy.NS_AccountId__c=accPl.Id;
               Database.insert(customsetdummy,false); */
             NS_CTIMultiMatchHandler.isDummyAcForOrphanContacts(null);
        }
    }
}