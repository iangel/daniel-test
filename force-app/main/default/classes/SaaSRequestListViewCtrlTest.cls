/** 
 *  Author : Accenture 
 *  Description : Test Class for Controller class for SaaSRequestListView  
 *  Created Date : 11\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  08\06\2015        created 
 *
 */
 
@isTest 
public class SaaSRequestListViewCtrlTest
{
    static testMethod void validateRequest() 
    {
        Boolean bool;
        SaaSTestUtility.createRequest();
        SaaSTestUtility.createRequest();
        SaaSTestUtility.createRequest();
        
        SaaSRequestListViewCtrl ctrlObj = new SaaSRequestListViewCtrl();
        List<SaaSRequestListViewCtrl.RequestWrapper> wraplst = ctrlObj.getrequestWrapLst();
        ctrlObj.first();
        ctrlObj.last();
        ctrlObj.previous();
        ctrlObj.next();
        ctrlObj.updateRequest();
        ctrlObj.cloneRequest();
        ctrlObj.searchtxt = 'test';
        ctrlObj.search();
        bool  =ctrlObj.hasNext;
        bool = ctrlObj.hasPrevious;
        wraplst.get(0).checked = true ;
        wraplst.get(1).checked = true ;
        ctrlObj.updateRequest();
        ctrlObj.cloneRequest();
        ctrlObj.deleteRequest();
        
        wraplst.get(1).checked = false;
        ctrlObj.updateRequest();
        ctrlObj.cloneRequest();
        ctrlObj.deleteRequest();
    }
}