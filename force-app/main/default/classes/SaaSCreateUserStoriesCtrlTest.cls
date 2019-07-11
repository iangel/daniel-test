/** 
 *  Author : Accenture 
 *  Description : Test class for SaaSCreateUserStoriesCtrl
 *  Created Date : 11\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  08\06\2015        created 
 *
 */
@isTest
public class SaaSCreateUserStoriesCtrlTest 
{

  static testmethod void ValidateSaaSCreateUserStoriesCtrl()
  {
      Release__c rel = SaaSTestUtility.createRelease();
      User_Story__c us = SaaSTestUtility.createUserStory(rel); 
      
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
      integer i=1;
      string s ='test';
      userStoryoption.Value_Deliver_Session_User_Stories__c=stories.Id;
      insert userStoryoption;
      
      User_Story_Options__c userStoryoption1 = new User_Story_Options__c ();
      userStoryoption1.Value_Deliver_Session_User_Stories__c=stories.Id;
      insert userStoryoption1;
      List<User_Story_Options__c> userStoryoptionlist = [select id from User_Story_Options__c where id=:userStoryoption1.Id LIMIT 1]; 
      
      SaaSCreateUserStoriesCtrl ctrl = new SaaSCreateUserStoriesCtrl(new ApexPages.StandardController(us)); 
      ctrl.userStoryObj.name='test';
      ctrl.userStoryObj.Release__c =rel.Id;
      ctrl.createNewUserStory();
      ctrl.addUserStoryOptions();

      SaaSCreateUserStoriesCtrl.UserStoryOptionWrapper pwt = new SaaSCreateUserStoriesCtrl.UserStoryOptionWrapper(userStoryoption1); 
      pwt.disableLookup = true;
      pwt.hash ='2';
      ctrl.clientHash ='1';
      SaaSCreateUserStoriesCtrl.UserStoryOptionWrapper pw = new SaaSCreateUserStoriesCtrl.UserStoryOptionWrapper(i,userStoryoption,s); 
      ctrl.userStoryOptionLst.add(pw);
      ctrl.initlizeOptions();
      pw.valueDeliverySession =objVDSO.ID;
      ctrl.userStoryOptionLst.add(pw);
      ctrl.saveUserStory();
      try{
      ctrl.saveUserStoryOption();
      }Catch(Exception ex){}
      ctrl.remove();
      ctrl.updatelookupToReadOnly();
  }
    
    static testmethod void ValidateSaaSCreateUserStoriesCtrlNegative()
    {
      Release__c rel = SaaSTestUtility.createRelease();
      User_Story__c usc = SaaSTestUtility.createUserStory(rel);   
       
      ApexPages.CurrentPage().getparameters().put('isClone', '1');  
      ApexPages.CurrentPage().getparameters().put('releaseid', rel.id);
      SaaSCreateUserStoriesCtrl ctrls = new SaaSCreateUserStoriesCtrl(new ApexPages.StandardController(usc)); 
      ctrls.saveUserStory();   
      ctrls.userStoryObj.name  = null;  
      ctrls.saveUserStory();   
      ctrls.userStoryObj.name  = 'test';        
      ctrls.saveUserStory();         
      ctrls.userStoryObj.User_Story_Description__c = null;
      ctrls.saveUserStory();   
      ctrls.userStoryObj.User_Story_Description__c = 'dec';
      ctrls.userStoryObj.Release__c =null; 
      ctrls.saveUserStory();   
     
      rel = SaaSTestUtility.createRelease();
      usc = SaaSTestUtility.createUserStory(rel);    
       
      SaaSCreateUserStoriesCtrl ctrl = new SaaSCreateUserStoriesCtrl(new ApexPages.StandardController(usc)); 
      ctrl.saveUserStory();   
      ctrl = new SaaSCreateUserStoriesCtrl(new ApexPages.StandardController(new User_Story__c())); 
    
         
   }
}