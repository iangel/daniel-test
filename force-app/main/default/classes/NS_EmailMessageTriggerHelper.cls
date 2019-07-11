/**@author  Accenture
* @Created Date 2nd April 2018
* @version  1.0
* @description :This class contains method to prevent deletion of email by anyone,except System administrator
*/ 
public with sharing class NS_EmailMessageTriggerHelper 
{
    /*Class Name*/
    private static final String CLASS_NAME='NS_EmailMessageTriggerHelper';
    /*Method Name*/
    private static final String METHOD_NAME='preventDeletionEmailMessage';
    /*method to prevent email deletion*/
    public static void preventDeletionEmailMessage(EmailMessage [] newEmailMessages) {
        try{
            /*EmailMessage deletion is only allowed for administrator*/
            String profileName=[Select Name from Profile where Id=:userinfo.getProfileId() limit 1].Name;
            for(EmailMessage currentEmailMessage : newEmailMessages) {
                /*Check if current user is not a system administrator and email is not in draft status*/
                if(profileName != NS_StaticVariablesUtility.SystemAdministratorProfile && currentEmailMessage.Status != string.valueOf(5)){
                    currentEmailMessage.addError(System.Label.EmailDeleteErrorMessage);
                }
            }
        }
        catch(Exception exp){
            /*Inserting a record in Exception object*/
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME,METHOD_NAME);
        }
    }
}