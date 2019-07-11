@isTest
public with sharing class CaseTestFactory {    
    public static Case createCaseRecord(String iReason,String icategory, Id accountId){
        //Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.NAME+NS_StaticVariablesUtility.NAME);
        Contact con = ContactTestFactory.createContactRecord(accountId, NS_StaticVariablesUtility.NAME);
        Case cse = new Case(
            //RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =:NS_StaticVariablesUtility.CashHold AND 
           //                 SobjectType =:NS_StaticVariablesUtility.NS_CASE Limit 1].id,
            NS_InteractionReason__c=iReason,
            NS_InteractionCategory__c=icategory,
            Subject= NS_StaticVariablesUtility.NAME,
            NS_ExternalCaseNotes__c=NS_StaticVariablesUtility.NAME,
            Status = NS_StaticVariablesUtility.NEW_TXT,
            Priority = NS_StaticVariablesUtility.NS_Medium,
            Origin = 'Manual',
            ContactId = con.Id,
            AccountId = accountId
        );
        
       // insert cse;
        return cse;
    }
    public static Case createCase(String iReason,String icategory, Id accountId, id conId){
        Case cse = new Case(
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =:NS_StaticVariablesUtility.CashHold AND 
                            SobjectType =:NS_StaticVariablesUtility.NS_CASE Limit 1].id,
            NS_InteractionReason__c=iReason,
            NS_InteractionCategory__c=icategory,
            Subject= NS_StaticVariablesUtility.NAME,
            Status = NS_StaticVariablesUtility.NS_NEW,
            Priority = NS_StaticVariablesUtility.NS_Medium,
            Origin = 'Manual',
            ContactId = conId,
            AccountId = accountId
        );
        
       // insert cse;
        return cse;
    }
    
     public static Case createEmailToCase(){
        Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.NAME+NS_StaticVariablesUtility.NAME);
         
         Case cse = new Case(
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='NS_EmailToCase' AND 
                            SobjectType =:NS_StaticVariablesUtility.NS_CASE Limit 1].id,
            //NS_InteractionReason__c=iReason,
            //NS_InteractionCategory__c=icategory,
            Subject= 'This is the Email Subject',
            Status = NS_StaticVariablesUtility.NS_NEW,
            Priority = NS_StaticVariablesUtility.NS_Medium,
            OwnerId = [SELECT Id FROM Group WHERE DeveloperName = 'NS_Clearances' LIMIT 1].Id,
            Origin = 'Email'
        );

       insert cse;


        return cse;
    }
        /*** For Internal Request Creation***/
        public static Case createChildCaseRecord(String iReason,String icategory, Id accountId,Id parent){
        
        Contact con = ContactTestFactory.createContactRecordForCase(accountId, NS_StaticVariablesUtility.NAME);
        Case cse = new Case(
            RecordTypeId = [SELECT Id FROM RecordType WHERE Name =:NS_StaticVariablesUtility.ChildCase AND 
                            SobjectType =:NS_StaticVariablesUtility.NS_CASE Limit 1].id,
            NS_InteractionReason__c=iReason,
            NS_InteractionCategory__c=icategory,
            Subject= NS_StaticVariablesUtility.NAME,
            Status = NS_StaticVariablesUtility.NS_NEW,
            Request_Resolution__c=NS_StaticVariablesUtility.NAME,
            Priority = NS_StaticVariablesUtility.NS_Medium,            
            ownerid =[SELECT Id FROM Group WHERE Type = 'Queue' and Name= 'Automotive - Bad Order'].id,
            Origin = 'Manual',
            parentId=parent,
            ContactId = con.Id,
            AccountId = accountId
        );
        
       // insert cse;
        return cse;
    }
    public static Case createServiceRequest(Contact con){
        
      String bU = 'Automotive';
      String queueName = 'Automotive - Bad Order';
      String sSubject = 'testData';
      String permitNumber = '123456';
      String eqNum = '654123';
      String description = 'TestDescription';
      Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Service Requests').getRecordTypeId();
        
        
        Case cSr = new Case();
        cSr.ContactId = con.id;
        cSr.NS_Owner_Business_Unit__c = bU;
        cSr.NS_Queue__c = queueName;
        cSr.Subject = sSubject;
        cSr.NS_TrainID__c = permitNumber;
        cSr.NS_Equipment__c = eqNum;
        cSr.Description = description;
        cSr.RecordTypeId = recordTypeId; 
        
        return cSr;
    }
    
}