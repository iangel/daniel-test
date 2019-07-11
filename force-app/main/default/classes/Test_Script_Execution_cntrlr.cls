global class Test_Script_Execution_cntrlr
{
    
    Public String pId{get;set;}
    Public string rId {get;set;}
    public Test_Script_Execution_cntrlr(ApexPages.StandardController controller) {
        pId = apexpages.currentpage().getparameters().get('Id');
        rId = [Select Id,name,Release_Name__c from Test_Execution_Cycle__c WHERE Id=:pId].Release_Name__c;
    }
    
    Public  PageReference insertingTextExecution(){ 
        List<Test_Script__c> tsLst_repstry = new List<Test_Script__c>();
        List<Test_Execution__c> teLst_Lab = new List<Test_Execution__c>();
        List<Test_Execution_Steps__c> testpLst = new List<Test_Execution_Steps__c>();
        List<Execution_Steps__C> exstps = new List<Execution_Steps__c>();
        List<Related_Request_Script__c> rltdScrpts = new List<Related_Request_Script__c>();
        List<Related_Request_Script_Execution__c> rrseLst = new List<Related_Request_Script_Execution__c>();

        for(Test_Scenario__c ts: [select Id,Name,Release__c,(select id,Name,Test_Scenario__c,Execution_Steps__c,Execution_Type__c,    
                                    Expected_Result__c,Request__c,Actual_Result__c,Test_Result__c FROM Test_Scripts__r)
                                                FROM Test_Scenario__c WHERE Release__c =: rId]){
                        for(Test_Script__c tscr: ts.Test_Scripts__r){        
                            tsLst_repstry.add(tscr);
                        }       
        }
        
        
        
     List<Test_Script__c> testScrptExstps = [Select Id,Name,Test_Scenario__c,Request__c,Execution_Steps__c,Execution_Type__c,    
                                            Expected_Result__c, Actual_Result__c,Test_Result__c,Execution_Date__c, 
                                            (select Id,Name,Step_Name__c,Step_Order__c,Expected_Result__c,Input_Data__c,User_Login_Details__c,Test_Script_Name__c from Execution_Steps__r)
                                            FROM Test_Script__c WHERE ID IN:tsLst_repstry];
     
     for(Related_Request_Script__c rrs: [Select Id,Name, Request__c,Test_Script__c from Related_Request_Script__c WHERE Test_Script__c IN: tsLst_repstry]){
                     rltdScrpts.add(rrs);
     }
      
    
    System.debug('Test Script list is as follows'+tsLst_repstry);
    
        for(Test_Script__c ts: testScrptExstps){
            Test_Execution__c  te = new Test_Execution__c ();
            te.Execution_Cycle_Name__c = pId;
            te.Test_Script_Description__c = ts.Id;
            te.Request_Description__c = ts.Request__c;
            te.Test_Scenario__c = ts.Test_Scenario__c;
            //te.Execution_Steps__c = ts.Execution_Steps__c;
            //te.Execution_Date__c = ts.Execution_Date__c;
           // te.Execution_Type__c = ts.Execution_Type__c;
           //te.Test_Case__c = 'a0I19000000r7wx';   
            teLst_Lab.add(te);
            
             for(Execution_Steps__c esp: ts.Execution_Steps__r){
                
                exstps.add(esp);
            }
        }
        
        if(!teLst_Lab.isempty())
            Insert teLst_Lab;
            
        for(Test_Execution__c te:teLst_Lab){
            for(Execution_Steps__c estps: exstps){
                if(te.Test_Script_Description__c == estps.Test_Script_Name__c){
                    Test_Execution_Steps__c  testp = new Test_Execution_Steps__c();
                    testp.Step_Order__c = estps.Step_Order__c;
                    testp.Name = estps.Step_Name__c;
                    testp.Test_Execution_Name__c = te.Id;
                    testp.Expected_Result__c = estps.Expected_Result__c;
                    testp.Input_Data__c = estps.Input_Data__c;
                    testp.User_Login_Details__c = estps.User_Login_Details__c;
                    testpLst.add(testp);
                                
                }
            
            }
        
        
        }   
    
    
    if(!testpLst.isempty())
        Insert testpLst; 
        
        for(Test_Execution__c te:teLst_Lab){
            for(Related_Request_Script__c rs: rltdScrpts){
                    if(te.Test_Script_Description__c == rs.Test_Script__c){
                    
                    Related_Request_Script_Execution__c rse = new Related_Request_Script_Execution__c();
                    rse.Request_Id__c  = rs.Request__c;
                    rse.Test_Script_Execution__c = te.Id;
                    rrseLst.add(rse);
                    }
            }
        } 
       
       if(!rrseLst.isempty())
           Insert rrseLst;   
            
            
       PageReference pf = new Pagereference('/'+pId);
       return pf;
    }

}