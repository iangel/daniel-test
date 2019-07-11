public class NS_Lopa implements NS_WebService {
    /* Xml vars */
    public final static string GET_LMR_RESPONSE = 'GetLOPAMetricsReportResponse';
    /* Xml vars */
    public final static string N_COMP_CUST_RSN = 'NonCompliantCustomerRSN';
    /* Xml vars */
    public final static string N_COMP_MERC_RSN = 'NonCompliantMechRSN';
    /* Xml vars */
    public final static string N_COMP_RRRSN = 'NonCompliantRRRSN';
    /* Xml vars */
    public final static string PCT_FAIL_CUST_RSN = 'PercentFailureCustRsn';
    /* Xml vars */
    public final static string PCT_FAIL_MECH_RSN= 'PercentFailureMechRsn';
    /* Xml vars */
    public final static string PCT_FAIL_RRRSN = 'PercentFailureRRRsn';
    /* Xml vars */
    public final static string PCT_TOT_FAIL = 'PercentTotalFailure';
 	/* Xml vars */
    public final static string TOT_PEND = 'TotalPending';
    /* Xml vars */
    public final static string TOT_PLAN = 'TotalPlanned';
    /* Xml namespaces */
    private final static string LOPA_ACTION = 'http://tempuri.org/ISalesForceDataService/GetLOPAMetricsReport';
    /* Xml vars */
    public final static string GET_LMR_RESULT = 'GetLOPAMetricsReportResult';
    /* Xml vars */
    public final static string CODE = 'Code';
	/* Xml namespaces */
    private final static string A_LOPA = 'http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.LOPAMetrics';
    /*Send invocation for callout*/
    public string invokeCallout(NS_IntegParams datum){ 
        
        string endpoint = NS_IntegrationUtility_Tyes.TYES_ENDPOINT; 
        string  body = NS_WsRequestBodyFactory.getLOPAReqBody(datum.getUserId(), datum.getClassCode(), datum.getstationCode());
        body = NS_IntegrationUtility_Tyes.prepareSignedBody(body);   
        return parseResponse(NS_WSCallout.sendRequest(endpoint, NS_IntegrationUtility.POST_METHOD, NS_IntegrationUtility.CONTENT_TYPE, LOPA_ACTION, body));
    }
     @TestVisible
    private string parseResponse(string response){
        String parsedResponse=null;
        Dom.Document docForResponse = new dom.Document();
        docForResponse.load(response);
        Dom.XmlNode res_envelope = docForResponse.getRootElement();
        Dom.XmlNode bodyElement = res_envelope.getChildElement(NS_IntegrationUtility.BODY, NS_IntegrationUtility.SOAP_NS);
        Dom.XmlNode routeRepResp = bodyElement.getChildElement(GET_LMR_RESPONSE, NS_IntegrationUtility.TEM);
        Dom.XmlNode routeRepResult = routeRepResp.getChildElement(GET_LMR_RESULT,  NS_IntegrationUtility.TEM);
        Dom.XmlNode routeReportStatus = routeRepResult.getChildElement(NS_IntegrationUtility_Tyes.TYES_STATUS, NS_IntegrationUtility_Tyes.b);
        Dom.XmlNode routeReportCode = routeReportStatus.getChildElement(CODE, NS_IntegrationUtility_Tyes.b);
        if(routeReportCode.getText() == '0'){
            string nCompCustRsn = routeRepResult.getChildElement(N_COMP_CUST_RSN, A_LOPA).getText();
            string nCompMercRsn = routeRepResult.getChildElement(N_COMP_MERC_RSN, A_LOPA).getText();
            string nCompRrrsn = routeRepResult.getChildElement(N_COMP_RRRSN, A_LOPA).getText();
            string pctFailCustRsn = routeRepResult.getChildElement(PCT_FAIL_CUST_RSN, A_LOPA).getText();
            string pctFailMechRsn = routeRepResult.getChildElement(PCT_FAIL_MECH_RSN, A_LOPA).getText();
            string pctFailRrrsn  = routeRepResult.getChildElement(PCT_FAIL_RRRSN, A_LOPA).getText();
            string pctTotFail = routeRepResult.getChildElement(PCT_TOT_FAIL, A_LOPA).getText();
            string totPend = routeRepResult.getChildElement(TOT_PEND, A_LOPA).getText();
            string totPlan = routeRepResult.getChildElement(TOT_PLAN, A_LOPA).getText();
            NS_LopaDataWrapper lwd = new NS_LopaDataWrapper(nCompCustRsn,nCompMercRsn,nCompRrrsn,pctFailCustRsn,
                                                            pctFailMechRsn,pctFailRrrsn,pctTotFail,totPend,totPlan);
            parsedResponse= JSON.serialize(lwd);
            
        }
        return parsedResponse;
    }
    
}