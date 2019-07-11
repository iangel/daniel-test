/****************************************************************
This is the test class for casereleasecontroller
Developer    : Accenture Solutions
Date         : 04-18-2018
*****************************************************************/
@isTest(SeeAllData=false)
private  class NS_CaseReleaseControllerTest {  

    		private static final String CLASS_NAME='NS_CaseReleaseControllerTest';
    		private static final String METHOD_NAME='getAssignedCasesTest';
    		
    		/********************************************************
            This is the test method for casereleasecontroller
            Developer    : Accenture Solutions
            Date         : 04-18-2018
			********************************************************/
            public static testmethod void getAssignedCasesTest()
            {
            	system.test.StartTest();

                    Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
                    User admin = UserTestFactory.createUser(18,sysprof.Id);
                    Case cs1 = new Case();
                    List<Id> csId= new List<Id>();                            
                    Profile agent = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
                    User atest = UserTestFactory.createUser(25,agent.Id);  
                    Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
                    acc.NS_MonitoredAccount__c=true;
                    Database.update(acc,false); 
        
                    AccountTestFactory.accountShare(acc.Id,atest.Id,NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.readAccess,
                                                    NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.rowCause);  
              
                    system.runAs(atest)
                    {
                    Contact con = ContactTestFactory.createContactRecord(acc.Id, NS_StaticVariablesUtility.NAME);
                    Case cse = new Case(NS_InteractionReason__c='Cash Hold',
                                        NS_InteractionCategory__c='Accounting/Waybilling',
                                        Subject= NS_StaticVariablesUtility.NAME,
                                        NS_ExternalCaseNotes__c=NS_StaticVariablesUtility.NAME,
                                        Status = 'NS_New',
                                        Priority = NS_StaticVariablesUtility.NS_Medium,
                                        Origin = 'Manual',
                                        ContactId = con.Id,
                                        AccountId = acc.Id);                   

                    insert cse;     
                    system.assertEquals(NS_StaticVariablesUtility.NS_NEW ,cse.Status);                
                    System.assertNotEquals(null, cse.Id); 
                    csId.add(cse.Id);                                    
                               
                    Database.update(cse,false);
                          
                    NS_CaseReleaseController.getAssignedCases(1,1);
                    NS_CaseReleaseController.releaseCase(csId);
                    NS_CaseReleaseController.setRetainOwnership(csId); 
                    system.assertEquals(cse.NS_AssignedTo__c ,null);    
        		System.test.StopTest(); 
            }
    	}
}