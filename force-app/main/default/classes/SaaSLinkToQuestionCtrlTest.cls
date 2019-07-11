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
public class SaaSLinkToQuestionCtrlTest
{
    static testMethod void validateLinkToQuestionLog() 
    {
        Boolean bool;
        Question_Log__c questionObj = SaaSTestUtility.createSaaSQuestion();
        SaaSTestUtility.createRequest();
        SaaSTestUtility.createRequest();
        
        SaaSLinkToQuestionCtrl ctrlObj = new SaaSLinkToQuestionCtrl(new ApexPages.StandardController(questionObj ));
        List<SaaSLinkToQuestionCtrl.RequestWrapper> wraplst = ctrlObj.getrequestWrapLst();
        ctrlObj.previous();
        ctrlObj.next();
        ctrlObj.first();
        ctrlObj.last();
        
        bool  =ctrlObj.hasNext;
        bool = ctrlObj.hasPrevious;
        wraplst.get(0).checked = true ;
        wraplst.get(1).checked = true ;
        
        wraplst.get(1).checked = false;
        ctrlObj.updateSelectedRequest();
        ctrlObj.getSelectedElement();
        ctrlObj.linkToRequest();
        
              
    }
 
}