@isTest(SeeAllData=false)
public class NS_AccountRelationTriggerHelperTest {

    public static testmethod void InsertMirrorRecordtest()
    {
    Account Acc1 = New Account();
    Account Acc2 = New Account();
    Acc1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business').getRecordTypeId();
    Acc1.Name = 'test1';
    Acc2.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business').getRecordTypeId();
    Acc2.Name = 'test2';
    insert Acc1;
    insert Acc2;
    NS_AccountRelation__c AccR = new NS_AccountRelation__c();
    AccR.NS_RelationParty1__c = Acc1.id;
    AccR.NS_RelationParty2__c = Acc2.id;
    insert AccR;
    delete AccR;
    }
    public static testmethod void DeleteAccountRelationstest()
    {
    Account Acc1 = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
    Account Acc2 = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
    Account Acc3 = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
    NS_AccountRelation__c AccR2 = new NS_AccountRelation__c();
    AccR2.NS_RelationParty1__c = Acc3.id;
    AccR2.NS_RelationParty2__c = Acc1.id;
    insert AccR2;
    NS_AccountRelation__c AccR3 = new NS_AccountRelation__c();
    AccR3.NS_RelationParty1__c = Acc2.id;
    AccR3.NS_RelationParty2__c = Acc3.id;
    insert AccR3;
    delete Acc3;
    }
    
    public static testmethod void DuplicateCheckPreventTest(){
        
      Account TestAccount1 = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
      Account TestAccount2 = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
      Account TestAccount3 = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
      NS_AccountRelation__c ar1 = new NS_AccountRelation__c(
            NS_RelationParty1__c = TestAccount1.id,
            NS_RelationParty2__c = TestAccount2.id,
            NS_RelationType__c = 'Autoramp');
        insert ar1;
        
      NS_AccountRelation__c ar2 = new NS_AccountRelation__c(
            NS_RelationParty1__c = TestAccount3.id,
            NS_RelationParty2__c = TestAccount1.id,
            NS_RelationType__c = 'Autoramp');
        insert ar2;
        
    }    
}