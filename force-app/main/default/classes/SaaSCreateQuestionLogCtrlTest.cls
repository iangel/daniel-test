@isTest
/** 
 *  Author : Accenture 
 *  Description : Test Class for Controller class for SaaSCreateQuestionLogCtrl
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  08\06\2015        created 
 *
 */
 public class SaaSCreateQuestionLogCtrlTest
{
    static testMethod void validateQuestionLog()
    {
        Release__c rel = SaaSTestUtility.createRelease();
        Request__c req = SaaSTestUtility.createRequest();
        Question_Log__c questionLogObj  = new Question_Log__c();
        questionLogObj.Request__c = req.id;
        questionLogObj.Submitter__c = Userinfo.getUserId();
        questionLogObj.Question__c = 'Test description ';
        questionLogObj.Sub_Capability__c='Access';
        questionLogObj.Industry__c='Financial Services';
        questionLogObj.Scope__c='Plan and Analyze';
      //questionLogObj.Submitter__c='ana lam';
       // questionLogObj.Request__c='Create Lead conversion Process';
        insert questionLogObj;
            
        
     
        
        SaaSCreateQuestionLogCtrl controller = new SaaSCreateQuestionLogCtrl(new ApexPages.StandardController(questionLogObj ));
        controller.questionType=SaaSTextConstant.VALUE_DELIVERY_QUESTION_RECORD_TYPE;
        controller.saveQuestionLog();
        controller.quesLogObj.Scope__c = null;
        controller.saveQuestionLog();
        controller.quesLogObj.Scope__c = 'test';
        controller.saveQuestionLog();
        controller.quesLogObj.Sub_Capability__c = null;
        controller.saveQuestionLog();
        controller.quesLogObj.Sub_Capability__c = 'sub';
        controller.saveQuestionLog();
        controller.quesLogObj.Industry__c = null;
        controller.saveQuestionLog();
        controller.quesLogObj.Industry__c = 'test';
        controller.saveQuestionLog();
        controller.QuesLogObj.Question__c = null;
        controller.saveQuestionLog();
        controller.QuesLogObj.Question__c = 'ques';
        controller.saveQuestionLog();
        controller.questionType=SaaSTextConstant.SAAS_QUESTION_RECORD_TYPE;
        controller.QuesLogObj.Request__c = null;        
        controller.saveQuestionLog();
        controller.QuesLogObj.Submitter__c = null;
        controller.saveQuestionLog();
        
        controller.questionType= SaaSTextConstant.VALUE_DELIVERY_QUESTION_RECORD_TYPE ;
         controller.QuesLogObj.Domain__c = 'Domain';       
        controller.saveQuestionLog();
     
        //controller.validateQuestion();
       
       // controller.validateQuestion();
        controller.getRecordType();
       // controller.showans();
        //controller.saveAnswer();
        controller.convertToRequest();
        controller.disbaleRecordType();
        controller.deleteRecord(); 
        controller.getRelatedReqLst();
       
     }
     
        
    static testMethod void validateQuestionLogclone()
    {
        Release__c rel = SaaSTestUtility.createRelease().clone();
        Request__c req = SaaSTestUtility.createRequest();        
        Question_Log__c questionLogObj  = SaaSTestUtility.createSaaSQuestion();
        PageReference pageRef = Page.SaaSCreateQuestionLog;
        pageRef.getParameters().put(SaaSTextConstant.IS_CLONE_URL_PARAM, '1');
        pageRef.getParameters().put(SaaSTextConstant.REQUEST_ID_URL_PARAM,req.id);
        Test.setCurrentPage(pageRef);      
        SaaSCreateQuestionLogCtrl controller = new SaaSCreateQuestionLogCtrl(new ApexPages.StandardController(questionLogObj ));
        controller.saveQuestionLog();
        controller.getRecordType();
                
        controller.validateQuestion();
        controller.convertToRequest();
        controller.disbaleRecordType();
        controller.createQuestion();
       // controller.saveAnswer();    
       
        controller = new SaaSCreateQuestionLogCtrl(new ApexPages.StandardController(new Question_Log__c()));
       
       
         
      }
        
          
         
    }