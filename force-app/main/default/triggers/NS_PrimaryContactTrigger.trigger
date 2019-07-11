/*
Description  : This class has callout methods for VDN Maintenance webservice Invocation
Developer    : Accenture Solutions
Date         : 29-05-2018
*/

trigger NS_PrimaryContactTrigger on NS_PrimaryContact__c (After Insert, After update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            NS_IntegrationHelper.onCustomerContactInsert(Trigger.newMap);
        }
        if(Trigger.isupdate){
            NS_IntegrationHelper.onCustomerContactUpdate(Trigger.newMap,Trigger.oldMap);
        }
    }
}