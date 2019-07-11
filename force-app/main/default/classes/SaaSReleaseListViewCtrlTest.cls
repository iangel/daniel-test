/** 
 *  Author : Accenture 
 *  Description : Test Class for Controller class for SaaSReleaseListView  
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  08\06\2015        created 
 *
 */
@isTest
public class SaaSReleaseListViewCtrlTest
{
     
    static testMethod void validateRelease() 
    {
        Boolean bool;
        SaaSTestUtility.createIssue();
        SaaSTestUtility.createIssue();
        SaaSTestUtility.createIssue();
        
        SaaSReleaseListViewCtrl ctrlObj = new SaaSReleaseListViewCtrl ();
        List<SaaSReleaseListViewCtrl.ReleaseWrapper> wraplst = ctrlObj.getReleaseWrapLst();
        ctrlObj.first();
        ctrlObj.last();
        ctrlObj.previous();
        ctrlObj.next();
        ctrlObj.updateRelease();
        ctrlObj.cloneRelease();
        ctrlObj.searchtxt = 'test';
        ctrlObj.search();
        bool  =ctrlObj.hasNext;
        bool = ctrlObj.hasPrevious;
        wraplst.get(0).checked = true ;
        wraplst.get(1).checked = true ;
        ctrlObj.updateRelease();
        ctrlObj.cloneRelease();
        ctrlObj.deleteRelease();
        
        wraplst.get(1).checked = false;
        ctrlObj.updateRelease();
        ctrlObj.cloneRelease();
        ctrlObj.deleteRelease();    
    }     
}