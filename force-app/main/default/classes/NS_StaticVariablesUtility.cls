public with sharing class NS_StaticVariablesUtility {
    
    /*----------------------------NS_CreateQuickCaseUtil start-----------------------------------------------*/
    /* PRIORITIES */
    public static final String MEDIUM_PRIORITY ='Medium';
    /*Other Constants*/
    public static final String CONST_TRUE ='true';
    /*Other Constants*/
    public static final String CONST_BLANK ='';
    /*Other Constants*/
    public static final String QUEUE='Queue';
    /*Other Constants*/
    public static final String MANAGERS_EXT='_Managers';
    /*Key for Map meta*/
    public static final String RECORD_TYPE_NAME ='RecordTypeName';
    /*Key for Map meta*/
    public static final String PRIORITY ='Priority';
    /*Key for Map meta*/
    public static final String ORIGIN ='Origin';
    /*Key for Map meta*/
    public static final String ESCALATION ='Escalation';
    /*Key for Map meta*/
    public static final String ASSOCIATE_TASK ='AssociateTask';
    /*Public Group*/
    public static final String TASK_OWNER='NS_Task_Owner';    
    /*Call*/
    public static final String CALL='Call';
    /*Completed*/
    public static final String NS_COMPLETED = 'Completed';
    /*MANUAL*/
    public static final String MANUAL = 'Manual';
    /*Focus*/
    public static final String FOCUS='focus';
    /*Status*/
    public static final String STATUS='status';
     /*Inbound*/
    public static final String INBOUND='Inbound';
    public static final String CASE_ORIGIN_PHONE='Phone';
    public static final String CASE_ORIGIN_MANUAL='Manual';
    public static final String  testvalidFor='AQAAcontrollingIndexes';
    /*----------------------------NS_CreateQuickCaseUtil End-----------------------------------------------*/
   
    //NameSpaces Variables
    public Final Static String tem = 'http://tempuri.org/';
    public Final Static String sigNS = 'http://www.w3.org/2000/09/xmldsig#';
    public Final Static String v1 = 'http://www.nscorp.com/tep/customer/v1.0';
    public Final Static String i = 'http://www.w3.org/2001/XMLSchema-instance';
    public Final Static String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';    
    public Final Static String tyes1 = 'http://schemas.datacontract.org/2004/07/Tyes.Business';
    public Final Static String arr = 'http://schemas.microsoft.com/2003/10/Serialization/Arrays';    
    public Final Static String b = 'http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity'; 
    //public Final Static String tyes = 'http://schemas.datacontract.org/2004/07/Tyes.Web.AccessNS.Service.Entity.Base';
    public Final Static String tyes = 'http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity';
    public Final Static String wsseNS = 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd';   
    public Final Static String tyes2 = 'http://schemas.datacontract.org/2004/07/Tyes.Web.AccessNS.Service.Entity.UserProfile';
    public Final Static String tyes3 = 'http://schemas.datacontract.org/2004/07/Tyes.Web.AccessNS.Service.Entity.CustomerSummary';
    public Final Static String SucessURI = 'http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.CustomerSummary';
    public Final Static String a1 = 'http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.CustomerRouteReport';
    public Final Static String a_LOPA = 'http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.LOPAMetrics';
    public Final Static String s = soapNS;
    public Final Static String Envelope = 'Envelope';
    public Final Static String Header = 'Header';
    public Final Static String Security = 'Security';
    public Final Static String soapenv = 'soapenv';
    public Final Static String wsse = 'wsse';
    public Final Static String Test = 'Test';
    public Final Static String Signature = 'Signature';
    public Final Static String a = tyes3;
    public Final Static String Body = 'Body';
    
    //Http request variables
    public Final Static String postmethod = 'POST';
    public Final Static String getmethod = 'GET';
    public Final Static String contentType = 'text/xml;charset=UTF-8';  
    public Final Static Integer SuccessStatusCode = 200;
    
    //TYES Method Action 
    public Final Static String LOPA_Action = 'http://tempuri.org/ISalesForceDataService/GetLOPAMetricsReport';
    public Final Static String CustomerRouteReport_Action = 'http://tempuri.org/ISalesForceDataService/GetCustomerRouteReport';
    
    //public Final Static String TYES_getCustomerSummary_Action = 'http://tempuri.org/IPacesetterDataService/GetCustomerSummary';
    public Final Static String TYES_getCustomerSummary_Action = 'http://tempuri.org/ISalesForceDataService/GetCustomerSummary';
    public Final Static String TEP_getCustomerInfo_Action = '/Customer.serviceagent/GetCustomerInfo';
    public Final Static String TransitExceptionQueueCountsAction = 'http://tempuri.org/ISalesForceDataService/GetTransitExceptionQueueCounts';
    public Final Static String TransitExceptionQueueDetailAction = 'http://tempuri.org/ISalesForceDataService/GetTransitExceptionQueueDetails';
    
    //ANI Maintenance Action
    public Final Static String OnlineCustomerVDNAction = 'http://tempuri.org/ISalesForceDataService/SetOnlineCustomerVDN';
    public Final Static String VDNMaintenanceAction = 'http://tempuri.org/ISalesForceDataService/VDNMaintenance';
    public Final Static String ManageOfflineCustomerANIAction = 'http://tempuri.org/ISalesForceDataService/ManageOfflineCustomerANI';
    public Final Static String ManageOnlineCustomerContactAction = 'http://tempuri.org/ISalesForceDataService/ManageOnlineCustomerContact';
    
    
    //ANI Maintenance Variables
    public Final Static String InsertActionInd = 'I';
    public Final Static String UpdateActionInd = 'U';
    public Final Static String DeleteActionInd = 'D';
    public Final Static String FALSE_STR = 'false';
    public Final Static String TRUE_STR = 'true';
    public Final Static String Blank = '';
    
    //TYES Endpoints
    public Static String VDN_endpoint = '';//https://qaapi.nscorp.com/External/SalesForce/SalesForceDataService';
    public Static String GCS_endpoint = '';//https://qaapi.nscorp.com/External/SalesForce/SalesForceDataService';
    public Static String LOPA_endpoint = '';//https://qaapi.nscorp.com/External/SalesForce/SalesForceDataService';
    public Static String RouteReport_endpoint = '';//https://qaapi.nscorp.com/External/SalesForce/SalesForceDataService';
    public Static String TransitExceptionReport_endpoint = '';//https://qaapi.nscorp.com/External/SalesForce/SalesForceDataService';
    //TYES Parser Variables
    public Final Static String Schedule = 'Schedule';
    public Final Static String KeyInfo = 'KeyInfo';
    public Final Static String X509Data = 'X509Data';
    public Final Static String Content_Type = 'Content-Type';
    //public Final Static String Application_json = 'application/json';
    public Final Static String SOAPAction = 'SOAPAction';
    public Final Static String RSA_SHA1 = 'RSA-SHA1';
    public Final Static String CRM = system.label.NS_IntegrationCertName;//'crm';
    //Transit Exception variables
    public Final Static String TransitExceptionQueueUri = 'http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.TransitExceptionQueue';
    public Final Static String XMLSchemaInstanceUri = 'http://www.w3.org/2001/XMLSchema-instance';
    //Case Variables
    public Final Static String NS_CASENUMBER= 'Case Number';
    public Final Static String NS_CASE = 'Case';
    public Final Static String NS_CASEQUEUE = 'Queue';
    public Final Static String NS_CLOSED = 'NS_Closed';
    public Final Static String NS_CLSD = 'Closed';
    public Final Static String NS_CANCELLED = 'NS_Cancelled';
    public Final Static String NS_REOPENED ='NS_Reopened'; 
    public Final Static String NS_CANCLD = 'Cancelled';
    public Final Static String NS_NEW = 'NS_New';
    public Final Static String NEW_TXT = 'New';
    public Final Static String NS_ESCALATED = 'NS_Escalated';
    public Final Static String NS_WORKING = 'NS_Working';
    public Final Static String NS_AWAITINGRESPONSE = 'NS_Awaiting Response';
    public Final Static String NS_HIGH = 'High';
    public Final Static String NS_Medium = 'Medium';
    public Final Static String NS_LOW = 'Low';
    public Final Static String NS_EMAILTOCASE = 'Email-to-Case';
    public Final Static String NS_EMAILTOLIBRARY = 'Email2Library';
    public Final Static String NS_NULL = 'null';
    public Final Static String NS_OSS = 'OSS';
    public Final Static String NS_INTERACTIONREASON = 'Cash Hold';
    public Final Static String Delayed = 'Delays';
    public Final Static String Expedite = 'Expedite Request';
    public Final Static String Delay_Expedite = 'Delays';
    public Final Static String NS_INTERACTIONCATEGORY = 'Account/Billing';
    public Final Static String GeneralCase = 'NS_GeneralCase';
    public Final Static String AccountBilling = 'NS_AccountingIssue';
    public Final Static String CashHold = 'NS_Cash_Hold';
    public static Boolean isTriggerExecuted=false;
     public Final Static String ChildCase = 'NS Internal';
    public Final Static String ChildError='All Internal Requests associated to this case must be closed in order to close this case.';
    
    //Gunjari for Req#1269
    public Final Static String NS_Automotive = 'Automotive';
    public Final Static String NS_EquipmentPlanning = 'Equipment Planning';
    public Final Static String NS_UnitTrain = 'Unit Train';
    
    //Email To Case
    public Final Static Integer NS_EmailBodyLimit = 128000;
    public Final Static Integer NS_EmailTextBodyLimit = 30000;   // Max size that can be assigned to Case description
    public Final Static String NS_EmailToCaseRT = 'Email-to-Case';
    public Final Static String NS_Regex = 'Case[ ]*Number[ ]*:[ ]*CS*[0-9]{10}'; //Search for specific pattern in email : "Case Number: case.casenumber"
    //public Final Static String NS_Regex = '\bCase Number: CS[0-9]{10}\b'; //Search for specific pattern in email : "Case Number: case.casenumber"
    public Final Static String NS_Colon = ':';
    public Final Static String NS_Outbound = 'Tracing';
    public Final Static String NS_Email = 'Email';
    public Final Static String NS = 'NS_';
    public Final Static String NS_SemiColon = ';';
    public Final Static String Hyphen = '-';
    public Final Static String Space = ' ';
    public Final Static String TXT = 'txt';
    public Final Static String PDF = 'pdf';
    public Final Static String Dot = '.';
    public Final Static String SystemAdministratorProfile = 'System Administrator';
    public Final Static String NsreadOnly = 'Read Only';
    public Final Static String noreply ='ns_noreplymail@2g7ty1usd7ew64xusjjgpf7fnajj6hblghnr99iyw2qeqflzpt.w-8xxrnmay.cs13.apex.sandbox.salesforce.com';
    
    //Contact Variables
    public static final string conRecordType = 'NS_GeneralContact';
    public static final string conActiveRecordType = 'General Contact';
    public static final string conInactiveRecordType = 'NS_ReadOnlyInactiveContact';
    public static final string inactiveRecordType = 'Read Only Inactive Contact';
    public static final string ANIRecordType = 'ANI ONLY';
    public static final string accRTName = 'Service';
    public static final string accName = 'ACCOUNT NOT LOADED';
    public static final string dummyExternalID = 'NS_DummyAccountNotLoaded';  
    public static final string sObj = 'Contact';
    public static final String integrationUserName = 'NS Integration User';
    public static final String conInactiveStatus = 'Inactive';
    public static final String Active = 'Active';
    public static final String deactivationStatus = 'Request Deactivation';
    public static final String Automotive = 'Automotive';
    public static final String Email12 = 'Test.Auto12@gmail.com';
    public static final String userRoleName ='OSS East Rep' ;
    public static final String userRoleSupportName ='OSS Support' ;
    public static final ID userRole = [SELECT DeveloperName,Id,Name FROM UserRole WHERE Name=: NS_StaticVariablesUtility.userRoleName LIMIT 1].ID;
    public static final ID userRoleSupport = [SELECT DeveloperName,Id,Name FROM UserRole WHERE Name = :  NS_StaticVariablesUtility.userRoleSupportName LIMIT 1].ID;
   
    //NS Partnership Variables
    public static final string partnershipType1 = 'Other Railroad';
    public static final string partnershipType2 = '3PL';
    public static final string ANI_ONLY = 'ANI_ONLY';
    //Task and Event Variables
    public final static string tskRecordType = 'NS_Task';
    public final static string taskRT = 'NS Task';
    public final static string tskObj = 'Task';
    public final static string evtRecordType = 'NS_Event';
    public final static string eventRT= 'NS Event';
    public final static string evtObj = 'Event';
    
    //Custom Setting DataSet Names
    public final static string conTrigger = 'ActiveContactTrigger';
    public final static string tskTrigger = 'ActiveTaskTrigger';
    public final static string evtTrigger = 'ActiveEventTrigger'; 
    public final static string caseTrigger = 'ActiveCaseTrigger';
    public final static string emailMsgTrigger = 'ActiveEmailMessageTrigger';
    public final static string assocTrigger = 'ActiveAssocAccountTrigger';
    public final static string partnershipTrigger = 'ActiveNSPartnershipTrigger';
    public final static string dummyAccount = 'Dummy Account';
    
    //Test Factory Constants
    public final static string NAME = 'Name';
    public final static string readAccess = 'Read';
    public final static string editAccess = 'Edit';
    public final static string rowCause = 'Manual';
    public final static string UserSupport = 'OSS Support';
    public final static string UserRep = 'OSS Rep';
    //Gunjari
    public final static string UserMarketing = 'NS Marketing Manager';
   
    //GetCustomerSummary Reponse Parser variable
    public Final Static String GetCustomerSummaryResponse = 'GetCustomerSummaryResponse';
    public Final Static String GetCustomerSummaryResult = 'GetCustomerSummaryResult';
    public Final Static String Success = 'Success';
    public Final Static String EquipmentSummary = 'EquipmentSummary';
    public Final Static String SpecialInstructions = 'SpecialInstructions';
    public Final Static String SpecialInstructionDisplay = 'SpecialInstructionDisplay';
    public Final Static String SpecialInstructionDescription = 'SpecialInstructionDescription';
    public Final Static String SummaryBullets = 'SummaryBullets';
    
    //Transit Exception response Parser variable
    public Final Static String GetTransitExceptionQueueCountsResponse = 'GetTransitExceptionQueueCountsResponse';
    public Final Static String GetTransitExceptionQueueCountsResult = 'GetTransitExceptionQueueCountsResult';
    public Final Static String TransitExceptionQueueCounts = 'TransitExceptionQueueCounts';
    public Final Static String GetTransitExceptionQueueDetailsResponse = 'GetTransitExceptionQueueDetailsResponse';
    public Final Static String GetTransitExceptionQueueDetailsResult = 'GetTransitExceptionQueueDetailsResult';
    public Final Static String TansitExceptionQueueDetails = 'TansitExceptionQueueDetails';
    
    //LOPA response Parser variable
    public Final Static String NonCompliantCustomerRSN = 'NonCompliantCustomerRSN';
    public Final Static String NonCompliantMechRSN = 'NonCompliantMechRSN';
    public Final Static String NonCompliantRRRSN = 'NonCompliantRRRSN';
    public Final Static String PercentFailureCustRsn = 'PercentFailureCustRsn';
    public Final Static String PercentFailureMechRsn = 'PercentFailureMechRsn';
    public Final Static String PercentFailureRRRsn = 'PercentFailureRRRsn';
    public Final Static String PercentTotalFailure = 'PercentTotalFailure';
    public Final Static String TotalPending = 'TotalPending';
    public Final Static String TotalPlanned = 'TotalPlanned';
    public Final Static String GetLOPAMetricsReportResponse = 'GetLOPAMetricsReportResponse';
    public Final Static String GetLOPAMetricsReportResult = 'GetLOPAMetricsReportResult';
    public Final Static String Code = 'Code';
    
    //Route Report response Parser variable
    public Final Static String GetCustomerRouteReportResponse = 'GetCustomerRouteReportResponse';
    public Final Static String GetCustomerRouteReportResult = 'GetCustomerRouteReportResult';
    public Final Static String CustomerRouteReportRecords = 'CustomerRouteReportRecords';
    public Final Static String CustomerRouteReportRecord = 'CustomerRouteReportRecord';
    public Final Static String RouteID = 'RouteID';
    public Final Static String Stn = 'Stn';
    public Final Static String StnName = 'StnName';
    public Final Static String MondayInd = 'MondayInd';
    public Final Static String TuesdayInd = 'TuesdayInd';
    public Final Static String WednesdayInd = 'WednesdayInd';
    public Final Static String ThursdayInd = 'ThursdayInd';
    public Final Static String FridayInd = 'FridayInd';
    public Final Static String SaturdayInd = 'SaturdayInd'; 
    //public Final Static String SaturdayInd = 'StaturdayInd'; // 5.23, JL, TYES response has a typo, report this to Dan
    public Final Static String SundayInd = 'SundayInd';    
    public static final String Tyes_Status = 'Status';
    
    static {
        Map<String,NS_Integration_Endpoints__c> endpoints = NS_Integration_Endpoints__c.getAll();
        if(endpoints.containsKey('VDN_endpoint')){
            VDN_endpoint = endpoints.get('VDN_endpoint').Endpoint_URL__c;
        }
        if(endpoints.containsKey('GCS_endpoint')){
            GCS_endpoint = endpoints.get('GCS_endpoint').Endpoint_URL__c;
        }
        if(endpoints.containsKey('LOPA_endpoint')){
            LOPA_endpoint = endpoints.get('LOPA_endpoint').Endpoint_URL__c;
        }
        if(endpoints.containsKey('RouteReport_endpoint')){
            RouteReport_endpoint = endpoints.get('RouteReport_endpoint').Endpoint_URL__c;
        }
        if(endpoints.containsKey('TransitExceptionReport_endpoint')){
            TransitExceptionReport_endpoint = endpoints.get('TransitExceptionReport_endpoint').Endpoint_URL__c;
        } 
    }
    
    public static String resetUserIdOnNull(String uId){
        if(uId == null || uId == ''){
            uId = 'SFDC1';    
        } 
        return uId;
    }
    
    public static String ManageOnlineCustomerContact(String uId, List<ManageOnlineCustomerContactWrapper> CustomerContactWrapperList){
        String body = '<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:tyes="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity" xmlns:tyes1="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.CustomerContact">';
        body += '<tem:ManageOnlineCustomerContact>';
        body += '<tem:request>';
        body += '<tyes:UserId>'+resetUserIdOnNull(uId)+'</tyes:UserId>';
        body += '<tyes1:Requests>';
        for(ManageOnlineCustomerContactWrapper mccw : CustomerContactWrapperList){
            body += '<tyes1:CustomerContactRequest>';
            body += '<tyes1:Action_Ind>'+mccw.Action_Ind+'</tyes1:Action_Ind>';
            body += '<tyes1:ClassCode>'+mccw.ClassCode+'</tyes1:ClassCode>';
            body += '<tyes1:Comment>'+mccw.Comment+'</tyes1:Comment>';
            body += '<tyes1:Commodity>'+mccw.Commodity+'</tyes1:Commodity>';
            body += '<tyes1:New_Cell_Phone>'+mccw.New_Cell_Phone+'</tyes1:New_Cell_Phone>';
            body += '<tyes1:New_Email>'+mccw.New_Email+'</tyes1:New_Email>';
            body += '<tyes1:New_Fax>'+mccw.New_Fax+'</tyes1:New_Fax>';
            body += '<tyes1:New_First_Name>'+mccw.New_First_Name+'</tyes1:New_First_Name>';
            body += '<tyes1:New_Last_Name>'+mccw.New_Last_Name+'</tyes1:New_Last_Name>';
            body += '<tyes1:New_Mid_Name>'+mccw.New_Mid_Name+'</tyes1:New_Mid_Name>';
            body += '<tyes1:New_Phone_1>'+mccw.New_Phone_1+'</tyes1:New_Phone_1>';
            body += '<tyes1:New_Phone_1_Ext>'+mccw.New_Phone_1_Ext+'</tyes1:New_Phone_1_Ext>';
            body += '<tyes1:New_Phone_2>'+mccw.New_Phone_2+'</tyes1:New_Phone_2>';
            body += '<tyes1:New_Phone_2_Ext>'+mccw.New_Phone_2_Ext+'</tyes1:New_Phone_2_Ext>';
            body += '<tyes1:New_Phone_3>'+mccw.New_Phone_3+'</tyes1:New_Phone_3>';
            body += '<tyes1:New_Phone_3_Ext>'+mccw.New_Phone_3_Ext+'</tyes1:New_Phone_3_Ext>';
            body += '<tyes1:New_Suffix>'+mccw.New_Suffix+'</tyes1:New_Suffix>';
            body += '<tyes1:Old_Cell_Phone>'+mccw.Old_Cell_Phone+'</tyes1:Old_Cell_Phone>';
            body += '<tyes1:Old_Email>'+mccw.Old_Email+'</tyes1:Old_Email>';
            body += '<tyes1:Old_Fax>'+mccw.Old_Fax+'</tyes1:Old_Fax>';
            body += '<tyes1:Old_First_Name>'+mccw.Old_First_Name+'</tyes1:Old_First_Name>';
            body += '<tyes1:Old_Last_Name>'+mccw.Old_Last_Name+'</tyes1:Old_Last_Name>';
            body += '<tyes1:Old_Mid_Name></tyes1:Old_Mid_Name>';
            body += '<tyes1:Old_Phone_1>'+mccw.Old_Phone_1+'</tyes1:Old_Phone_1>';
            body += '<tyes1:Old_Phone_1_Ext>'+mccw.Old_Phone_1_Ext+'</tyes1:Old_Phone_1_Ext>';
            body += '<tyes1:Old_Phone_2>'+mccw.Old_Phone_2+'</tyes1:Old_Phone_2>';
            body += '<tyes1:Old_Phone_2_Ext>'+mccw.Old_Phone_2_Ext+'</tyes1:Old_Phone_2_Ext>';
            body += '<tyes1:Old_Phone_3>'+mccw.Old_Phone_3+'</tyes1:Old_Phone_3>';
            body += '<tyes1:Old_Phone_3_Ext>'+mccw.Old_Phone_3_Ext+'</tyes1:Old_Phone_3_Ext>';
            body += '<tyes1:Old_Suffix>'+mccw.Old_Suffix+'</tyes1:Old_Suffix>';
            body += '<tyes1:Primary_Indicator>'+mccw.Primary_Indicator+'</tyes1:Primary_Indicator>';
            body += '<tyes1:Role>'+mccw.Role+'</tyes1:Role>';
            body += '<tyes1:StationCode>'+mccw.StationCode+'</tyes1:StationCode>';
           //Start
            body += '<tyes1:UserID>'+mccw.UserID+'</tyes1:UserID>';
            body += '</tyes1:CustomerContactRequest>';
        }    
        body += '</tyes1:Requests>';
        body += '</tem:request>';
        body += '</tem:ManageOnlineCustomerContact>';
        body += '</soapenv:Body>';
        
        return body;
    }
    
    public static String nonServiceAccVDNMaintenance(String uId, String ActionInd, String VDNExten, String PhoneANI){
        String body = '<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:tyes="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity" xmlns:tyes1="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.OfflineCustomerANI">';
        body += '<tem:ManageOfflineCustomerANI>';
        body += '<tem:request>';
        body += '<tyes:UserId>VND1H</tyes:UserId>';
        body += '<tyes1:Requests>';
        //Zero or more repetitions//
        body += '<tyes1:OfflineCustomerANIRecord>';
        body += '<tyes1:Action_Ind>A</tyes1:Action_Ind>';
        body += '<tyes1:Phone_ANI>1234567890</tyes1:Phone_ANI>';
        body += '<tyes1:VDNExten>1802</tyes1:VDNExten>';
        body += '</tyes1:OfflineCustomerANIRecord>';
        body += '</tyes1:Requests>';
        body += '</tem:request>';
        body += '</tem:ManageOfflineCustomerANI>';
        body += '</soapenv:Body>';
        
        return body;
    }
        /* ================================================
* @Method Name : getCarRequestBody
* @author id: arjun.c.ghosh@accenture.com
* @Purpose: This method is used to create the request body Cryto Sign it and remove the X.509 tags from it for CAR_REQUEST_SERVICE(TEAMS) only
* @Parameters: String classcode, String Operating Station code, String Serving Road, String Start Week Date
* @return: String
* @created date: 02-01-2019
==================================================*/ 
     public static String getCarRequestBody(String cCode, String oSCode, String sRoad, String startWeekDate){        
        String body = '<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" >';
        body += '<tem:GetCarRequestSummary>';
        body += '<tem:ClassCode>'+cCode+'</tem:ClassCode>';
        body += '<tem:OperationStation>'+oSCode+'</tem:OperationStation>';        
        body += '<tem:ServingRoad>'+sRoad+'</tem:ServingRoad>';
        body += '<tem:StartWeekDate>'+startWeekDate+'</tem:StartWeekDate>';
        body += '</tem:GetCarRequestSummary>';
        body += '</soapenv:Body>';
        
        return body;
    }
    public static String offlineAccAniMaintenance(String uId, String ActionInd, List<OfflineAccAniMaintenanceWrapper> offlineAccAniMaintenanceList){
        String body = '<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:tyes="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity" xmlns:tyes1="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.OfflineCustomerANI">';
        body += '<tem:ManageOfflineCustomerANI>';
        body += '<tem:request>';
        body += '<tyes:UserId>'+resetUserIdOnNull(uId)+'</tyes:UserId>';
        body += '<tyes1:Requests>';
        for(OfflineAccAniMaintenanceWrapper oaam : offlineAccAniMaintenanceList){
            body += '<tyes1:OfflineCustomerANIRecord>';
            body += '<tyes1:Action_Ind>'+oaam.ActionInd+'</tyes1:Action_Ind>';
            body += '<tyes1:New_Phone_ANI>'+oaam.Phone_ANI+'</tyes1:New_Phone_ANI>';
            body += '<tyes1:Old_Phone_ANI>'+oaam.Old_Phone_ANI+'</tyes1:Old_Phone_ANI>';
            body += '<tyes1:VDNExten>'+oaam.VDNExten+'</tyes1:VDNExten>';            
            body += '</tyes1:OfflineCustomerANIRecord>';    
        }        
        body += '</tyes1:Requests>';
        body += '</tem:request>';
        body += '</tem:ManageOfflineCustomerANI>';
        body += '</soapenv:Body>';
        
        return body;
    }
    
    public static String getVDNMaintenanceBody(String uId, String ActionInd, String Description, String NewVDNExten, String OldVDNExten){
        String body = '<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:tyes="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity">';
        body += '<tem:VDNMaintenance>';
        body += '<tem:request>';
        body += '<tyes:UserId>'+resetUserIdOnNull(uId)+'</tyes:UserId>';//VND1H
        body += '<tyes:Action_Ind>'+ActionInd+'</tyes:Action_Ind>';//U
        body += '<tyes:Description>'+Description+'</tyes:Description>';//OSS TEST VDN
        body += '<tyes:New_VDNExten>'+NewVDNExten+'</tyes:New_VDNExten>';//1802
        body += '<tyes:Old_VDNExten>'+OldVDNExten+'</tyes:Old_VDNExten>';//1805
        body += '</tem:request>';
        body += '</tem:VDNMaintenance>';
        body += '</soapenv:Body>'; 
        
        return body;
    }
    
    public static String getCustomerVDNBody_Absolute(String uId, String cCode, String sCode, String VDNExt){
        String body = '<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:tyes="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity" xmlns:tyes1="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.CustomerVDN">';
        body += '<tem:SetOnlineCustomerVDN>';
        body += '<tem:request>';
        body += '<tyes:UserId>'+resetUserIdOnNull(uId)+'</tyes:UserId>';//VND1H
        body += '<tyes:ClassCode>'+cCode+'</tyes:ClassCode>';//F01
        body += '<tyes:StationCode>'+sCode+'</tyes:StationCode>';//148H
        body += '<tyes1:VDN_Exten>'+VDNExt+'</tyes1:VDN_Exten>';//1802
        body += '</tem:request>';
        body += '</tem:SetOnlineCustomerVDN>';
        body += '</soapenv:Body>';
        
        return body;
    }
    
    public static String getCustomerVDNBody(String uId, String cCode, String sCode, String VDNExt){
        String body = '<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:tyes="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity" xmlns:tyes1="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.CustomerVDN">';
        body += '<tem:SetOnlineCustomerVDN>';
        body += '<tem:requests>';
        body += '<tyes:UserId>'+resetUserIdOnNull(uId)+'</tyes:UserId>';//VND1H
        body += '<tyes1:Requests>';
        body += '<tyes1:CustomerVDNRequest>';
        body += '<tyes1:ClassCode>'+cCode+'</tyes1:ClassCode>';//F01
        body += '<tyes1:StationCode>'+sCode+'</tyes1:StationCode>';//148H
        body += '<tyes1:VDN_Exten>'+VDNExt+'</tyes1:VDN_Exten>';//1802
        body += '</tyes1:CustomerVDNRequest>';
        body += '</tyes1:Requests>';
        body += '</tem:requests>';
        body += '</tem:SetOnlineCustomerVDN>';
        body += '</soapenv:Body>';
        
        return body;
    }
    
    public static String getTransitExCountReqBody(String uId, String cCode, String sCode){
        String body = '<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:tyes="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity">';
        body += '<tem:GetTransitExceptionQueueCounts>';
        body += '<tem:request>';
        body += '<tyes:UserId>'+resetUserIdOnNull(uId)+'</tyes:UserId>';
        body += '<tyes:ClassCode>'+cCode+'</tyes:ClassCode>';//F01
        body += '<tyes:StationCode>'+sCode+'</tyes:StationCode>';//148H
        body += '</tem:request>';
        body += '</tem:GetTransitExceptionQueueCounts>';
        body += '</soapenv:Body>';
        
        return body;
    }
    
    public static String getTransitExDetailReqBody(String uId, String cCode, String sCode, String EquipmentInit, String EquipmentNr, String WaybillSrNr){
        String body = '<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:tyes="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity" xmlns:tyes1="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.TransitExceptionQueue">';
        body += '<tem:GetTransitExceptionQueueDetails>';
        body += '<tem:request>';
        body += '<tyes:UserId>'+resetUserIdOnNull(uId)+'</tyes:UserId>';
        body += '<tyes:ClassCode>'+cCode+'</tyes:ClassCode>';
        body += '<tyes:StationCode>'+sCode+'</tyes:StationCode>';
        body += '<tyes1:EqInit>'+EquipmentInit+'</tyes1:EqInit>';//MTTX
        body += '<tyes1:EqNr>'+EquipmentNr+'</tyes1:EqNr>';// 0000941468
        body += '<tyes1:WaybillSerNr>'+WaybillSrNr+'</tyes1:WaybillSerNr>';//6174184322
        body += '</tem:request>';
        body += '</tem:GetTransitExceptionQueueDetails>';
        body += '</soapenv:Body>';
        
        return body;
    }
    
    public static String getCustomerSummaryReqBody(String uId, String cCode, String sCode){
        String body = '<soapenv:Body xmlns:soapenv="'+soapNS+'" xmlns:tem="'+tem+'" xmlns:tyes="'+tyes+'">';//' xmlns:tyes1="'+tyes1+'" xmlns:tyes2="'+tyes2+'" xmlns:arr="'+arr+'" xmlns:tyes3="'+tyes3+'">';
        body += '<tem:GetCustomerSummary>';     
        body += '<tem:request>'; 
        body += '<tyes:UserId>'+resetUserIdOnNull(uId)+'</tyes:UserId>';         
        body += '<tyes:ClassCode>'+cCode+'</tyes:ClassCode>';         
        body += '<tyes:StationCode>'+sCode+'</tyes:StationCode>';
        body += '</tem:request>';
        body += '</tem:GetCustomerSummary>';
        body += '</soapenv:Body>';
        
        return body;
    }
    
    public static String getLOPAReqBody(String uId, String cCode, String sCode){
        String body = '<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:tyes="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity">';
        body += '<tem:GetLOPAMetricsReport>';
        body += '<tem:request>';
        body += '<tyes:UserId>'+resetUserIdOnNull(uId)+'</tyes:UserId>';
        body += '<tyes:ClassCode>'+cCode+'</tyes:ClassCode>';//T25
        body += '<tyes:StationCode>'+sCode+'</tyes:StationCode>';//659
        body += '</tem:request>';
        body += '</tem:GetLOPAMetricsReport>';
        body += '</soapenv:Body>';
        
        return body;
    }
    
    public static String getCustomerRouteReportReqBody(String uId, String cCode, String sCode){
        String body = '<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:tyes="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity">';
        body += '<tem:GetCustomerRouteReport>';
        body += '<tem:request>';
        body += '<tyes:UserId>'+resetUserIdOnNull(uId)+'</tyes:UserId>';//jkd4b
        body += '<tyes:ClassCode>'+cCode+'</tyes:ClassCode>';//B52
        body += '<tyes:StationCode>'+sCode+'</tyes:StationCode>';//09141        
        body += '</tem:request>';
        body += '</tem:GetCustomerRouteReport>';
        body += '</soapenv:Body>';
        
        return body;
    }
    
    public static String getCustomerSummaryMockResBody(){
        String cusSumRes = '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">';
        cusSumRes += '<s:Body>';
        cusSumRes += '<GetCustomerSummaryResponse xmlns="http://tempuri.org/">';
        cusSumRes += '<GetCustomerSummaryResult xmlns:a="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.CustomerSummary" xmlns:i="http://www.w3.org/2001/XMLSchema-instance">';
        cusSumRes += '<Status xmlns="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity">';
        cusSumRes += '<Code>0</Code>';
        cusSumRes += '<Message/>';
        cusSumRes += '</Status>';
        cusSumRes += '<a:BusinessName>FABRICATION PLANT</a:BusinessName>';
        cusSumRes += '<a:ClassCode>F01</a:ClassCode>';
        cusSumRes += '<a:EquipmentSummary>';
        cusSumRes += '<a:OnTrackDetails>';
        cusSumRes += '<a:EmptyCount>69</a:EmptyCount>';
        cusSumRes += '<a:Length>5479</a:Length>';
        cusSumRes += '<a:LoadCount>22</a:LoadCount>';
        cusSumRes += '<a:TotalCount>91</a:TotalCount>';
        cusSumRes += '<a:Weight>4230</a:Weight>';
        cusSumRes += '</a:OnTrackDetails>';
        cusSumRes += '</a:EquipmentSummary>';
        cusSumRes += '<a:NotifyStations xmlns:b="http://schemas.microsoft.com/2003/10/Serialization/Arrays">';
        cusSumRes += '<b:string>ATLANTA, GA</b:string>';
        cusSumRes += '</a:NotifyStations>';
        cusSumRes += '<a:Schedule>';
        cusSumRes += '<a:CustomerSummaryServiceSchedule>';
        cusSumRes += '<a:CutOffDayOfWeek>Monday</a:CutOffDayOfWeek>';
        cusSumRes += '<a:CutoffTimeDisplay>6:59 AM</a:CutoffTimeDisplay>';
        cusSumRes += '<a:ScheduleCloseTime>3:59 PM</a:ScheduleCloseTime>';
        cusSumRes += '<a:ScheduleDayOfWeek>Monday</a:ScheduleDayOfWeek>';
        cusSumRes += '<a:ScheduleOpenTime>7:59 AM</a:ScheduleOpenTime>';
        cusSumRes += '</a:CustomerSummaryServiceSchedule>';
        cusSumRes += '</a:Schedule>';
        cusSumRes += '<a:SpecialInstructions xmlns:b="http://schemas.microsoft.com/2003/10/Serialization/Arrays">';
        cusSumRes += '<b:string>GE-98 FAB JOB- SWITCH LIST 5/11/18&#xD;';
        cusSumRes += '</b:string>';
        cusSumRes += '</a:SpecialInstructions>';
        cusSumRes += '<a:StateAbbreviation>GA</a:StateAbbreviation>';
        cusSumRes += '<a:StationName>ATLANTA</a:StationName>';
        cusSumRes += '<a:SummaryBullets xmlns:b="http://schemas.microsoft.com/2003/10/Serialization/Arrays">';
        cusSumRes += '<b:string>Order for Placement</b:string>';
        cusSumRes += '<b:string>Operating Division - GEORGIA</b:string>';
        cusSumRes += '</a:SummaryBullets>';
        cusSumRes += '</GetCustomerSummaryResult>';
        cusSumRes += '</GetCustomerSummaryResponse>';
        cusSumRes += '</s:Body>';
        cusSumRes += '</s:Envelope>';
        
        return cusSumRes;
    }
    
    public static String getCustomerRouteMockResBody(){
        String cusRouteRes = '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">';
        cusRouteRes += '<s:Body>';
        cusRouteRes += '<GetCustomerRouteReportResponse xmlns="http://tempuri.org/">';
        cusRouteRes += '<GetCustomerRouteReportResult xmlns:a="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.CustomerRouteReport" xmlns:i="http://www.w3.org/2001/XMLSchema-instance">';
        cusRouteRes += '<a:CustomerRouteReportRecords>';
        cusRouteRes += '<a:CustomerRouteReportRecord>';
        cusRouteRes += '<a:FridayInd>Y</a:FridayInd>';
        cusRouteRes += '<a:MondayInd>Y</a:MondayInd>';
        cusRouteRes += '<a:RouteID>DB02</a:RouteID>';
        cusRouteRes += '<a:SaturdayInd>Y</a:SaturdayInd>';
        cusRouteRes += '<a:Stn>09141</a:Stn>';
        cusRouteRes += '<a:StnName>DECATUR</a:StnName>';
        cusRouteRes += '<a:SundayInd>Y</a:SundayInd>';
        cusRouteRes += '<a:ThursdayInd>Y</a:ThursdayInd>';
        cusRouteRes += '<a:TuesdayInd>Y</a:TuesdayInd>';
        cusRouteRes += '<a:WednesdayInd>Y</a:WednesdayInd>';
        cusRouteRes += '</a:CustomerRouteReportRecord>';
        cusRouteRes += '<a:CustomerRouteReportRecord>';
        cusRouteRes += '<a:FridayInd>Y</a:FridayInd>';
        cusRouteRes += '<a:MondayInd>Y</a:MondayInd>';
        cusRouteRes += '<a:RouteID>DB06</a:RouteID>';
        cusRouteRes += '<a:SaturdayInd>Y</a:SaturdayInd>';
        cusRouteRes += '<a:Stn>09141</a:Stn>';
        cusRouteRes += '<a:StnName>DECATUR</a:StnName>';
        cusRouteRes += '<a:SundayInd>Y</a:SundayInd>';
        cusRouteRes += '<a:ThursdayInd>Y</a:ThursdayInd>';
        cusRouteRes += '<a:TuesdayInd>Y</a:TuesdayInd>';
        cusRouteRes += '<a:WednesdayInd>Y</a:WednesdayInd>';
        cusRouteRes += '</a:CustomerRouteReportRecord>';
        cusRouteRes += '<a:CustomerRouteReportRecord>';
        cusRouteRes += '<a:FridayInd>Y</a:FridayInd>';
        cusRouteRes += '<a:MondayInd>Y</a:MondayInd>';
        cusRouteRes += '<a:RouteID>DB20</a:RouteID>';
        cusRouteRes += '<a:SaturdayInd/>';
        cusRouteRes += '<a:Stn>09141</a:Stn>';
        cusRouteRes += '<a:StnName>DECATUR</a:StnName>';
        cusRouteRes += '<a:SundayInd/>';
        cusRouteRes += '<a:ThursdayInd>Y</a:ThursdayInd>';
        cusRouteRes += '<a:TuesdayInd>Y</a:TuesdayInd>';
        cusRouteRes += '<a:WednesdayInd>Y</a:WednesdayInd>';
        cusRouteRes += '</a:CustomerRouteReportRecord>';
        cusRouteRes += '<a:CustomerRouteReportRecord>';
        cusRouteRes += '<a:FridayInd>Y</a:FridayInd>';
        cusRouteRes += '<a:MondayInd>Y</a:MondayInd>';
        cusRouteRes += '<a:RouteID>DB22</a:RouteID>';
        cusRouteRes += '<a:SaturdayInd>Y</a:SaturdayInd>';
        cusRouteRes += '<a:Stn>09141</a:Stn>';
        cusRouteRes += '<a:StnName>DECATUR</a:StnName>';
        cusRouteRes += '<a:SundayInd>Y</a:SundayInd>';
        cusRouteRes += '<a:ThursdayInd>Y</a:ThursdayInd>';
        cusRouteRes += '<a:TuesdayInd>Y</a:TuesdayInd>';
        cusRouteRes += '<a:WednesdayInd>Y</a:WednesdayInd>';
        cusRouteRes += '</a:CustomerRouteReportRecord>';
        cusRouteRes += '<a:CustomerRouteReportRecord>';
        cusRouteRes += '<a:FridayInd>Y</a:FridayInd>';
        cusRouteRes += '<a:MondayInd>Y</a:MondayInd>';
        cusRouteRes += '<a:RouteID>DB26</a:RouteID>';
        cusRouteRes += '<a:SaturdayInd>Y</a:SaturdayInd>';
        cusRouteRes += '<a:Stn>09141</a:Stn>';
        cusRouteRes += '<a:StnName>DECATUR</a:StnName>';
        cusRouteRes += '<a:SundayInd>Y</a:SundayInd>';
        cusRouteRes += '<a:ThursdayInd>Y</a:ThursdayInd>';
        cusRouteRes += '<a:TuesdayInd>Y</a:TuesdayInd>';
        cusRouteRes += '<a:WednesdayInd>Y</a:WednesdayInd>';
        cusRouteRes += '</a:CustomerRouteReportRecord>';
        cusRouteRes += '<a:CustomerRouteReportRecord>';
        cusRouteRes += '<a:FridayInd>Y</a:FridayInd>';
        cusRouteRes += '<a:MondayInd>Y</a:MondayInd>';
        cusRouteRes += '<a:RouteID>DB42</a:RouteID>';
        cusRouteRes += '<a:SaturdayInd>Y</a:SaturdayInd>';
        cusRouteRes += '<a:Stn>09141</a:Stn>';
        cusRouteRes += '<a:StnName>DECATUR</a:StnName>';
        cusRouteRes += '<a:SundayInd>Y</a:SundayInd>';
        cusRouteRes += '<a:ThursdayInd>Y</a:ThursdayInd>';
        cusRouteRes += '<a:TuesdayInd>Y</a:TuesdayInd>';
        cusRouteRes += '<a:WednesdayInd>Y</a:WednesdayInd>';
        cusRouteRes += '</a:CustomerRouteReportRecord>';
        cusRouteRes += '<a:CustomerRouteReportRecord>';
        cusRouteRes += '<a:FridayInd>Y</a:FridayInd>';
        cusRouteRes += '<a:MondayInd>Y</a:MondayInd>';
        cusRouteRes += '<a:RouteID>DB46</a:RouteID>';
        cusRouteRes += '<a:SaturdayInd>Y</a:SaturdayInd>';
        cusRouteRes += '<a:Stn>09141</a:Stn>';
        cusRouteRes += '<a:StnName>DECATUR</a:StnName>';
        cusRouteRes += '<a:SundayInd>Y</a:SundayInd>';
        cusRouteRes += '<a:ThursdayInd>Y</a:ThursdayInd>';
        cusRouteRes += '<a:TuesdayInd>Y</a:TuesdayInd>';
        cusRouteRes += '<a:WednesdayInd>Y</a:WednesdayInd>';
        cusRouteRes += '</a:CustomerRouteReportRecord>';
        cusRouteRes += '</a:CustomerRouteReportRecords>';
        cusRouteRes += '<a:Status xmlns:b="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity">';
        cusRouteRes += '<b:Code>0</b:Code>';
        cusRouteRes += '<b:Message/>';
        cusRouteRes += '</a:Status>';
        cusRouteRes += '</GetCustomerRouteReportResult>';
        cusRouteRes += '</GetCustomerRouteReportResponse>';
        cusRouteRes += '</s:Body>';
        cusRouteRes += '</s:Envelope>';
        
        return cusRouteRes;
    }
    
    public static String getLOPAMockResBody(){
        String lopaMockRes = '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">';
        lopaMockRes += '<s:Body>';
        lopaMockRes += '<GetLOPAMetricsReportResponse xmlns="http://tempuri.org/">';
        lopaMockRes += '<GetLOPAMetricsReportResult xmlns:a="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.LOPAMetrics" ';
        lopaMockRes += 'xmlns:i="http://www.w3.org/2001/XMLSchema-instance">';
        lopaMockRes += '<Status xmlns="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity">';
        lopaMockRes += '<Code>0</Code>';
        lopaMockRes += '<Message/>';
        lopaMockRes += '</Status>';
        lopaMockRes += '<a:NonCompliantCustomerRSN>4</a:NonCompliantCustomerRSN>';
        lopaMockRes += '<a:NonCompliantMechRSN>0</a:NonCompliantMechRSN>';
        lopaMockRes += '<a:NonCompliantRRRSN>0</a:NonCompliantRRRSN>';
        lopaMockRes += '<a:PercentFailureCustRsn>0.00%</a:PercentFailureCustRsn>';
        lopaMockRes += '<a:PercentFailureMechRsn>0.00%</a:PercentFailureMechRsn>';
        lopaMockRes += '<a:PercentFailureRRRsn>0.00%</a:PercentFailureRRRsn>';
        lopaMockRes += '<a:PercentTotalFailure>0.00%</a:PercentTotalFailure>';
        lopaMockRes += '<a:TotalPending>0</a:TotalPending>';
        lopaMockRes += '<a:TotalPlanned>32</a:TotalPlanned>';
        lopaMockRes += '</GetLOPAMetricsReportResult>';
        lopaMockRes += '</GetLOPAMetricsReportResponse>';
        lopaMockRes += '</s:Body>';
        lopaMockRes += '</s:Envelope>';
        
        return lopaMockRes;
    }
    
    public Static String getVDNResponseBody(){
        String vdnresponse  = '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">';
        vdnresponse += '<s:Body>';
        vdnresponse += '<ManageOnlineCustomerContactResponse xmlns="http://tempuri.org/">';
        vdnresponse += '<ManageOnlineCustomerContactResult xmlns:a="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity" xmlns:i="http://www.w3.org/2001/XMLSchema-instance">';
        vdnresponse += '<a:Status>';
        vdnresponse += '<a:Code>0</a:Code>';
        vdnresponse += '<a:Message/>';
        vdnresponse += '</a:Status>';
        vdnresponse += '</ManageOnlineCustomerContactResult>';
        vdnresponse += '</ManageOnlineCustomerContactResponse>';
        vdnresponse += '</s:Body>';
        vdnresponse += '</s:Envelope>';
        
        return vdnresponse;
    }

    public static List<String> getValidFieldsForContactMaintenance(){
        List<String> allValidFields = new List<String> ();
        allValidFields.add('NS_Commodity__c');
        allValidFields.add('Email');
        allValidFields.add('Title');
        allValidFields.add('Fax');
        allValidFields.add('Phone');
        allValidFields.add('MobilePhone');
        allValidFields.add('FirstName');
        allValidFields.add('LastName');
        allValidFields.add('OtherPhone');
        allValidFields.add('HomePhone');
        allValidFields.add('NS_Work_Phone_Ext__c');
        allValidFields.add('NS_OtherPhone2Ext__c');
        allValidFields.add('NS_OtherPhoneExt__c');
        allValidFields.add('Description');
        
        return allValidFields;
    }
    
    public static String getMockTransitExCountResBody(){
        String body = '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">';
        body += '<s:Body>';
        body += '<GetTransitExceptionQueueCountsResponse xmlns="http://tempuri.org/">';
        body += '<GetTransitExceptionQueueCountsResult xmlns:a="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.TransitExceptionQueue" xmlns:i="http://www.w3.org/2001/XMLSchema-instance">';
        body += '<Status xmlns="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity">';
        body += '<Code>0</Code>';
        body += '<Message/>';
        body += '</Status>';
        body += '<a:TransitExceptionQueueCounts>';
        body += '<a:TransitExceptionQueueCount>';
        body += '<a:EqInit>NW</a:EqInit>';
        body += '<a:EqNr>0000032137</a:EqNr>';
        body += '<a:EtaDTM>07/24 03:59 PM</a:EtaDTM>';
        body += '<a:TEQCount>1</a:TEQCount>';
        body += '<a:WaybillSrNr>6247505213</a:WaybillSrNr>';
        body += '</a:TransitExceptionQueueCount>';
        body += '</a:TransitExceptionQueueCounts>';
        body += '</GetTransitExceptionQueueCountsResult>';
        body += '</GetTransitExceptionQueueCountsResponse>';
        body += '</s:Body>';
        body += '</s:Envelope>';
        
        return body;
    }
    
    public static String getMockTransitExDetailResBody(){
    
        String body = '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">';
        body += '<s:Body>';
        body += '<GetTransitExceptionQueueDetailsResponse xmlns="http://tempuri.org/">';
        body += '<GetTransitExceptionQueueDetailsResult xmlns:a="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.TransitExceptionQueue" xmlns:i="http://www.w3.org/2001/XMLSchema-instance">';
        body += '<Status xmlns="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity">';
        body += '<Code>0</Code>';
        body += '<Message/>';
        body += '</Status>';
        body += '<a:TansitExceptionQueueDetails>';
        body += '<a:TansitExceptionQueueDetail>';
        body += '<a:AdditionalDetails> </a:AdditionalDetails>';
        body += '<a:ControllingStation>BARNESVILLE (1234)</a:ControllingStation>';
        body += '<a:DelayReason>ARIL LATE</a:DelayReason>';
        body += '<a:EqInit>NW</a:EqInit>';
        body += '<a:EqNr>0000032137</a:EqNr>';
        body += '<a:OperatingStation>BARNESVILLE (1234)</a:OperatingStation>';
        body += '<a:PlannedMovementDTM>07/21 07:24 PM ET</a:PlannedMovementDTM>';
        body += '<a:PlannedMovementTrain>180G821</a:PlannedMovementTrain>';
        body += '<a:QueueInsertDtm>07/21 09:17 PM</a:QueueInsertDtm>';
        body += '</a:TansitExceptionQueueDetail>';
        body += '</a:TansitExceptionQueueDetails>';
        body += '</GetTransitExceptionQueueDetailsResult>';
        body += '</GetTransitExceptionQueueDetailsResponse>';
        body += '</s:Body>';
        body += '</s:Envelope>';
        
        return body;
    }
    
    public static String getMockTransitExDetailResBody(String uId, String cCode, String sCode, String EquipmentInit, String EquipmentNr, String WaybillSrNr){
        String body = '';
        
        return body;
    }    
    
    public static void createExceptionRecord(Exception exp, String class_Name, String method_Name){
        Exception__c excep = new Exception__c();
        excep.Name = exp.getTypeName(); 
        excep.Class_Name__c = class_Name;
        excep.Method_Name__c = method_Name;
        if(exp.getMessage().length()<255){
      		excep.Description__c = exp.getMessage();
        }else{
           	excep.Description__c=  exp.getMessage().substring(0, 254);
        }        
        excep.Line_No__c = exp.getLineNumber();
        insert excep;
    }
    
    public class OfflineAccAniMaintenanceWrapper{
        public string Phone_ANI = NS_StaticVariablesUtility.Blank ;
        public string Old_Phone_ANI = NS_StaticVariablesUtility.Blank ;
        public string VDNExten = NS_StaticVariablesUtility.Blank ;
        public string ActionInd = NS_StaticVariablesUtility.Blank ;
    }
    
    public class ManageOnlineCustomerContactWrapper{
        public string Action_Ind = NS_StaticVariablesUtility.Blank ;
        public string ClassCode = NS_StaticVariablesUtility.Blank ;
        public string Comment = NS_StaticVariablesUtility.Blank ;
        public string Commodity = NS_StaticVariablesUtility.Blank ;
        public string New_Cell_Phone = NS_StaticVariablesUtility.Blank ;
        public string New_Email = NS_StaticVariablesUtility.Blank ;
        public string New_Fax = NS_StaticVariablesUtility.Blank ;
        public string New_First_Name = NS_StaticVariablesUtility.Blank ;
        public string New_Last_Name = NS_StaticVariablesUtility.Blank ;
        public string New_Mid_Name = NS_StaticVariablesUtility.Blank ;
        public string New_Phone_1 = NS_StaticVariablesUtility.Blank ;
        public string New_Phone_1_Ext = NS_StaticVariablesUtility.Blank ;
        public string New_Phone_2 = NS_StaticVariablesUtility.Blank ;
        public string New_Phone_2_Ext = NS_StaticVariablesUtility.Blank ;
        public string New_Suffix = NS_StaticVariablesUtility.Blank ;
        public string Old_Cell_Phone = NS_StaticVariablesUtility.Blank ;
        public string Old_Email = NS_StaticVariablesUtility.Blank ;
        public string Old_Fax = NS_StaticVariablesUtility.Blank ;
        public string Old_First_Name = NS_StaticVariablesUtility.Blank ;
        public string Old_Last_Name = NS_StaticVariablesUtility.Blank ;
        public string Old_Mid_Name = NS_StaticVariablesUtility.Blank ;
        public string Old_Phone_1 = NS_StaticVariablesUtility.Blank ;
        public string Old_Phone_1_Ext = NS_StaticVariablesUtility.Blank ;
        public string Old_Phone_2 = NS_StaticVariablesUtility.Blank ;
        public string Old_Phone_2_Ext = NS_StaticVariablesUtility.Blank ;
        public string New_Phone_3 = NS_StaticVariablesUtility.Blank ;
        public string New_Phone_3_Ext = NS_StaticVariablesUtility.Blank ;
        public string Old_Phone_3 = NS_StaticVariablesUtility.Blank ;
        public string Old_Phone_3_Ext = NS_StaticVariablesUtility.Blank ;
        public string Old_Suffix = NS_StaticVariablesUtility.Blank ;
        public string Primary_Indicator = NS_StaticVariablesUtility.Blank ;
        public string Role = NS_StaticVariablesUtility.Blank ;
        public string StationCode = NS_StaticVariablesUtility.Blank ;
        //Start
        public string UserId = NS_StaticVariablesUtility.Blank ; 
    }
    /*Description: Wrapper for Contact Delete Request 
     *Enhancement request on mail for Phase 1
     *Developer name: Arjun Ghosh
     *Date: 14-12-2018
     */
     public class ManageOnlineCustomerContactDeleteWrapper{
        public string Action_Ind = NS_StaticVariablesUtility.Blank ;
        public string ClassCode = NS_StaticVariablesUtility.Blank ;
        public string Comment = NS_StaticVariablesUtility.Blank ;
        public string Commodity = NS_StaticVariablesUtility.Blank ;
        public string nCellPhone = NS_StaticVariablesUtility.Blank ;
        public string nEmail = NS_StaticVariablesUtility.Blank ;
        public string nFax = NS_StaticVariablesUtility.Blank ;
        public string nFname = NS_StaticVariablesUtility.Blank ;
        public string nLname = NS_StaticVariablesUtility.Blank ;
        public string nMname = NS_StaticVariablesUtility.Blank ;
        public string nPhone1 = NS_StaticVariablesUtility.Blank ;
        public string nPhone1Ext = NS_StaticVariablesUtility.Blank ;
        public string nPhone2 = NS_StaticVariablesUtility.Blank ;
        public string nPhone2Ext = NS_StaticVariablesUtility.Blank ;
        public string nSuffix = NS_StaticVariablesUtility.Blank ;
        public string oCellPhone = NS_StaticVariablesUtility.Blank ;
        public string oEmail = NS_StaticVariablesUtility.Blank ;
        public string oFax = NS_StaticVariablesUtility.Blank ;
        public string oFname = NS_StaticVariablesUtility.Blank ;
        public string oLname = NS_StaticVariablesUtility.Blank ;
        public string oMname = NS_StaticVariablesUtility.Blank ;
        public string oPhone1 = NS_StaticVariablesUtility.Blank ;
        public string oPhone1Ext = NS_StaticVariablesUtility.Blank ;
        public string oPhone2 = NS_StaticVariablesUtility.Blank ;
        public string oPhone2Ext = NS_StaticVariablesUtility.Blank ;
        public string nPhone3 = NS_StaticVariablesUtility.Blank ;
        public string nPhone3Ext = NS_StaticVariablesUtility.Blank ;
        public string oPhone3 = NS_StaticVariablesUtility.Blank ;
        public string oPhone3Ext = NS_StaticVariablesUtility.Blank ;
        public string oSuffix = NS_StaticVariablesUtility.Blank ;
        public string Primary_Indicator = NS_StaticVariablesUtility.Blank ;
        public string Role = NS_StaticVariablesUtility.Blank ;
        public string StationCode = NS_StaticVariablesUtility.Blank ;
        public string UserId = NS_StaticVariablesUtility.Blank ; 
    }
    
    /*Description: Prepare the body for the delete request 
     *Enhancement request on mail for Phase 1
     *Developer name: Arjun Ghosh
     *Date: 14-12-2018
     */
  public static String ManageOnlineCustomerContactonDelete(String uId, List<ManageOnlineCustomerContactDeleteWrapper> CustomerContactWrapperList){
        String body = '<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:tyes="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity" xmlns:tyes1="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.CustomerContact">';
        body += '<tem:ManageOnlineCustomerContact>';
        body += '<tem:request>';
        body += '<tyes:UserId>'+resetUserIdOnNull(uId)+'</tyes:UserId>';
        body += '<tyes1:Requests>';
        for(ManageOnlineCustomerContactDeleteWrapper mccw : CustomerContactWrapperList){
            body += '<tyes1:CustomerContactRequest>';
            body += '<tyes1:Action_Ind>'+mccw.Action_Ind+'</tyes1:Action_Ind>';            
            body += '<tyes1:ClassCode>'+mccw.ClassCode+'</tyes1:ClassCode>';
            body += '<tyes1:Comment>'+mccw.Comment+'</tyes1:Comment>';
            body += '<tyes1:Commodity>'+mccw.Commodity+'</tyes1:Commodity>';
            body += '<tyes1:New_Cell_Phone>'+mccw.nCellPhone+'</tyes1:New_Cell_Phone>';
            body += '<tyes1:New_Email>'+mccw.nEmail+'</tyes1:New_Email>';
            body += '<tyes1:New_Fax>'+mccw.nFax+'</tyes1:New_Fax>';
            body += '<tyes1:New_First_Name>'+mccw.nFname+'</tyes1:New_First_Name>';
            body += '<tyes1:New_Last_Name>'+mccw.nLname+'</tyes1:New_Last_Name>';
            body += '<tyes1:New_Mid_Name>'+mccw.nMname+'</tyes1:New_Mid_Name>';
            body += '<tyes1:New_Phone_1>'+mccw.nPhone1+'</tyes1:New_Phone_1>';
            body += '<tyes1:New_Phone_1_Ext>'+mccw.nPhone1Ext+'</tyes1:New_Phone_1_Ext>';
            body += '<tyes1:New_Phone_2>'+mccw.nPhone2+'</tyes1:New_Phone_2>';
            body += '<tyes1:New_Phone_2_Ext>'+mccw.nPhone2Ext+'</tyes1:New_Phone_2_Ext>';
            body += '<tyes1:New_Phone_3>'+mccw.nPhone3+'</tyes1:New_Phone_3>';
            body += '<tyes1:New_Phone_3_Ext>'+mccw.nPhone3Ext+'</tyes1:New_Phone_3_Ext>';
            body += '<tyes1:New_Suffix>'+mccw.nSuffix+'</tyes1:New_Suffix>';
            body += '<tyes1:Old_Cell_Phone>'+mccw.oCellPhone+'</tyes1:Old_Cell_Phone>';
            body += '<tyes1:Old_Email>'+mccw.oEmail+'</tyes1:Old_Email>';
            body += '<tyes1:Old_Fax>'+mccw.oFax+'</tyes1:Old_Fax>';
            body += '<tyes1:Old_First_Name>'+mccw.oFname+'</tyes1:Old_First_Name>';
            body += '<tyes1:Old_Last_Name>'+mccw.oLname+'</tyes1:Old_Last_Name>';
            body += '<tyes1:Old_Mid_Name></tyes1:Old_Mid_Name>';
            body += '<tyes1:Old_Phone_1>'+mccw.oPhone1+'</tyes1:Old_Phone_1>';
            body += '<tyes1:Old_Phone_1_Ext>'+mccw.oPhone1Ext+'</tyes1:Old_Phone_1_Ext>';
            body += '<tyes1:Old_Phone_2>'+mccw.oPhone2+'</tyes1:Old_Phone_2>';
            body += '<tyes1:Old_Phone_2_Ext>'+mccw.oPhone2Ext+'</tyes1:Old_Phone_2_Ext>';
            body += '<tyes1:Old_Phone_3>'+mccw.oPhone3+'</tyes1:Old_Phone_3>';
            body += '<tyes1:Old_Phone_3_Ext>'+mccw.oPhone3Ext+'</tyes1:Old_Phone_3_Ext>';
            body += '<tyes1:Old_Suffix>'+mccw.oSuffix+'</tyes1:Old_Suffix>';
            body += '<tyes1:Primary_Indicator>'+mccw.Primary_Indicator+'</tyes1:Primary_Indicator>';
            body += '<tyes1:Role>'+mccw.Role+'</tyes1:Role>';
            body += '<tyes1:StationCode>'+mccw.StationCode+'</tyes1:StationCode>';
           //Start
            body += '<tyes1:UserID>'+mccw.UserID+'</tyes1:UserID>';
            body += '</tyes1:CustomerContactRequest>';
        }    
        body += '</tyes1:Requests>';
        body += '</tem:request>';
        body += '</tem:ManageOnlineCustomerContact>';
        body += '</soapenv:Body>';
        
        return body;
    } 
    /*Description: Parse the xml response from delete request to retrieve the Status Code 
     *Enhancement request on mail for Phase 1
     *Developer name: Arjun Ghosh
     *Date: 14-12-2018
     */
    public static String parseXML(DOM.XMLNode node) {
        if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
            if(node.getName().equals('Code')){
         String ret=(String)node.getText();
                return ret;
        }
        }    
        for (Dom.XMLNode child: node.getChildElements()) {
            parseXML(child);
        }
        return null;
    }
     
}