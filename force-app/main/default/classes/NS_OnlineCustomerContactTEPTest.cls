@isTest(SeeAllData=false)
private class NS_OnlineCustomerContactTEPTest {
    
    static testmethod void testinvokeManageOnlineCustomerContactOnInsertTEP(){ 
        
        NS_TriggerSettings__c customSet1 = new NS_TriggerSettings__c();
        customSet1.Name=NS_StaticVariablesUtility.assocTrigger;
        customSet1.NS_IsActive__c=true;
        Database.insert(customSet1,false);
        System.debug('CustomSet: '+customSet1.id);
        NS_Integration_Endpoints__c ie = new NS_Integration_Endpoints__c();
        ie.Name = 'CustomerContactChange_Teams';
        ie.Endpoint_URL__c = 'https://www.google.com';
        insert ie;
        //Account newAcc = AccountTestFactory.createOnlineServiceAccountRecord(NS_StaticVariablesUtility.Name);
        Account newAcc = new Account(Name='Test',RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='NS_OnlineCustomerService' AND 
                                                                 SobjectType ='Account' Limit 1].id);
        insert newAcc; 
        
        Contact newCon = new Contact();
        newCon.FirstName = 'Test';
        newCon.LastName = 'Test1';
        newCon.AccountId = newAcc.Id;
        newCon.NS_RACF_ID__c = 'SFDC1';
        newCon.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='NS_GeneralContact'].Id;
        newCon.Phone ='1234567890';
        insert newCon;
        System.debug('Con Id'+newCon.id);
        System.debug('RACF Id'+newCon.NS_RACF_ID__c);
        newCon.Email ='abc@gmail.com';
        update newCon;
        system.debug(newCon.Email);
        System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
        
    }
    
}