@isTest
Public class VFC_TestScript_Steps_Export_Tes{
    Public static testMethod Void VFC_TestScript_Steps_Export_Tes(){
        Release__c rl = new Release__c();
        rl.Name = 'TestRelease';
        
        Insert rl;
        
        Request__c rq = new Request__c();
        rq.Request_Title__c  = 'TestREquest';
        rq.Status__c = 'Release: Build';
        rq.Request_Type__c = 'Configuration';
        rq.Request_Description__c = 'TestDescription';
        rq.Planned_Release__c = rl.Id;
        
        Insert rq;
        
        Test_Scenario__c ts = new Test_Scenario__c();
        ts.Release__c = rl.Id;
        ts.Request__c = rq.Id;
        Insert ts;
        
        Test_Script__c tsp = new Test_Script__c();
        tsp.Test_Scenario__c = ts.Id;
        Insert tsp;
        
        Execution_Steps__c es = new Execution_Steps__c();
        es.Step_Name__c = 'TestStep';
        es.Expected_Result__c = 'Test Expected Result';
        es.Input_Data__c = 'Test Input Data';
        es.Test_Script_Name__c = tsp.Id;
        es.User_Login_Details__c = 'Test User Login details';
        
        Insert es;
        
        List<Test_Script__c> tsLst = new List<Test_Script__c>{tsp};
        
        
        ApexPages.currentPage().getParameters().put('id',tsp.Id);
        
        ApexPages.StandardSetController sst = new ApexPages.StandardSetController(tsLst);
        VFC_TScript_Steps_Export tse2 = new VFC_TScript_Steps_Export(sst);
        
        
        ApexPages.StandardController  std = new ApexPages.StandardController(tsp);
        VFC_TScript_Steps_Export tse = new VFC_TScript_Steps_Export(std);
        
        VFC_TScript_Steps_Export tse1 = new VFC_TScript_Steps_Export();
        
        
    
    
    }

}