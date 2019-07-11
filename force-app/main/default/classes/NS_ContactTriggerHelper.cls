/**@author  Accenture
* @Created Date 2018-03-11
* @version  1.0
* @description This class conatins method to auto-create and update Associated Account based on Contact's primary Account name 
*/ 
public without sharing class NS_ContactTriggerHelper {
    
    /*Class Name*/
    private static final String CLASS_NAME = 'NS_ContactTriggerHelper';
    /*Method Name*/ 
    private static final String METHOD_NAME='beforeContactInsert';
    private static final String METHOD_NAME1='beforeContactUpdate';
    private static final String METHOD_NAME2='createAssociatedAccount';
    private static final String METHOD_NAME3='updateAssociatedAccount';
    private static final String METHOD_NAME4='getAssocAcc';
    private static final String METHOD_NAME5='autoPopulateContactAddress';
    private static final String METHOD_NAME7='getRecTypeId';
    private static final String METHOD_NAME8='deleteAssocAccountOnMerge';
    //private static final String METHOD_NAME8='getDummyAccountId';
    
    /*Preferred Contact Method Constants*/
    private static final String PHONE='Work Phone';
    private static final String MOBILE_PHONE='Mobile Phone';
    private static final String OTHER_PHONE1='Other Phone 1';
    private static final String OTHER_PHONE2='Other Phone 2';
    private static final String EMAIL='Email';
    
    /**@author-  Accenture
*  @description- To populate business unit based on users business unit,contact Owner as NS Integration User,Updating Contact
*  Record Type based on Contact Status,auto-create and auto-update Associated Account based on Contact's primary Account name. 
*  @param- List of contacts
*  @return- None
*  @throws- None
*/ 
    public static void beforeContactInsert(List<Contact> conList){
        NS_TriggerSettings__c customset = NS_TriggerSettings__c.getValues(NS_StaticVariablesUtility.conTrigger);
        if(customset.NS_IsActive__c){
            String userName = UserInfo.getUserName();
            String businessUnit=NS_StaticVariablesUtility.CONST_BLANK;
            String integrationUserId=NS_StaticVariablesUtility.CONST_BLANK;
            Integer count =limits.getLimitQueryRows();
            Id activeContactRTId = getRecTypeId(NS_StaticVariablesUtility.conActiveRecordType);            
            Set<Id> setAccId = new Set<Id>();
            Map<Id,Account> accMap = new Map<Id,Account>();
            try{
                /*Getting Integration user and current user*/
                for( User usr : [Select Id,Username,name,Associated_Business_Unit__c From User where 
                                 Username = : userName OR name=:NS_StaticVariablesUtility.integrationUserName LIMIT:count]){
                                     if(usr.Username.equals(userName)){
                                         businessUnit = usr.Associated_Business_Unit__c;
                                     }
                                     if(NS_StaticVariablesUtility.integrationUserName.equalsIgnoreCase(usr.name)){
                                         integrationUserId = usr.Id;
                                     }
                                 } 
                
                for (Contact con : conList){
                    if(con.RecordTypeId.equals(activeContactRTId)) {
                        /*Auto Capitalization of Contact FirstName and LastName*/
                        String fName = con.FirstName;
                        con.FirstName=fName.toUpperCase();
                        String lName = con.LastName;
                        con.LastName=lName.toUpperCase();
                        /*Contact Owner as NS Integration User*/
                        con.OwnerId = integrationUserId;
                        /*Updating Orphan Contact with Dummy Account*/
                        if(con.AccountId != null){
                            
                            setAccId.add(con.Accountid);
                        }
                        if(!string.isBlank(businessUnit)){
                            if(string.isBlank(con.NS_BusinessUnit__c)){
                                con.NS_BusinessUnit__c = businessUnit;
                                con.NS_TextBusinessUnit__c = businessUnit;
                            }
                            else {
                                con.NS_BusinessUnit__c =con.NS_BusinessUnit__c;
                                con.NS_TextBusinessUnit__c = con.NS_BusinessUnit__c;
                            }
                        }
                    }
                }
                for (Account acc: [SELECT BillingCity,BillingCountry,BillingPostalCode,BillingState,BillingStreet,Id,
                                   NS_BillingAddressDetails__c,NS_MailingAddressCity__c,NS_MailingAddressCountry__c,
                                   NS_MailingAddressDetails__c,NS_MailingAddressState__c,NS_MailingAddressStreet__c,
                                   NS_MailingAddressZip__c,NS_PhysicalAddressCity__c,NS_PhysicalAddressCountry__c,
                                   NS_PhysicalAddressDetails__c,NS_PhysicalAddressState__c,NS_PhysicalAddressStreet__c,
                                   NS_PhysicalAddressZip__c,NS_ShippingAddressDetails__c,ShippingCity,ShippingCountry,
                                   ShippingPostalCode,ShippingState,ShippingStreet FROM Account WHERE Id IN :setAccId 
                                   LIMIT:count]){
                                       accMap.put(acc.Id,acc);
                                   }
                for (Contact con : conList){
                    if(con.RecordTypeId.equals(activeContactRTId) && con.AccountId != null) {
                        autoPopulateContactAddress(con,accMap.get(con.AccountId));
                    }
                }
            }
            catch (Exception exp) {
                /*Inserting a record in Exception object*/
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME);
            }
        }
    }
    
    /*Updating Contact Record Type based on Contact Status*/ 
    public static void beforeContactUpdate(Map<Id,Contact> newConMap, Map<Id,Contact> oldConMap){
        NS_TriggerSettings__c customset = NS_TriggerSettings__c.getValues(NS_StaticVariablesUtility.conTrigger);
        if(customset.NS_IsActive__c){
            Id activeContactRTId = getRecTypeId(NS_StaticVariablesUtility.conActiveRecordType);
            Id inactiveContactRTId = getRecTypeId(NS_StaticVariablesUtility.inactiveRecordType);
            Id aniContactRTId = getRecTypeId(NS_StaticVariablesUtility.ANIRecordType);            
            List<Contact> listContact=new List<Contact>();
            try{
                for (Contact con : newConMap.values()){
                    if(con.RecordTypeId != aniContactRTId){ 
                        /*Auto Capitalization of Contact FirstName and LastName*/
                        String fName = con.FirstName;
                        con.FirstName=fName.toUpperCase();
                        String lName = con.LastName;
                        con.LastName=lName.toUpperCase();
                        
                        /*Updating Orphan Contact with Dummy Account*/
                        /*if(oldConMap.get(con.Id).AccountId!=con.AccountId && String.isBlank(con.AccountId)
&& con.NS_CustomerAccnt__c != null) {
con.AccountId = getDummyAccountId();  
}*/
                        /*Updating business unit value used in contact sharing settings*/
                        if(oldConMap.get(con.Id).NS_BusinessUnit__c!=con.NS_BusinessUnit__c) {
                            con.NS_TextBusinessUnit__c = con.NS_BusinessUnit__c;
                        }
                         /*Updating Preferred Contact Method to None if Chosed contact value is null*/
                        if(oldConMap.get(con.Id).Phone!=con.Phone && con.Phone==null) {
                           if(con.NS_PrefConMethd__c == PHONE) 
                           {
                              con.NS_PrefConMethd__c = null; 
                           } 
                        } 
                        else if(oldConMap.get(con.Id).MobilePhone!=con.MobilePhone && con.MobilePhone==null) {
                           if(con.NS_PrefConMethd__c == MOBILE_PHONE) 
                           {
                              con.NS_PrefConMethd__c = null; 
                           }
                        } 
                        else if(oldConMap.get(con.Id).OtherPhone!=con.OtherPhone && con.OtherPhone==null) {
                           if(con.NS_PrefConMethd__c == OTHER_PHONE1) 
                           {
                              con.NS_PrefConMethd__c = null; 
                           }  
                        } 
                        else if(oldConMap.get(con.Id).HomePhone!=con.HomePhone && con.HomePhone==null) {
                           if(con.NS_PrefConMethd__c == OTHER_PHONE2) 
                           {
                              con.NS_PrefConMethd__c = null; 
                           } 
                        } 
                        else if(oldConMap.get(con.Id).Email!=con.Email && con.Email==null) {
                           if(con.NS_PrefConMethd__c == EMAIL) 
                           {
                              con.NS_PrefConMethd__c = null; 
                           }
                        }
                    }
                    if(con.RecordTypeId.equals(activeContactRTId)){
                        /*Updating to Inactive Contact record type when contact status is inactive*/  
                        if(NS_StaticVariablesUtility.conInactiveStatus.equalsIgnoreCase(con.NS_ContactStatus__c)){  
                            con.RecordTypeId = inactiveContactRTId;
                        } 
                    }
                    /*Updating to Active Contact record type when contact status changed from Inactive to Active/Request Deactivation*/ 
                    else if(con.RecordTypeId.equals(inactiveContactRTId)){
                        if(oldConMap.get(con.Id).NS_ContactStatus__c!=con.NS_ContactStatus__c ){
                            con.RecordTypeId = activeContactRTId;
                        }
                    }
                }
            }
            catch (Exception exp) {
                /*Inserting a record in Exception object*/
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME1);
            }
        }
    }
    
    /*Creating Associated Account when Contact is created*/ 
    public static void createAssociatedAccount(List<Contact> conList){
        
        NS_TriggerSettings__c customset = NS_TriggerSettings__c.getValues(NS_StaticVariablesUtility.conTrigger);
        if(customset.NS_IsActive__c){
            Id activeContactRTId = getRecTypeId(NS_StaticVariablesUtility.conActiveRecordType);
            List<NS_AssociatedAccount__c> ascList = new List<NS_AssociatedAccount__c>();
            try{
                for (Contact con : conList){
                    /*Inserting Associated Account when contact is created with Account Name populated*/
                    if(con.RecordTypeId.equals(activeContactRTId) && con.AccountId != null){
                        ascList.add(getAssocAcc(con,true));
                    } 
                }
                if(!ascList.isEmpty()){
                    Database.SaveResult[] srList = Database.insert(ascList,false); 
                    NS_Utility.databaseSvResult(srList,METHOD_NAME2,CLASS_NAME);
                }
            }
            catch (Exception exp) {
                /*Inserting a record in Exception object*/
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME2);
            }
        }
    }
    
    /*Updating Associated Account when Contact is updated*/ 
    public static void updateAssociatedAccount(Map<Id,Contact> newConMap,Map<Id,Contact> oldConMap){ 
        NS_TriggerSettings__c customset = NS_TriggerSettings__c.getValues(NS_StaticVariablesUtility.conTrigger);
        if(customset.NS_IsActive__c){
            Integer count =limits.getLimitQueryRows();
            Id aniContactRTId = getRecTypeId(NS_StaticVariablesUtility.ANIRecordType);
            Map<Id,List<NS_AssociatedAccount__c>> assocMap = new Map<Id,List<NS_AssociatedAccount__c>>();
            List<NS_AssociatedAccount__c> assocList = new List<NS_AssociatedAccount__c>();
            List<NS_AssociatedAccount__c> ascList = new List<NS_AssociatedAccount__c>(); 
            try{
                for(NS_AssociatedAccount__c tempAssocAcc : [select Id,NS_AccountName__c,NS_PrimaryAccount__c,
                                                            NS_ContactName__c,NS_AccountRole__c 
                                                            from NS_AssociatedAccount__c 
                                                            where NS_ContactName__c = :newConMap.keyset() 
                                                            LIMIT:count])
                {
                    if(!assocMap.containsKey(tempAssocAcc.NS_ContactName__c))
                    {
                        assocMap.put(tempAssocAcc.NS_ContactName__c,new list<NS_AssociatedAccount__c>{tempAssocAcc});
                    }
                    else
                    {
                        assocMap.get(tempAssocAcc.NS_ContactName__c).add(tempAssocAcc);
                    }
                }
                for (Contact con : newConMap.values()){
                    if (con.RecordTypeId != aniContactRTId){

                        if(oldConMap.get(con.Id).AccountId!=con.AccountId || oldConMap.get(con.Id).NS_InternalContact__c!=con.NS_InternalContact__c || 
                           oldConMap.get(con.Id).firstname!=con.firstname ||
                           oldConMap.get(con.Id).lastname!=con.lastname || oldConMap.get(con.Id).MobilePhone!=con.MobilePhone ||
                           oldConMap.get(con.Id).Phone!=con.Phone || oldConMap.get(con.Id).OtherPhone!=con.OtherPhone ||
                           oldConMap.get(con.Id).HomePhone!=con.HomePhone ||oldConMap.get(con.Id).NS_ContactType__c!= con.NS_ContactType__c){
                               
                               /*Updating Associated Account record when the account name 
                               in contact was not blank and new value is assigned*/
                               if(oldConMap.get(con.Id).AccountId != null){                    
                                   if(assocMap.containsKey(con.Id)) {
                                       for(NS_AssociatedAccount__c ascp :assocMap.get(con.Id) )
                                       {
                                           if(ascp.NS_PrimaryAccount__c){
                                               NS_AssociatedAccount__c ascp1 = getAssocAcc(con,true); 
                                               ascp1.NS_ConName__c = con.firstname+NS_StaticVariablesUtility.Space+con.lastname;
                                               ascp1.NS_CellPhone__c = con.MobilePhone;
                                               ascp1.NS_WorkPhone__c = con.Phone;
                                               ascp1.NS_OtherPhone1__c=con.OtherPhone;
                                               ascp1.NS_OtherPhone2__c=con.HomePhone;
                                               ascp1.NS_InternalContact__c = con.NS_InternalContact__c;
                                               ascp1.Id = ascp.id;
                                               ascList.add(ascp1);
                                           }
                                           else{
                                               ascp.NS_ConName__c = con.firstname+NS_StaticVariablesUtility.Space+con.lastname;
                                               ascp.NS_CellPhone__c = con.MobilePhone;
                                               ascp.NS_WorkPhone__c = con.Phone;
                                               ascp.NS_OtherPhone1__c=con.OtherPhone;
                                               ascp.NS_OtherPhone2__c=con.HomePhone;
                                               ascp.Contact_Type__c=con.NS_ContactType__c;
                                               ascp.NS_InternalContact__c = con.NS_InternalContact__c;
                                               ascList.add(ascp); 
                                           }  
                                       }
                                   }
                               }
                           }
                    } 
                }
                if(!ascList.isEmpty()){
                    Database.SaveResult[] srList = Database.update(ascList,false);
                    NS_Utility.databaseSvResult(srList,METHOD_NAME3,CLASS_NAME);
                }
            }
            catch (Exception exp) {
                /*Inserting a record in Exception object*/
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME3);
            }
        }
    }
    
    /* @author-  Accenture
*  @description- Return Id of Salesforce Record Type
*  @param- String of Record Type Name
*  @return- Id of Record Type
*  @throws- Standard Exception
*/
    public static Id getRecTypeId(String recTypeName){             
        Id recTypeId =null;
        try{
            recTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get(recTypeName).getRecordTypeId();  
        }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME7);
        }
        return recTypeId;
    }
    /*Fetching Dummy Account Id for Orphan Contact Creation and Updation*/
    /*  public static Id getDummyAccountId(){
Id dAccId = null;
try{     
dAccId = [SELECT Id FROM Account WHERE NS_External_ID__c =:NS_StaticVariablesUtility.dummyExternalID AND
Name =:NS_StaticVariablesUtility.accName LIMIT 1].id;
}
catch (Exception exp) {
NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME8);
}
return dAccId;
}*/
    /*Associate Account record creation*/
    public static NS_AssociatedAccount__c getAssocAcc(Contact con, Boolean isPrimary){
        NS_AssociatedAccount__c ascp = new NS_AssociatedAccount__c();
        try{
            ascp.NS_AccountName__c = con.AccountId;
            ascp.NS_ContactName__c = con.Id;
            ascp.NS_AccountRole__c = con.Title;
            ascp.NS_PrimaryAccount__c = isPrimary;
            ascp.NS_InternalContact__c = con.NS_InternalContact__c;
            /*to add value in Contact_Type__c field in Associated Account from Contact*/
            ascp.Contact_Type__c=con.NS_ContactType__c;
        }
        catch (Exception exp) {
            /*Inserting a record in Exception object*/
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME4);
        }
        return ascp;
    }  
    /*Auto Population of Contact Address From Account*/
    public static void autoPopulateContactAddress(Contact con1, Account acc1){
        try{
            Contact con = con1;
            Account acc = acc1;
            
            if(acc.NS_MailingAddressDetails__c!=null){
                con.MailingCountry = acc.NS_MailingAddressCountry__c;
                con.MailingState = acc.NS_MailingAddressState__c;
                con.MailingCity = acc.NS_MailingAddressCity__c;
                con.MailingStreet = acc.NS_MailingAddressStreet__c;
                con.MailingPostalCode = acc.NS_MailingAddressZip__c;
            }
            else if (acc.NS_ShippingAddressDetails__c!=null){
                con.MailingCountry = acc.ShippingCountry;
                con.MailingState = acc.ShippingState;
                con.MailingCity = acc.ShippingCity;
                con.MailingStreet = acc.ShippingStreet;
                con.MailingPostalCode = acc.ShippingPostalCode;
            }
            else if (acc.NS_BillingAddressDetails__c!=null){
                con.MailingCountry = acc.BillingCountry;
                con.MailingState = acc.BillingState;
                con.MailingCity = acc.BillingCity;
                con.MailingStreet = acc.BillingStreet;
                con.MailingPostalCode = acc.BillingPostalCode; 
            } 
            if (acc.NS_PhysicalAddressDetails__c!=null){
                con.OtherCountry = acc.NS_PhysicalAddressCountry__c;
                con.OtherState = acc.NS_PhysicalAddressState__c;
                con.OtherCity = acc.NS_PhysicalAddressCity__c;
                con.OtherStreet = acc.NS_PhysicalAddressStreet__c;
                con.OtherPostalCode = acc.NS_PhysicalAddressZip__c;
            }
            
        }
        catch (Exception exp) {
            /*Inserting a record in Exception object*/
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME5);
        }
    }
    //Gunjari 01/03/2019-- delete duplicate assoc acc on contact merge//
    public static void deleteAssocAccountOnMerge(Map<Id,Contact> newConMap){ 
        NS_TriggerSettings__c customset = NS_TriggerSettings__c.getValues(NS_StaticVariablesUtility.conTrigger);
        if(customset.NS_IsActive__c){
            Integer count =limits.getLimitQueryRows();   
            List<NS_AssociatedAccount__c> assocAccountsList= new list<NS_AssociatedAccount__c>();
            //List<NS_AssociatedAccount__c> duplicateAssocAccounts= new list<NS_AssociatedAccount__c>();
            List<NS_AssociatedAccount__c> deleteAssocAccList = new List<NS_AssociatedAccount__c>();
            assocAccountsList=[select Id,NS_AccountName__c,
                               NS_ContactName__c,LastModifiedDate
                               from NS_AssociatedAccount__c 
                               where NS_ContactName__c in :newConMap.keyset() 
                               ORDER BY LastModifiedDate ASC
                               LIMIT:count];                 
            try{ 
                map<String,List<NS_AssociatedAccount__c>> mapDuplicateAscAcc = new map<String,List<NS_AssociatedAccount__c>>();
                for(NS_AssociatedAccount__c assoc : assocAccountsList){
                    //for(NS_AssociatedAccount__c duplicateAssoc : assocAccountsList){
                        //if((assoc.NS_AccountName__c == duplicateAssoc.NS_AccountName__c) && (assoc.NS_ContactName__c == duplicateAssoc.NS_ContactName__c))
                        //{
                           if(!mapDuplicateAscAcc.containsKey(assoc.NS_AccountName__c+'_'+assoc.NS_ContactName__c)){
                                mapDuplicateAscAcc.put(assoc.NS_AccountName__c+'_'+assoc.NS_ContactName__c, new List<NS_AssociatedAccount__c>());   
                           }
                            mapDuplicateAscAcc.get(assoc.NS_AccountName__c+'_'+assoc.NS_ContactName__c).add(assoc); 
                              
                        //}
                    //}
                 }       
                for(String acc_con : mapDuplicateAscAcc.KEYSET()){
                    for(integer i=1;i<(mapDuplicateAscAcc.get(acc_con)).size();i++){
                        deleteAssocAccList.add((mapDuplicateAscAcc.get(acc_con))[i]);
                    }        
                 }    
                if(!deleteAssocAccList.isEmpty()){
                    Database.DeleteResult[] delList = Database.delete(deleteAssocAccList, false);
                    NS_Utility.databaseDelResult(delList,METHOD_NAME8,CLASS_NAME);
                }
            }
            catch(Exception exp){
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME8);
            }
        }
    } 
    
    public static void deleteAssociationRecordOnTyesWhenContatisDeleted(){
    
        Map<Id,Contact> contactListDelete = new Map<Id,Contact>();
        List<Contact> conold = (List<Contact>) Trigger.Old;
        Map<Id,Contact> conmapOld = (Map<Id,Contact>) Trigger.oldMap;
        List<Id> oldIds = new List<Id>();
        for(Contact conObj: conold ){
        oldIds.add(conObj.Id);
        }       
           for(NS_AssociatedAccount__c asscon: [Select id,NS_AccountName__c,NS_ContactName__c from NS_AssociatedAccount__c 
                                               where NS_ContactName__c =:oldIds]){
               if(asscon.NS_AccountName__c != conmapOld.get(asscon.NS_ContactName__c).AccountId){
                   List<contact> clonedcon = (new List<Contact>{(conmapOld.get(asscon.NS_ContactName__c))}).deepClone(true,true,true);
                   clonedcon[0].put('AccountId',asscon.NS_AccountName__c );
                   contactListDelete.Put(clonedcon[0].Id,clonedcon[0]);
               }       
        }//Inside for loop2
      
      if(contactListDelete.size()>0){
      NS_IntegrationHelper.invoke_ContactDel(contactListDelete); 
      }
      }
}