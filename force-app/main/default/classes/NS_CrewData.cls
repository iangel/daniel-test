public class NS_CrewData implements NS_WebService {
    /*Send invocation for callout*/    
    public string invokeCallout(NS_IntegParams datum){ 
        string endpoint = NS_IntegrationUtility_Tyes.TYES_ENDPOINT; 
        string  body = NS_WsRequestBodyFactory.getCustomerRouteReportReqBody(datum.getUserId(), datum.getClassCode(), datum.getstationCode());
        body = NS_IntegrationUtility_Tyes.prepareSignedBody(body);   
        return parseResponse(NS_WSCallout.sendRequest(endpoint, NS_IntegrationUtility.POST_METHOD, NS_IntegrationUtility.CONTENT_TYPE, NS_StaticVariablesUtility.CustomerRouteReport_Action, body));
    }
    /* Parse the response*/
    @TestVisible
    private String parseResponse(String response){
        List<NS_RouteReportWrapper> rrList = new List<NS_RouteReportWrapper>();
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
                
                NS_RouteReportWrapper rr = new NS_RouteReportWrapper(RouteID.getText(),Stn.getText(),StnName.getText(),MondayInd.getText(),TuesdayInd.getText(),WednesdayInd.getText(),ThursdayInd.getText(),FridayInd.getText(),SaturdayInd.getText(),SundayInd.getText()); 
                rrList.add(rr);
            }
        }
        
        return JSON.serialize(rrList);
    } 
    
}