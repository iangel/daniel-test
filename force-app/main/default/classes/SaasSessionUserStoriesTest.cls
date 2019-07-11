/** 
 *  Author : Accenture 
 *  Description : Test class for SaasSessionUserStories
 *  Created Date : 04\04\2016
 * 
 *  Version History :
 *  Date              Changes 
 *  04\04\2016        created 
 *
 */
 
 @isTest(seealldata=false)

public class SaasSessionUserStoriesTest
{
    static testmethod void ValidateSaasSessionUserStories()
   {

      PageReference pageRef = Page.SaasSessionUserStories;
      Test.setCurrentPage(pageRef);  
      
        Release__c rel = SaaSTestUtility.CreateRelease();
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
        userstory.Priority__c ='Low';
        userstory.Release__c =rel.ID;
        userstory.Level_3_Process__c ='testing';
        insert userstory;

       //create  2 childs  for userstory..
        Value_Delivery_Session_User_Stories__c userStories1 = new Value_Delivery_Session_User_Stories__c();
        userStories1.Value_Delivery_Session_Outcomes__c = objVDSO.Id;
        userStories1 .User_Story__c =userstory.ID;
        insert userStories1 ;
        
        Value_Delivery_Session_User_Stories__c userStories2 = new Value_Delivery_Session_User_Stories__c();
        userStories2.Value_Delivery_Session_Outcomes__c = objVDSO.Id;
        userStories2 .User_Story__c =userstory.ID;
        insert userStories2 ;
        
        set<Id> setId= new set<Id>();

        //there is no child for userstory1 and userstory2
        User_Story__c userstory1 = new User_Story__c();
        userstory1.Priority__c ='Low';
        userstory1.Release__c =rel.ID;
        userstory1.Level_3_Process__c ='testing1';
        insert userstory1;
        
        setId.add(userstory1.Id);
        
        Value_Delivery_Session_User_Stories__c userStories = new Value_Delivery_Session_User_Stories__c();
        userStories.Value_Delivery_Session_Outcomes__c = objVDSO.Id;
        userStories.User_Story__c =null;
        userStories.User_Story__c = userstory1.Id;

        insert userStories ;
        
        User_Story__c userstory2 = new User_Story__c();
        userstory2.Priority__c ='Low';
        userstory2.Release__c =rel.ID;
        userstory2.Level_3_Process__c ='testing2';
        insert userstory2;
        setId.add(userstory2.Id);

        SaasSessionUserStories sus = new SaasSessionUserStories(new ApexPages.StandardController(objVDSO)); 
        sus.getUserStoriesWrapLst();
      
        SaasSessionUserStories.UserStoriesWrapper wr = new SaasSessionUserStories.UserStoriesWrapper(us);
        sus.getUserStoriesWrapLst()[0].checked=true; 
      
        boolean bnext = sus.hasNext ;
        boolean bprevious = sus.hasPrevious;
        sus.previous();
        sus.next();
        sus.sortByColumn();
        sus.search();
        sus.getSelectedElement();
        sus.importUserStories();
    }
}