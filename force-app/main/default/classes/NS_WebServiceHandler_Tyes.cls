/*
Description  : This class has callout methods for NS webservice Implementation
Developer    : Accenture Solutions
Date         : 1-24-2018
*/

public class NS_WebServiceHandler_Tyes{

    Static String body;
    Static String endpoint;
        
    //** Start - Methods to create request body **//
	public Static GCSWrapper invoke_TYES_getCustomerSummary(String uId, String cCode, String sCode){     
        endpoint = NS_StaticVariablesUtility.GCS_endpoint;
        body = NS_StaticVariablesUtility.getCustomerSummaryReqBody(uId, cCode, sCode);
        body = prepareSignedBody();
        return TYES_GCS_ResponseParser(sendRequest(endpoint, NS_StaticVariablesUtility.postmethod, NS_StaticVariablesUtility.contentType, NS_StaticVariablesUtility.TYES_getCustomerSummary_Action, body));
     }
     
     public Static LOPADataWrapper invoke_LOPA(String uId, String cCode, String sCode){ 
         endpoint = NS_StaticVariablesUtility.LOPA_endpoint; 
         body = NS_StaticVariablesUtility.getLOPAReqBody(uId, cCode, sCode);
         body = prepareSignedBody();         
         return LOPA_getMetricsResponseParser(sendRequest(endpoint, NS_StaticVariablesUtility.postmethod, NS_StaticVariablesUtility.contentType, NS_StaticVariablesUtility.LOPA_Action, body));
     }
     
     public Static List<RouteReportWrapper> invoke_CustomerRouteReport(String uId, String cCode, String sCode){        
        endpoint = NS_StaticVariablesUtility.RouteReport_endpoint;
        body = NS_StaticVariablesUtility.getCustomerRouteReportReqBody(uId, cCode, sCode);
        body = prepareSignedBody();
        return RouteReportResponseParser(sendRequest(endpoint, NS_StaticVariablesUtility.postmethod, NS_StaticVariablesUtility.contentType, NS_StaticVariablesUtility.CustomerRouteReport_Action, body));
     }
    
    public Static List<TransitExceptionCountWrapper> invoke_TransitExceptionCount(String uId, String cCode, String sCode){        
        endpoint = NS_StaticVariablesUtility.TransitExceptionReport_endpoint;
        body = NS_StaticVariablesUtility.getTransitExCountReqBody(uId, cCode, sCode);
        body = prepareSignedBody();
        String res = sendRequest(endpoint, NS_StaticVariablesUtility.postmethod, NS_StaticVariablesUtility.contentType, NS_StaticVariablesUtility.TransitExceptionQueueCountsAction, body);
        return TYES_TransitCount_ResponseParser(res);
     }
     
     public Static List<TransitExceptionDetailWrapper> invoke_TransitExceptionDetail(String uId, String cCode, String sCode, String EquipmentInit, String EquipmentNr, String WaybillSrNr){        
        endpoint = NS_StaticVariablesUtility.TransitExceptionReport_endpoint;
        body = NS_StaticVariablesUtility.getTransitExDetailReqBody(uId, cCode, sCode, EquipmentInit, EquipmentNr, WaybillSrNr );
        body = prepareSignedBody();
        String res = sendRequest(endpoint, NS_StaticVariablesUtility.postmethod, NS_StaticVariablesUtility.contentType,NS_StaticVariablesUtility.TransitExceptionQueueDetailAction , body);
     	return TYES_TransitDetail_ResponseParser(res,WaybillSrNr);
     }
     
     //** END - Methods to create request body **//
     
     //** Start - Methods to Cryto Sign the request body **//
    
    private Static String prepareSignedBody(){
        Dom.Document doc = new dom.Document();
        dom.XmlNode envelope = doc.createRootElement(NS_StaticVariablesUtility.Envelope, NS_StaticVariablesUtility.soapNS, NS_StaticVariablesUtility.soapenv);
        dom.XmlNode nodeHeader = envelope.addChildElement(NS_StaticVariablesUtility.Header, NS_StaticVariablesUtility.soapNS, null);
        dom.XmlNode nodeSecurity = nodeHeader.addChildElement(NS_StaticVariablesUtility.Security, NS_StaticVariablesUtility.wsseNS, NS_StaticVariablesUtility.wsse);
        dom.XmlNode nodeTest = nodeSecurity.addChildElement(NS_StaticVariablesUtility.Test, NS_StaticVariablesUtility.soapNS , NS_StaticVariablesUtility.soapenv);
        
        Dom.Document docForBody = new dom.Document();
        docForBody.load(Body);
        dom.XmlNode envelopeb = docForBody.getRootElement();
        
        cryptoSign(envelopeb);
        Dom.XmlNode sigElement = envelopeb.getChildElement(NS_StaticVariablesUtility.Signature, NS_StaticVariablesUtility.sigNS);        
        removeX509Tags(sigElement);        
        nodeSecurity.insertBefore(sigElement , nodeTest);
        nodeSecurity.removeChild(nodeTest);
        envelopeb.removeChild(sigElement);
        envelope.insertBefore(envelopeb,null);
        
        return doc.toXMLString();
     }    
    
    //** END - Methods to Cryto Sign the request body **//
    
    //** START - Cyrto Sign an element **//
    
    private Static void cryptoSign(dom.XmlNode envelopebody){
        System.Crypto.signXml(NS_StaticVariablesUtility.RSA_SHA1, envelopebody, null, NS_StaticVariablesUtility.CRM);
    }
    
    //** END - Cyrto Sign an element **//
    
    //** Start - Methods to Remove extra X509 tags from Cyro sign request **//
    
    private Static void removeX509Tags(Dom.XmlNode sigElement){    
        for(Dom.XmlNode childElement : sigElement.getChildElements()){
            if(childElement.getName() == NS_StaticVariablesUtility.KeyInfo){
                for(Dom.XmlNode KeyInfo_childElement : childElement.getChildElements()){
                    if(KeyInfo_childElement.getName() == NS_StaticVariablesUtility.X509Data){
                        if(KeyInfo_childElement.getChildElements().size() > 0){
                        Integer size = KeyInfo_childElement.getChildElements().size();
                            for(integer i = size-1 ; i >= 1 ; i--){
                                KeyInfo_childElement.removeChild(KeyInfo_childElement.getChildElements().get(i));    
                            }
                        }        
                    }
                }
            }
        }
    }
    
    //** END - Methods to Remove extra X509 tags from Cyro sign request **//
    
    //** Start - Methods to Make the HTTP Callout **//
    
    private Static String sendRequest(String endpoint, String method, String contentType, String action, String body){
        HttpRequest hreq = new HttpRequest();
        hreq.setEndpoint(endpoint);
        hreq.setMethod(method);
        hreq.setHeader(NS_StaticVariablesUtility.Content_Type, contentType);
        hreq.setHeader(NS_StaticVariablesUtility.SOAPAction, action);
        hreq.setBody(body);
        Http http = new Http();
        System.debug('Request>>>>'+body);
        HTTPResponse hres = http.send(hreq);
        System.debug('Response>>>>'+hres.getbody());
        return hres.getbody();
    }
    
    //** END - Methods to Make the HTTP Callout **//
    
    //** Start - Methods to Parse the response body **//
    
    public Static List<TransitExceptionCountWrapper> TYES_TransitCount_ResponseParser(String res){
    	List<TransitExceptionCountWrapper> TECWrapperList = new List<TransitExceptionCountWrapper>();
        Dom.Document docForResponse = new dom.Document();
        docForResponse.load(res);
        Dom.XmlNode res_envelope = docForResponse.getRootElement();
        Dom.XmlNode bodyElement = res_envelope.getChildElement(NS_StaticVariablesUtility.Body, NS_StaticVariablesUtility.soapNS);
        Dom.XmlNode QueueCountsResponseElement = bodyElement.getChildElement(NS_StaticVariablesUtility.GetTransitExceptionQueueCountsResponse, NS_StaticVariablesUtility.tem);
        Dom.XmlNode QueueCountsResultElement = QueueCountsResponseElement.getChildElement(NS_StaticVariablesUtility.GetTransitExceptionQueueCountsResult, NS_StaticVariablesUtility.tem);
        Dom.XmlNode StatusElement = QueueCountsResultElement.getChildElement(NS_StaticVariablesUtility.Status, NS_StaticVariablesUtility.TransitExceptionQueueUri);
        Dom.XmlNode ExceptionCountsElement = QueueCountsResultElement.getChildElement(NS_StaticVariablesUtility.TransitExceptionQueueCounts, NS_StaticVariablesUtility.TransitExceptionQueueUri);
        for(Dom.XmlNode GetChildren : ExceptionCountsElement.getChildren()){
        	List<String> TECWrapperData = new List<String>();
            for(Dom.XmlNode GetSubChildren : GetChildren.getChildren()){
        		TECWrapperData.add(GetSubChildren.getText());
        	}
            TransitExceptionCountWrapper TECWrapper = new TransitExceptionCountWrapper(TECWrapperData[0],TECWrapperData[1],TECWrapperData[2],TECWrapperData[3],TECWrapperData[4]);
        	TECWrapperList.add(TECWrapper);
        }
        return TECWrapperList;
    }
    
    public Static List<TransitExceptionDetailWrapper> TYES_TransitDetail_ResponseParser(String res, String WbSrNr){
    	List<TransitExceptionDetailWrapper> TEDWrapperList = new List<TransitExceptionDetailWrapper>();
        Dom.Document docForResponse = new dom.Document();
        docForResponse.load(res);
        Dom.XmlNode res_envelope = docForResponse.getRootElement();
        Dom.XmlNode bodyElement = res_envelope.getChildElement(NS_StaticVariablesUtility.Body, NS_StaticVariablesUtility.soapNS);
        Dom.XmlNode QueueDetailsResponseElement = bodyElement.getChildElement(NS_StaticVariablesUtility.GetTransitExceptionQueueDetailsResponse, NS_StaticVariablesUtility.tem);
        Dom.XmlNode QueueDetailResultElement = QueueDetailsResponseElement.getChildElement(NS_StaticVariablesUtility.GetTransitExceptionQueueDetailsResult, NS_StaticVariablesUtility.tem);
        Dom.XmlNode StatusElement = QueueDetailResultElement.getChildElement(NS_StaticVariablesUtility.Status, NS_StaticVariablesUtility.TransitExceptionQueueUri);
        Dom.XmlNode ExceptionDetailElement = QueueDetailResultElement.getChildElement(NS_StaticVariablesUtility.TansitExceptionQueueDetails, NS_StaticVariablesUtility.TransitExceptionQueueUri);
        for(Dom.XmlNode GetChildren : ExceptionDetailElement.getChildren()){
        	List<String> TEDWrapperData = new List<String>();
            for(Dom.XmlNode GetSubChildren : GetChildren.getChildren()){
        		TEDWrapperData.add(GetSubChildren.getText());
        	}
            TransitExceptionDetailWrapper TEDWrapper = new TransitExceptionDetailWrapper(WbSrNr,TEDWrapperData[0],TEDWrapperData[1],TEDWrapperData[2],TEDWrapperData[3],TEDWrapperData[4],TEDWrapperData[5],TEDWrapperData[6],TEDWrapperData[7],TEDWrapperData[8]);
        	TEDWrapperList.add(TEDWrapper);
        }
        return TEDWrapperList;
    }
     
    public Static GCSWrapper TYES_GCS_ResponseParser(String res){
                   
        Dom.Document docForResponse = new dom.Document();
        docForResponse.load(res);
        Dom.XmlNode res_envelope = docForResponse.getRootElement();
        Dom.XmlNode bodyElement = res_envelope.getChildElement(NS_StaticVariablesUtility.Body, NS_StaticVariablesUtility.soapNS);
        Dom.XmlNode CustomerSummaryResponseElement = bodyElement.getChildElement(NS_StaticVariablesUtility.GetCustomerSummaryResponse, NS_StaticVariablesUtility.tem);
        Dom.XmlNode GetCustomerSummaryResultElement = CustomerSummaryResponseElement.getChildElement(NS_StaticVariablesUtility.GetCustomerSummaryResult, NS_StaticVariablesUtility.tem);
        Dom.XmlNode StatusElement = GetCustomerSummaryResultElement.getChildElement(NS_StaticVariablesUtility.Tyes_Status, NS_StaticVariablesUtility.tyes);
        Dom.XmlNode CodeElement = StatusElement.getChildElement(NS_StaticVariablesUtility.Code, NS_StaticVariablesUtility.b);
        
        GCSWrapper gcsData = new GCSWrapper();
        if(CodeElement.getText() == '0'){    
            List<EquipmentSummary> eSummaryList = new List<EquipmentSummary>();
            List<String> EquipSumList;
            Dom.XmlNode GetEquipmentSummaryElement = GetCustomerSummaryResultElement.getChildElement(NS_StaticVariablesUtility.EquipmentSummary, NS_StaticVariablesUtility.SucessURI); 
            for(Dom.XmlNode GetChildren : GetEquipmentSummaryElement.getChildren()){
                EquipSumList= new List<String>();
                for(Dom.XmlNode GetChildreninfo : GetChildren.getChildren()){
                    EquipSumList.add(GetChildreninfo.getText());    
                }
                EquipmentSummary es = new EquipmentSummary(GetChildren.getName(),EquipSumList[0],EquipSumList[1],EquipSumList[2],EquipSumList[3],EquipSumList[4]);
                eSummaryList.add(es);              
            }
            gcsData.EquipmentElement = eSummaryList;
            
            
            //Service Window            
            Dom.XmlNode GetScheduleElement = GetCustomerSummaryResultElement.getChildElement(NS_StaticVariablesUtility.Schedule, NS_StaticVariablesUtility.SucessURI);
            List<CustomerSummarySchedule> cssList = new List<CustomerSummarySchedule>();
            for(Dom.XmlNode GetSummaryScheduleChildren : GetScheduleElement.getChildren()){
                List<String> scheduleDataList = new List<String>();
                for(Dom.XmlNode SubChild : GetSummaryScheduleChildren.getChildren()){
                    scheduleDataList.add(SubChild.getText());   
                }
                CustomerSummarySchedule css = new CustomerSummarySchedule(scheduleDataList[0],scheduleDataList[1],scheduleDataList[2],scheduleDataList[3],scheduleDataList[4]);
                cssList.add(css);
            }
            gcsData.scheduleElement = cssList;
            
            //Special Instruction
            Dom.XmlNode GetSpecialInstructionsElement = GetCustomerSummaryResultElement.getChildElement(NS_StaticVariablesUtility.SpecialInstructions, NS_StaticVariablesUtility.SucessURI);
            for(Dom.XmlNode GetChildren : GetSpecialInstructionsElement.getChildren()){
                gcsData.SpecialInstructionElement = GetChildren.getText();                
            }
            
            //General Instruction
            Dom.XmlNode GetSummaryBulletsElement = GetCustomerSummaryResultElement.getChildElement(NS_StaticVariablesUtility.SummaryBullets, NS_StaticVariablesUtility.SucessURI);
            List<String> genInstList = new List<String>();
            for(Dom.XmlNode GetChildren : GetSummaryBulletsElement.getChildren()){
                genInstList.add(GetChildren.getText());                
            }
            SummaryBullets sbull = new SummaryBullets(genInstList[0],genInstList[1]);
            gcsData.GeneralInstructionElement = sbull;
         }
         return gcsData;
    }   
    
    public Static LOPADataWrapper LOPA_getMetricsResponseParser(String response){
        Dom.Document docForResponse = new dom.Document();
        docForResponse.load(response);
        Dom.XmlNode res_envelope = docForResponse.getRootElement();
        Dom.XmlNode bodyElement = res_envelope.getChildElement(NS_StaticVariablesUtility.Body, NS_StaticVariablesUtility.soapNS);
        Dom.XmlNode RouteReportResponse = bodyElement.getChildElement(NS_StaticVariablesUtility.GetLOPAMetricsReportResponse, NS_StaticVariablesUtility.tem);
        Dom.XmlNode RouteReportResult = RouteReportResponse.getChildElement(NS_StaticVariablesUtility.GetLOPAMetricsReportResult, NS_StaticVariablesUtility.tem);
        Dom.XmlNode RouteReportStatus = RouteReportResult.getChildElement(NS_StaticVariablesUtility.Tyes_Status, NS_StaticVariablesUtility.b);
        Dom.XmlNode RouteReportCode = RouteReportStatus.getChildElement(NS_StaticVariablesUtility.Code, NS_StaticVariablesUtility.b);
        if(RouteReportCode.getText() == '0'){
            String NonCompliantCustomerRSN = RouteReportResult.getChildElement(NS_StaticVariablesUtility.NonCompliantCustomerRSN, NS_StaticVariablesUtility.a_LOPA).getText();
            String NonCompliantMechRSN = RouteReportResult.getChildElement(NS_StaticVariablesUtility.NonCompliantMechRSN, NS_StaticVariablesUtility.a_LOPA).getText();
            String NonCompliantRRRSN = RouteReportResult.getChildElement(NS_StaticVariablesUtility.NonCompliantRRRSN, NS_StaticVariablesUtility.a_LOPA).getText();
            String PercentFailureCustRsn = RouteReportResult.getChildElement(NS_StaticVariablesUtility.PercentFailureCustRsn, NS_StaticVariablesUtility.a_LOPA).getText();
            String PercentFailureMechRsn = RouteReportResult.getChildElement(NS_StaticVariablesUtility.PercentFailureMechRsn, NS_StaticVariablesUtility.a_LOPA).getText();
            String PercentFailureRRRsn = RouteReportResult.getChildElement(NS_StaticVariablesUtility.PercentFailureRRRsn, NS_StaticVariablesUtility.a_LOPA).getText();
            String PercentTotalFailure = RouteReportResult.getChildElement(NS_StaticVariablesUtility.PercentTotalFailure, NS_StaticVariablesUtility.a_LOPA).getText();
            String TotalPending = RouteReportResult.getChildElement(NS_StaticVariablesUtility.TotalPending, NS_StaticVariablesUtility.a_LOPA).getText();
            String TotalPlanned = RouteReportResult.getChildElement(NS_StaticVariablesUtility.TotalPlanned, NS_StaticVariablesUtility.a_LOPA).getText();
            
            LOPADataWrapper lwd = new LOPADataWrapper(NonCompliantCustomerRSN,NonCompliantMechRSN,NonCompliantRRRSN,PercentFailureCustRsn,PercentFailureMechRsn,PercentFailureRRRsn,PercentTotalFailure,TotalPending,TotalPlanned);
            return lwd;
        }
        return null;
    }
    
    public Static List<RouteReportWrapper> RouteReportResponseParser(String response){
        List<RouteReportWrapper> rrList = new List<RouteReportWrapper>();
        Dom.Document docForResponse = new dom.Document();
        docForResponse.load(response);
        
        Dom.XmlNode res_envelope = docForResponse.getRootElement();
        Dom.XmlNode bodyElement = res_envelope.getChildElement(NS_StaticVariablesUtility.Body, NS_StaticVariablesUtility.soapNS);
        Dom.XmlNode RouteReportResponse = bodyElement.getChildElement(NS_StaticVariablesUtility.GetCustomerRouteReportResponse, NS_StaticVariablesUtility.tem);
        Dom.XmlNode RouteReportResult = RouteReportResponse.getChildElement(NS_StaticVariablesUtility.GetCustomerRouteReportResult, NS_StaticVariablesUtility.tem);
        Dom.XmlNode RouteReportRecords = RouteReportResult.getChildElement(NS_StaticVariablesUtility.CustomerRouteReportRecords, NS_StaticVariablesUtility.a1);
        
        for(Dom.XmlNode childElement : RouteReportRecords.getChildElements()){
            if(childElement.getName() == NS_StaticVariablesUtility.CustomerRouteReportRecord){
                Dom.XmlNode RouteID = childElement.getChildElement(NS_StaticVariablesUtility.RouteID, NS_StaticVariablesUtility.a1);                
                Dom.XmlNode Stn = childElement.getChildElement(NS_StaticVariablesUtility.Stn, NS_StaticVariablesUtility.a1);
                Dom.XmlNode StnName = childElement.getChildElement(NS_StaticVariablesUtility.StnName, NS_StaticVariablesUtility.a1);
                Dom.XmlNode MondayInd = childElement.getChildElement(NS_StaticVariablesUtility.MondayInd, NS_StaticVariablesUtility.a1);
                Dom.XmlNode TuesdayInd = childElement.getChildElement(NS_StaticVariablesUtility.TuesdayInd, NS_StaticVariablesUtility.a1);
                Dom.XmlNode WednesdayInd = childElement.getChildElement(NS_StaticVariablesUtility.WednesdayInd, NS_StaticVariablesUtility.a1);
                Dom.XmlNode ThursdayInd = childElement.getChildElement(NS_StaticVariablesUtility.ThursdayInd, NS_StaticVariablesUtility.a1);
                Dom.XmlNode FridayInd = childElement.getChildElement(NS_StaticVariablesUtility.FridayInd, NS_StaticVariablesUtility.a1);                
                Dom.XmlNode SaturdayInd = childElement.getChildElement(NS_StaticVariablesUtility.SaturdayInd, NS_StaticVariablesUtility.a1);
                Dom.XmlNode SundayInd = childElement.getChildElement(NS_StaticVariablesUtility.SundayInd, NS_StaticVariablesUtility.a1);
                
                RouteReportWrapper rr = new RouteReportWrapper(RouteID.getText(),Stn.getText(),StnName.getText(),MondayInd.getText(),TuesdayInd.getText(),WednesdayInd.getText(),ThursdayInd.getText(),FridayInd.getText(),SaturdayInd.getText(),SundayInd.getText()); 
                rrList.add(rr);
            }
        }
        
        return rrList;
    } 
    
    //** END - Methods to Parse the response body **//
    
    public class RouteReportWrapper{
        @AuraEnabled public string RouteID;
        @AuraEnabled public string Station;
        @AuraEnabled public string StationName;
        @AuraEnabled public string MondayInd;
        @AuraEnabled public string TuesdayInd;
        @AuraEnabled public string WednesdayInd;
        @AuraEnabled public string ThursdayInd;
        @AuraEnabled public string FridayInd;
        @AuraEnabled public string SaturdayInd;
        @AuraEnabled public string SundayInd;
        
        public RouteReportWrapper(String RID, String Stn, String StnName, String MnInd, String TuInd, String WdInd, String ThInd, String FrInd, String StInd, String SnInd){
            RouteID = RID;
            Station = Stn;
            StationName = StnName;
            MondayInd = MnInd;
            TuesdayInd = TuInd;
            WednesdayInd = WdInd;
            ThursdayInd = ThInd;
            FridayInd = FrInd;
            SaturdayInd = StInd;
            SundayInd = SnInd;
        }
    }
    
    public class LOPADataWrapper{
        @AuraEnabled public String NonCompliantCustomerRSN;
        @AuraEnabled public String NonCompliantMechRSN;
        @AuraEnabled public String NonCompliantRRRSN;
        @AuraEnabled public String PercentFailureCustRsn;
        @AuraEnabled public String PercentFailureMechRsn;
        @AuraEnabled public String PercentFailureRRRsn;
        @AuraEnabled public String PercentTotalFailure;
        @AuraEnabled public String TotalPending;
        @AuraEnabled public String TotalPlanned;
        
        public LOPADataWrapper(String NonCompCustRSN,String NonCompMechRSN, String NonCompRRRSN, String PercentFailCustRsn, String PercentFailMechRsn, 
                               String PercentFailRRRsn, String PercentTotalFail, String TotPending, String TotPlanned){
            NonCompliantCustomerRSN = NonCompCustRSN;
            NonCompliantMechRSN = NonCompMechRSN;
            NonCompliantRRRSN = NonCompRRRSN;
            PercentFailureCustRsn = PercentFailCustRsn;
            PercentFailureMechRsn = PercentFailMechRsn;
            PercentFailureRRRsn = PercentFailRRRsn;
            PercentTotalFailure = PercentTotalFail;
            TotalPending = TotPending;
            TotalPlanned = TotPlanned;
        }        
    }
    
    public class GCSWrapper{
        @AuraEnabled public String SpecialInstructionElement;
        @AuraEnabled public List<CustomerSummarySchedule> scheduleElement;
        @AuraEnabled public List<EquipmentSummary> EquipmentElement;
        @AuraEnabled public SummaryBullets GeneralInstructionElement;
    }
    
    public class CustomerSummarySchedule{
        @AuraEnabled public String CutOffDayOfWeek;
        @AuraEnabled public String CutoffTimeDisplay;
        @AuraEnabled public String ScheduleCloseTime;
        @AuraEnabled public String ScheduleDayOfWeek;
        @AuraEnabled public String ScheduleOpenTime;
        
        public CustomerSummarySchedule(String CutOffDOW, String CutoffTimeDisp, String SchCloseTime, String SchDayOfWeek, String SchOpenTime){
            CutOffDayOfWeek = CutOffDOW;
            CutoffTimeDisplay = CutoffTimeDisp;
            ScheduleCloseTime = SchCloseTime;
            ScheduleDayOfWeek = SchDayOfWeek;
            ScheduleOpenTime = SchOpenTime;   
        }
    }
    
    public class EquipmentSummary{
        @AuraEnabled public String TagName;
        @AuraEnabled public String EmptyCount;
        @AuraEnabled public String Length;
        @AuraEnabled public String LoadCount;
        @AuraEnabled public String TotalCount;
        @AuraEnabled public String Weight;
        
        public EquipmentSummary(String tname, String EptyCount, String Lnth, String LoadCnt, String TotalCnt, String TotalWeight){
            TagName = tname;
            EmptyCount = EptyCount;
            Length = Lnth;
            LoadCount = LoadCnt;
            TotalCount = TotalCnt;
            Weight = TotalWeight;   
        }
    }
    
    public class SummaryBullets{
        @AuraEnabled public String string1;
        @AuraEnabled public String string2;
        
        public SummaryBullets(String str1, String str2){
            string1 = str1;
            string2 = str2;    
        }
    }
    
    public class TransitExceptionDetailWrapper{
        @AuraEnabled public String AdditionalDetails;
        @AuraEnabled public String ControlStation;
        @AuraEnabled public String DelayReason;
        @AuraEnabled public String EqInit;
        @AuraEnabled public String EqNr;
        @AuraEnabled public String OperatingStation;
        @AuraEnabled public String PLANNEDMOVEMENTDATE;
		@AuraEnabled public String PLANNEDMOVEMENTTRAIN;
        @AuraEnabled public String QueueInsertDtm;
        @AuraEnabled public String WaybillSrNr;
        
        public TransitExceptionDetailWrapper(){}
        
        public TransitExceptionDetailWrapper(String WbSrNr, String AddDetails, String CntrlStation, String DlayReason, String EqInt, String EqNumber, String OpratinStation, String PlanMovemntDTM, String PlanMovemntTrain, String QInsertDtm){
            AdditionalDetails = AddDetails;
            ControlStation = CntrlStation;
            DelayReason = DlayReason;
            EqInit = EqInt;
            EqNr = EqNumber;
            OperatingStation = OpratinStation;
            PLANNEDMOVEMENTDATE = PlanMovemntDTM;
            PLANNEDMOVEMENTTRAIN = PlanMovemntTrain;
            WaybillSrNr = WbSrNr;
            QueueInsertDtm = QInsertDtm;
        }
    }
    
    public class TransitExceptionCountWrapper{
        @AuraEnabled public String EquipmentInit;
        @AuraEnabled public String EquipmentNr;
        @AuraEnabled public String EquipmentDTM;
        @AuraEnabled public String TEQCount;
        @AuraEnabled public String WaybillSrNr;
        
        public TransitExceptionCountWrapper(){}
        
        public TransitExceptionCountWrapper(String EquipInit, String EquipNr, String EquipDTM, String TEQCnt, String WaybillSrNum){
            EquipmentInit = EquipInit;
            EquipmentNr = EquipNr;
            EquipmentDTM = EquipDTM;
            TEQCount = TEQCnt;
            WaybillSrNr = WaybillSrNum;
        }
    }
}