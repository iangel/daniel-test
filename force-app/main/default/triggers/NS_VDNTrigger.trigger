/*
Description  : This class has callout methods for VDN Maintenance webservice Invocation
Developer    : Accenture Solutions
Date         : 29-05-2018
*/

trigger NS_VDNTrigger on NS_VDN__c (After Insert, After update,Before delete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            NS_IntegrationHelper.invoke_VDNMaintenanceOnInsert(Trigger.newMap);
        }
        if(Trigger.isupdate){
            NS_IntegrationHelper.invoke_VDNMaintenanceOnUpdate(Trigger.newMap,Trigger.oldMap);
        }
      }
     if(Trigger.isBefore){
        if(Trigger.isDelete){
            System.debug('Befor delete hit');
            NS_IntegrationHelper.invoke_VDNMaintenanceOnDelete(Trigger.newMap,Trigger.oldMap);
        }
        }
}