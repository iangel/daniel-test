@isTest
public class QuestionToRequestConversionTest{
    public static testMethod void QuestionToRequestConversionTest() {
           
        PageReference pageRef = Page.VFP_QuestionToRequestConvserion;
        Test.setCurrentPage(pageRef);     
                      
        Question_Log__c ques = new Question_log__c ( Question__c = 'Test Question'
                                                        ,Sub_Capability__c='Access'
                                                        ,Industry__c ='Products'
                                                        ,Scope__c = 'Scope Phase'
                                                        ,Domain__c = 'Account Management'
                                                        );
        if(ques != null)
        insert ques;
        
        Release__c release = new Release__c(Name = 'XXXXX Release');

        insert release;
       
        request__c req = new Request__c(Request_Title__c = 'Request Title'
                                       ,Status__c = 'Identify: New Requirement'
                                       ,Request_Type__c = 'Configuration'
                                       ,Request_Description__c ='Description'
                                       ,Planned_Release__c = release.id );
            
        ApexPages.currentPage().getParameters().put('id',ques.id);
      
        ApexPages.standardController controller = new ApexPages.standardController(req);
        
        QuestionToRequestConversion pag = new QuestionToRequestConversion(controller);

        pag.reqst=req;
        pag.save();
        pag.cancel();    
    }
}