/*
Description  : This class has callout methods for ANI Maintenance webservice callout
Developer    : Accenture Solutions
Date         : 24-05-2018
*/

public class NS_WebServiceHandler_ANIMaintenance {
    
    Static String body;
    Static String endpoint;
    
    //** Start - Methods to invoke ANI Maintenance **//
    
    public Static void prepareOfflineAccAniUpdateBody(String uId, String ActionInd, List<NS_StaticVariablesUtility.OfflineAccAniMaintenanceWrapper> offlineAccAniMaintenanceList){  
        endpoint = NS_StaticVariablesUtility.VDN_endpoint;
        body = NS_StaticVariablesUtility.offlineAccAniMaintenance(uId,ActionInd,offlineAccAniMaintenanceList);
        body = prepareSignedBody();
        invoke_offlineAccAniUpdate(body,endpoint);
    }
    
    @future (callout=true)
    public Static void invoke_offlineAccAniUpdate(String body,String endpoint){
        System.debug(sendRequest(endpoint, NS_StaticVariablesUtility.postmethod, NS_StaticVariablesUtility.contentType, NS_StaticVariablesUtility.ManageOfflineCustomerANIAction, body));
    }
    
    public Static void prepareManageOnlineCustomerContactRequest(List<NS_StaticVariablesUtility.ManageOnlineCustomerContactWrapper> CustomerContactWrapperList){  
        String userFederationId = [Select FederationIdentifier from user where ID = :UserInfo.getUserId()].FederationIdentifier;        
        body = NS_StaticVariablesUtility.ManageOnlineCustomerContact(userFederationId,CustomerContactWrapperList);
        
        system.debug('Integration Request body'+body);
        system.debug('Wrapper: '+CustomerContactWrapperList);
        body = prepareSignedBody();
        invoke_ManageOnlineCustomerContact(body);
        System.debug('Signed body: '+body);
    }
    
    @future (callout=true)
    public Static void invoke_ManageOnlineCustomerContact(String body){  
        endpoint = NS_StaticVariablesUtility.VDN_endpoint;
        System.debug(sendRequest(endpoint, NS_StaticVariablesUtility.postmethod, NS_StaticVariablesUtility.contentType, NS_StaticVariablesUtility.ManageOnlineCustomerContactAction, body));
    }
    
    @future (callout=true)
    public Static void invoke_SetCustomerVDN(String uId, String cCode, String sCode, String VDNExt){  
        endpoint = NS_StaticVariablesUtility.VDN_endpoint;
        body = NS_StaticVariablesUtility.getCustomerVDNBody(uId,cCode,sCode,VDNExt);
        body = prepareSignedBody();
        System.debug(sendRequest(endpoint, NS_StaticVariablesUtility.postmethod, NS_StaticVariablesUtility.contentType, NS_StaticVariablesUtility.OnlineCustomerVDNAction, body));
    }
    
    @future (callout=true)
    public Static void invoke_VDN_Maintenance(String uId, String ActionInd, String Description, String NewVDNExten, String OldVDNExten){     
        endpoint = NS_StaticVariablesUtility.VDN_endpoint;
        body = NS_StaticVariablesUtility.getVDNMaintenanceBody(uId,ActionInd,Description,NewVDNExten,OldVDNExten);
        body = prepareSignedBody();
        System.debug(sendRequest(endpoint, NS_StaticVariablesUtility.postmethod, NS_StaticVariablesUtility.contentType, NS_StaticVariablesUtility.VDNMaintenanceAction, body));
    }
    
    //** End - Methods to invoke ANI Maintenance **//
    
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
        if(test.isRunningTest()){
        HttpRequest hreq = new HttpRequest();
        hreq.setTimeout(20000);
        hreq.setEndpoint(endpoint);
        hreq.setMethod(method);
        hreq.setHeader(NS_StaticVariablesUtility.Content_Type, contentType);
        hreq.setHeader(NS_StaticVariablesUtility.SOAPAction, action);
        hreq.setBody(body);
        Http http = new Http();
        System.debug('Request>>>>'+body);
        System.debug('Request>>>>'+hreq.getbody());
        //HTTPResponse hres = http.send(hreq);
        //System.debug('Response>>>>'+hres.getBody());
        return null;
        }else{
                    HttpRequest hreq = new HttpRequest();
        hreq.setTimeout(20000);
        hreq.setEndpoint(endpoint);
        hreq.setMethod(method);
        hreq.setHeader(NS_StaticVariablesUtility.Content_Type, contentType);
        hreq.setHeader(NS_StaticVariablesUtility.SOAPAction, action);
        hreq.setBody(body);
        Http http = new Http();
        System.debug('Request>>>>'+body);
        System.debug('Request>>>>'+hreq.getbody());
        HTTPResponse hres = http.send(hreq);
        System.debug('Response>>>>'+hres.getBody());
        return hres.getbody();
        }
    }
    
    //** END - Methods to Make the HTTP Callout **//
  public Static void prepareManageOnlineCustomerContactDeleteRequest(List<NS_StaticVariablesUtility.ManageOnlineCustomerContactDeleteWrapper> CustomerContactWrapperList){  
        String userFederationId = [Select FederationIdentifier from user where ID = :UserInfo.getUserId()].FederationIdentifier;        
       
            body = NS_StaticVariablesUtility.ManageOnlineCustomerContactonDelete(userFederationId,CustomerContactWrapperList);
       
       
        body = prepareSignedBody();
        invoke_ManageOnlineCustomerContactonDelete (body);
    }
    
     @future (callout=true)
    public Static void invoke_ManageOnlineCustomerContactonDelete(String body){  
        System.debug('invoke_ManageOnlineCustomerContactonDelete');
        endpoint = NS_StaticVariablesUtility.VDN_endpoint;
        String responseCode=  sendRequest(endpoint, NS_StaticVariablesUtility.postmethod, NS_StaticVariablesUtility.contentType, NS_StaticVariablesUtility.ManageOnlineCustomerContactAction, body);
        
    }
    
  
}