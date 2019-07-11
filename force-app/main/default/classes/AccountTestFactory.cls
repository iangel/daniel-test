@isTest
public with sharing class AccountTestFactory {
     /*Create Test Account*/
    public static Account buildAccountRecord(String accName){
        Account acc = new Account(
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='NS_OtherRailRoad' AND 
                            SobjectType ='Account' Limit 1].id,
            Name=accName);
        return acc;
    }
    /*Insert test Account*/
    public static Account createAccountRecord(String accName1){
        Account acc = new Account(
            Name=accName1,
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='NS_OtherRailRoad' AND 
                            SobjectType ='Account' Limit 1].id,
            NS_StatusIndicator__c='Active',
            NS_MailingAddressCountry__c ='United States' ,
            NS_MailingAddressState__c ='CA' ,
            NS_MailingAddressCity__c = 'San Francisco',
            NS_MailingAddressStreet__c = 'Sacramento Street',
            NS_MailingAddressZip__c ='942867',
            NS_PhysicalAddressCountry__c = 'USA',
            NS_PhysicalAddressState__c ='IN' ,
            NS_PhysicalAddressCity__c ='Monticello',
            NS_PhysicalAddressStreet__c ='1515 N Main St' ,
            NS_PhysicalAddressZip__c ='47960' );
        insert acc;
        return acc;
    }
     /*Read/Edit access to Account(Parent Object) for user*/
    public static AccountShare accountShare(Id accId, Id userId,string accAccess, string oppAccess, string caseAccess, string rowCauseValue){
        AccountShare accshare = new AccountShare();
        accshare.AccountId = accId; 
        accshare.UserOrGroupId =userId; 
        accshare.AccountAccessLevel = accAccess;
        accshare.OpportunityAccessLevel = oppAccess;
        accshare.CaseAccessLevel = caseAccess;
        accshare.RowCause  = rowCauseValue;
        insert accshare;
        return accshare;
    }
    
    /*Insert test Online Account*/
    public static Account createOnlineAccountRecord(String onlineAccName1){
        Account acc = new Account(
            Name=onlineAccName1,
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='NS_OnlineCustomerCorporate' AND 
                            SobjectType ='Account' Limit 1].id,NS_ClassCode__c='Test',
            NS_StatusIndicator__c='Active');
            
        insert acc;
        return acc;
    }
    
    /* ================================================
* @Method Name : createOnlineServiceAccountRecord
* @author id: arjun.c.ghosh@accenture.com
* @Purpose: This method is used to create OnlineServiceAccount record. Do not modify this method 
* @Parameters: String Account Name
* @return: Account
* @Release: Phase-1 Enhancement Request
* @created date: 20-01-2019
==================================================*/ 
    public static Account createOnlineServiceAccountRecord(String onlineAccName1){
        NS_ServiceStations__c serviceStation = new NS_ServiceStations__c();
        serviceStation.NS_OperatingStationCode__c = 'GARDN';
        serviceStation.NS_StationCode_6_Spell__c='Test12';
        Database.Insert(serviceStation);
        Account acc = new Account(
            Name=onlineAccName1,
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='NS_OnlineCustomerService' AND 
                            SobjectType ='Account' Limit 1].id,NS_ClassCode__c='Test',
            NS_ServiceAccountType__c='Service - Online', NS_StatusIndicator__c='Active', 
            NS_OperatingStation__c = serviceStation.Id);
        
        insert acc;
        return acc;
    }
     
    /* ================================================
* @Method Name : createOfflineServiceAccountRecord
* @author id: arjun.c.ghosh@accenture.com
* @Purpose: This method is used to create OffineServiceAccount record. Do not modify this method 
* @Parameters: String Account Name
* @return: Account
* @Release: Phase-2 
* @created date: 02-05-2019
==================================================*/ 
    public static Account createOfflineServiceAccountRecord(String offLineAccName1){
        NS_ServiceStations__c serviceStation = new NS_ServiceStations__c();
        serviceStation.NS_OperatingStationCode__c = 'Test';
        serviceStation.NS_StationCode_6_Spell__c='Test21';
        Database.Insert(serviceStation);
        Account acc = new Account(
            Name=offLineAccName1,
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='NS_OnlineCustomerService' AND 
                            SobjectType ='Account' Limit 1].id,NS_ClassCode__c='Tset',
            NS_ServiceAccountType__c='Service - OffLine', NS_StatusIndicator__c='Active',
            NS_OperatingStation__c = serviceStation.Id);
        
        insert acc;
        return acc;
    }
    /*get test Online Account*/
    public static Account getOnlineAccountRecord(String onlineAccName1){
        Account acc = new Account(
            Name=onlineAccName1,
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='NS_OnlineCustomerCorporate' AND 
                            SobjectType ='Account' Limit 1].id,
            NS_StatusIndicator__c='Active');
        return acc;
    }
     /*Insert test Dummy Account*/
    public static Account createDummyAccountRecord(String onlineAccName1){
        Account acc = new Account(
            Name=onlineAccName1,
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='NS_OnlineCustomerCorporate' AND 
                            SobjectType ='Account' Limit 1].id,
            NS_StatusIndicator__c='Active',
            NS_External_ID__c =NS_StaticVariablesUtility.dummyExternalID);
        insert acc;
        return acc;
    }
   public static Account getThreePLAccountRecord(String threePLAccName1){
        Account acc = new Account(
            Name=threePLAccName1,
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='NS_3PL' AND 
                            SobjectType ='Account' Limit 1].id,
            NS_StatusIndicator__c='Active');
        insert acc;
        return acc;
    }
    
    
            /*Insert test Account*/
    public static Account createAccountRecord1(String accName1){
        Account acc = new Account(
            Name=accName1,
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='NS_3PL' AND 
                            SobjectType ='Account' Limit 1].id,
            NS_StatusIndicator__c='Active',
            ShippingCountry = 'United States',
            ShippingState  ='IL',
            ShippingCity ='Downers Grove',
            ShippingStreet ='4445  Millbrook Road',
            ShippingPostalCode ='60515'
           
        );
        insert acc;

        return acc;
    }
    
        public static Account createAccountRecord2(String accName1){
        Account acc = new Account(
            Name=accName1,
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='NS_3PL' AND 
                            SobjectType ='Account' Limit 1].id,
            NS_StatusIndicator__c='Active',
            BillingCountry = 'United States',
            BillingState  ='TX',
            BillingCity ='Plano',
            BillingStreet ='2503  Wilson Avenue',
            BillingPostalCode ='75074'
           
        );
        insert acc;
        return acc;
    }
    
    
    }