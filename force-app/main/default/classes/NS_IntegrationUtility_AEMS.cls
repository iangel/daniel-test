public class NS_IntegrationUtility_AEMS {
/*Endpoint for AEMS*/
    public final static string AEMS_ENDPOINT;
    /*Custom setting name for AEMS*/
    public final static string CUST_SETTING_PD='AEMS_PipelineData';
    /*Static block to fetch Endpoints from custom settings*/
    static {
        Map<String,NS_Integration_Endpoints__c> endpoints = NS_Integration_Endpoints__c.getAll();
        if(endpoints.containsKey(CUST_SETTING_PD)){
            AEMS_ENDPOINT = endpoints.get(CUST_SETTING_PD).Endpoint_URL__c;
        }else{
            AEMS_ENDPOINT='';
        }         
    }
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
        nodeSecurity.insertBefore(sigElement , nodeTest);
        nodeSecurity.removeChild(nodeTest);
        envelopeb.removeChild(sigElement);
        envelope.insertBefore(envelopeb,null);
        return doc.toXMLString();
    }    
   
}