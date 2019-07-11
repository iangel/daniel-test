public with sharing class VFC_EmployeeCycle_Releasee {
    Public List<TestExecutionSteps> wrpexctnsptsLst {get;set;}
    Public List<Test_Execution_Steps__c> tstExcstpLst{get;set;}
    Public List<Test_Execution__c> testEctn {get;set;}
    Public String ExtsId{get;set;}
    private ApexPages.StandardController stdController;
    Public Id usrId{get;set;}
    
    public VFC_EmployeeCycle_Releasee (ApexPages.StandardController controller) {
        this.stdController= Controller;    
        testEctn = new List<Test_Execution__c>();
        tstExcstpLst = new List<Test_Execution_Steps__c>();
        usrId = userInfo.getUserId();
       
        System.debug('Current Logged in User Id Informaion');
       
                
        
        wrpexctnsptsLst = new List<TestExecutionSteps>();
        for(Test_Execution__c te: [select Id, Name,Execution_Date__c,Test_Executor__c,Execution_Type__c,Execution_Cycle_Name__r.OwnerId,CreatedBy.Id,Execution_Cycle_Name__c,Execution_Cycle_Name__r.Name,
                                    Execution_Cycle_Name__r.Release_Name__r.Name,Result__c,Status__c,Test_Script_Description__c,Description_of_Script__c,Test_Executor__r.name,Request_Description__c,
                                    (select Id, Name,Status__c,Actual_Result__c,Step_Order__c,Test_Execution_Name__r.Name,Test_Execution_Name__r.Execution_Cycle_Name__r.Release_Name__r.Name
                                      ,Test_Execution_Name__r.Execution_Cycle_Name__r.Name,Test_Execution_Name__r.Execution_Date__c,Input_Data__c,User_Login_Details__c,Expected_Result__c,Test_Execution_Name__r.Execution_Type__c
                                      from Test_Execution_Steps__r ORDER BY Step_Order__c ASC  )
                                    FROM Test_Execution__c 
                                    WHERE Execution_Cycle_Name__c =: apexpages.currentPage().getParameters().get('id')
                                    ]){
                                    
               if(te.Test_Executor__c == usrId){
                    testEctn.add(te);
               
                    for(Test_Execution_Steps__c testps: te.Test_Execution_Steps__r){
                      
                      
                        wrpexctnsptsLst.add(new TestExecutionSteps(testps,false));                 
                    } 
        
                //wrpexctnsptsLst.add(new TestExecutionSteps(te,tstExcstpLst,false));        
               }
           
            }
         
       tstExcstpLst = [Select id,Name,Actual_Result__c,Status__c,Step_Order__c, Expected_Result__c,Input_Data__c,User_Login_Details__c,Test_Execution_Name__c,
                       Test_Execution_Name__r.Comments__c,Test_Execution_Name__r.Status__c from Test_Execution_Steps__c 
                       where Test_Execution_Name__c IN: testEctn];
                       
                       System.debug('Execution steps list is>>>>>>>>>'+tstExcstpLst+'Size is******'+tstExcstpLst.size());
      
    }
    
    Public Void submitStpStaus(){
    
      if(stdController.save()!=null){ // This takes care of the details for you.
       PageReference pageRef = new PageReference('/');
       pageRef.setRedirect(false);      
      }
     
      
      
                   
     List<Test_Execution_Steps__c > stpLst = new List<Test_Execution_Steps__c >();
        for(TestExecutionSteps ts: wrpexctnsptsLst){
           {
                System.debug('Selected Test Execution Id is>>>>>'+ts.tes);
                stpLst.add(ts.tes);          
            }
        }
        
        if(stpLst.size()>0){
        try{
            Update stpLst;
            }Catch(Exception Ex){}
            }
        //System.debug('Execution step Id as follows>>>>>'+ExtsId);
        
    }
    
    Public class TestExecutionSteps{
        Public Boolean checkSelectd{get;set;}
        Public Test_Execution_Steps__c tes{get;set;}
        
        
        Public TestExecutionSteps(Test_Execution_Steps__c tstps, Boolean chs){        
            tes = tstps;
            checkSelectd = chs;
        }
        
    }
    public PageReference cancelB(){
    return null;

}
}