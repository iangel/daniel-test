/*======================================================================================================
* @Class Name : NS_WebServiceHandler_Teams
* @author : Accenture
* @Purpose: This is a Callout Service class to make HTTP callout for Transit Exception
* @created date: 09-01-2018
* @Change Logs:									
----------------------------------------------------------------------------------------------------------
Developer name        Date          Description        
----------------------------------------------------------------------------------------------------------
@Arjun Ghosh          28-02-2019    Request No.   , Phase-II
Methods Created: invokeCarRequestService(),carRequestResponseParser()
==========================================================================================================*/
public class NS_TransitExp implements NS_WebService{
/* Action name for Transit Exception Summary*/    
public final Static String TRANSIT_EXCQUEUECNT_ACTION = 'http://tempuri.org/ISalesForceDataService/GetTransitExceptionQueueCounts';
   
    public string invokeCallout(NS_IntegParams datum){ 
        string endpoint = NS_IntegrationUtility_Tyes.TYES_ENDPOINT; 
        string  body = NS_WsRequestBodyFactory.getTransitExCountReqBody(datum.getUserId(), datum.getClassCode(), datum.getstationCode());
        body = NS_IntegrationUtility_Tyes.prepareSignedBody(body);   
        String res = NS_WSCallout.sendRequest(endpoint, NS_IntegrationUtility.POST_METHOD, NS_IntegrationUtility.CONTENT_TYPE, TRANSIT_EXCQUEUECNT_ACTION, body);
        return responseParser(res);
    }
    @TestVisible
     private String responseParser(String res){
    	List<NS_TransitExceptionCountWrapper> TECWrapperList = new List<NS_TransitExceptionCountWrapper>();
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
            NS_TransitExceptionCountWrapper TECWrapper = new NS_TransitExceptionCountWrapper(TECWrapperData[0],TECWrapperData[1],TECWrapperData[2],TECWrapperData[3],TECWrapperData[4]);
        	TECWrapperList.add(TECWrapper);
        }
        return JSON.serialize(TECWrapperList);
    }
    
}