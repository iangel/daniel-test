public with sharing class VFC_Test_Execution_InlineEdit {
    
    Public String eId {get;set;}   
    public Task tsk{get;set;} 
    Public List<Test_Execution_Steps__c> testExstps {get;set;}
    Public List<Test_Execution__c> testExs {get;set;}
    private ApexPages.StandardController stdController;
 
    
    public VFC_Test_Execution_InlineEdit(ApexPages.StandardController controller) {
        this.stdController= Controller;
        eId = apexpages.currentPage().getParameters().get('Id');        
        testExstps = new List<Test_Execution_Steps__c>();
        testExs = new List<Test_Execution__c>();
        testExstps = [Select id,Name,Actual_Result__c,Status__c,Step_Order__c,Expected_Result__c,Input_Data__c,User_Login_Details__c,Test_Execution_Name__c,Test_Execution_Name__r.Comments__c,Test_Execution_Name__r.Status__c from Test_Execution_Steps__c 
                       where Test_Execution_Name__c  =:eId ORDER BY Step_Order__c ASC ];        
        tsk = new task();
        //tsk.OwnerId = UserInfo.getuserid();
        testExs = [Select id,name,Status__c,Test_Executor__c,Execution_Cycle_Name__c,Comments__c from Test_Execution__c
                 ];
        
    }
    

    public PageReference saveAndCongrat() {
       upsert testExstps;
       if(stdController.save()!=null){ // This takes care of the details for you.
       PageReference pageRef = new PageReference('/'+eid);
       pageRef.setRedirect(true);
       return pageRef; 
      }
      return null; 
      }

      public PageReference saveSteps(){         
        upsert testExstps;
        PageReference pageRef = new PageReference('/'+eid);
        pageRef.setRedirect(true);
        return pageRef;                  
    }
    
        public PageReference cancelB(){
      
       return new PageReference('/' + eId);

           
    }
    }