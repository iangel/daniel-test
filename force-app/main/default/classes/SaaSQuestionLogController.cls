public with sharing class SaaSQuestionLogController {
    
    public Question_Log__c QuesLog { get; set; }
    
    public Request__c req;
    
    public SaaSQuestionLogController(ApexPages.StandardController stdcontroller) {
        
        string theId = ApexPages.currentPage().getParameters().get('id');

       QuesLog =new Question_Log__c (); 
       
       QuesLog.Request__c= theId;


    }
    
     public PageReference save() { 
         Id SaaSDeliveryQuestionLogRecTypeId = Schema.SObjectType.Question_Log__c.getRecordTypeInfosByName().get('PMO Question').getRecordTypeid();
         this.QuesLog.RecordTypeId = SaaSDeliveryQuestionLogRecTypeId; 
         
         insert QuesLog;
         
         PageReference requestpage = new ApexPages.StandardController(QuesLog).view();
         requestpage.setRedirect(true);
         return requestpage;
         
     }  
     
     public PageReference cancel() {
        
        PageReference requestpage = new ApexPages.StandardController(QuesLog).view();
        requestpage.setRedirect(true);
        return requestpage;
         
     }   
    
    

}