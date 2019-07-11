@isTest
Public class Test_Script_Execution_cntrlr_Test{
    Public static testMethod Void Test_Script_Execution_cntrlr_tset(){
    
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
        
        Insert te;
        
        Test_Execution_Steps__c  testp = new Test_Execution_Steps__c();
        testp.Name = 'TestStep';
        testp.Test_Execution_Name__c  = te.Id;
        Insert testp;      
        
        Related_Request_Script__c rrs = new Related_Request_Script__c();
        //rrs.Name = 'TestrelatedScript';
        rrs.Request__c = rq.id;
        rrs.Test_Script__c  = tsp.Id;
        
        Insert rrs;
        
        Related_Request_Script_Execution__c rrse = new Related_Request_Script_Execution__c();
        rrse.Request_Id__c= rq.id;
        rrse.Test_Script_Execution__c = te.Id;
        
        Insert rrse;
         
        
        apexpages.currentpage().getparameters().put('Id',tec.Id);
        
        ApexPages.StandardController stnd = new ApexPages.StandardController(tec);
        
        Test_Script_Execution_cntrlr testc = new Test_Script_Execution_cntrlr(stnd);
        testc.insertingTextExecution();
        
        
    
    
    }

}