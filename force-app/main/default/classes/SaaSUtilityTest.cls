@isTest
/** 
 *  Author : Accenture 
 *  Description : Test Class for Controller class for SaaSUtility
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  09\06\2015        created 
 *
 */
public class SaaSUtilityTest
{
     static testMethod void validateSaaSUtility() 
     {
        List<Question_Log__c> Quest = new List<Question_Log__c>();
        SaaSUtility ctrlObj = new SaaSUtility();
        SaaSUtility.getCreatableFieldsSOQL('', '');
        SaaSUtility.getRecordTypeID('Question_Log__c','SaaS_Delivery_Question_Log');
        SaaSUtility.displayErrMsg('Error');
        SaaSUtility.displaySuccessMsg('Success');
        SaaSUtility.isAccentureRepresentative();
        SaaSUtility.getURLParameter('key');
        SaaSUtility.deleteSobject(Quest);
        SaaSUtility.insertSobject(Quest);
    }    
    
    static testMethod void validateSaaSPageTemplateCtrl()
    {
         SaaSPageTemplateCtrl  ctrlObj = new SaaSPageTemplateCtrl();
         ctrlObj.getUserPhotoUrl();
         ctrlObj.getDesginSessionOutcomes();
         ctrlObj.getBuildSessionOutcomes();
         ctrlObj.getInitiateSessionOutcomes();
    }
    
    
    static testMethod void validateSaaSPageMessage()
    {
        SaaSPageMessages.getMessages();
        SasSCustomPageMessages customMsg = new SasSCustomPageMessages();
        customMsg.getPageMessages();
        String s = customMsg.CustomPageMessages_ClosableErrorsRenderPlaceHolder;
    }
    static testMethod void validateDocumentDownload()
    {
        SaaSDocumentDownload ctrlObj = new SaaSDocumentDownload();
        String docID = ctrlObj.getDocumentID();
    }
    
}