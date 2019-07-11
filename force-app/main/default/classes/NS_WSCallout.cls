public class NS_WSCallout {
    /*Http request CONTENT_TYPE_CONST*/
    public final Static String CONTENT_TYPE_CONST = 'Content-Type';
    /*Http request SOAPAction*/
    public final static String SOAP_ACTION = 'SOAPAction';
    /* ================================================
* @Method Name : sendRequest
* @author id: arjun.c.ghosh@accenture.com
* @Purpose: This method is used to make webservice SOAP callout and can be used across all interfaces 
* @Parameters: String Endpoint, String Method, String contentType, String action, String body
* @return: String
* @created date: 07-02-2019
==================================================*/
    public Static String sendRequest(String endpoint, String method, String contentType, String action, String body){
        HttpRequest hreq = new HttpRequest();
        hreq.setEndpoint(endpoint);
        hreq.setMethod(method);
        hreq.setHeader(CONTENT_TYPE_CONST, contentType);
        hreq.setHeader(SOAP_ACTION, action);
        hreq.setBody(body);
        System.debug('Request Body:'+body);
        Http http = new Http();
        HTTPResponse hres = http.send(hreq);
        System.debug('Response from NS_WSCallout>>>>'+hres.getbody());
        System.debug('Response status>>>>'+hres.getStatus());
        return hres.getbody();
    }
   /* public static String prepareSignedBody(String body){
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
    */
}