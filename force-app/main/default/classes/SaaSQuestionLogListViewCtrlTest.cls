/** 
 *  Author : Accenture 
 *  Description : Test Class for Controller class for SaaSQuestionLogListViewCtrl  
 *  Created Date : 16\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  16\06\2015        created 
 *
 */
@isTest 
public class SaaSQuestionLogListViewCtrlTest
{
    static testMethod void validateQuestionLog() 
    {
        Boolean bool;
        SaaSTestUtility.createSaaSQuestion();
        SaaSTestUtility.createSaaSQuestion();
        SaaSTestUtility.createSaaSQuestion();
        
        SaaSQuestionLogListViewCtrl ctrlObj = new SaaSQuestionLogListViewCtrl ();
        List<SaaSQuestionLogWrapper> wraplst = ctrlObj.getQuesLogWrapLst();
        ctrlObj.previous();
        ctrlObj.next();
        ctrlObj.updateQuestion();
        ctrlObj.cloneQuestion();
        ctrlObj.linkToRequest();
        ctrlObj.convertToRequest();
        ctrlObj.commentQuestion();
        
        ctrlObj.searchtxt = 'test';
        ctrlObj.search();
        bool  =ctrlObj.hasNext;
        bool = ctrlObj.hasPrevious;
        wraplst.get(0).checked = true ;
        wraplst.get(1).checked = true ;
        ctrlObj.updateQuestion();
        ctrlObj.cloneQuestion();
        ctrlObj.deleteQuestion();
        ctrlObj.linkToRequest();
        ctrlObj.convertToRequest();
        ctrlObj.commentQuestion();
        
        wraplst.get(1).checked = false;
        ctrlObj.updateQuestion();
        ctrlObj.cloneQuestion();
        ctrlObj.deleteQuestion();    
        ctrlObj.linkToRequest();
        ctrlObj.convertToRequest();
        ctrlObj.commentQuestion();
        ctrlObj.sortByColumn();
        
              
    }
 
}