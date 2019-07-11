/** 
 *  Author : Accenture 
 *  Description : Test Class for Controller class for SaaSCreateIssueRiskCtrl
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  09\06\2015        created 
 *
 */
@isTest 
public class SaaSCreateIssueRiskCtrlTest
{
    static testMethod void validateInsertIssueRisk() 
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
         
         Issues_Risks__c issue = new Issues_Risks__c();
         issue.Priority__c = 'High';
         issue.Status__c ='Open';
         issue.Description__c ='Test Description';
         issue.Target_Resolution_Date__c = System.today()+7;
         issue.release__c=rel.id;
         insert issue;
         
        
        PageReference pageRef = Page.SaaSClientQuestionSearch;
        pageRef.getParameters().put(SaaSTextConstant.IS_CLONE_URL_PARAM, '1');
        pageRef.getParameters().put(SaaSTextConstant.RELEASEID_URL_PARAM,rel.id);
        Test.setCurrentPage(pageRef);
        
        SaaSCreateIssueRiskCtrl IssRisk = new SaaSCreateIssueRiskCtrl(new ApexPages.StandardController(issue));
        IssRisk.issueRiskType = 'Issue'; 
        IssRisk.disbaleRecordType();
        IssRisk.getRecordType();
        IssRisk.saveIssueRisk();
        IssRisk.issueRiskObj.Status__c = null;
        IssRisk.saveIssueRisk();
        IssRisk.issueRiskObj.Status__c = 'Status';
        IssRisk.targetResolutionDate  = system.today().addDays(10);
        IssRisk.loggedDate =  system.today();
        IssRisk.saveIssueRisk();
        IssRisk.createIssueOrRisk();
        
    }  
    
     static testMethod void validateIssueRiskCtrl() 
     {
         Issues_Risks__c issue = new Issues_Risks__c();
         SaaSCreateIssueRiskCtrl controller = new SaaSCreateIssueRiskCtrl(new ApexPages.StandardController(issue));
         controller.saveIssueRisk();
         controller.createIssueOrRisk();     
     } 
      
    
    static testMethod void validateIssueRiskClone() 
    {
        Release__c rel =SaaSTestUtility.createRelease();
        Request__c req = new Request__c();
        req.Status__c= 'Identify: New Requirement';
        req.Request_Title__c = 'Test description ';
        req.Request_Type__c ='Integration ';
        req.Request_Description__c= 'Test description ';
        req.Release__c = rel.id;
        insert req;
        Issues_Risks__c issue = SaaSTestUtility.createIssue();
        PageReference pageRef = Page.SaaSCreateIssueRiskPage;
        Test.setCurrentPage(pageRef);
        SaaSCreateIssueRiskCtrl IssRisk = new SaaSCreateIssueRiskCtrl(new ApexPages.StandardController(issue));
        
        IssRisk.saveIssueRisk();
        IssRisk.disbaleRecordType();
        IssRisk.getRecordType();
         IssRisk.issueRiskObj.Priority__c = null;
        IssRisk.saveIssueRisk();
        IssRisk.issueRiskObj.Priority__c = 'priority';
        IssRisk.saveIssueRisk();
        IssRisk.issueRiskObj.Description__c = null;
        IssRisk.saveIssueRisk();
        IssRisk.issueRiskObj.Description__c = 'Desc';
        IssRisk.saveIssueRisk();
        IssRisk.TargetResolutionDate = null;
        IssRisk.saveIssueRisk();
        IssRisk.TargetResolutionDate = System.today();
        IssRisk.saveIssueRisk();
               
        IssRisk.validateKeyDecision();
        IssRisk.issueRiskObj.Target_Resolution_Date__c = system.today().addDays(10);
        IssRisk.saveIssueRisk();
        IssRisk.createIssueOrRisk();
    } 


}