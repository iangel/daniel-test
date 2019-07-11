public class NS_TransitExceptionDetail implements NS_WebService{
 /* Action name for Transit Exception Details*/      
    public final static String TRANS_EXP_Q_DET_ACTION = 'http://tempuri.org/ISalesForceDataService/GetTransitExceptionQueueDetails';
 
    public String invokeCallout(NS_IntegParams datum){        
     String endpoint = NS_IntegrationUtility_Tyes.TYES_ENDPOINT; 
     String body = NS_WsRequestBodyFactory.getTransitExDetailReqBody(datum.getUserId(), datum.getClassCode(), datum.getstationCode(), 
                                                              datum.getEquipInt(), datum.getEquipNr(), datum.getWaybillSrNr() );
        body = NS_IntegrationUtility_Tyes.prepareSignedBody(body);
      String res = NS_WSCallout.sendRequest(endpoint, NS_IntegrationUtility.POST_METHOD, NS_IntegrationUtility.CONTENT_TYPE,TRANS_EXP_Q_DET_ACTION, body);
   
        return responseParser(res,datum.getWaybillSrNr());
    
     }
	@TestVisible    
      private String responseParser(String res, String WbSrNr){
    	List<NS_TransitExceptionDetailWrapper> TEDWrapperList = new List<NS_TransitExceptionDetailWrapper>();
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
            NS_TransitExceptionDetailWrapper TEDWrapper = new NS_TransitExceptionDetailWrapper(WbSrNr,TEDWrapperData[0],TEDWrapperData[1],TEDWrapperData[2],TEDWrapperData[3],TEDWrapperData[4],TEDWrapperData[5],TEDWrapperData[6],TEDWrapperData[7],TEDWrapperData[8]);
        	TEDWrapperList.add(TEDWrapper);
        }
        
        return JSON.serialize(TEDWrapperList);
    }
     
}