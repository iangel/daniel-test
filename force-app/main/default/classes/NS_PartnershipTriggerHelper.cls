/**@author  Accenture
* @Created Date 2018-05-16
* @version  1.0
* @description This class contains method to restrict duplicate partnership record based on Customer Account,Primary Partner Contact and Partnership Type on 
before insert and before update
*/
public with sharing class NS_PartnershipTriggerHelper {
    
    /*Class Name*/
    private static final String CLASS_NAME = 'NS_PartnershipTriggerHelper';
    /*Method Name*/
    private static final String METHOD_NAME1 = 'duplicatePartnershipCheckOnInsert';
    private static final String METHOD_NAME2 = 'duplicatePartnershipCheckOnUpdate';
    
    /*Restricting Duplicate Partnership on Inserting/Updating a Record*/
    public static void duplicatePartnershipCheckOnInsert(List <NS_Partnership__c> pList)
    {
        NS_TriggerSettings__c customset = NS_TriggerSettings__c.getValues(NS_StaticVariablesUtility.partnershipTrigger);
        if(customset.NS_IsActive__c){
            set<Id> setCustomerAccounts=new set<Id>();
            set<Id> setPartnerContacts=new set<Id>();
            set<String> setPartnershipTypes=new set<String>();
            set<String> setUniqueKey=new set<String>();
            Integer count =limits.getLimitQueryRows();
            List<NS_Partnership__c> dupPartnership =new List<NS_Partnership__c>();
            try{
                for(NS_Partnership__c p : pList){ 
                    if(p.NS_PrimaryPartnerContact__c!=NULL){
                        if(setUniqueKey.contains(String.valueOf(p.NS_CustomerAccount__c) +
                                                 String.valueOf(p.NS_PrimaryPartnerContact__c) + 
                                                 String.valueOf(p.NS_PartnershipType__c))){
                           p.addError(Label.NS_DuplicatePartnershipErrorMessage2+NS_StaticVariablesUtility.Space+p.NS_CustomerAccount__c+
                                      NS_StaticVariablesUtility.Space+p.NS_PrimaryPartnerContact__c+
                                      NS_StaticVariablesUtility.Space+p.NS_PartnershipType__c);
                        }
                        else{
                            setCustomerAccounts.add(p.NS_CustomerAccount__c);
                            setPartnerContacts.add(p.NS_PrimaryPartnerContact__c);
                            setPartnershipTypes.add(p.NS_PartnershipType__c);
                            setUniqueKey.add(String.valueOf(p.NS_CustomerAccount__c) + 
                                             String.valueOf(p.NS_PrimaryPartnerContact__c)+ 
                                             String.valueOf(p.NS_PartnershipType__c));
                        }
                    } 
                }      
              for(NS_Partnership__c p2  : pList){
                    for(NS_Partnership__c p1 : [SELECT id,Name,NS_CustomerAccount__c,NS_PrimaryPartnerContact__c,NS_PartnershipType__c 
                                    FROM NS_Partnership__c 
                                    WHERE NS_CustomerAccount__c IN:setCustomerAccounts
                                    AND NS_PrimaryPartnerContact__c IN:setPartnerContacts
                                    AND NS_PartnershipType__c IN:setPartnershipTypes LIMIT:count]){
                        if(p2.NS_CustomerAccount__c.equals(p1.NS_CustomerAccount__c) 
                           && p2.NS_PrimaryPartnerContact__c.equals(p1.NS_PrimaryPartnerContact__c)
                           && p2.NS_PartnershipType__c.equals(p1.NS_PartnershipType__c))
                               {
                                    p2.addError(Label.NS_DuplicatePartnershipErrorMessage1+NS_StaticVariablesUtility.Space+p1.name);
                               }
                           }
                }
            }
            catch (Exception exp) {
                    /*Inserting a record in Exception object*/
                    NS_StaticVariablesUtility.createExceptionRecord(exp,CLASS_NAME,METHOD_NAME1);
            }
        }
    
    }
   
    /*Restricting Duplicate Partnership Record on Updating a Record*/
     public static void duplicatePartnershipCheckOnUpdate( Map<Id,NS_Partnership__c> newPartnershipMap, 
                                                     Map<Id,NS_Partnership__c> oldPartnershipmap){
        NS_TriggerSettings__c customset = NS_TriggerSettings__c.getValues(NS_StaticVariablesUtility.partnershipTrigger);
        List<NS_Partnership__c> duplicatePartner=new List<NS_Partnership__c>();                                                  
        if(customset.NS_IsActive__c){
          try{
              for(NS_Partnership__c p2  : newPartnershipMap.values()){
                 if(p2.NS_CustomerAccount__c!=oldPartnershipmap.get(p2.id).NS_CustomerAccount__c  ||
                       p2.NS_PrimaryPartnerContact__c!=oldPartnershipmap.get(p2.id).NS_PrimaryPartnerContact__c  ||
                       p2.NS_PartnershipType__c!=oldPartnershipmap.get(p2.id).NS_PartnershipType__c){
                       duplicatePartner.add(p2);
                 }          
              }
              if(!duplicatePartner.isEmpty()){
                  duplicatePartnershipCheckOnInsert(duplicatePartner);
              }
          } 
          catch (Exception exp) {
                /*Inserting a record in Exception object*/
                NS_StaticVariablesUtility.createExceptionRecord(exp,CLASS_NAME,METHOD_NAME2);
            }
      }
   }
}