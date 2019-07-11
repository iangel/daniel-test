/**@author  Accenture
* @Created Date 2018-05-21
* @version  1.0
* @description This test class is to test the functionality When OSS Reps creates and updates a Contact record
*/ 
@isTest(SeeAllData=false)
private class NS_CreateQuickCaseControllerTest {
 	  // test methods
  @isTest static void runTest(){
        system.test.StartTest();
        Profile agent = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
       	User testUser = UserTestFactory.createUser(25,agent.Id);  
        system.runAs(testUser){
        Map<String,List<String>> actual =NS_CreateQuickCaseController.getDependentOptionsImpl('NS_InteractionCategory__c','NS_InteractionReason__c');  
         Map<String,List<String>> createExp =
             NS_CreateQuickCaseController.getDependentOptionsImpl('','');
         Map<String,List<String>> createExp1 =
             NS_CreateQuickCaseController.getDependentOptionsImpl('NS_InteractionCategory__c','');
         Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);        
        Account accPl = AccountTestFactory.getThreePLAccountRecord('Demo');
            accPl.NS_MonitoredAccount__c=true;
            Database.insert(accPl,false);
        Contact con = ContactTestFactory.buildContactRecord(accPl.id,NS_StaticVariablesUtility.CONST_BLANK);
            con.LastName = NS_StaticVariablesUtility.MANUAL;
            ContactTestFactory.insertContactRecord(con);   
        Map<String,List<String>> expected= new Map<String,List<String>>();  
        Map<String,String> myMap=new Map<String,String> ();
        Map<String,String> emptyMap=new Map<String,String> ();
        myMap.put('category', 'Foreign Road');
        myMap.put('reason', 'Request for 418');
        myMap.put('description', 'Test Data');
        myMap.put('contactid', con.id); 
        myMap.put('status', 'Test Data');
        myMap.put('priority', 'Test Data');
        myMap.put('subject', 'Test Data');
        myMap.put('onBehalfOfId', accPl.id);
        myMap.put('accountid',    accPl.id);      
        NS_CreateQuickCaseController.performBackgroundActions(myMap);
        NS_CreateQuickCaseController.performBackgroundActions(emptyMap);
        NS_CreateQuickCaseController.is3PLRecordType(accPl.id);
        NS_CreateQuickCaseController.is3PLRecordType('');
        NS_CreateQuickCaseController.isOssRepLoggedin();
        NS_CreateQuickCaseController.removeContact();
        ManageContactAndUserIds__c customSet= new ManageContactAndUserIds__c(Name= testUser.id); 
               customSet.Account_Id__c = accPl.id;
               customSet.Contact_Id__c=con.id;
               customSet.User_Id_del__c=UserInfo.getUserId();
          Database.insert(customSet,false);  
            NS_CreateQuickCaseController.getContact();
            
        }
    }

}