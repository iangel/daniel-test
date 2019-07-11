/**@author  Accenture
* @Created Date 2018-Apr-15
* @version  1.0
* @description This is a test class of CaseTriggerHelper class 
*/ 
@isTest(SeeAllData=false)
public class NS_CaseTriggerHelperTest {
    /*
* Method tests case creation for non monitored account and logged in user primary queue is not available
*/
    public static testmethod void positiveCaseInsertUpdate()
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
        //Create a Case
        System.runAs(atest){
            cs1 = CaseTestFactory.createCaseRecord('Local Service Inquiry','Local Service',acc.Id);
            insert cs1;  
        }   
        
        NS_StaticVariablesUtility.isTriggerExecuted=false;
        cs1.NS_RailcarNumbers__c = NS_StaticVariablesUtility.Name;
        cs1.NS_DateOfShutdown__c = datetime.now();
        update cs1;
        
        
        //Create Case with random non OSS user without primary queue
        /*atest.NS_Primary_Queue__c='';
        atest.Associated_Business_Unit__c='Marketing';
        NS_StaticVariablesUtility.isTriggerExecuted=false;
        update atest;
        Account acc1 = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
        AccountTestFactory.accountShare(acc1.Id,atest.Id,NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.rowCause);
        System.runAs(atest){
            Case cs2 = CaseTestFactory.createCaseRecord('Cash Hold','Accounting/Waybilling',acc1.Id);
            insert cs2;
        }*/
        System.test.StopTest();
    }
    
    
    public static testmethod void CaseUpdatewithOpenTask()
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
        //Create a Case
        System.runAs(atest){
            cs1 = CaseTestFactory.createCaseRecord('RIT','Business Functions',acc.Id);
            insert cs1;
        }   
        Task tsk = new Task();
        tsk.WhatId = cs1.Id;
        tsk.Status='Not Started';
        tsk.Subject=NS_StaticVariablesUtility.Name;
        tsk.RecordTypeId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('NS Task').getRecordTypeId();
        insert tsk;
        
        cs1.Status=NS_StaticVariablesUtility.NS_CLOSED;
        cs1.NS_ExternalCaseNotes__c=NS_StaticVariablesUtility.Name;
        cs1.NS_RailcarNumbers__c = NS_StaticVariablesUtility.Name;
        NS_StaticVariablesUtility.isTriggerExecuted=false;
        try{
            update cs1;
        }
        catch(Exception ex){
            
        }
        
        //Create Case with random non OSS user without primary queue
        /*atest.NS_Primary_Queue__c='';
        atest.Associated_Business_Unit__c='Marketing';
        NS_StaticVariablesUtility.isTriggerExecuted=false;
        update atest;
        Account acc1 = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
        AccountTestFactory.accountShare(acc1.Id,atest.Id,NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.rowCause);
        System.runAs(atest){
            Case cs2 = CaseTestFactory.createCaseRecord('Cash Hold','Accounting/Waybilling',acc1.Id);
            insert cs2;
        }*/
        System.test.StopTest();
    }
    
    
    public static testmethod void CaseMethod()
    {
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        List<Case> caseList = new List<Case>();
        Set<Case> caseSet = new Set<Case>(); 
        Case cs1 = new Case();
        User atest;
        
        
        System.runAs( admin ){ 
            
            NS_TriggerSettings__c cs = new NS_TriggerSettings__c(Name= NS_StaticVariablesUtility.caseTrigger); 
            cs.NS_IsActive__c = true;
            insert cs;
            Profile agent = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
            atest = UserTestFactory.createUser(21,agent.Id);
            UserTestFactory.assignUserQueue(atest);
            
            
            system.test.StartTest();
            Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
            AccountTestFactory.accountShare(acc.Id,atest.Id,NS_StaticVariablesUtility.readAccess,
                                            NS_StaticVariablesUtility.readAccess,
                                            NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.rowCause);
            //Create a Case
            
            cs1 = CaseTestFactory.createCaseRecord('Local Service Inquiry','Local Service',acc.Id);
            insert cs1;
            cs1.NS_Type__c='Missed Switch';
            update cs1;
            Cs1.Description='Test';
            update CS1;
            caseList.add(cs1);
            caseSet.add(cs1);
            NS_CaseTriggerUtility.getCaseSettings(caseList);
            NS_CaseTriggerUtility.refreshTask(caseSet);
            NS_CaseTriggerUtility.getMktgNotifications(caseList);
            cs1.Status='NS_Escalate';
            Update CS1;
            caseList.add(cs1);
            NS_CaseTriggerHelper.createTask(caseList);
            NS_CaseTriggerHelper.checkTask();
            
            Task tsk = new Task();
            tsk.WhatId=cs1.Id;
            tsk.TaskSubtype='Task';
            insert tsk;
            caseList.clear();
            caseList.add(cs1);
            NS_CaseTriggerHelper.createTask(caseList);
            NS_CaseTriggerHelper.checkTask();
            System.test.StopTest();
        }
    }
    
    public static testmethod void createTaskforCase(){
        
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        System.runAs( admin ){ 
            NS_TriggerSettings__c cs = new NS_TriggerSettings__c(Name= NS_StaticVariablesUtility.caseTrigger); 
            cs.NS_IsActive__c = true;
            insert cs;
        }
        Profile agent = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
        User atest = UserTestFactory.createUser(21,agent.Id);
        system.test.StartTest();
        System.runAs( admin ){ 
            List<Group> publicGrp =  [SELECT DeveloperName,Id FROM Group WHERE DeveloperName ='NS_ShutdownEmailAlertRecipient'LIMIT 1];
            if(publicGrp.isEmpty()){
                Group grp = new Group(Name = 'NS_ShutdownEmailAlertRecipient',DeveloperName='NS_ShutdownEmailAlertRecipient');
                insert grp;
                publicGrp.add(grp);
            }
            GroupMember grpMem = new GroupMember();
            grpMem.GroupId = publicGrp[0].Id;
            grpMem.UserOrGroupId = atest.Id;
            Database.insert(grpMem);
        }    
        System.test.StopTest();
        Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
        AccountTestFactory.accountShare(acc.Id,atest.Id,NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.rowCause);
        
        System.runAs(atest){
            Case cs1 = CaseTestFactory.createCaseRecord('Shutdown','Local Service',acc.Id);
            insert cs1;
        }
        //System.test.StopTest();
    }    
    public static testmethod void updateCaseInfoTest(){
        //   Profile agent = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
        //  User atest = UserTestFactory.createUser(22,agent.Id);
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        User repUser;
        System.runAs( admin ){ 
            Profile OSSRep = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
            repUser = UserTestFactory.createUser(21,OSSRep.Id);
            UserTestFactory.assignUserQueue(repUser);
        }
        Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
        AccountTestFactory.accountShare(acc.Id,repUser.Id,NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.rowCause);
        
         Account acc1= AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name+'DD');
        AccountTestFactory.accountShare(acc1.Id,repUser.Id,NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.rowCause);
        
        List<Case> lc = new List<Case>();
        
        System.runAs(repUser){
            Case cs1 = CaseTestFactory.createCaseRecord('Shutdown','Local Service',acc.Id);
            insert cs1;
            lc.add(cs1);
            
            Case cs2 = CaseTestFactory.createCaseRecord('Shutdown','Local Service',acc1.Id);
            insert cs2;
            cs2.NS_InteractionReason__c='Local Service Inquiry';
            cs2.Type='Local Service Inquiry';
            lc.add(cs2);
            
        }    
        NS_CaseTriggerHelper.updateCaseInfo(lc);
    }
    
    public static testmethod void testUtility(){
        list<Case> listCase = new list<Case> ();
         Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        System.runAs( admin ){
            
            Group newGroup = new Group();
			newGroup.name = 'groupName';
            newGroup.Type='Queue';
            insert newGroup;
            
                       
            GroupMember member = new GroupMember();
			member.UserOrGroupId = admin.Id;
			member.GroupId = newGroup.Id;
			insert member;
            
            Account accnt = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
            Case case1 = CaseTestFactory.createCaseRecord('Shutdown','Local Service',accnt.Id);
            case1.OwnerId=newGroup.id;
            insert case1;
            listCase.add(case1);
            NS_CaseTriggerHelper.createTask(listCase);
            listCase.clear();
            case1.Status ='NS_Escalated';
            update case1;
            listCase.add(case1);
            NS_CaseTriggerHelper.createTask(listCase);
            
        }
 
        
    }
public static testmethod void ValidateOEMAccountTest()
{
    Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        User repUser;
        System.runAs( admin ){ 
            Profile OSSRep = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
            repUser = UserTestFactory.createUser(21,OSSRep.Id);
            UserTestFactory.assignUserQueue(repUser);
        }
        Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
    	Account acc1 = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
        AccountTestFactory.accountShare(acc.Id,repUser.Id,NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.rowCause);
    	AccountTestFactory.accountShare(acc1.Id,repUser.Id,NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.rowCause);
    	NS_AccountRelation__c aR = new NS_AccountRelation__c();
    	aR.NS_RelationParty1__c = acc.Id;
    	aR.NS_RelationParty2__c = acc1.Id;
    	aR.NS_RelationType__c = 'Autoramp';
    	insert aR;
        
        List<Case> lc = new List<Case>();
        //Case cs1 = CaseTestFactory.createCaseRecord('Shutdown','Local Service',acc.Id);
        //insert cs1;
        System.runAs(admin){
            Case cs1 = CaseTestFactory.createCaseRecord('Shutdown','Local Service',acc.Id);
            cs1.NS_OEM_Account__c = acc1.Id;
            insert cs1;
}
}
}