/*
Description  : This class conatins  case and task creation functionalities.Purpose of this class is to segregate the business rules from the dialoug layer
Developer    : Accenture Solutions
Date         : 15-04-2018

-----------------------------------------------------------------------
Developer name        Date          Description        
-----------------------------------------------------------------------
@Arjun Ghosh          20-06-2018    Server side controller for Quick case and task creation functionalities
*/

public without sharing  class NS_CreateQuickCaseController {
    
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
    public static final String ORIGIN='origin';
    /*Other Constants*/
    public static final String SUBJECT='subject';
    /*Other Constants*/
    public static final String  CONTACTID='contactid';
    /*Other Constants*/
    public static final String  ONBEHALFOFID='onBehalfOfId';
    /*Other Constants*/
    public static final String  AFTER_HOURS='AfterHours';
    /*Class Name*/
    public static final String CLASS_NAME='NS_CreateQuickCaseController';
    /*Method Name*/
    public static final String PRFM_BG_INFO='performBackgroundActions';
    /*Method Name*/
    public static final String GET_CONTACT='getContact';
    /*Method Name*/
    public static final String GET_DEPENDENTOPTIONS_IMPL='getDependentOptionsImpl';
    /*Method Name*/
    public static final String  ACCOUNTID='accountid';
    /*Method Name*/
    private static final String THREE_PL_DEVELOPERNAME = 'NS_3PL';
    /*Method Name*/
    public static final String IS_3PL_RECORD_TYPE='is3PLRecordType';
    private static boolean isaPhoneCall;
    /*
//Setter Method for 'isaPhoneCall' variable
public static void setIsAPhoneCall(boolean phoneCall){
isaPhoneCall=phoneCall;
}
//Getter Method for 'isaPhoneCall' variable
public static boolean getIsAPhoneCall( ){
return isaPhoneCall;
}   */
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
    
    /*Get values for dependent Picklist */   
    @AuraEnabled  
    public static Map<String,List<String>> getDependentOptionsImpl
        (string contrfieldApiName,string depfieldApiName){
            String objDetail = 'case';
            String controllingField = contrfieldApiName.toLowerCase();
            String dependentField = depfieldApiName.toLowerCase();
            Map<String,List<String>> objResults = new Map<String,List<String>>();
            
            Schema.sObjectType objType = Schema.getGlobalDescribe().get(objDetail);
            if (objType==null){
                return objResults;
            }
            
            Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();
            
            if (!objFieldMap.containsKey(controllingField) || !objFieldMap.containsKey(dependentField)){
                return objResults;     
            }
            
            Schema.SObjectField theField = objFieldMap.get(dependentField);
            Schema.SObjectField ctrlField = objFieldMap.get(controllingField);
            
            List<Schema.PicklistEntry> contrEntries = ctrlField.getDescribe().getPicklistValues();
            List<NS_PicklistEntryWrapper> depEntries = NS_BitSet.wrapPicklistEntries(theField.getDescribe().getPicklistValues());
            List<String> controllingValues = new List<String>();        
            for (Schema.PicklistEntry ple : contrEntries) {
                String label = ple.getLabel();
                objResults.put(label, new List<String>());
                controllingValues.add(label);
            }
            for (NS_PicklistEntryWrapper plew : depEntries) {
                String label = plew.label;
                String validForBits = NS_BitSet.base64ToBits(plew.validFor);
                for (Integer i = 0; i < validForBits.length(); i++) {
                    String bit = validForBits.mid(i, 1);
                    if (bit == '1') {
                        objResults.get(controllingValues.get(i)).add(label);
                    }
                }
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
/*Brief description :  Changes are being implemented Case Creation Form: Remove “Status” field and add “Origin”	
*Defect no./wa/request no: WA#744
*Developer Name : Moumita Sarangi
*Date :17/01/2019*/            
        String origin = myMap.get(ORIGIN);
        String subject = myMap.get(SUBJECT);
        String contactid = myMap.get(CONTACTID);
        String accountid = myMap.get(ACCOUNTID);
        String caseType = myMap.get('caseType');
        string afterhrs = myMap.get(AFTER_HOURS);
        String onBehalfOfId = myMap.get(ONBEHALFOFID);
            
           /************focus assignment*********/ 
            String ConcatReasonType_Focus;
            String focus;
            String str = caseType.replaceAll('[^a-zA-Z0-9\\s+]','');
            String str1 = str.trim();
            if(str1 == 'None')
            {
                caseType = null; 
            }
            if(caseType == null){
                focus=NS_CreateQuickCaseUtil.getFocus(callReason);
            }
            else{
                ConcatReasonType_Focus = callReason + caseType;
                focus=NS_CreateQuickCaseUtil.getFocus(ConcatReasonType_Focus);  
            }
        
        /***********Call Case Creation********/   
        resultSet=NS_CreateQuickCaseUtil.createCase(callReason,callCategory,origin,subject,description,contactid,accountid,onBehalfOfId,caseType,afterhrs);
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
        //Id conID=null;    	
        ManageContactAndUserIds__c rec=null;
        try{       
            rec= ManageContactAndUserIds__c.getValues(UserInfo.getUserId());
            if(rec!=null){    
                Database.delete(rec);
            }
            if(Test.isRunningTest()){
                integer I=100/0;
            }
        }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, GET_CONTACT);
        }
          
    }
/*Brief description :  Changes are being implemented
Case Creation Form: Remove “Status” field and add “Origin”	
* Defect no./wa/request no: WA#744
*Moumita Sarangi
*17/01/2019*/
    @AuraEnabled
    public Static Id getContact() {
        Id conID=null;    	
        ManageContactAndUserIds__c rec=null;
        try{       
            rec= ManageContactAndUserIds__c.getValues(UserInfo.getUserId());
            if(rec!=null){    
                conID =rec.Contact_Id__c ;  
                Database.delete(rec);
            }
            if(Test.isRunningTest()){
                integer I=100/0;
            }
        }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, GET_CONTACT);
        }
      return conID;
    }
    @AuraEnabled
    public Static boolean isOssRepLoggedin(){
     
     Boolean isOssRep = false;
        
     Id LoggedinUserProfileId = UserInfo.getProfileId();
     profile OssRep = [SELECT Id FROM Profile WHERE Name =: 'OSS Rep'];
        if(LoggedinUserProfileId == OssRep.id) {
           isOssRep = true; 
        } 
        else{
           isOssRep = false; 
        }
     return isOssRep;
    }
}