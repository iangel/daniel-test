public class NS_ShowExternalDataController{
    public Static Map<String,List<String>> EquipmentDataMap = new Map<String,List<String>>();
    Final Static String SpecialInstructionDescription = 'SpecialInstructionDescription';
    Final Static String SummaryBullets = 'SummaryBullets';
    Final Static String UserId=[Select FederationIdentifier from user where ID = :UserInfo.getUserId()].FederationIdentifier;
    Static String classCode;
    Static String stationCode;
    Static String stationClassCode;
    Static String servingRoad;
    Static String nsAcctNum; 
    
    /*Class Name*/
    private static final String CLASS_NAME = 'NS_ShowExternalDataController';
    
    /*Method Name for Exception Handling*/ 
    private static final String METHOD_NAME='getAccount';
    private static final String METHOD_NAME1='GetCrewData';
    private static final String METHOD_NAME2='GetLOPAData';
    private static final String METHOD_NAME3='invokeTYESGetCustomerSummary';
    private static final String METHOD_NAME4='invokeTransitExceptionCount';
    private static final String METHOD_NAME5='invokeTransitExceptionDetail';
    private static final String METHOD_NAME6='getStationClassCode';
    private static final String METHOD_NAME7='getCarRequestServiceData';
    private static final String METHOD_NAME8='getAemsUrl';
    private static final String METHOD_NAME9='getShipmentStatus';
    private static final String METHOD_NAME10='getTrainSetEnquiry';    
    private static final String METHOD_NAME11='getTeamsUrl';    

    /*Get Account*/
     public static void getParamCallouts(String accId){
        Integer count =limits.getLimitQueryRows();
        try{
            Account acc = [Select Id,NS_ClassCode__c, NS_OperatingStation__r.NS_OperatingStationCode__c ,NS_ServingRoad__c, AccountNumber
                           from Account 
                           where Id =:accId LIMIT:count];
            classCode = acc.NS_ClassCode__c;
            stationCode = acc.NS_OperatingStation__r.NS_OperatingStationCode__c;
            servingRoad= acc.NS_ServingRoad__c;
            System.debug('Classcode:'+classCode);
            System.debug('stationCode:'+stationCode);
            System.debug('Service Road:'+servingRoad);
          
           nsAcctNum =acc.AccountNumber;
        }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME);
        }
    }


    /* ================================================
* @Method Name : hideSummarypage
* @author id: arjun.c.ghosh@accenture.com
* @Purpose: This method is used to hide the summary page if it is not service online account 
* @Parameters: String accId
* @return: boolean
==================================================*/
    @AuraEnabled
    public static String hideSummarypage(String accId){
        String ret='NA';
        List<Account> rec= [Select NS_ServiceAccountType__c
                            from Account 
                            where Id =:accId Limit 1];       
        String res=rec[0].NS_ServiceAccountType__c; 
        ret='Service - Online'; 
        if('Service - Online'.equalsIgnoreCase(res)){
            ret='Service - Online';  
        }
        else if('Service - Offline'.equalsIgnoreCase(res)){
             ret='Service - Offline';  
        }
       return ret;
        
    }

    @AuraEnabled
    /* Crew Data */
    public static List<NS_RouteReportWrapper> GetCrewData(String accId){
        getParamCallouts(accId);
        NS_IntegParams datum= new NS_IntegParams();
        datum.setClassCode(classCode);
        datum.setUserId(userId);
        datum.setStationCode(stationCode);
         NS_WebService tyes= new NS_CrewData();
        List<NS_RouteReportWrapper> rrList = new List<NS_RouteReportWrapper>();
        if(ClassCode != null && StationCode != null){
            try{
                rrList = (List<NS_RouteReportWrapper>)JSON.deserializeStrict(tyes.invokeCallout(datum),
                                                                                   List<NS_RouteReportWrapper>.class);
            }
            catch (Exception exp) {
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME1);
            }
        }
        return rrList;
    }
    
    @AuraEnabled
    /* Lopa Data */
    public static  List<NS_LopaDataWrapper> getLopaData(String accId){       
        getParamCallouts(accId);
        NS_IntegParams datum= new NS_IntegParams();
        datum.setClassCode(classCode);
        datum.setUserId(UserId);
        datum.setStationCode(stationCode);
        NS_WebService tyes= new NS_Lopa();
        List<NS_LopaDataWrapper> lwdList = new List<NS_LopaDataWrapper>();
        if(classCode != null && stationCode != null){
            try{
                NS_LopaDataWrapper c = (NS_LopaDataWrapper)JSON.deserializeStrict(tyes.invokeCallout(datum),
                                                                                  NS_LopaDataWrapper.class);
                lwdList.add(c);
            }
            catch (Exception exp) {
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME2);
            }
        }
        return lwdList;
    }
     @AuraEnabled
    public static boolean checkConditions(String accId){
        getParamCallouts(accId);
        boolean result=false;
        if(String.isBlank(classCode) || classCode==null){
            result=true;
        }
         
      return result;
    }
    
    
    /* invoke getPipeLineData*/
    @AuraEnabled
    public static NS_GCS.GCSWrapper getPipeLineData(String accId){

       
        getParamCallouts(accId);
        NS_IntegParams datum= new NS_IntegParams();
        datum.setUserId(UserId);
        datum.setStationCode(stationCode);
        NS_WebService aems= new NS_PipeLineData();
         NS_GCS.GCSWrapper gcsData = new NS_GCS.GCSWrapper();
         
        if(stationCode != null){
            try{              
                gcsData =(NS_GCS.GCSWrapper)JSON.deserializeStrict(aems.invokeCallout(datum),NS_GCS.GCSWrapper.class);
              // aems.invokeCallout(datum);
            }
            catch (Exception exp) {
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, 'GetAemsPipelineData');
            }
        }else{
            
        }
       
        return gcsData;
    }

    @AuraEnabled
    /* invoke TYES customer summary*/
    public static NS_GCS.GCSWrapper invokeTYESGetCustomerSummary(String accId){
        
         getParamCallouts(accId);
        getParamCallouts(accId);
        NS_IntegParams datum= new NS_IntegParams();
        datum.setClassCode(classCode);
        datum.setUserId(UserId);
        datum.setStationCode(stationCode);
        NS_WebService tyes= new NS_CustomerSummaryData();
        NS_GCS.GCSWrapper gcsData = new NS_GCS.GCSWrapper();
          
        if(ClassCode != null && StationCode != null){
            try{
              
                gcsData =(NS_GCS.GCSWrapper)JSON.deserializeStrict(tyes.invokeCallout(datum),
                                                                                  NS_GCS.GCSWrapper.class);
                
            }
            catch (Exception exp) {
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME3);
            }
        }
        return gcsData;
    }
  
    @AuraEnabled
    /* invoke Transit Exception Count*/
    public static List<NS_TransitExceptionCountWrapper> invokeTransitExceptionCount(String accId){
        NS_WebService tyes= new NS_TransitExp();
        getParamCallouts(accId);
         NS_IntegParams datum= new NS_IntegParams();
        datum.setClassCode(classCode);
        datum.setUserId(UserId);
        datum.setStationCode(stationCode);
        List<NS_TransitExceptionCountWrapper> tECDataList =new List<NS_TransitExceptionCountWrapper>();
            
        if(ClassCode != null && StationCode != null){
            try{
                tECDataList =  (List<NS_TransitExceptionCountWrapper>)JSON.deserializeStrict(tyes.invokeCallout(datum),
                                                                                   List<NS_TransitExceptionCountWrapper>.class);
                tyes.invokeCallout(datum);
            }
            catch (Exception exp) {
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME4);
            }
        }
        return tECDataList;
    }
    
    @AuraEnabled
    /* invoke Transit Exception Detail*/
    public static List<NS_TransitExceptionDetailWrapper> invokeTransitExceptionDetail(String accId, String equipmentInit, String equipmentNr, String waybillSrNr){
     System.debug('Equipment Init:'+equipmentInit);
        NS_WebService tyes= new NS_TransitExceptionDetail();
        getParamCallouts(accId);
        NS_IntegParams datum= new NS_IntegParams();
        datum.setClassCode(classCode);
        datum.setUserId(UserId);
        datum.setStationCode(stationCode);
        datum.setEquipInt(equipmentInit);
        datum.setEquipNr(equipmentNr);
        datum.setWaybillSrNr(waybillSrNr);
        List<NS_TransitExceptionDetailWrapper> TEDDataList = 
            new List<NS_TransitExceptionDetailWrapper>();
        if(classCode != null && stationCode != null){
            try{
                TEDDataList =(List<NS_TransitExceptionDetailWrapper>)JSON.deserializeStrict(tyes.invokeCallout(datum),
                                                                                   List<NS_TransitExceptionDetailWrapper>.class);
            }
            catch (Exception exp) {
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME5);
            }
        }
        System.debug('Teddata list:'+TEDDataList.size());
        return TEDDataList;
    }
    
    @AuraEnabled
     /* get Station Class Code*/
    public static String getStationClassCode(String accId){ 
        String url;
        try{
            getParamCallouts(accId);
            stationClassCode = ClassCode+'/'+StationCode; 
            NS_Integration_Endpoints__c obj = NS_Integration_Endpoints__c.getValues('Access_NS');
            url=obj.Endpoint_URL__c+stationClassCode;
        }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME6);
        }
        return url;
    }

/* ================================================
* @Method Name : getCarRequestServiceData
* @author id: arjun.c.ghosh@accenture.com
* @Purpose: This method is used as server side controller to make calls to the web service 
* @Parameters: String accId
* @return: Map<String,List<NS_CarRequestWrapper>> 
* @created date: 09-01-2019
==================================================*/
    @AuraEnabled
    public static Map<String,List<NS_CarRequestWrapper>>  getCarRequestService(String accId){
        getParamCallouts(accId); 
        NS_IntegParams datum= new NS_IntegParams();
        datum.setClassCode(classCode);
        datum.setUserId(UserId);
        datum.setStationCode(stationCode);
        datum.setServingRoad(servingRoad);
        NS_WebService teams= new NS_CarRequestSummary();
        Map<String,List<NS_CarRequestWrapper>> mapOfCrList = new Map<String,List<NS_CarRequestWrapper>>();
        if(ClassCode != null && StationCode != null && servingRoad!= null){
            try{                
                mapOfCrList = (Map<String,List<NS_CarRequestWrapper>>)JSON.deserialize(teams.invokeCallout(datum), Map<String,List<NS_CarRequestWrapper>>.class);
                                  
            }
            catch (Exception exp) {
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME7);
            }
        }
        
        return mapOfCrList;
    } 

     /* get URL for AEMS button on Summary tab */    
    @AuraEnabled
    public static String getAemsUrl(String accId){ 
        String url;
        try{
            NS_Integration_Endpoints__c aemsEndpoint = NS_Integration_Endpoints__c.getValues('AEMS_AppButton');
            url=aemsEndpoint.Endpoint_URL__c;
        }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME8);
        }
        return url;
    }    
    
     /* get CTMS Shipment Status report button on Summary tab*/
    @AuraEnabled
    public static String getShipmentStatus(String accId){ 
        String url;
        try{
            getParamCallouts(accId);
            String ctmsShipmentStatusUri = '';
            if (UserId != null) {
                    ctmsShipmentStatusUri = '/' +UserId +'/' +nsAcctNum;
            }
            else {
                ctmsShipmentStatusUri = '/NoFederationIDInProfile/' +nsAcctNum;
            }
            
            NS_Integration_Endpoints__c ctmsEndpoint = NS_Integration_Endpoints__c.getValues('CTMS_ShipmentStatus');
            url=ctmsEndpoint.Endpoint_URL__c +ctmsShipmentStatusUri;
        }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME9);
        }
        return url;
    }
    
     /* get CTMS TrainSet Inquery Report button on Summary tab */
    @AuraEnabled
    public static String getTrainSetEnquiry(String accId){ 
        String url;
        try{
            getParamCallouts(accId);
            String ctmsTrainInqUri = '';
            
            if (UserId != null) {
                    ctmsTrainInqUri = '/' +UserId +'/' +nsAcctNum;
            }
            else {
                ctmsTrainInqUri = '/NoFederationIDInProfile/' +nsAcctNum;
            }
            
            NS_Integration_Endpoints__c ctmsEnpoint = NS_Integration_Endpoints__c.getValues('CTMS_TrainSetInquery');
            url=ctmsEnpoint.Endpoint_URL__c +ctmsTrainInqUri;
        }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME10);
        }
        return url;
    }

    /* get TEAMS app button on Summary tab */
      @AuraEnabled
    public static String getTeamsUrl(String accId){ 
        String url;
        try{
            NS_Integration_Endpoints__c teamsEndpoint = NS_Integration_Endpoints__c.getValues('TEAMS_AppButton');
            url=teamsEndpoint.Endpoint_URL__c;
        }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME11);
        }
        return url;
    }
    
}