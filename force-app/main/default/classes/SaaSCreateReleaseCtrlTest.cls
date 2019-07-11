@isTest
/** 
 *  Author : Accenture 
 *  Description : Test Class for Controller class for SaaSCreateReleaseCtrl
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  09\06\2015        created 
 *
 */
  public class SaaSCreateReleaseCtrlTest
{
    static testMethod void validateCreateRelease() 
    {
        Release__c rel = new Release__c();
        rel.Name = 'Test Release ';
        rel.Release__c = 24;
        rel.Id = null;
        rel.Plan_Start_Date__c = System.today();
        rel.Release_Planned_End_Date__c= System.today() + 10;
        rel.Status__c = 'Red';
        rel.Description__c = 'Test description ';
        rel.Status_Update__c = 'Test Comments';
        insert rel;
        
        SaaSCreateReleaseCtrl controller = new SaaSCreateReleaseCtrl(new ApexPages.StandardController(rel));
        controller.saveRelease();
        controller.validateKeyDecision();
        
    }
    
    static testMethod void validateCreateRelease1()
    {
       Release__c rel = new Release__c(); 
       SaaSCreateReleaseCtrl controller = new SaaSCreateReleaseCtrl(new ApexPages.StandardController(rel));
       controller.saveRelease();
       controller.createNewRelease();
       controller.validateKeyDecision();
       
       
     
    }
    
    static testMethod void validateReleaseClone()
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
        
        PageReference pageRef = Page.SaaSCreateRelease;
        pageRef.getParameters().put(SaaSTextConstant.IS_CLONE_URL_PARAM, '1');
        pageRef.getParameters().put(SaaSTextConstant.RELEASEID_URL_PARAM,rel.id);
        Test.setCurrentPage(pageRef);
        SaaSCreateReleaseCtrl controller = new SaaSCreateReleaseCtrl(new ApexPages.StandardController(rel));
        Controller.saveRelease();
        Controller.validateKeyDecision();
    }
}