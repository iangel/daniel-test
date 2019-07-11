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
public class SaaSUserStoriesListViewCtrlTest 
{
  static testmethod void ValidateSaaSUserStoriesListViewCtrl()
  {
      Release__c rel = SaaSTestUtility.createRelease();
      User_Story__c us = SaaSTestUtility.createUserStory(rel);    

      PageReference pageRef = Page.SaaSUserStoriesListView;
      Test.setCurrentPage(pageRef);      
      
      SaaSUserStoriesListViewCtrl sus = new SaaSUserStoriesListViewCtrl();
      sus.getUserStoriesWrapLst();
      
      SaaSUserStoriesListViewCtrl.UserStoriesWrapper wr = new SaaSUserStoriesListViewCtrl.UserStoriesWrapper(us);
      sus.getUserStoriesWrapLst()[0].checked=true; 
      
      boolean bnext = sus.hasNext;
      boolean bprevious = sus.hasPrevious;
      sus.previous();
      sus.next();
      sus.sortByColumn();
      sus.search();
      sus.getSelectedElement();
      sus.cloneUserStory();
      sus.updateUserStory();
      sus.deleteUserStory();
      
  }
}