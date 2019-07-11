@isTest
public class SaasSessionUserStoriesResultCtrlTest
{
   static testMethod void validateSaasSessionUserStoriesResultCtrl() 
   {
        Release__c rel = new Release__c();
        rel.Name = 'Test Release Data';
        rel.Id = null;
        rel.Plan_Start_Date__c = System.today();
        rel.Release_Planned_End_Date__c= System.today() + 10;
        rel.Status__c = 'Red';
        rel.Description__c = 'Test description ';
        insert rel;
        
        Value_Delivery_Session__c vds = new Value_Delivery_Session__c();
        vds.Description__c = 'test delivery data';
        vds.End_Date__c = System.today() + 10; 
        vds.Start_Time__c=system.now();
        vds.Releases__c = rel.id;
        insert vds;        
                
        Value_Delivery_Session_Outcomes__c objVDSO = new Value_Delivery_Session_Outcomes__c();
        objVDSO.Name = 'Test outcome Data';
        objVDSO.Phase__c = 'Design';
        objVDSO.Start_Date__c = system.today();
        objVDSO.End_Date__c = system.today()+10;
        objVDSO.Session_Outcome__c = 'Test data preparation';
        objVDSO.Value_Delivery_Session__c = vds.id; 
        insert objVDSO; 
        
        User_Story__c userstory = new User_Story__c();
        userstory.name ='how to implement';
        userstory.Release__c = rel.Id;
        insert userstory;
        Value_Delivery_Session_User_Stories__c stories = new Value_Delivery_Session_User_Stories__c();
        stories.Value_Delivery_Session_Outcomes__c = objVDSO.Id;
        stories.User_Story__c =userstory.Id;
        insert stories;
      
        User_Story_Options__c userStoryoption = new User_Story_Options__c ();
        userStoryoption.Value_Deliver_Session_User_Stories__c=stories.Id;
        insert userStoryoption;
        
        Id us = Userinfo.getUserID();
        
        Vote_User_Story__c vote = new Vote_User_Story__c();
        vote.User_Story_Option__c = userStoryoption.ID;
        vote.User__c = us;
        insert vote;
        
        
        
        
        SaasSessionUserStoriesResultCtrl ctrl = new SaasSessionUserStoriesResultCtrl(new ApexPages.StandardController(stories)); 
        SaasSessionUserStoriesResultCtrl.UserVoteWrapper pwt = new SaasSessionUserStoriesResultCtrl.UserVoteWrapper(); 
        SaasSessionUserStoriesResultCtrl.ChartWarpper  pwtr = new SaasSessionUserStoriesResultCtrl.ChartWarpper (); 
        ctrl.chartLst.add(pwtr);
        boolean bnext = ctrl.hasNext ;
        boolean bprevious = ctrl.hasPrevious;
        ctrl.previous();
        ctrl.next();
        ctrl.sortByColumn();
        ctrl.search();
  
    }
    
 }