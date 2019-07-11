/*======================================================================================================
* @Class Name : NS_IntegrationUtility_Teams
* @author : Accenture
* @Purpose: This class is an Utility Class to be used across Interfaces which makes webservice Callouts, 
SOQLS Related to Integration Classes, Prepares signed Req Header Across Interfaces
* @created date: 09-01-2018
* @Change Logs:									
----------------------------------------------------------------------------------------------------------
Developer name        Date          Description        
----------------------------------------------------------------------------------------------------------
@Arjun Ghosh          09-01-2019    Phase-II
Methods Created: prepareSignedBodyforCarRequestService(),sendRequest()
----------------------------------------------------------------------------------------------------------
Record next changes here
==========================================================================================================*/
public class NS_IntegrationUtility_Teams {
    /*Endpoint for Teams*/
     public final static String TEAMS_ENDPOINT;
    
    /*Custom setting name for Teams*/
    public final static String CUST_SETTING_TEAMS='TEAMS_Endpoint';
    /*Static block to fetch Endpoints from custom settings*/
    static {
        Map<String,NS_Integration_Endpoints__c> endpoints = NS_Integration_Endpoints__c.getAll();
        system.debug('endpoints test'+ endpoints);
        if(endpoints.containsKey(CUST_SETTING_TEAMS)){
            TEAMS_ENDPOINT = endpoints.get(CUST_SETTING_TEAMS).Endpoint_URL__c;
        }else{
            TEAMS_ENDPOINT='';
        }         
    }
    /*CAR REQUEST SUMMARY ACTION*/
    public final static String CAR_REQ_SUMMARY_ACTION='http://tempuri.org/ICarRequestService/GetCarRequestSummary';
    /*Keys for retreiving the values car requests of current week from the Map in client side*/
    public final static String cWk='currentWeek';
    /*Keys for retreiving the values car requests of next week from the Map in client side*/
    public final static String nWk='nextWeek';
    /* Variables for parsing response received from GetCarRequestSummary request*/
    public final static String ACCEPTED='Accepted';
    /* Variables for parsing response received from GetCarRequestSummary request*/
    public final static String C_PATTERN = 'CustomerPattern';
    /* Variables for parsing response received from GetCarRequestSummary request*/
    public final static String F_FILLED='Fulfilled';
    /* Variables for parsing response received from GetCarRequestSummary request*/
    public final static String L_FILL='LoadFill';
    /* Variables for parsing response received from GetCarRequestSummary request*/
    public final static String MPR='MarketingPriorityRank';
    /* Variables for parsing response received from GetCarRequestSummary request*/
    public final static String O_FILL='OrderFill';
    /* Variables for parsing response received from GetCarRequestSummary request*/
    public final static String PROJECTED='Projected';
    /* Variables for parsing response received from GetCarRequestSummary request*/
    public final static String R_FILL='RequestFill';
    /* Variables for parsing response received from GetCarRequestSummary request*/
    public final static String REQUESTED='Requested';
    /* Variables for parsing response received from GetCarRequestSummary request*/
    public final static String SWD='StartWeekDate';
    /* Variables for parsing response received from GetCarRequestSummary request*/
    public final static String S_SHORT='SurplusShortage';
    /* Variables for parsing response received from GetCarRequestSummary request*/
    public final static String WFT='WeeklyFillTarget';
    
    /* Namespace for CarRequestSummary*/
    public final static String NS_CRS='http://schemas.datacontract.org/2004/07/NS.TEAMS.Domain.Models.CarRequest';
     /* Namespace for CarRequestSummaryList*/
    public final static String NS_CRSL='http://schemas.datacontract.org/2004/07/NS.TEAMS.Web.Api.WCF.CarRequest.EmptyCarRequestService';
     /* Element for CarRequestSummaryList*/
    public final static String ELEMENT_CRSL='CarRequestSummaryList';
    /* Element for GetCarRequestSummaryResult*/
    public final static String ELEMENT_CRSR='GetCarRequestSummaryResult';
    
    /* Element for GetCarRequestSummaryResponse*/
    public final static String ELEMENT_CRSRES='GetCarRequestSummaryResponse';
    /* ================================================
* @Method Name : prepareSignedBodyforCarRequestService
* @author id: arjun.c.ghosh@accenture.com
* @Purpose: This method is used to create the request body Cryto Sign it and remove the X.509 tags from it for CAR_REQUEST_SERVICE(TEAMS) only
* @Parameters: String response
* @return: CarRequestWrapper
* @created date: 09-01-2019
==================================================*/ 
   public static String prepareSignedBody(String body){
        Dom.Document doc = new dom.Document();
        dom.XmlNode envelope = doc.createRootElement(NS_StaticVariablesUtility.Envelope, NS_StaticVariablesUtility.soapNS, NS_StaticVariablesUtility.soapenv);
        dom.XmlNode nodeHeader = envelope.addChildElement(NS_StaticVariablesUtility.Header, NS_StaticVariablesUtility.soapNS, null);
        dom.XmlNode nodeSecurity = nodeHeader.addChildElement(NS_StaticVariablesUtility.Security, NS_StaticVariablesUtility.wsseNS, NS_StaticVariablesUtility.wsse);
        dom.XmlNode nodeTest = nodeSecurity.addChildElement(NS_StaticVariablesUtility.Test, NS_StaticVariablesUtility.soapNS , NS_StaticVariablesUtility.soapenv);
        Dom.Document docForBody = new dom.Document();
        docForBody.load(body);
        dom.XmlNode envelopeb = docForBody.getRootElement();
        System.Crypto.signXml(NS_StaticVariablesUtility.RSA_SHA1, envelopeb, null, NS_StaticVariablesUtility.CRM);
        Dom.XmlNode sigElement = envelopeb.getChildElement(NS_StaticVariablesUtility.Signature, NS_StaticVariablesUtility.sigNS);        
        /*Removing the X509Tags*/     
        for(Dom.XmlNode childElement : sigElement.getChildElements()){
            if(childElement.getName() == NS_StaticVariablesUtility.KeyInfo){
                removeX509(childElement);
            }
        }
        nodeSecurity.insertBefore(sigElement , nodeTest);
        nodeSecurity.removeChild(nodeTest);
        envelopeb.removeChild(sigElement);
        envelope.insertBefore(envelopeb,null);
        return doc.toXMLString();
    }    
    public static Dom.XmlNode removeX509(Dom.XmlNode childElement){
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
        return childElement;
    }    
}