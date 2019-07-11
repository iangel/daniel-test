/*@author: Accenture
@Description:This class conatins  case and task creation functionalities.Purpose of this class is to segregate the business rules from the dialoug layer
@Version: 1.0
@Developer id: arjun.c.ghosh@accenture.com
@Date: 04-15-2018
*/
public without sharing class NS_CreateQuickCaseUtil {
    /*Class Name*/
    public static final String CLASS_NAME='NS_CreateQuickCaseUtil';
    /*Method Name*/	
    public static final String CREATE_CASE='createCase';
    /*Method Name*/
    public static final String GET_RECORD_TYPE_ID='getRecordTypeIdfromDb';
    /*Method Name*/
    public static final String GET_FOCUS='getFocus';
    /*Method Name*/
    public static final String GET_STATUS='getStatus';
    /*Method Name*/
    public static final String GET_PRIORITY='getPriority';
    /*Method Name*/
    public static final String GET_ORIGIN='getOrigin';
    /*Method Name*/
    public static final String GET_INTERACTION_REASON_MAPPINGS='getInteractionReasonMappings';
    /*Method Name*/
    public static final String GET_RECORD_META_DATUM='getRecordMetaDatum';
    /*Method Name*/
    public static final String CREATE_TASK_FOR_CASE='createTaskforCase';
    /*Method Name*/
    public static final String NEW_VALUE ='NS_NEW';
    /*RECORDTYPE NAME*/
    public static final String RECORDTYPE_SERVICEREQUEST='Service Requests';
    /*Create case*/
    /*Brief description :  Changes are being implemented Case Creation Form: Remove “Status” field and add “Origin”	
*Defect no./wa/request no: WA#744
*Developer Name : Moumita Sarangi
*Date :17/01/2019*/
    /*public static List<String>  createCase(String callReason,String callCategory,String status,
String priority,String subject,String description, String contactid, 
String accountid, String onBehalfOfId,String caseType){*/
    public static List<String>  createCase(String callReason,String callCategory,
                                           String origin,String subject,String description, String contactid, 
                                           String accountid, String onBehalfOfId,String caseType,String afterhrs)
    {
             
    List<String> accountNCaseIds=new List<String>();
        
   try{
                                                      
       Case caseObj = new Case(Subject=subject);
       
       /********status assignment********/
       if(caseType != null){
       String ConcatReasonType_Status = callReason + caseType;
       caseObj.Status = getStatus(ConcatReasonType_Status);
       }
       else{
          String ConcatReasonType_Status = callReason;
       caseObj.Status = getStatus(ConcatReasonType_Status);
       }
       
       /********Priority assignment********/
        if(caseType != null){
       String ConcatReasonType_Priority = callReason + caseType;
       caseObj.Priority = getPriority(ConcatReasonType_Priority);
       }
       else{
          String ConcatReasonType_Priority = callReason;
       	  caseObj.Priority = getPriority(ConcatReasonType_Priority);
       }
       
       /********assigned to assignment********/
       caseObj.NS_AssignedTo__c=userInfo.getUserId();
       
       /********account assignment********/
       if(!String.isEmpty(accountid) ){
           caseObj.accountid=accountid;
       }
       
       /********on behalf assignment********/
       if(!String.isEmpty(onBehalfOfId) ){
           caseObj.NS_Contacting_on_Behalf_of__c = onBehalfOfId;
       }
       
       /********other assignment********/
       caseObj.NS_Created_using_Quick_Case__c=true;    
       caseObj.ContactId=contactid;        
       caseObj.NS_InteractionCategory__c=callCategory;
       caseObj.NS_InteractionReason__c=callReason;
       caseObj.Description=description;
       if('true'.equalsignorecase(afterhrs))
       {
           caseObj.NS_Off_Hours_CheckBox__c = TRUE;
       }
       else{
           caseObj.NS_Off_Hours_CheckBox__c = FALSE;
       }
       
       if(!String.isBlank(caseType) && (!'--- None ---'.equalsIgnoreCase(caseType))){
           
           caseObj.NS_Type__c=caseType;
       }
       
       /********origin assignment for caller selection page case ********/
       String uniqueId=UserInfo.getUserId()+contactid;
       Case_Origin__c rec = Case_Origin__c.getValues(uniqueId);
       if(rec!=null){   
           caseObj.Origin = NS_StaticVariablesUtility.CASE_ORIGIN_PHONE;             
           Database.delete(rec);
           
       }
       
       /********end of origin assignment for caller selection page case********/
       else if(origin!=null && String.isNotEmpty(origin)  && !NEW_VALUE.equalsIgnoreCase(origin)){
           caseObj.Origin=origin; 
       }
       else
       {
           caseObj.Origin = NS_StaticVariablesUtility.CASE_ORIGIN_MANUAL;  
       }
       System.debug('Case Object: '+caseObj);
       Database.SaveResult srList = Database.insert(caseObj);
       if(srList.isSuccess()){
           createTaskforCase(caseObj);
           List<Case> savedCase = [ SELECT CaseNumber FROM Case WHERE Id =:caseObj.Id  limit 1];
           accountNCaseIds.add(String.valueOf(savedCase[0].CaseNumber));             
           accountNCaseIds.add(String.valueOf(caseObj.Id));
           
       }
   }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, CREATE_CASE);
            accountNCaseIds.add(exp.getMessage());
        }
        return accountNCaseIds;
    }
    
    public static String getRecordTypeIdfromDb(String recTypeName){             
        Id recTypeId =null;
        try{
            recTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(recTypeName).getRecordTypeId();  
        }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, GET_RECORD_TYPE_ID);
        }
        return recTypeId;
    }
    /*Get Focus*/
    public static String getFocus(String interactionReason){
        String result=null;
        try{
            Map<String,List<Map<String,String>>> callReasonSettings=getInteractionReasonMappings();
            Map<String,String> data=getRecordMetaDatum(callReasonSettings,interactionReason);
            result=data.get(NS_StaticVariablesUtility.FOCUS);
        }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, GET_FOCUS);
        }
        return result;
    }
    /*Get Status*/
    public static String getStatus(String interactionReason){
        String result=null;
        try{
            Map<String,List<Map<String,String>>> callReasonSettings=getInteractionReasonMappings();
            Map<String,String> data=getRecordMetaDatum(callReasonSettings,interactionReason);
            result=data.get(NS_StaticVariablesUtility.STATUS);
        }catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, GET_STATUS);
        }
        return result;
    }
    /*Get Priority*/
    public static String getPriority(String interactionReason){
        String result=null;
        try{
            Map<String,List<Map<String,String>>> callReasonSettings=getInteractionReasonMappings();
            Map<String,String> data=getRecordMetaDatum(callReasonSettings,interactionReason);
            result=data.get(NS_StaticVariablesUtility.PRIORITY);
        }catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, GET_PRIORITY);
        }
        return result;
    }
    /*getOrigin*/
    public static String getOrigin(String interactionReason){
        String result=null;
        try{
            Map<String,List<Map<String,String>>> callReasonSettings=getInteractionReasonMappings();
            Map<String,String> data=getRecordMetaDatum(callReasonSettings,interactionReason);
            result=data.get(NS_StaticVariablesUtility.ORIGIN);
        }catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, GET_ORIGIN);
        }
        return result;
    }
    /*Create interaction reason Mappings*/
    public static Map<String,List<Map<String,String>>> getInteractionReasonMappings(){
        Map<String,List<Map<String,String>>> caseReasonMapping = new Map<String,List<Map<String,String>>>();
        try{
            for(NS_CaseSetting__mdt rec: [SELECT Label,Interaction_Type__c,NS_DefaultStatus__c, Focus_On__c,NS_Priority__c 
                                          FROM NS_CaseSetting__mdt limit 250])
            { 
                List <Map<String,String>> assocValues=new List<Map<String,String>>();
                Map<String,String> meta=new Map<String,String>();
                String CaseLabelType;
                
                String status = String.valueOf(rec.NS_DefaultStatus__c);
                String focus = String.valueOf(rec.Focus_On__c);
                String Priority = String.valueOf(rec.NS_Priority__c);
                meta.put(NS_StaticVariablesUtility.FOCUS,focus);
                meta.put(NS_StaticVariablesUtility.STATUS, status); 
                meta.put(NS_StaticVariablesUtility.PRIORITY,Priority);
                assocValues.add(meta);
                
                if(rec.Interaction_Type__c != null){                                                              
                    CaseLabelType =  rec.Label+rec.Interaction_Type__c;
                }
                else{
                    CaseLabelType =   rec.Label;                                                              
                }
                caseReasonMapping.put(CaseLabelType,assocValues);
                
            }
            
        }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, GET_INTERACTION_REASON_MAPPINGS);
        }
        return caseReasonMapping;
    }
    /*Returns the interaction mapping for a specific interaction reason*/
    public static Map<String,String>  getRecordMetaDatum(Map<String,List<Map<String,String>>> interactionReasonMappings,String reasonOfCall)
    {
        Map<String,String> metadatum=null;
        try{
            if(interactionReasonMappings.size()>0 && interactionReasonMappings.containskey(reasonOfCall)){
                List<Map<String,String>> result=interactionReasonMappings.get(reasonOfCall);
                metadatum=result[0];
            }
        }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, GET_RECORD_META_DATUM);
        }
        return metadatum;
    }
    /*Creates Task for all the cases*/
    public static void createTaskforCase(Case caseObj){
        Task tsk = new Task();
        try{ 
            Id taskRecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =: NS_StaticVariablesUtility.tskRecordType 
                                   AND SobjectType =:NS_StaticVariablesUtility.tskObj Limit 1].id;
            tsk.RecordTypeId=taskRecordTypeId;
            tsk.WhoId=caseObj.ContactId;
            tsk.WhatId=caseObj.id;            
            tsk.Subject = caseObj.Subject;        
            tsk.TaskSubtype =NS_StaticVariablesUtility.CALL;
            tsk.CallType=NS_StaticVariablesUtility.INBOUND;
            tsk.Status=NS_StaticVariablesUtility.NS_COMPLETED;
            tsk.OwnerId=UserInfo.getUserId(); 
            tsk.ActivityDate=Date.today();
            tsk.Description=caseObj.Description;
            tsk.NS_Flag__c=true;  
            //tsk.NS_CallReasonCategory__c= caseObj.NS_InteractionCategory__c;    
            //tsk.NS_CallReason__c=caseObj.NS_InteractionReason__c;
            Database.insert(tsk) ;
        }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, CREATE_TASK_FOR_CASE);
        } 
    }
    public static  Map<String,String> createServiceRequest(String srContactId,String OwnerQId,String srSubject, 
                                                           String trainId,String equipment,
                                                           String srDescription,Id AccId, String onBehalfOfId)
    {
        Map<String,String>  resultSet= new  Map<String,String>();
        resultSet.put('isCasecreated', 'false');
        resultset.put('caseId','');
        resultset.put('caseNumber','');
        Case serviceRequest = new Case(Subject=srSubject); 
        serviceRequest.RecordTypeId=getRecordTypeIdfromDb('Service Requests'); 
        serviceRequest.OwnerId=OwnerQId;//'00G0v0000010kPGEAY';//
        serviceRequest.AccountId = AccId;
        serviceRequest.ContactId=srContactId;
        serviceRequest.NS_TrainID__c=trainId;
        serviceRequest.Origin='Marketing';
        serviceRequest.NS_Equipment__c=equipment;
        serviceRequest.Description=srDescription;
        if(!String.isEmpty(onBehalfOfId) ){
            serviceRequest.NS_Contacting_on_Behalf_of__c = onBehalfOfId;
        }
        Database.SaveResult srList = Database.insert(serviceRequest);
        if(srList.isSuccess()){
            List<Case> savedCase = [ SELECT CaseNumber FROM Case WHERE Id =:serviceRequest.Id  limit 1];
            resultSet.put('isCasecreated','true');
            resultSet.put('caseId',serviceRequest.id);
            resultset.put('caseNumber',String.valueOf(savedCase[0].CaseNumber));
        }   
        return resultSet;
    }
    
}