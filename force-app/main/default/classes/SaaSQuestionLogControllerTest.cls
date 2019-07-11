@isTest
public class SaaSQuestionLogControllerTest{
    public static testMethod void RequestToQuestionConversionTest() {
           
        PageReference pageRef = Page.VFP_SaaSQuestionLogPage;
        Test.setCurrentPage(pageRef);     
                      
        Question_Log__c ques = new Question_log__c ( Question__c = 'Test Question'
                                                        ,Sub_Capability__c='Access'
                                                        ,Industry__c ='Products'
                                                        ,Scope__c = 'Scope Phase'
                                                        ,Domain__c = 'Account Management'
                                                        ,RecordTypeId = Schema.SObjectType.Question_Log__c.getRecordTypeInfosByName().get('PMO Question').getRecordTypeid() 
                                                        );
        /*if(ques != null)
        insert ques;
        
        Response__c res = new Response__c(Question_Log__c = ques.id);
        
        if(res!= null)
        insert res;
        
        Release__c release = new Release__c(Name = 'XXXXX Release');

        insert release;
       
        request__c req = new Request__c(Request_Title__c = 'Request Title'
                                       ,Status__c = 'Identify: New Requirement'
                                       ,Request_Type__c = 'Configuration'
                                       ,Request_Description__c ='Description'
                                       ,Planned_Release__c = release.id );
            
        ApexPages.currentPage().getParameters().put('id',ques.id);*/
      
        ApexPages.standardController controller = new ApexPages.standardController(ques);
        
        SaaSQuestionLogController pag = new SaaSQuestionLogController(controller);

        pag.QuesLog=ques;
        pag.save();
        pag.cancel();
        
    }

}