/*======================================================================================================
* @Class Name : NS_WebServiceHandler_Teams
* @author : Accenture
* @Purpose: This is a Callout Service class to make HTTP callout for Teams
* @created date: 09-01-2018
* @Change Logs:									
----------------------------------------------------------------------------------------------------------
Developer name        Date          Description        
----------------------------------------------------------------------------------------------------------
@Arjun Ghosh          09-01-2019    Request No.   , Phase-II
Methods Created: invokeCarRequestService(),carRequestResponseParser()
Inner class:CarRequestWrapper
----------------------------------------------------------------------------------------------------------
@Arjun Ghosh          15-02-2019    Request No.   , Phase-II
Change Note: Class structure changed.
==========================================================================================================*/

public class NS_CarRequestSummary implements NS_WebService{
    /* ================================================
* @Method Name : invokeCarRequestService
* @author id: arjun.c.ghosh@accenture.com
* @Purpose: This method is used to make a callout to get the TEAMS CarRequestSummary data
* @Parameters: String ClassCode,String StationCode,String ServingRoad, String StartWeekDate
* @return: CarRequestWrapper
* @created date: 09-01-2019
================================================*/    
    public  String invokeCallout(NS_IntegParams datum){     
        Date weekStart=getStrtWkDt();
        String startWeekDate=weekStart.month()+'/'+weekStart.day()+'/'+weekStart.year();
        String endpoint = NS_IntegrationUtility_Teams.TEAMS_ENDPOINT;
        String action=NS_IntegrationUtility_Teams.CAR_REQ_SUMMARY_ACTION;
        String body = NS_WsRequestBodyFactory.getCarRequestBody(datum.getClassCode(), datum.getstationCode(), datum.getServingRoad(),startWeekDate,datum.getUserId());
        String signedBody =NS_IntegrationUtility_Teams.prepareSignedBody(body);
        String response=NS_WSCallout.sendRequest(endpoint, NS_StaticVariablesUtility.postmethod, NS_StaticVariablesUtility.contentType,action, signedBody);
        String ret=carRequestResponseParser(response,weekStart);        
        return ret;
       
    }
    /* ================================================
* @Method Name : carRequestResponseParser
* @author id: arjun.c.ghosh@accenture.com
* @Purpose: This method is used to parse the xml response from the Action GetCarRequestSummary
* @Parameters: String response, Date End date of the week
* @return: CarRequestWrapper
* @created date: 09-01-2019
================================================*/ 
    @TestVisible
    private String  carRequestResponseParser(String response,Date weekStart){             
        String parsedResponse=null;
        List<NS_CarRequestWrapper> rrListforCurrentWeek = new List<NS_CarRequestWrapper>();
        List<NS_CarRequestWrapper> rrListforNextWeek = new List<NS_CarRequestWrapper>();
        Map<String,List<NS_CarRequestWrapper>> mCrList=new Map<String,List<NS_CarRequestWrapper>>();
        Dom.Document docForResponse = new dom.Document();
        docForResponse.load(response);          
        Dom.XmlNode res_envelope = docForResponse.getRootElement();
        Dom.XmlNode bodyElement=res_envelope.getChildElement(NS_IntegrationUtility.BODY, NS_IntegrationUtility.SOAP_NS);
        Dom.XmlNode getCarRequestSummaryResponse =bodyElement.getChildElement(NS_IntegrationUtility_Teams.ELEMENT_CRSRES,NS_IntegrationUtility.TEM);
        Dom.XmlNode getCarRequestSummaryResult=getCarRequestSummaryResponse.getChildElement(NS_IntegrationUtility_Teams.ELEMENT_CRSR,NS_IntegrationUtility.TEM);
        Dom.XmlNode carRequestSummaryList=getCarRequestSummaryResult.getChildElement(NS_IntegrationUtility_Teams.ELEMENT_CRSL,NS_IntegrationUtility_Teams.NS_CRSL);
        for(Dom.XmlNode carRequestSummary : carRequestSummaryList.getChildElements()){
            Dom.XmlNode accepted= carRequestSummary.getChildElement(NS_IntegrationUtility_Teams.ACCEPTED, NS_IntegrationUtility_Teams.NS_CRS);  
            Dom.XmlNode customerPattern= carRequestSummary.getChildElement(NS_IntegrationUtility_Teams.C_PATTERN, NS_IntegrationUtility_Teams.NS_CRS);
            Dom.XmlNode fulfilled= carRequestSummary.getChildElement(NS_IntegrationUtility_Teams.F_FILLED, NS_IntegrationUtility_Teams.NS_CRS);
            Dom.XmlNode loadFill= carRequestSummary.getChildElement(NS_IntegrationUtility_Teams.L_FILL, NS_IntegrationUtility_Teams.NS_CRS);
            Dom.XmlNode marketingPriorityRank= carRequestSummary.getChildElement(NS_IntegrationUtility_Teams.MPR, NS_IntegrationUtility_Teams.NS_CRS);
            Dom.XmlNode orderFill= carRequestSummary.getChildElement(NS_IntegrationUtility_Teams.O_FILL, NS_IntegrationUtility_Teams.NS_CRS);
            Dom.XmlNode projected= carRequestSummary.getChildElement(NS_IntegrationUtility_Teams.PROJECTED, NS_IntegrationUtility_Teams.NS_CRS);
            Dom.XmlNode requestFill= carRequestSummary.getChildElement(NS_IntegrationUtility_Teams.R_FILL, NS_IntegrationUtility_Teams.NS_CRS);
            Dom.XmlNode requested= carRequestSummary.getChildElement(NS_IntegrationUtility_Teams.REQUESTED, NS_IntegrationUtility_Teams.NS_CRS);
            Dom.XmlNode startWeekDate= carRequestSummary.getChildElement(NS_IntegrationUtility_Teams.SWD, NS_IntegrationUtility_Teams.NS_CRS);
            Dom.XmlNode surplusShortage= carRequestSummary.getChildElement(NS_IntegrationUtility_Teams.S_SHORT, NS_IntegrationUtility_Teams.NS_CRS);
            Dom.XmlNode weeklyFillTarget= carRequestSummary.getChildElement(NS_IntegrationUtility_Teams.WFT, NS_IntegrationUtility_Teams.NS_CRS);
            NS_CarRequestWrapper cr = new NS_CarRequestWrapper(accepted.getText(),customerPattern.getText(),fulfilled.getText(),
                                                         loadFill.getText(),marketingPriorityRank.getText(),orderFill.getText(),
                                                         projected.getText(),requestFill.getText(),requested.getText(),
                                                         startWeekDate.getText(),surplusShortage.getText(),weeklyFillTarget.getText()); 
            Date dt= date.parse(cr.startWeekDate);            
            if(dt.daysBetween(weekStart)==0){                
                rrListforCurrentWeek.add(cr);                
            }else if(dt.daysBetween(weekStart)==-7){
                rrListforNextWeek.add(cr);                
            }            
            mCrList.put(NS_IntegrationUtility_Teams.cWk, rrListforCurrentWeek);
            mCrList.put(NS_IntegrationUtility_Teams.nWk, rrListforNextWeek); 
        }    
       
          parsedResponse= JSON.serialize(mCrList);        
        return parsedResponse;
    }
    private  Date getStrtWkDt(){
         Date myDate = Date.today();
		Date weekStartSunday = myDate.toStartofWeek();
        /* For NS Requirement, Start of week is defined as Monday*/
        Date weekStart=weekStartSunday.addDays(1);
      return weekStart;       
    }
}