public class VFC_ExecutionSteps_Upload {

    public Blob csvFileBody{get;set;}
    public string csvAsString{get;set;}
    public String[] csvFileLines{get;set;}
    public List<Execution_Steps__c> acclist{get;set;}
    Public List<Execution_Steps__c> upEstpsLst {get;set;}
    Public Boolean msgBlock{get;set;}
    Public Boolean Showform{get;set;}
    
    List<Execution_Steps__c> estpsLst{get;set;}
    
    Public String tsId{get;set;}
  
  public VFC_ExecutionSteps_Upload(ApexPages.StandardController controller) {
        csvFileLines = new String[]{};
        acclist = New List<Execution_Steps__c>(); 
        tsId = apexPages.CurrentPage().getParameters().get('Id');
        estpsLst = new List<Execution_Steps__c>();
        
        upEstpsLst = new List<Execution_Steps__c>();
        msgBlock = false;
        Showform = true;
        
    }
  public PageReference  importCSVFile(){
       //try{
           if(csvFileBody != Null){
           csvAsString = csvFileBody.toString();
           }else{
               apexPages.addMessage(new Apexpages.Message(ApexPages.Severity.WARNING,'Please select the Valid file'));
           }
           
           if(csvAsString != Null){
           
           csvFileLines = csvAsString.split('\r\n');
           
           }else{
               apexPages.addMessage(new Apexpages.Message(ApexPages.Severity.WARNING,'Please select the Valid file'));
           
           }
           
           
           System.debug('csvFileLines as follows********'+csvFileLines+'csvFileLines file Size is********'+csvFileLines.size());
           try{ 
           for(Integer i=1;i<csvFileLines.size() ;i++){
               
               Execution_Steps__c accObj = new Execution_Steps__c();
               string[] csvRecordData = csvFileLines[i].split(',(?=([^\"]*\"[^\"]*\")*[^\"]*$)');                             
             // string[] csvRecordData = csvFileLines[i].split('\\,');                     
               System.debug('csvRecordData is as follows&&&&&&&&&&&&&&&&'+csvRecordData+'Size is'+csvRecordData.size());
               accObj.Step_Order__c = Decimal.Valueof(csvRecordData[0].replace('"',''));
               accObj.Step_Name__c= csvRecordData[1].replace('"',''); 
               accObj.Input_Data__c = csvRecordData[2].replace('"','');
               accObj.Expected_Result__c = csvRecordData[3].replace('"','');             
               accObj.User_Login_Details__c = csvRecordData[4].replace('"','');             
               //accObj.Test_Script_Name__r.Id = tsId;             
               acclist.add(accObj);
               System.debug('acclist as follows>>>>>'+acclist+'AccLst size is*********'+acclist.size());   
               } 
               }catch(ListException le) {
                System.debug('The following exception has occurred: ' + le.getMessage());
                le.setMessage('The "Test Script Steps" having all the fields value are imported, Please ensure that fields are not blank for remaining steps or enter the steps details manually');
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, le.getMessage()));                                
                } 
               
   
               if(!acclist.isempty())
               try{
               insert acclist;                             
               }
               catch(DmlException de)
               {
               System.debug('The following exception has occurred: ' + de.getMessage());             
                de.setMessage('Test script already has steps. Please delete the existing steps and try again');
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, de.getMessage()));    
               }                   
               updateScripts();
              
         
         // if (ApexPages.hasMessages()) return null;
          
            //return  new PageReference('/'+tsId);
            msgBlock = true;
            Showform = false;
               
                PageReference pf = new PageReference('/'+tsId);
               return null;
          
               
        
     }
     
     Public Void updateScripts(){
         System.debug('Inserted List is*****'+acclist);
         if(!acclist.isempty())
           estpsLst = [Select Id,Test_Script_Name__c,Step_Order__c,Test_Script_Name__r.Id,Input_Data__c,Step_Name__c,Expected_Result__c ,User_Login_Details__c  from Execution_Steps__c WHERE ID IN: acclist];
            
            System.debug('Queried List is*****'+estpsLst +'estpsLst size is &&&****'+estpsLst.size());
            System.debug('Current TestScript Id is as follwos>>>>$$$$'+tsId);
            if(estpsLst.size()>0){
            
                System.debug('estpsLst as follows>>>>>>>>>>'+estpsLst+'estpsLst Size is****'+estpsLst.size());
                for(Execution_Steps__c estp : estpsLst){
                    estp.Test_Script_Name__c = tsId;
                    upEstpsLst.add(estp);
                    System.debug('update Execution Steps List>>>>>'+upEstpsLst+'Size Is>>>'+upEstpsLst.size());
                
                }
            }
            System.debug('Updated list as follows ^^^^*****'+upEstpsLst+'Size is>>>>'+upEstpsLst.size());
            
            if(!upEstpsLst.isempty())try{
            
                Update upEstpsLst;}
                catch(ListException le){
                 System.debug('update Execution Steps List>>>>>'+le.getmessage());
                }
                
           
     
     
     }
     Public PageReference cancelRec(){
          PageReference pf = new PageReference('/'+tsId);
          return pf ;
     
     }
     }