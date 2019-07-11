/**@author  Accenture
* @Created Date 2018-03-07
* @version  1.0
* @description This class conatins method to filter out inactive contacts from Events.
*/ 
public with sharing class NS_EventTriggerHelper {
    /** @author  Accenture
*  @description To filter out the inactive contacts from Event
*  @param List of event
*  @return None
*  @throws None
*/ 
    /*Class Name*/ 
    private static final String CLASS_NAME='NS_EventTriggerHelper';
    /*Method Name*/ 
    private static final String METHOD_NAME='filterInactiveContacts';
  
    /*Filtering Event with Active Contact*/
    public static void filterInactiveContacts(List<Event> eventList){
        NS_TriggerSettings__c setting = NS_TriggerSettings__c.getValues(NS_StaticVariablesUtility.evtTrigger);
        if(setting.NS_IsActive__c){
            Integer count =limits.getLimitQueryRows();
            Set<Id> contactIds = new Set<Id>();
            Map<Id, Event> eventIdMap = new Map<Id, Event>();  
            Id eventRecordTypeId = Schema.SObjectType.Event.getRecordTypeInfosByName().
                                  get(NS_StaticVariablesUtility.eventRT).getRecordTypeId();
            /*Filtering Tasks for Record Type "NS Event" and storing Event Ids matching Contact Ids*/  
            try{
                for(Event evt : eventList){           
                    if(evt.RecordTypeId.equals(eventRecordTypeId)){
                        if(evt.WhoId != null && evt.WhoId.getSObjectType() == Contact.SObjectType && !contactIds.contains(evt.WhoId)){
                            contactIds.add(evt.WhoId);
                            eventIdMap.put(evt.WhoId,evt);
                        }
                    }
                }
                /*Display Error message if Event WhoId equals Inactive Contact Ids*/ 
                for(Contact con: [Select Id,Name,NS_ContactStatus__c from Contact where Id in :contactIds LIMIT:count] ){
                    
                    if(con.NS_ContactStatus__c!= null && NS_StaticVariablesUtility.conInactiveStatus.equalsIgnoreCase(con.NS_ContactStatus__c)){
                        eventIdMap.get(con.Id).addError(con.Name+NS_StaticVariablesUtility.Space+ Label.NS_TaskErrorMessage);
                    }
                }
            }
            catch (Exception exp) {
                //inserting a record in Exception object
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME);
            }
        }
    } 
}