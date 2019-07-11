@isTest(SeeAllData=false)
private class TestResultTriggerHelperTest {
    public static testMethod void FailedTestResult(){
        System.test.StartTest();
        Release__c rel = new Release__c();
        rel.Name='R1';
        Insert rel;
        
        Test_Case__c tc = new Test_Case__c();
        tc.Name ='Test';
        tc.Test_Scenario__c = 'Test';
        tc.Test_Phase__c = 'SIT';
        tc.User__c='OSS Rep';
        tc.Test_Script_Description__c = 'Test';
        tc.Execution_Steps__c = 'test';
        tc.Expected_Result__c = 'Test';
        tc.Total_Results_Expected__c ='Test';
        //tc.Status__c = 'Draft';
        tc.Release__c = rel.Id;
        Insert tc;
        
        Test_Result__c tr= new Test_Result__c();
        tr.User__c='OSS Rep';
        tr.Tester__c = system.UserInfo.getUserId();
        tr.Test_Case__c = tc.Id;
        tr.Testing_Phase__c ='SIT';
        tr.Test_Result__c = 'In Progress';
        insert tr;
        
        Test_Case__c tc1 = [Select Id,Execution_Status__c From Test_Case__c limit 1];
        system.assertEquals('Pending', tc1.Execution_Status__c);
        
        tr.Test_Result__c = 'Passed';
        update tr;
        
        Test_Case__c tc2 = [Select Id,Execution_Status__c From Test_Case__c limit 1];
        system.assertEquals('Passed', tc2.Execution_Status__c);
        
        Test_Result__c tr2= new Test_Result__c();
        tr2.User__c='OSS Rep';
        tr2.Tester__c = system.UserInfo.getUserId();
        tr2.Test_Case__c = tc.Id;
        tr2.Testing_Phase__c ='SIT';
        tr2.Test_Result__c = 'Failed';
        insert tr2;
        
        Test_Case__c tc3 = [Select Id,Execution_Status__c From Test_Case__c limit 1];
        system.assertEquals('Failed', tc3.Execution_Status__c);
        System.test.StopTest();
    }
}