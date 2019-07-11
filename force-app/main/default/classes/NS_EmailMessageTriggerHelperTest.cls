/**@author  Accenture
* @Created Date 2018-05-21
* @version  1.0
* @description Test class to test the coverage of apex class and its methods which prevent users fom deleting emails.
*/
@isTest(SeeAllData=false)
private class NS_EmailMessageTriggerHelperTest{
    /* System Administrator user should be able to delete an Email Message*/
    static testMethod void deleteEmailMessageWithAdminUserTest(){
        Profile adminProf = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User adminUser = UserTestFactory.createUser(14,adminProf.Id);
        System.runAs(adminUser){
            Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
            Case tmpCase=CaseTestFactory.createCaseRecord('Cash Hold','Accounting/Waybilling',acc.Id);
            Database.insert(tmpCase);
            EmailMessage tmpEmailMessage=new EmailMessage();
            tmpEmailMessage.ParentID=tmpCase.id;
            tmpEmailMessage.TextBody='Test';
            Database.insert(tmpEmailMessage);
            Database.DeleteResult result=Database.delete(tmpEmailMessage,false);
            System.assert(result.isSuccess());
            System.assert(result.getErrors().size()==0);
            
        }
    }
    
    /*A non administrator user should not be able to delete an Email Message*/
    /*static testMethod void deleteEmailMessageWithUserTest(){
        Profile stdProf=[SELECT Id FROM Profile WHERE Name='Standard User' limit 1];
        User stdUser = UserTestFactory.createNonOSSUser(113,stdProf.Id) ;
        System.runAs(stdUser){
            Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
            Case tmpCase=CaseTestFactory.createCaseRecord('Cash Hold','Accounting/Waybilling',acc.Id);
            Database.insert(tmpCase);
            EmailMessage tmpEmailMessage=new EmailMessage();
            tmpEmailMessage.ParentID=tmpCase.id;
            tmpEmailMessage.TextBody='Test';
            Database.insert(tmpEmailMessage);
            Database.DeleteResult result=Database.delete(tmpEmailMessage,false);
            System.assert(result.isSuccess());
            System.assert(result.getErrors().size()==0);
            
        }
    }*/
    
    static testMethod void testExcptn(){
        NS_EmailMessageTriggerHelper.preventDeletionEmailMessage(null);
    }
    
}