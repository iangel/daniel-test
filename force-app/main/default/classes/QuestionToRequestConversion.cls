public with sharing class QuestionToRequestConversion {

   Public Question_Log__c QuestionLog {get; set;}
   
    //Public List<Response__c> Responses {get; set;}
    
    public Request__c reqst { get; set; }

     public Related_Request__c RelatedRequest;
    
    public string QUESTIONANDANSWER {get; set;}
    
    public QuestionToRequestConversion(ApexPages.StandardController standardController) {
        
        String theId = ApexPages.currentPage().getParameters().get('id');
        reqst = new Request__c();
        QuestionLog = [Select Id, Name,Question__C,Answer__c from Question_Log__c where Id =:theId];
        
        QUESTIONANDANSWER = 'Question :' +  QuestionLog.Question__C+'\n\n' + 'Answer:' +  QuestionLog.Answer__C;
        
        reqst.Request_Description__c = QUESTIONANDANSWER;
        
        //Responses = [Select Id, Name, Response__c,Average_Rating__C,Question_Log__r.Question__C from Response__c  where Question_Log__r.Id =:theId ORDER BY Average_Rating__C DESC NULLS LAST ];    

        /*QUESTIONANDANSWER = 'Question :' +  Responses[0].Question_Log__r.Question__C+'\n\n'+ 'Response :' +  Responses[0].Response__c;
        
        reqst.Request_Description__c = QUESTIONANDANSWER;*/
        
        RelatedRequest = new Related_Request__c();
        
        RelatedRequest.Question_Log__c=  QuestionLog.id;
        RelatedRequest.Request__c =  QuestionLog.id;
        RelatedRequest.Converted_Request__c = true;
    }


     public PageReference save() {
         
         if(reqst.Status__c == 'Identify: Deferred' || reqst.Status__c == 'Close: Rejected' || reqst.Status__c == 'Close: Duplicate' )
         {
             if(reqst.Closed_Deferred__c == '')
             {
             reqst.Closed_Deferred__c.addError( 'You must pick a value for the Closed/Deferred Reason.');
             return null;
             }
             
         }
        
         
        try
        {
        
         insert reqst;
        } catch(DMLException e){
            
            
           ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getdmlMessage(0));
            ApexPages.addMessage(myMsg);
            return null;
        }
         QuestionLog.Request__c = reqst.Id;
         update QuestionLog;
         
         RelatedRequest.Request__c = reqst.Id;
         insert RelatedRequest;
         
         PageReference requestpage = new ApexPages.StandardController(reqst).view();
        
        requestpage.setRedirect(true);
        return requestpage;

     }
    
      public PageReference Cancel() {
         PageReference requestpage = new ApexPages.StandardController(QuestionLog).view();
        
        requestpage.setRedirect(true);
        return requestpage;
    }
}