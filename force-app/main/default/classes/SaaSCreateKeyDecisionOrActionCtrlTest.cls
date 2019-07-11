@isTest
/** 
 *  Author : Accenture 
 *  Description : Test Class for Controller class for SaaSCreateKeyDecisionOrActionCtrl
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  09\06\2015        created 
 *
 */
  public class SaaSCreateKeyDecisionOrActionCtrlTest
{
    static testMethod void validateCreatekeyActionDecision() 
    {
        Key_Action_Decision__c key = new Key_Action_Decision__c();
        key.Name = 'Test Clone';
        key.Priority__c = 'High';
        key.Due_Date__c = System.today() + 10;
        //key.RecordType.Name= 'Action Item';
        key.Status__c = 'Completed';
        key.Description__c = 'Test description ';
        key.Decision_Outcome__c= 'Test Comments';
        insert key;    
        Release__c rel = new Release__c();
        List<Release__c> relLst = new List<Release__c>();
        relLst.add(rel);
        
        SaaSCreateKeyDecisionOrActionCtrl controller = new SaaSCreateKeyDecisionOrActionCtrl(new ApexPages.StandardController(key));
        controller.actionOrDecisionType = 'Action_Item';
        controller.disbaleRecordType();
        controller.getRecordType();
       
       // controller.validateKeyDecision();
        controller.saveKeyDecision();
        controller.keyDecisionObj.name =  null;
        controller.saveKeyDecision();
        controller.keyDecisionObj.name =  'Test name';
        controller.keyDecisionObj.Status__c = null;
        controller.saveKeyDecision();
        controller.keyDecisionObj.Status__c = 'Status';        
        controller.keyDecisionObj.Priority__c = null;        
        controller.saveKeyDecision();
        controller.keyDecisionObj.Priority__c = 'p21';        
        controller.keyDecisionObj.Description__c = '';
        controller.saveKeyDecision();
        controller.keyDecisionObj.Description__c = 'desc';
        controller.DueDate  = null;
        controller.saveKeyDecision();    
        controller.DueDate  = System.today();
        controller.saveKeyDecision();
        controller.KeyDecisionObj.Options__c = null;
        controller.saveKeyDecision();
        controller.KeyDecisionObj.Options__c = 'options'; 
        controller.saveKeyDecision();   
        controller.createActionOrDecision();
    }    
    
     static testMethod void validateCreatekeyActionDecision1() 
     {
         Key_Action_Decision__c key = new Key_Action_Decision__c();
         SaaSCreateKeyDecisionOrActionCtrl controller = new SaaSCreateKeyDecisionOrActionCtrl(new ApexPages.StandardController(key));
         controller.saveKeyDecision();
         controller.createActionOrDecision();     
     } 
     
       
     static testMethod void validatekeyActionDecisionClone() 
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
         Key_Action_Decision__c key = SaaSTestUtility.createKeyAction(); 
         PageReference pageRef = page.SaaSCreateKeyDecisionOrAction;
         pageRef.getParameters().put(SaaSTextConstant.IS_CLONE_URL_PARAM, '1');
         pageRef.getParameters().put(SaaSTextConstant.RELEASEID_URL_PARAM,rel.id);
         Test.setCurrentPage(pageRef);
         SaaSCreateKeyDecisionOrActionCtrl controller = new SaaSCreateKeyDecisionOrActionCtrl(new ApexPages.StandardController(key));
         controller.saveKeyDecision();
    }    


}