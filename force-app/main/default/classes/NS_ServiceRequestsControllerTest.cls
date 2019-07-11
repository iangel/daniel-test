/*
Description  : This test class is to test the functionality When a Service request record is created
Developer    : Accenture Solutions
Date         : 29-04-2019

-----------------------------------------------------------------------
Developer name        Date          Description        
-----------------------------------------------------------------------
@Moumita    29-04-2019     Added Method to test case for Service Request
*/

@isTest(SeeAllData=false)
public class NS_ServiceRequestsControllerTest {
    
    static testmethod boolean is3PLRecordTypetest(){
        Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('3PL').getRecordTypeId();
        upsert acc;
        system.assertNotEquals(null, acc.Id);
        boolean is3pl = NS_ServiceRequestsController.is3PLRecordType(acc.RecordType.Name);
        return is3pl;
    }
    
    static testmethod void processDataTest(){
        
        Profile agent = UserTestFactory.createProfile('NS Marketing Leadership');
        User testUser = UserTestFactory.createUser(25,agent.Id);  
        system.runAs(testUser)
        {
            Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name); 
            system.assertNotEquals(null, acc.Id);
            Contact con = ContactTestFactory.buildContactRecord(acc.id,NS_StaticVariablesUtility.CONST_BLANK);
            con.LastName = NS_StaticVariablesUtility.MANUAL;
            ContactTestFactory.insertContactRecord(con);
            
            Map<String,List<String>> actual = NS_ServiceRequestsController.getDependentOptionsImpl('Case','NS_Owner_Business_Unit__c',null,'NS_Queue__c');
            
            String bU = 'Automotive';
            String queueName = 'Automotive - Bad Order';
            String sSubject = 'testData';
            String permitNumber = '123456';
            String eqNum = '654123';
            String description = 'TestDescription';
            Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Service Requests').getRecordTypeId();
            
            Map<String,String> myMap=new Map<String,String>();
            myMap.put('CONTACT_ID',con.id);
            myMap.put('SUBJECT',sSubject);
            myMap.put('TRAIN_ID',permitNumber);
            myMap.put('EQUIPMENT',eqNum);
            myMap.put('DESCRIPTION',description);
            myMap.put('OWNER_Q_NAME',queueName);
            myMap.put('accId',acc.id);
            
            NS_ServiceRequestsController.processData(myMap);
            
        }
        
    }
}