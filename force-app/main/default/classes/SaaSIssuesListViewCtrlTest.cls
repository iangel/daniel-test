/** 
 *  Author : Accenture 
 *  Description : Test Class for Controller class for SaaSIssuesListViewCtrl
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  08\06\2015        created 
 *
 */
@isTest
public class SaaSIssuesListViewCtrlTest
{
    static testMethod void validateissueRisk() 
    {
        Boolean bool;
        SaaSTestUtility.createIssue();
        SaaSTestUtility.createIssue();
        SaaSTestUtility.createIssue();
        
        SaaSIssuesListViewCtrl ctrlObj = new SaaSIssuesListViewCtrl();
        List<SaaSIssuesListViewCtrl.IssueRiskWrapper> wraplst = ctrlObj.getIssueRiskWrapLst();
        ctrlObj.first();
        ctrlObj.last();
        ctrlObj.previous();
        ctrlObj.next();
        ctrlObj.updateIssue();
        ctrlObj.cloneIssue();
      //  ctrlObj.deleteIssues(); 
        ctrlObj.searchtxt = 'test';
        ctrlObj.search();
        bool  =ctrlObj.hasNext;
        bool = ctrlObj.hasPrevious;
        wraplst.get(0).checked = true ;
        wraplst.get(1).checked = true ;
        ctrlObj.updateIssue();
        ctrlObj.cloneIssue();
        ctrlObj.deleteIssues();
        
        wraplst.get(1).checked = false;
        ctrlObj.updateIssue();
        ctrlObj.cloneIssue();
     //   ctrlObj.deleteIssues(); 
    }
}