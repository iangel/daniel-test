/**@author  Accenture
* @Created Date 2018-05-14
* @version  1.0
* @description This class contains method to restrict duplicate Associated Account based on Account name and Contact name on 
before insert and before update
*/
public with sharing class NS_AssociatedAccountTriggerHelper {
    
    /*Class Name*/
    private static final String CLASS_NAME = 'NS_AssociatedAccountTriggerHelper';
    /*Method Name*/
    private static final String METHOD_NAME1 = 'beforeAssociatedAccountInsert';
    private static final String METHOD_NAME2 = 'beforeAssociatedAccountUpdate';
    
    /*Restricting Duplicate Associate Accounts on Inserting a Record*/
    public static void beforeAssociatedAccountInsert(List <NS_AssociatedAccount__c> assocList)
    {
        NS_TriggerSettings__c customset = NS_TriggerSettings__c.getValues(NS_StaticVariablesUtility.assocTrigger);
        if(customset.NS_IsActive__c ){
            Integer count =limits.getLimitQueryRows();
            set<Id> setAccountNames=new set<Id>();
            set<Id> setContactNames=new set<Id>();
            
            try{
                for(NS_AssociatedAccount__c assoc : assocList)
                {
                    setAccountNames.add(assoc.NS_AccountName__c);
                    setContactNames.add(assoc.NS_ContactName__c);
                }
                
                Map<Id,Account> accountMap = new Map<Id,Account>([select Id,name from Account where id =:setAccountNames LIMIT:count]);
                Map<Id,Contact> contactMap = new Map<Id,Contact>([select Id,firstname,lastname,MobilePhone,
                                                                  Phone,OtherPhone,HomePhone from Contact where id =:setContactNames
                                                                 LIMIT:count]);
                
                for(NS_AssociatedAccount__c assoc: assocList)            
                {   
                    assoc.NS_CellPhone__c = contactMap.get(assoc.NS_ContactName__c).MobilePhone;
                    assoc.NS_WorkPhone__c = contactMap.get(assoc.NS_ContactName__c).Phone;
                    assoc.NS_OtherPhone1__c=contactMap.get(assoc.NS_ContactName__c).OtherPhone;
                    assoc.NS_OtherPhone2__c=contactMap.get(assoc.NS_ContactName__c).HomePhone;
                    assoc.NS_AccName__c = accountMap.get(assoc.NS_AccountName__c).name;
                    assoc.NS_ConName__c = contactMap.get(assoc.NS_ContactName__c).firstname+NS_StaticVariablesUtility.Space+
                                          contactMap.get(assoc.NS_ContactName__c).lastname;
                    
                    for(NS_AssociatedAccount__c dup:[select NS_AccountName__c,NS_ContactName__c,id from NS_AssociatedAccount__c where 
                                                     NS_AccountName__c IN:setAccountNames and NS_ContactName__c IN:setContactNames 
                                                     and id NOT IN:Trigger.new LIMIT:count ])                
                    {                
                        if(assoc.NS_AccountName__c.equals(dup.NS_AccountName__c) 
                           && assoc.NS_ContactName__c.equals(dup.NS_ContactName__c )) 
                        {
                            assoc.addError(Label.NS_AssocAccErrorMsg);
                        }
                    }            
                }
            }
           
            catch (Exception exp) {
                /*Inserting a record in Exception object*/
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME1);
            }
        }
    }
    /*Restricting Duplicate Associate Accounts on Updating a Record*/
    public static void beforeAssociatedAccountUpdate( Map<Id,NS_AssociatedAccount__c> newAssocMap, 
                                                     Map<Id,NS_AssociatedAccount__c> oldAssocMap)
    {
        NS_TriggerSettings__c customset = NS_TriggerSettings__c.getValues(NS_StaticVariablesUtility.assocTrigger);
        if(customset.NS_IsActive__c){
             List<NS_AssociatedAccount__c> assocListValues =new List<NS_AssociatedAccount__c>();
            try{
                for(NS_AssociatedAccount__c acc: newAssocMap.values())            
                {    
                    if( acc.NS_AccountName__c!=oldAssocMap.get(acc.id).NS_AccountName__c)
                    {
                        assocListValues.add(acc);
                    }
                }
                if(!assocListValues.isEmpty()){
                    beforeAssociatedAccountInsert(assocListValues);
                }
            } 
            catch (Exception exp) {
                /*Inserting a record in Exception object*/
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME2);
            }
        }
    }
}