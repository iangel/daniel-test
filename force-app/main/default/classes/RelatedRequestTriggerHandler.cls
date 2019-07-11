/*------------------------------------------------------------
Author:        Accenture IDC
Company:       Accenture
Description:   This is Handler class for Related Request Trigger
Test Class:    TBD : The name of the test class that is used to verify its function
History
<Date>      <Authors Name>     <Brief Description of Change>
07/03/2015  Accenture IDC       Initial Draft
------------------------------------------------------------*/
public without sharing class RelatedRequestTriggerHandler {

    
    /*------------------------------------------------------------
    Author:        Accenture IDC
    Company:       Accenture
    Description:   This is a handler function for After Insert context
    Inputs:        List<Contact>, Map<Id, Contact>
    Returns:       void
    ------------------------------------------------------------ */
    public static void handleBeforeInsert(List<Related_Request__c> lTriggerNew) {                                          
		RelatedRequestTriggerUtility.IsRelatedRequestDuplicate(lTriggerNew);
    }                                           
 
}