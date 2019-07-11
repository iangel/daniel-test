public Without sharing class NS_AccountRelationTriggerHelper {
    
    public static boolean run = false;
    private static final String CLASS_NAME = 'NS_AccountRelationTriggerHelper';
    private static final String METHOD_NAME1='InsertMirrorRecord';
    private static final String METHOD_NAME2='DeleteAccountRelations';
    private static final String METHOD_NAME3='DeleteMirrorRecord';
    
    public static void InsertMirrorRecord(List<NS_AccountRelation__c> ARList){
        
        List<NS_AccountRelation__c> MirroredRecordList = new List<NS_AccountRelation__c>();
        try{
        if(run == false){
            run = true;
            for(NS_AccountRelation__c ar : ARList){
                
                NS_AccountRelation__c newAR = new NS_AccountRelation__c();
                
                newAR.NS_RelationParty1__c = ar.NS_RelationParty2__c;
                newAR.NS_RelationParty2__c = ar.NS_RelationParty1__c;
                
                newAR.NS_RelationDescription__c = ar.NS_RelationDescription__c;
                newAR.NS_RelationType__c = ar.NS_RelationType__c;
                
                MirroredRecordList.add(newAR);
                
            }
            upsert MirroredRecordList;
            
        }
        }
            catch(Exception exp) 
            {
                /*Inserting a record in Exception object*/
                NS_StaticVariablesUtility.createExceptionRecord(exp,CLASS_NAME,METHOD_NAME1);
            } 
       
    }
    
    //delete all account relation records where deleted Account record is referenced
    public static void DeleteAccountRelations(List<Account> AccList){   
        
        list<id> AccountIds = new list<id>();
        
        try{
                for(Account acc : AccList)
                {
                    AccountIds.add(acc.id);
                }
            
                list<NS_AccountRelation__c> listOfAccountRelation1 = new list<NS_AccountRelation__c>([SELECT id FROM NS_AccountRelation__c where (NS_RelationParty1__c IN :AccountIds OR NS_RelationParty2__c IN :AccountIds)]);
                delete listOfAccountRelation1;
        	}
        catch (Exception exp) 
        {
            /*Inserting a record in Exception object*/
            NS_StaticVariablesUtility.createExceptionRecord(exp,CLASS_NAME,METHOD_NAME2);
        }
	}
    public static void DuplicateCheckPrevent(List<NS_AccountRelation__c> ARList)
    {
        try{
        List<NS_AccountRelation__c> AccountRelationship = new List<NS_AccountRelation__c>([Select id,NS_RelationParty1__c,NS_RelationParty2__c from NS_AccountRelation__c limit 10000]);
        for(NS_AccountRelation__c ar : ARList)
        {
           Id Party1Acc = ar.NS_RelationParty1__c;
           Id Party2Acc = ar.NS_RelationParty2__c;
            for(NS_AccountRelation__c fromAcc : AccountRelationship)
            {
                if(((fromAcc.NS_RelationParty1__c == Party1Acc) && (fromAcc.NS_RelationParty2__c == Party2Acc)) ||
                   ((fromAcc.NS_RelationParty2__c == Party1Acc) && (fromAcc.NS_RelationParty1__c == Party2Acc)))
                {
                    ar.NS_RelationParty1__c.addError('You cannot create a duplicate record');
                }
            }
            
        }
        }
        catch (Exception exp) 
        {
            /*Inserting a record in Exception object*/
            NS_StaticVariablesUtility.createExceptionRecord(exp,CLASS_NAME,METHOD_NAME2);
        }
    }
    
    //delete mirrored account relation record where deleting one account relation record
    public static void DeleteMirrorRecord(List<NS_AccountRelation__c> ARList){   
        
        try{
                for(NS_AccountRelation__c acctRelation : ARList)
                {
                    String query = 'SELECT id FROM NS_AccountRelation__c ';
                    query += 'WHERE NS_RelationParty1__c = \'' + acctRelation.NS_RelationParty2__c + '\' ';
                    query += 'AND NS_RelationParty2__c = \'' + acctRelation.NS_RelationParty1__c + '\' ';
                    query += 'LIMIT 1';
                    list<NS_AccountRelation__c> listARDel = Database.query(query); 
					if (listARDel.size() >0)
                        {
                            delete listARDel;
                        }
                }
        	}
        catch (Exception exp) 
        {
            /*Inserting a record in Exception object*/
            NS_StaticVariablesUtility.createExceptionRecord(exp,CLASS_NAME,METHOD_NAME3);
        }
	}

}