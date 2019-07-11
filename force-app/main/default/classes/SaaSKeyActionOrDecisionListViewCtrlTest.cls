/** 
 *  Author : Accenture 
 *  Description : Test Class for Controller class for SaaSKeyActionOrDecisionListViewCtrl  
 *  Created Date : 16\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  16\06\2015        created 
 *
 */
@isTest 
public class SaaSKeyActionOrDecisionListViewCtrlTest
{
     static testMethod void validateKeyActionDecision() 
     {
        Boolean bool;
        SaaSTestUtility.createKeyAction();
        SaaSTestUtility.createKeyAction();
        SaaSTestUtility.createKeyAction();
        
        SaaSKeyActionOrDecisionListViewCtrl ctrlObj = new SaaSKeyActionOrDecisionListViewCtrl ();
        List<SaaSKeyActionOrDecisionListViewCtrl.KeyDecisionWrapper> wraplst = ctrlObj.getkeyDecisionWrapLst();
        ctrlObj.previous();
        ctrlObj.next();
        ctrlObj.updateKeyAction();
        ctrlObj.cloneKeyAction();
        ctrlObj.searchtxt = 'test';
        ctrlObj.search();
        bool  =ctrlObj.hasNext;
        bool = ctrlObj.hasPrevious;
        wraplst.get(0).checked = true ;
        wraplst.get(1).checked = true ;
        ctrlObj.updateKeyAction();
        ctrlObj.cloneKeyAction();
        ctrlObj.deleteKeyAction();
        
        wraplst.get(1).checked = false;
        ctrlObj.updateKeyAction();
        ctrlObj.cloneKeyAction();
        ctrlObj.deleteKeyAction();    
       
    }
 
}