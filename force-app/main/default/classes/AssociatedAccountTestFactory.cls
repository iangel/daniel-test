@isTest
public with sharing class AssociatedAccountTestFactory {
    /*Create Test Associated Account*/
    public static NS_AssociatedAccount__c buildAssociatedAccountRecord(Id accId, Id conId){
        NS_AssociatedAccount__c assoc = new NS_AssociatedAccount__c (
        NS_AccountName__c = accId,
        NS_ContactName__c = conId);
        return assoc;
    }
    /*Insert Test Associated Account*/
    public static NS_AssociatedAccount__c insertAssociatedAccountRecord(Id accId, Id conId){
        NS_AssociatedAccount__c assoc = new NS_AssociatedAccount__c (
        NS_AccountName__c = accId,
        NS_ContactName__c = conId);
        insert assoc;
        return assoc;
    }
    /*Enable Associated Account Trigger Settings*/
    public static void enableAssocAccountTrigger()
    {
        NS_TriggerSettings__c customSet1 = new NS_TriggerSettings__c(Name= NS_StaticVariablesUtility.assocTrigger); 
        customSet1.NS_IsActive__c = true;
        Database.insert(customSet1,false);
    }
}