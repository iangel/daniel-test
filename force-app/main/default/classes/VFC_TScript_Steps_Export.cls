public with sharing class VFC_TScript_Steps_Export {

    
    
    Public String teId{get;set;}
    
    
    public VFC_TScript_Steps_Export(ApexPages.StandardController controller) {
            
            
            //  returnToPage();
    } 
    
    public VFC_TScript_Steps_Export(ApexPages.StandardSetController controller) {
        scrptLst = new List<Execution_Steps__c>();
        
        teId =  ApexPages.currentPage().getParameters().get('id');
        
         for(Execution_Steps__c est: [Select Id,name,Expected_Result__c,Step_Order__c,Input_Data__c,Step_Name__c,Test_Script_Name__c,Test_Script_Name__r.Id,User_Login_Details__c 
                                        FROM Execution_Steps__c  WHERE Test_Script_Name__c =: ApexPages.currentPage().getParameters().get('id')]){
                    scrptLst.add(est);
                
            }
            
         // returnToPage();
    }

    
    Public List<Execution_Steps__c> scrptLst {get;set;}
    
    
    
    Public VFC_TScript_Steps_Export(){
        scrptLst = new List<Execution_Steps__c>();
            
            for(Execution_Steps__c est: [Select Id,name,Expected_Result__c,Step_Order__c,Input_Data__c,Step_Name__c,Test_Script_Name__c,Test_Script_Name__r.Id,User_Login_Details__c 
                                        FROM Execution_Steps__c  WHERE Test_Script_Name__c =: ApexPages.currentPage().getParameters().get('id')]){
                    scrptLst.add(est);
                
            }
    
    }
     /* Public PageReference returnToPage(){
        PageReference pf = new PageReference('/'+teId);
        
        return pf;
    
    }   */

    
   }