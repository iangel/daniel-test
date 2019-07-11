/*------------------------------------------------------------
Author:        Accenture IDC
Company:       Accenture Services Private Limited
Description:   This is Contact trigger which sends request to Handler Class for processing.
History
<Date>      <Authors Name>     <Brief Description of Change>
04/12/2014  Accenture IDC       Inital Draft
------------------------------------------------------------*/
trigger trg_RelatedRequest on Related_Request__c (before insert) {

    if (Trigger.isBefore) {
            // CHECK FOR TRIGGER INSERT CONTEXT 
            if (Trigger.isInsert) {
                RelatedRequestTriggerHandler.handleBeforeInsert(Trigger.new);    
        }
    }
}