@isTest
Public class VFC_Test_Execution_InlineEdit_Test{
    Public static testMethod void VFC_Test_Execution_InlineEdit_Test(){
        
        String UsrId = Userinfo.getUserId();
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
        
        Test_Execution_Cycle__c tec = new Test_Execution_Cycle__c ();
        tec.Release_Name__c  = rl.Id;
        tec.Name = 'testCycleName';
        Insert tec;
        
        Test_Execution__c te = new Test_Execution__c();
        te.Execution_Cycle_Name__c = tec.Id;
        te.Comments__c = 'Create account record';
        te.Test_Executor__c = UsrId;
        
        Insert te;
        
        Test_Execution_Steps__c  testp = new Test_Execution_Steps__c();
        testp.Name = 'TestStep';
        testp.Test_Execution_Name__c  = te.Id;
        
        Insert testp;
        
        apexpages.currentPage().getParameters().put('id',te.Id);
        
        ApexPages.StandardController std = new ApexPages.StandardController(te);        
        VFC_Test_Execution_InlineEdit vte = new VFC_Test_Execution_InlineEdit(std);
        vte.saveAndCongrat();
        vte.saveSteps();
        vte.cancelB();
        
    
    
    }


}