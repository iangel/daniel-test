/*
Description  : This test class is to test the functionality When OSS Reps creates and updates a Contact record
Developer    : Accenture Solutions
Date         : 20-06-2018

-----------------------------------------------------------------------
Developer name        Date          Description        
-----------------------------------------------------------------------
@Arjun Ghosh    20-06-2018     Unit testing methods
*/

@isTest(SeeAllData=false)
/* Test Class for NS_CreateQuickCaseFromContact */
private class NS_CreateQuickCaseFromContactTest {
 	  
  @isTest 
    static void runTest(){
        system.test.StartTest();
        Profile agent = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
       	User testUser = UserTestFactory.createUser(25,agent.Id);  
        system.runAs(testUser){
        Map<String,List<String>> actual =NS_CreateQuickCaseFromContactController.getDependentOptionsImpl('Case',
        	'NS_InteractionCategory__c','NS_InteractionReason__c');  
        Map<String,List<String>> createExp =NS_CreateQuickCaseFromContactController.getDependentOptionsImpl('',
        	'','');
        Map<String,List<String>> createExp1 =NS_CreateQuickCaseFromContactController.getDependentOptionsImpl('Case',
    		'NS_InteractionCategory__c','');           
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);        
        Account accPl = AccountTestFactory.getThreePLAccountRecord('Demo');
            accPl.NS_MonitoredAccount__c=true;
            Database.update(accPl,false);
        Contact con = ContactTestFactory.buildContactRecord(accPl.id,
        	NS_StaticVariablesUtility.CONST_BLANK);
          con.LastName = NS_StaticVariablesUtility.MANUAL;
        ContactTestFactory.insertContactRecord(con);   
        Map<String,List<String>> expected= new Map<String,List<String>>();  
        Map<String,String> myMap=new Map<String,String> ();
        Map<String,String> emptyMap=new Map<String,String> ();
        myMap.put('category', 'Foreign Road');
        myMap.put('reason', 'Request for 418');
        myMap.put('description', 'Test Data');
        myMap.put('contactid', con.id); 
        myMap.put('status', '');
        myMap.put('priority', '');
        myMap.put('subject', 'Test Data');
        myMap.put('onBehalfOfId', accPl.id);
        myMap.put('accountid',    accPl.id);      
        NS_CreateQuickCaseFromContactController.performBackgroundActions(myMap);
        List<String> result = NS_CreateQuickCaseFromContactController.performBackgroundActions(emptyMap);
        List<String>  exp=new  List<String> ();
        System.AssertEquals(exp,result);  
        NS_CreateQuickCaseController.is3PLRecordType(accPl.id);
        NS_CreateQuickCaseController.is3PLRecordType('');
        ManageContactAndUserIds__c customSet= new ManageContactAndUserIds__c(Name= testUser.id); 
               customSet.Account_Id__c = accPl.id;
               customSet.Contact_Id__c=con.id;
               customSet.User_Id_del__c=UserInfo.getUserId();
          Database.insert(customSet,false);  
            NS_CreateQuickCaseFromContactController.removeContact();         
        }
    }

}