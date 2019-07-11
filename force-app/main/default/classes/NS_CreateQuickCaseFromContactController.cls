/*@author: Accenture
  @Description:This class contains  case and task creation functionalities.Purpose of this class is to segregate the business rules from the dialoug layer
  @Version: 1.0
  @Date: 04-15-2018
*/
public without sharing class NS_CreateQuickCaseFromContactController {

  /*Other Constants*/   
    public static final String CONTACT_ID ='contactId';
    /*Other Constants*/
    public static final String CALL_REASON='reason';
    /*Other Constants*/
    public static final String CALL_CATEGORY='category';
    /*Other Constants*/
    public static final String DESCRIPTION='description';
    /*Other Constants*/
    public static final String STATUS='status';
    /*Other Constants*/
    public static final String PRIORITY='priority';
    /*Other Constants*/
    public static final String SUBJECT='subject';
    /*Other Constants*/
    public static final String  CONTACTID='contactid';
    /*Class Name*/
    public static final String CLASS_NAME='NS_CreateQuickCaseFromContactController';
    /*Method Name*/
    public static final String PRFM_BG_INFO='performBackgroundActions';
    /*Method Name*/
    public static final String GET_CONTACT='getContact';
    /*Method Name*/
    public static final String GET_DEPENDENTOPTIONS_IMPL='getDependentOptionsImpl';
    /*Method Name*/
    public static final String  ACCOUNTID='accountid';
    
    /*Get values for dependent Picklist */   
    @AuraEnabled  
    public static Map<String,List<String>> getDependentOptionsImpl
            (string objApiName,string contrfieldApiName,string depfieldApiName){
        String objectName = objApiName;
        String controllingField = contrfieldApiName;
        String dependentField = depfieldApiName;
        Map<String,List<String>> objResults = new Map<String,List<String>>();
        try{
        /*Get the string to sobject global map*/
        Map<String,Schema.SObjectType> objGlobalMap = Schema.getGlobalDescribe();
        
        if (!Schema.getGlobalDescribe().containsKey(objectName)){
           
            return null;
        }
        
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
        if (objType==null){
            return objResults;
        }
        NS_BitSet bitSetObj = new NS_BitSet();
        Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();
        /*Check if picklist values exist*/
        if (!objFieldMap.containsKey(controllingField) || !objFieldMap.containsKey(dependentField)){
           
            return objResults;     
        }
        
        List<Schema.PicklistEntry> contrEntries = objFieldMap.get(controllingField).getDescribe().getPicklistValues();
        List<Schema.PicklistEntry> depEntries = objFieldMap.get(dependentField).getDescribe().getPicklistValues();
        objFieldMap = null;
        List<Integer> controllingIndexes = new List<Integer>();
        for(Integer contrIndex=0; contrIndex<contrEntries.size(); contrIndex++){            
            Schema.PicklistEntry ctrlentry = contrEntries[contrIndex];
            String label = ctrlentry.getLabel();
            objResults.put(label,new List<String>());
            controllingIndexes.add(contrIndex);
        }
        List<Schema.PicklistEntry> objEntries = new List<Schema.PicklistEntry>();
        List<NS_PicklistEntryWrapper> objJsonEntries = new List<NS_PicklistEntryWrapper>();
        for(Integer dependentIndex=0; dependentIndex<depEntries.size(); dependentIndex++){            
            Schema.PicklistEntry depentry = depEntries[dependentIndex];
            objEntries.add(depentry);
        } 
        objJsonEntries = (List<NS_PicklistEntryWrapper>)JSON.deserialize
                    (JSON.serialize(objEntries), List<NS_PicklistEntryWrapper>.class);
        List<Integer> indexes;
        for (NS_PicklistEntryWrapper objJson : objJsonEntries){
            if (objJson.validFor==null || objJson.validFor==''){
                continue;
            }
           
            indexes = bitSetObj.testBits(objJson.validFor,controllingIndexes);
          
            for (Integer idx : indexes){                
                String contrLabel = contrEntries[idx].getLabel();
                objResults.get(contrLabel).add(objJson.label);
            }
        }
        objEntries = null;
        objJsonEntries = null;
    }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, GET_DEPENDENTOPTIONS_IMPL);
       }
        
        return objResults;
    }
    /*Perform Background Actions*/
    @AuraEnabled
    public static List<String> performBackgroundActions(Map<String,String> myMap) {
        List<String> resultSet= new List<String>();
        try{
        String callReason = myMap.get(CALL_REASON).trim();
        String callCategory = myMap.get(CALL_CATEGORY);
        String description = myMap.get(DESCRIPTION);
        String status = myMap.get(STATUS);
        String priority = myMap.get(PRIORITY);
        String subject = myMap.get(SUBJECT);
        String contactid = myMap.get(CONTACTID);
        String accountid = myMap.get(ACCOUNTID);
        String focus=NS_CreateQuickCaseUtil.getFocus(callReason);
            
            String caseType='';
            
            
        resultSet=NS_CreateQuickCaseUtil.createCase(callReason,callCategory,status,priority,
        											subject,description,contactid,accountid,NS_StaticVariablesUtility.Blank,caseType);
        resultSet.add(focus);
        resultSet.add([SELECT AccountId FROM Contact WHERE Id =: contactid LIMIT 1].AccountId );            
        }
        catch (Exception exp) {
             NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, PRFM_BG_INFO);
        }
        
        return resultSet;
    }
   /*Get the id of contact selected in multimatch page*/
    @AuraEnabled
    public static void removeContact() {
        ManageContactAndUserIds__c rec=null;
        try{
       
        rec= ManageContactAndUserIds__c.getValues(UserInfo.getUserId());    
            if(rec!=null){    
    
             
               Database.delete(rec);
            }
        }
         catch (Exception exp) {
             NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, GET_CONTACT);
        }
     
    }
    
    
    
    
}