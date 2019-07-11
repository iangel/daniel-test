/*
Description  : This class is created to sync contact to Teams when Updated/Deleted. The contact should belong to a service account.
Developer    : Accenture Solutions
Date         : 12-03-2018
-----------------------------------------------------------------------
Developer name        Date          Description        
-----------------------------------------------------------------------
@Debosmeeta Paul    12-03-2018     Added Method to sync contact
*/
public class NS_OnlineCustomerContactTEP{
     Static Final Id GENERALCONTACT = [SELECT Id FROM RecordType WHERE DeveloperName ='NS_GeneralContact'].Id; /*Only for General Contact we have sent data to server.*/
     Static Final String CLASS_NAME = 'NS_OnlineCustomerContactTEP';  /*Needed data to record in case of Exception*/
     Static Final String METHOD_NAME = 'invokeManageOnlineCustomerContactOnInsertTEP'; /*Needed data to record in case of Exception*/
     /*For sending data to TEP*/
     public Final Static String MESSAGESOURCE = 'ConnectNS'; 
     /*For sending data to TEP*/
     public Final Static String MEDIATYPE = 'E'; /*4/4 mapping change from Email to E per TEP req*/
     public Final Static String WORK = 'W'; /*4/4 mapping change from Work to W per TEP req*/
     public Final Static String CELL = 'C'; /*4/4 mapping change from Cell to C per TEP req*/
     public Final Static String OTHER1 = 'O1'; /*4/4 mapping change from Other1 to 01 per TEP req*/
     public Final Static String OTHER2 = 'O2'; /*4/4 mapping change from Other2 to 02 per TEP req*/
     public Final Static String FAX = 'F'; /*4/4 mapping change from Fax to F per TEP req*/

     public Final Static String WORKPHONE = 'Work Phone'; /*For checking preferred contact type*/
     public Final Static String MOBILEPHONE = 'Mobile Phone'; /*For checking preferred contact type*/
     public Final Static String OTHERPHONE1 = 'Other Phone 1'; /*For checking preferred contact type*/
     public Final Static String OTHERPHONE2 = 'Other Phone 2'; /*For checking preferred contact type*/
     
     public Final Static String BLANK = ''; /*For checking null values*/
     public Static String CustomerContactChange_Teams = ''; /*For endpoint url*/
     public Final Static String CONTENTTYPE = 'text/xml;charset=UTF-8'; /*Content type of request sent to server.*/
     public Final Static String TEPCONTACTUPDATEACTION = '/CustomerContactChange.serviceagent/CustomerContactChangeEP/PublishCustomerContact'; /* Action of request sent.*/
     
     public Final Static String POSTMETHOD = 'POST'; /*Method defined sent to server.*/
     public Final Static String ENDPOINT_VALUE = 'CustomerContactChange_Teams';
     public Final Static String UID_VALUE = 'SFDC1';
     public Final Static String RECORDTYPE_VALUE = 'NS_OnlineCustomerService';
     public Final Static String PROFILE_CHECK = 'NS Integration User';
     public Final Static String ONE = '1';
     public Final Static String TWO = '2';
     static {
        Map<String,NS_Integration_Endpoints__c> endpoints = NS_Integration_Endpoints__c.getAll();  
        if(endpoints.containsKey(ENDPOINT_VALUE)){
            CustomerContactChange_Teams = endpoints.get(ENDPOINT_VALUE).Endpoint_URL__c;
        }
      }
     public static boolean isValidForSync(Contact con){
        boolean check = false;
        if(con.RecordTypeId == GENERALCONTACT)
            check = true;
        return check;
    }
    public String resetUserIdOnNull(String uId){
        if(uId == null || uId == ''){
            uId = UID_VALUE;    
        } 
        return uId;
    }
    /*Description: Assigning values to Wrapper for TEP Services for ConnectNS 
     *Phase 2
     *Developer name: Debosmeeta Paul
     *Date: 02-27-2019
     */
    public static void invokeManageOnlineCustomerContactOnInsertTEP(Map<Id, Contact> newMap, String action){
        system.debug('I m in ');
        Set<Id> AccountIdSet = new Set<Id>();
        List<ManageOnlineCustomerContactWrapperTEP> CustomerContactWrapperList;
        CustomerContactWrapperList = new List<ManageOnlineCustomerContactWrapperTEP>();
        
        Id onLineServiceAccount = [SELECT Id FROM RecordType WHERE DeveloperName =: RECORDTYPE_VALUE].Id;
        
        Set<Id> rtIds = new Set<Id>();
        rtIds.add(OnLineServiceAccount);
        
        for(Contact newContact : newMap.values()){
            AccountIdSet.add(newContact.AccountId);
        }
        String ProfileName = [Select Profile.Name from user where ID = :UserInfo.getUserId()].Profile.Name;
        Map<Id,Account> AccountMap = new Map<Id, Account>([Select Id,RecordTypeId,NS_ClassCode__c,NS_ControllingStation__c,NS_OperatingStation__c,NS_OperatingStation__r.name 
                                                           from Account 
                                                           where Id IN :AccountIdSet and RecordTypeId IN :rtIds]);
        for(Contact newContact : newMap.values()){  
            if(ProfileName != PROFILE_CHECK){
                System.debug('NS_RACF:'+newContact.NS_RACF_ID__c+' con id:'+newContact.Id);
                if(newContact.NS_RACF_ID__c != null){ 
                    if(isValidForSync(newContact)){
                        if(AccountMap.containsKey(newContact.AccountId)){                
                            Account contactsAccount = AccountMap.get(newContact.AccountId);                
                            ManageOnlineCustomerContactWrapperTEP mocw = new ManageOnlineCustomerContactWrapperTEP();
                            mocw.MessageSource = MessageSource;
                           
                            mocw.ContactType = newContact.NS_ContactType__c == null ? BLANK : newContact.NS_ContactType__c;
                          
                            mocw.ContactUserId = newContact.NS_RACF_ID__c == null ? BLANK : newContact.NS_RACF_ID__c;
                           
                            mocw.ContactStatus = newContact.NS_ContactStatus__c == null ? BLANK : newContact.NS_ContactStatus__c;
                            mocw.NameTitle = newContact.Salutation == null ? BLANK : newContact.Salutation;
                            mocw.FirstName = newContact.FirstName == null ? BLANK : newContact.FirstName;
                           
                            mocw.LastName = newContact.LastName == null ? BLANK : newContact.LastName;
                           
                            mocw.Comments = newContact.Description == null ? BLANK : newContact.Description;
                           
                            mocw.PhoneType = newContact.Phone != null ? WORK : BLANK;
                            mocw.PhonePriority = newContact.NS_PrefConMethd__c == null ? ONE : newContact.NS_PrefConMethd__c == WORKPHONE ? ONE : TWO;
                            mocw.PhoneNumber = newContact.Phone != null && newContact.NS_Work_Phone_Ext__c != null? newContact.Phone+'x'+newContact.NS_Work_Phone_Ext__c : newContact.Phone != null? newContact.Phone : BLANK;
                            
                           
                            mocw.MobilePhoneType = newContact.MobilePhone != null ? CELL : BLANK;
                            mocw.MobilePhonePriority = newContact.NS_PrefConMethd__c == null ? TWO : newContact.NS_PrefConMethd__c == MOBILEPHONE ? ONE : TWO;
                            mocw.MobilePhoneNumber = newContact.MobilePhone != null ? newContact.MobilePhone : BLANK;
                            mocw.MobileProviderName = newContact.MobilePhone == null ? BLANK : newContact.NS_MobileServiceProvider__c != null ?  newContact.NS_MobileServiceProvider__c : BLANK;
                          
                            mocw.OtherPhoneType1 = newContact.OtherPhone != null ? OTHER1 : BLANK;
                            mocw.OtherPhonePriority1 = newContact.NS_PrefConMethd__c == null ? TWO : newContact.NS_PrefConMethd__c == OTHERPHONE1 ? ONE : TWO;
                            mocw.OtherPhoneNumber1 = newContact.OtherPhone != null ? newContact.OtherPhone : BLANK;
                            
                            mocw.OtherPhoneType2 = newContact.HomePhone != null ? OTHER2 : BLANK;
                            mocw.OtherPhonePriority2 = newContact.NS_PrefConMethd__c == null ? TWO : newContact.NS_PrefConMethd__c == OTHERPHONE2 ? ONE : TWO;
                            mocw.OtherPhoneNumber2 = newContact.HomePhone != null ? newContact.HomePhone : BLANK;
                            
                            mocw.FaxPhoneType = FAX;
                            mocw.FaxPhonePriority = TWO;
                            mocw.FaxPhoneNumber = newContact.Fax != null ? newContact.Fax : BLANK;
                            
                         
                            mocw.Street_Address = newContact.MailingStreet == null ? BLANK : newContact.MailingStreet;
                            mocw.City = newContact.MailingCity == null ? BLANK : newContact.MailingCity;
                            mocw.State_Province_Region = newContact.MailingState == null ? BLANK : newContact.MailingState;
                            mocw.State_Province_Region_Abbreviation = newContact.MailingState == null ? BLANK : newContact.MailingState;
                            mocw.Country = newContact.MailingCountry == null ? BLANK : newContact.MailingCountry;
                            mocw.ZipCode = newContact.MailingPostalCode == null ? BLANK : newContact.MailingPostalCode;
                          
                            mocw.MediaType = newContact.Email == null ? BLANK : MEDIATYPE;
                            mocw.Media = newContact.Email == null ? BLANK : newContact.Email;
                          
                            mocw.CommodityDesc = newContact.NS_Commodity_UTS__c == null ? BLANK : newContact.NS_Commodity_UTS__c;
                            CustomerContactWrapperList.add(mocw);
                            
                            try{
                              prepareManageOnlineCustomerContactRequestTEP(CustomerContactWrapperList,action);
                            }
                            catch(Exception e){
                                NS_StaticVariablesUtility.createExceptionRecord(e, CLASS_NAME, METHOD_NAME);
                            }
                            
                            break;
                            }
                        }
                    }
                else{
                   Exception__c excep = new Exception__c();
                    excep.Name = 'RACF ID is null for ' +newContact.id ; 
                    excep.Class_Name__c = CLASS_NAME;
                    excep.Method_Name__c = METHOD_NAME;
                    excep.Description__c = 'RACF ID is mandatory for TEP Server integration';
                    excep.Line_No__c = 1126;
                    insert excep;
                   break;
                }
            }
        }
    }
    
    /*Description: Wrapper for TEP Services for ConnectNS 
     *Phase 2
     *Developer name: Debosmeeta Paul
     *Date: 02-27-2019
     */
    public class ManageOnlineCustomerContactWrapperTEP{
        public string MessageSource = BLANK ;
        public string ContactBusinessUnit = BLANK ;
        public string ContactSourceName = BLANK ;
        public string ContactType = BLANK ;
        public string DisplayName = BLANK ;
        public string DisplayImage = BLANK ;
        public string ContactUserId = BLANK ;
        public string ContactRole = BLANK ;
        public string ContactStatus = BLANK ;
        public string NameTitle = BLANK ;
        public string FirstName = BLANK ;
        public string MiddleName = BLANK ;
        public string LastName = BLANK ;
        public string NameSuffix = BLANK ;
        public string JobTitle = BLANK ;
        public string ContactTimezone = BLANK ;
        public string Comments = BLANK ;
        public string UserId = BLANK ;
        public string SourceCode = BLANK ;
        public string Confidentiality = BLANK ;
        public string PhoneType = BLANK ;
        public string PhonePriority = BLANK ;
        public string PhoneNumber = BLANK ;
        public string ProviderName = BLANK ;
        public string PhoneComments = BLANK ;
        public string MobilePhoneType = BLANK ;
        public string MobilePhonePriority = BLANK ;
        public string MobilePhoneNumber = BLANK ;
        public string MobileProviderName = BLANK ;
        public string MobilePhoneComments = BLANK ;
        public string OtherPhoneType1 = BLANK ;
        public string OtherPhonePriority1 = BLANK ;
        public string OtherPhoneNumber1 = BLANK ;
        public string OtherPhoneType2 = BLANK ;
        public string OtherPhonePriority2 = BLANK ;
        public string OtherPhoneNumber2 = BLANK ;
        public string FaxPhoneType = BLANK ;
        public string FaxPhonePriority = BLANK ;
        public string FaxPhoneNumber = BLANK ;
        public string StreetAddressType = BLANK ;
        public string Street_Address = BLANK ;
        public string City = BLANK ;
        public string State_Province_Region = BLANK ;
        public string State_Province_Region_Abbreviation = BLANK ;
        public string Country = BLANK ;
        public string ZipCode = BLANK ;
        public string AddressComments = BLANK ;
        public string MediaType = BLANK ;
        public string Media = BLANK ;
        public string MediaComments = BLANK ;
        public string CommodityType = BLANK ;
        public string CommodityDesc = BLANK ; 
    }
     /*Description: Creating the body for TEP Services for ConnectNS 
     *Phase 2
     *Developer name: Debosmeeta Paul
     *Date: 02-27-2019
     */
    private static void prepareManageOnlineCustomerContactRequestTEP(List<ManageOnlineCustomerContactWrapperTEP> CustomerContactWrapperList,String action){  
        String userFederationId = [Select FederationIdentifier from user where ID = :UserInfo.getUserId()].FederationIdentifier;        
        String body;
        body = NS_WsRequestBodyFactory.ManageOnlineCustomerContactTEP(userFederationId,CustomerContactWrapperList);
        
        
        body = prepareSignedBodyTEP(action,body);
        
        invoke_ManageOnlineCustomerContactTEP(body);
    }
    /*Invoking the request to send data from SF to TEP server*/
     @future (callout=true)
    public static void invoke_ManageOnlineCustomerContactTEP(String body){  
        String endpoint = CustomerContactChange_Teams;
        System.debug(NS_WSCallout.sendRequest(endpoint, POSTMETHOD, CONTENTTYPE, TEPCONTACTUPDATEACTION, body));
    }
    
    //** Start - Methods to Cryto Sign the request body **//
    private Static String prepareSignedBodyTEP(String action,String body){
        Dom.Document doc = new dom.Document();
        dom.XmlNode envelope = doc.createRootElement(NS_StaticVariablesUtility.Envelope, NS_StaticVariablesUtility.soapNS, NS_StaticVariablesUtility.soapenv);
        dom.XmlNode nodeHeader = envelope.addChildElement(NS_StaticVariablesUtility.Header, NS_StaticVariablesUtility.soapNS, null);
        nodeHeader.setNamespace('v1','http://www.nscorp.com/tep/customerchange/v1.0');
        dom.XmlNode nodeMsgHeader = nodeHeader.addChildElement('MessageHeaderInfo','http://www.nscorp.com/tep/customerchange/v1.0','v1');
        dom.XmlNode nodeActionHeader = nodeMsgHeader.addChildElement('ActionType','http://www.nscorp.com/tep/customerchange/v1.0','v1').addTextNode(action);
        dom.XmlNode nodeSourceHeader = nodeMsgHeader.addChildElement('MessageSourceName','http://www.nscorp.com/tep/customerchange/v1.0','v1').addTextNode(MESSAGESOURCE);
        dom.XmlNode nodeBusinessHeader = nodeMsgHeader.addChildElement('ContactBusinessUnit','http://www.nscorp.com/tep/customerchange/v1.0','v1');
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
     
    
    
    //** START - Cyrto Sign an element **//
    
    private static void cryptoSign(dom.XmlNode envelopebody){
        System.Crypto.signXml(NS_StaticVariablesUtility.RSA_SHA1, envelopebody, null, NS_StaticVariablesUtility.CRM);
    }
    
    //** END - Cyrto Sign an element **//
    
    //** Start - Methods to Remove extra X509 tags from Cyro sign request **//
    
    private static void removeX509Tags(Dom.XmlNode sigElement){    
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
}