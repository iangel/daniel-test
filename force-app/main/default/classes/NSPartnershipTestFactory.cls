@isTest
public class NSPartnershipTestFactory {
    /*Create Test NS Partnership Record*/
    public static NS_Partnership__c buildNSPartnershipRecord(Id acc1Id,Id accId, Id conId,String pType){
        NS_Partnership__c partner = new NS_Partnership__c (
            NS_CustomerAccount__c = acc1Id,
            NS_PartnerAccount__c = accId,
            NS_PrimaryPartnerContact__c = conId,
            NS_PartnershipType__c= pType);
        return partner;
    }
    /*Insert Test NS Partnership Record*/
    public static NS_Partnership__c createNSPartnershipRecord(NS_Partnership__c pnr){
        insert pnr;
        return pnr;
    }
    /*Insert Bulk Test NS Partnership Record*/
    public static void createBulkNSPartnershipRecord(List<NS_Partnership__c> pnrList){
        database.insert(pnrList,false);
    }
}