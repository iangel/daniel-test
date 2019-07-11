@isTest
public class ContactTestFactory {
    /*Insert Test Contact Record*/
    public static Contact createContactRecord(Id accId, String customerAccount){
        Contact con = new Contact(
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =:NS_StaticVariablesUtility.conRecordType AND 
                            SobjectType =:NS_StaticVariablesUtility.sObj Limit 1].id,
            FirstName='Test',
            LastName='User'+accId,
            AccountId= accId,
            Email ='user.test'+accId+'@gmail.com',
            NS_ContactStatus__c ='Active',
            NS_ContactRole__c = 'TestTest',
            NS_CustomerAccnt__c= customerAccount);
        insert con;  
        
        return con;
        
    }
    /*** For Internal Request Test ***/
    public static Contact createContactRecordForCase(Id accId, String customerAccount){
        Contact con = new Contact(
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =:NS_StaticVariablesUtility.conRecordType AND 
                            SobjectType =:NS_StaticVariablesUtility.sObj Limit 1].id,
            FirstName='Test019',
            LastName='User019'+accId,
            AccountId= accId,
            Email ='user.test019'+accId+'@gmail.com',
            NS_CustomerAccnt__c= customerAccount);
        insert con;
        return con;
    }
    /*Create Test Contact Record*/
    public static Contact buildContactRecord(Id accId, String customerAccount){
        Contact con = new Contact(
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =:NS_StaticVariablesUtility.conRecordType AND 
                            SobjectType =:NS_StaticVariablesUtility.sObj Limit 1].id,
            FirstName='Test',
            LastName='User'+accId,
            AccountId= accId,
            Email = 'user.test3'+accId+'@gmail.com',
            NS_CustomerAccnt__c= customerAccount);
        return con;
    }
    /*Update Test Contact Record*/
    public static void updateContactRecord(Contact conMap){
        if(conMap!=null){
            update conMap;
        }
    }
    /*Insert Test Contact Record*/
    public static void insertContactRecord(Contact conMap){
        if(conMap!=null){
            insert conMap;
        }
    }
    
    /*Read/Edit access to Contact for user*/
    public static ContactShare contactShare(Id conId, Id userId,string conAccess,string rowCauseValue){
        ContactShare conshare = new ContactShare();
        conshare.ContactId = conId; 
        conshare.UserOrGroupId = userId;
        conshare.ContactAccessLevel = conAccess;
        conshare.RowCause  = rowCauseValue;
        insert conshare;
        return conshare;
    }
    /*Enable Contact Trigger Settings*/
    public static void enableContactTrigger()
    {
        NS_TriggerSettings__c customSet = new NS_TriggerSettings__c(Name= NS_StaticVariablesUtility.conTrigger); 
        customSet.NS_IsActive__c = true;
        Database.insert(customSet,false);
    }
}