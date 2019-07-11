/** 
 *  Author : Accenture 
 *  Description : Test Class for Controller class for SaaSClientQuestionSearchCtrl
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  08\06\2015        created 
 *
 */
 @isTest
public class SaaSClientQuestionSearchCtrlTest
{
     static testMethod void validateQuestionSearch() 
     {
        Boolean bool;
        SaaSTestUtility.createValueDeliveryQuestion();
        SaaSTestUtility.createValueDeliveryQuestion();
        SaaSTestUtility.createValueDeliveryQuestion();
        PageReference pageRef = Page.SaaSClientQuestionSearch;
        pageRef.getParameters().put(SaaSTextConstant.SCOPE_URL_PARAM, 'Scope Phase');

        Test.setCurrentPage(pageRef);
        SaaSClientQuestionSearchCtrl ctrlObj = new SaaSClientQuestionSearchCtrl ();
        List<SaaSQuestionLogWrapper> wraplst = ctrlObj.getQuesLogWrapLst();
        ctrlObj.previous();
        ctrlObj.next();
        ctrlObj.first();
        ctrlObj.Last();
        ctrlObj.editQuestion();
        ctrlObj.cloneQuestion();
        ctrlObj.linkToRequest();
        ctrlObj.convertToRequest();
        ctrlObj.commentQuestion();      
        ctrlObj.deleteQuestion();  
        ctrlObj.search();
        bool  =ctrlObj.hasNext;
        bool = ctrlObj.hasPrevious;
        wraplst.get(0).checked = true ;
        wraplst.get(1).checked = true ;
        ctrlObj.editQuestion();
        ctrlObj.cloneQuestion();
        ctrlObj.deleteQuestion();
        ctrlObj.linkToRequest();
        ctrlObj.convertToRequest();
        ctrlObj.commentQuestion();
        ctrlObj.initilizeDomain();
        ctrlObj.sortByColumn();
        
        wraplst.get(1).checked = false;
        ctrlObj.editQuestion();
        ctrlObj.cloneQuestion();
        ctrlObj.deleteQuestion();    
        ctrlObj.linkToRequest();
        ctrlObj.convertToRequest();
        ctrlObj.commentQuestion();   
     
     }    
}