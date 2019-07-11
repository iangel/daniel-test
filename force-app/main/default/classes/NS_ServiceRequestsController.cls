/*
Description  : This class conatins  case and task creation functionalities.Purpose of this class is to segregate the business rules from the dialoug layer
Developer    : Accenture Solutions
Date         : 15-04-2018

-----------------------------------------------------------------------
Developer name        Date          Description        
-----------------------------------------------------------------------
@Arjun Ghosh          23-11-2018    Server side controller for Quick case and task creation functionalities
*/
public class NS_ServiceRequestsController {
    
    /*Other Constants*/	
    public static final String CONTACT_ID ='srContactId';    
    /*Other Constants*/
    public static final String DESCRIPTION='srDescription';
    /*Other Constants*/
    public static final String OWNER_ID='srOwnerid';
    /*Other Constants*/
    public static final String PRIORITY='srPriority';
    /*Other Constants*/
    public static final String SUBJECT='srSubject';
    /*Other Constants*/
    public static final String OWNER_Q_NAME='SelectedQ';
    /*Other Constants*/
    public static final String accId='accId';
    /*Other Constants*/
    public static final String  ONBEHALFOFID='onBehalfOfId';
    //public static final String SHUTDOWN='srShutdown';
    /*Other Constants*/
    public static final String  EQUIPMENT='equipment';
    /*Other Constants*/
    public static final String  TRAIN_ID='trainId';
    /*Other Constants*/
    public static final String  ORIGIN='srOrigin';
    /*Class Name*/
    public static final String CLASS_NAME='NS_ServiceRequestsController';
    /*Method Name*/
    public static final String PROCESS_DATA='processData';
    
    private static final String THREE_PL_DEVELOPERNAME = 'NS_3PL';
    public static final String IS_3PL_RECORD_TYPE='is3PLRecordType';
   
    @AuraEnabled 
    /*Checks if Record Type is 3PL*/ 
    public static boolean is3PLRecordType(String accId){
        boolean is3pl= false;
        try{
            Id threePL_RecTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = :THREE_PL_DEVELOPERNAME LIMIT 1].Id;
            Account currAcc = [Select Id,RecordTypeId from Account where Id = :accId LIMIT 1];
            if(threePL_RecTypeId == currAcc.RecordTypeId){
                is3pl=true;
            }
        }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, IS_3PL_RECORD_TYPE);
        }
        return is3pl; 
    }
    
 /*Perform Background Actions*/
    @AuraEnabled
    public static  Map<String,String> processData(Map<String,String> myMap) {
        Map<String,String> resultSet= new  Map<String,String>();
        try{
            String srContactId = myMap.get(CONTACT_ID);
            //String srOwnerid= myMap.get(OWNER_ID);
            String srSubject = myMap.get(SUBJECT);            
            String trainId =myMap.get(TRAIN_ID); 
            //String srOrigin=myMap.get(ORIGIN);
            String equipment=myMap.get(EQUIPMENT);   
            //String shutdown=(String)myMap.get(SHUTDOWN);   
            String srDescription = myMap.get(DESCRIPTION); 
            String srOwnerQName = myMap.get(OWNER_Q_NAME);
            String onBehalfOfId = myMap.get(ONBEHALFOFID);
            /*Moumita*/
            Id AccId = myMap.get(accId);
            /*Moumita*/
            Id OwnerQId;
            
            //NS_EmailToQueue__mdt rec = [SELECT Queue_Id__c from NS_EmailToQueue__mdt WHERE Label=:srOwnerQName];
            OwnerQId = [Select id, Name from group where Type = 'Queue' AND Name =: srOwnerQName].id;
            //OwnerQId = rec.Queue_Id__c;
            
            resultSet=NS_CreateQuickCaseUtil.createServiceRequest(srContactId,OwnerQId,srSubject,trainId,
                                                                  equipment,srDescription,AccId,onBehalfOfId);
        }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, PROCESS_DATA);
            
            
        }
        return resultSet;
    }
    @AuraEnabled  
    public static Map<String,List<String>> getDependentOptionsImpl(string objApiName , string contrfieldApiName , 
                                                               String controllerLabelName, string depfieldApiName){
           
        String objectName = objApiName.toLowerCase();
        String controllingField = contrfieldApiName.toLowerCase();
        String dependentField = depfieldApiName.toLowerCase();
        
        Map<String,List<String>> objResults = new Map<String,List<String>>();
            //get the string to sobject global map
        Map<String,Schema.SObjectType> objGlobalMap = Schema.getGlobalDescribe();
         
        if (!Schema.getGlobalDescribe().containsKey(objectName)){
            System.debug('OBJNAME NOT FOUND --.> ' + objectName);
            return null;
         }
        
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
        if (objType==null){
            return objResults;
        }
        NS_BitSet bitSetObj = new NS_BitSet();
        Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();
        //Check if picklist values exist
        if (!objFieldMap.containsKey(controllingField) || !objFieldMap.containsKey(dependentField)){
            System.debug('FIELD NOT FOUND --.> ' + controllingField + ' OR ' + dependentField);
            return objResults;     
        }
        List<Schema.PicklistEntry>  contrEntries = objFieldMap.get(controllingField).getDescribe().getPicklistValues();
        List<Schema.PicklistEntry> depEntries = objFieldMap.get(dependentField).getDescribe().getPicklistValues();
        List<Integer> controllingIndexes = new List<Integer>();                                                          	
        if(controllerLabelName==null) {
            
            objFieldMap = null;
            for(Integer contrIndex=0; contrIndex<contrEntries.size(); contrIndex++){            
                Schema.PicklistEntry ctrlentry = contrEntries[contrIndex];
                String label = ctrlentry.getLabel();
                objResults.put(label,new List<String>());
                controllingIndexes.add(contrIndex);
            }
        }
        else {
        	objResults.put(controllerLabelName,new List<String>());
            controllingIndexes.add(0);                                                             
        }
        List<Schema.PicklistEntry> objEntries = new List<Schema.PicklistEntry>();
        List<NS_PicklistEntryWrapper> objJsonEntries = new List<NS_PicklistEntryWrapper>();
        for(Integer dependentIndex=0; dependentIndex<depEntries.size(); dependentIndex++){            
               Schema.PicklistEntry depentry = depEntries[dependentIndex];
               objEntries.add(depentry);
        } 
        objJsonEntries = (List<NS_PicklistEntryWrapper>)JSON.deserialize(JSON.serialize(objEntries), List<NS_PicklistEntryWrapper>.class);
        List<Integer> indexes;
        for (NS_PicklistEntryWrapper objJson : objJsonEntries){
            if (objJson.validFor==null || objJson.validFor==''){
                continue;
            }
            try {
            //objJson.validFor = objJson.validFor.replace('+', '');
            indexes = bitSetObj.testBits(objJson.validFor,controllingIndexes);
            for (Integer idx : indexes){                
                String contrLabel = (controllerLabelName!=null ? controllerLabelName : contrEntries[idx].getLabel());
                objResults.get(contrLabel).add(objJson.label);
            }
            }
            catch(Exception e) {
              	//objResults.get('A321').add('CFM56');
                continue;
            }
        }
        objEntries = null;
        objJsonEntries = null;
        return objResults;
    }
     
}