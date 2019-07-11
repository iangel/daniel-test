@isTest
/** 
 *  Author : Accenture 
 *  Description : Test Class for Controller class for SaaSCreateRequestCtrl
 *  Created Date : 17\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  08\06\2015        created 
 *
 */
 public class SaaSCreateRequestCtrlTest
 {
        static testMethod void validateCreateRequest() 
        {
        Release__c rel = new Release__c();
        rel.Name = 'Test Release ';
        rel.Release__c = 24;
        rel.Plan_Start_Date__c = System.today();
        rel.Release_Planned_End_Date__c= System.today() + 10;
        rel.Status__c = 'Red';
        rel.Description__c = 'Test description ';
        rel.Status_Update__c = 'Test Comments';
        insert rel;
        
               
        Request__c req = new Request__c();
        req.Status__c= 'Identify: New Requirement';
        req.id= null;
        req.Request_Title__c = 'Test description ';
        req.Request_Type__c ='Integration ';
        req.Request_Description__c= 'Test description ';
        req.Planned_Release__c = rel.id;
        insert req;
        
        Question_Log__c questionLogObj  = new Question_Log__c();
       // questionLogObj.RecordTypeId =  '012J00000005IbZ';
        questionLogObj.Request__c = req.id;
        questionLogObj.Submitter__c = Userinfo.getUserId();
        questionLogObj.Question__c = 'Test description ';
        insert questionLogObj; 
        
        
        SaaSCreateRequestCtrl controller = new SaaSCreateRequestCtrl(new ApexPages.StandardController(req));
        controller.saveRequest();
        //controller.validateKeyDecision();
        controller.requestObj.Status__c = null;
        controller.saveRequest();
        controller.requestObj.Status__c = 'Status'; 
        controller.requestObj.Request_Description__c = null;
        controller.saveRequest();
        controller.requestObj.Request_Description__c = 'desc';
        controller.saveRequest();
        controller.requestObj.Request_Type__c = null;
        controller.saveRequest();
        controller.requestObj.Request_Type__c = 'req';
        controller.saveRequest();
        }
        
        static testMethod void validateCreateRequest1()
        {
           Request__c req = new Request__c(); 
           SaaSCreateRequestCtrl controller = new SaaSCreateRequestCtrl(new ApexPages.StandardController(req));
           controller.saveRequest();
           controller.createNewRequest();
           
     
    }
      static testMethod void validateConvertRequest() 
      {
           Release__c rel =SaaSTestUtility.createRelease();
           Request__c req = new Request__c();
           req.Status__c= 'Identify: New Requirement';
           req.Request_Title__c = 'Test description ';
           req.Request_Type__c ='Integration ';
           req.Request_Description__c= 'Test description ';
           req.Release__c = rel.id;
           insert req;
        
           Question_Log__c questionLogObj  = new Question_Log__c();
       // questionLogObj.RecordTypeId =  '012J00000005IbZ';
           questionLogObj.Request__c = req.id;
           questionLogObj.Submitter__c = Userinfo.getUserId();
           questionLogObj.Question__c = 'Test description ';
           insert questionLogObj; 
         
          PageReference pageRef = Page.SaaSCreateRequest;
          pageRef.getParameters().put(SaaSTextConstant.CONVERT_QUEST_ID,questionLogObj.id);
          pageRef.getParameters().put(SaaSTextConstant.RELEASEID_URL_PARAM,rel.id);
          pageRef.getParameters().put(SaaSTextConstant.CONVERT_QUEST, '1');          
          Test.setCurrentPage(pageRef);
          
       /*   Response__c questionLogObj  = SaaSTestUtility.createQuestionResponse();
          PageReference pageRef = Page.SaaSCreateRequest;
          pageRef.getParameters().put(SaaSTextConstant.CONVERT_QUEST_ID,questionLogObj.Question_Log__c);
          pageRef.getParameters().put(SaaSTextConstant.RELEASEID_URL_PARAM,rel.id);
          pageRef.getParameters().put(SaaSTextConstant.CONVERT_QUEST, '1');          
          Test.setCurrentPage(pageRef); */
          SaaSCreateRequestCtrl ctrlObj = new SaaSCreateRequestCtrl(new ApexPages.StandardController(req));
          ctrlObj.saveRequest();
          
          
          
          ctrlObj.createNewRequest();
      
      }        
        static testMethod void validateRequestClone()
        {    
            Release__c rel = new Release__c();
            rel.Name = 'Test Release ';
            rel.Release__c = 24;
            rel.Plan_Start_Date__c = System.today();
            rel.Release_Planned_End_Date__c= System.today() + 10;
            rel.Status__c = 'Red';
            rel.Description__c = 'Test description ';
            rel.Status_Update__c = 'Test Comments';
            insert rel;
        
               
            Request__c req = new Request__c();
            req.Status__c= 'Identify: New Requirement';
            req.Request_Title__c = 'Test description ';
            req.Request_Type__c ='Integration ';
            req.Request_Description__c= 'Test description ';
            req.Release__c = rel.id;
            insert req;
        
            Question_Log__c questionLogObj  = new Question_Log__c();
           // questionLogObj.RecordTypeId =  '012J00000005IbZ';
            questionLogObj.Request__c = req.id;
            questionLogObj.Submitter__c = Userinfo.getUserId();
            questionLogObj.Question__c = 'Test description ';
            insert questionLogObj; 
            
            
            
            PageReference pageRef = Page.SaaSClientQuestionSearch;
            pageRef.getParameters().put(SaaSTextConstant.IS_CLONE_URL_PARAM, '1');
            Test.setCurrentPage(pageRef);
            SaaSCreateRequestCtrl controller = new SaaSCreateRequestCtrl(new ApexPages.StandardController(req));
            controller.saveRequest();
            controller.validateKeyDecision();
        }
        
      
            
 }