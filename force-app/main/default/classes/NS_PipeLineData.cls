/*
Description  : This class is used for invoking AEMS & parsing the response received for Pipeline Data from AEMS
Developer    : Accenture Solutions
Date         : 06-04-2019

-----------------------------------------------------------------------
Developer name        Date          Description        
-----------------------------------------------------------------------
@Arjun Ghosh          06-04-2019    Invoke AEMS & parse the response received for Pipeline Data from AEMS
@Arjun Ghosh          22-04-2019    If Station code =GARDN then send GARDN-PW to AEMS
*/
public class NS_PipeLineData implements NS_WebService{
    /* Action name for Transit Exception Summary*/    
    public final static String PIPELINE_ACTION ='http://aemsws.integration.aems.nscorp.com';
    /*Hard coding for the station code GARDN*/
    public final  static String GARDN ='GARDN';
    /*If Station code =GARDN then send GARDN-PW to AEMS*/
    public final  String GARDN_PW ='GARDN-PW';
    /*XML Keys*/
    public final  String ES_RES='getEquipmentSummaryResponse';
    /*XML Keys*/
    public final  String ES_RET='getEquipmentSummaryReturn';
    /*XML Keys*/
    public final  String ONSITE='onsite';
    /*XML Keys*/
    public final  String RECEIVING='receiving';
    /*Hard coded value*/
    public final  String NOT_AVAIL='NA';
    /*Hard coded value*/
    public final  String BLANK='';
    
    /*Implementation of invokeCallout from NS_WebService Interface*/
    public string invokeCallout(NS_IntegParams datum){
        String response;
        string endpoint = NS_IntegrationUtility_AEMS.AEMS_ENDPOINT; 
        String stationCode=datum.getstationCode();
        System.debug('Station code:'+stationCode);
        if(GARDN.equalsIgnoreCase(stationCode)){
            stationCode=GARDN_PW;
        }
        string  body = NS_WsRequestBodyFactory.getPipeLineReqBodyAEMS(stationCode);
        body = NS_IntegrationUtility_AEMS.prepareSignedBody(body);
       
            response = NS_WSCallout.sendRequest(endpoint, NS_IntegrationUtility.POST_METHOD, NS_IntegrationUtility.CONTENT_TYPE, PIPELINE_ACTION, body);
               return responseParser(response);
        
    }
    /* Parse the response and send it as a String*/
    @TestVisible
    private String responseParser(String res){
        NS_GCS.GCSWrapper gcsData = new NS_GCS.GCSWrapper();
        List<NS_GCS.EquipmentSummary> eSummaryList = new List<NS_GCS.EquipmentSummary>();
        Dom.Document docForResponse = new dom.Document();
        docForResponse.load(res);
        Dom.XmlNode res_envelope = docForResponse.getRootElement();
        Dom.XmlNode bodyElement = res_envelope.getChildElement(NS_StaticVariablesUtility.Body, NS_StaticVariablesUtility.soapNS);
        Dom.XmlNode equipmentSummaryResponseElement = bodyElement.getChildElement(ES_RES,PIPELINE_ACTION);
        Dom.XmlNode equipmentSummaryReturnElement = equipmentSummaryResponseElement.getChildElement(ES_RET,PIPELINE_ACTION);                                                                        //NS_StaticVariablesUtility.i);   
        String onSite=equipmentSummaryReturnElement.getChildElement(ONSITE, PIPELINE_ACTION).getText();
        String receivingData=equipmentSummaryReturnElement.getChildElement(RECEIVING,PIPELINE_ACTION).getText();
        
        List<String> EquipSumList=new List<String>();
        EquipSumList.add(receivingData);
        EquipSumList.add(onSite);
        EquipSumList.add(NOT_AVAIL);
        
        for(String equip:EquipSumList){
            NS_GCS.EquipmentSummary es = new NS_GCS.EquipmentSummary(BLANK,BLANK,BLANK,BLANK,equip,BLANK);
            eSummaryList.add(es);   
        }
        gcsData.EquipmentElement = eSummaryList;
        
        return JSON.serialize(gcsData);
    }
    
}