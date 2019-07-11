/*------------------------------------------------------------
Author:        Accenture IDC
Company:       Accenture
Description:   This is Handler class for Question Log Trigger
Test Class:    TBD : The name of the test class that is used to verify its function
History
<Date>      <Authors Name>     <Brief Description of Change>
15/06/2015  Accenture IDC       Initial Draft
------------------------------------------------------------*/
public without sharing class RelatedRequestTriggerUtility {

    public static void IsRelatedRequestDuplicate(List<Related_Request__c> lTriggerNew)
        {
        set<Id> RequestIds = new set<Id>();          
         
          for(Related_Request__c objrr : lTriggerNew)
            {
            RequestIds.add(objrr.Request__c);
            }

            List<Related_Request__c> lstrr = [SELECT Name, Request__c, Question_Log__c FROM Related_Request__c Where Request__c =: RequestIds];
            
            for(Related_Request__c rrobj : lstrr)
                {
                if(rrobj.Question_Log__c == lTriggerNew[0].Question_Log__c){
                        Trigger.new[0].addError('Combination of selected Request and Question Log is already exist.');                            
                    }               
                }
            }
}