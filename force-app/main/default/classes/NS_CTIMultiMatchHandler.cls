/*
Description  : This class provides Business functionality for NS_MuttiMatchComp Lightning Component
Developer    : Accenture Solutions
Date         : 3-16-2018

-------------------------------------------
Developer name      Date        Description        
-------------------------------------------
@Bharadwaj Urma     24-05-2018  removed limit and offset that was used for pagination. 
                                Instead JQuery was used in the lightning component.
                                Changes were also made on the lightning componenet and helper.
*/

public without sharing class NS_CTIMultiMatchHandler{
    
    //current user profile info
    static Id profileId = userinfo.getProfileId();
    static String currentUserProfileName = [Select Id,Name from Profile where Id=:profileId].Name;
    static String sysAdmin = System.Label.SYS_ADMIN;
    static string AniOnlyContact = System.Label.ANI_ONLY_CONTACT;
    static Id AniOnlyRTId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get(AniOnlyContact).getRecordTypeId();
    
    //multimatch Variables
    static Set<String> contactId = new Set<String>();
    static Map<Id,AccountWrapper> AccountWrapperMap = new Map<Id,AccountWrapper>();
    static Map<Id,ContactWrapper> ContactWrapperMap = new Map<Id,ContactWrapper>();
    static Map<Id,Set<Id>> AccountContactIdMap = new Map<Id,Set<Id>>();
    static AccountMutiMatchWrapper accountGlobalWrapper = new AccountMutiMatchWrapper();
    static ContactMutiMatchWrapper contactGlobalWrapper = new ContactMutiMatchWrapper();
    
    //Query Variables    
    static String searchPhone='';
    final static String active = 'Active';
    
    //Regex variables
    final static Pattern specialCharacterReg = Pattern.compile('[^a-zA-Z0-9]');
    final static Pattern multiplePercentileReg = Pattern.compile('[%]{2,}');//Removes extra percentile sign
    
    //Pagination variables    
    public static integer counter = 0;  //keeps track of the offset
    public static integer list_size = 50000; //sets the page size or number of rows.defaulted to 50000. should be modified as required.
    public static integer total_size = 0; //used to show user the total size of the list
    public static integer con_total_size = 0;
    public static integer con_counter = 0;
    
    /* 
     * Following methods handle the Initial search - Start :
     */
    @AuraEnabled
    public static void setPhoneNumber(String phone){
        searchPhone = phone;
    }
   
    public static boolean isDummyAcForOrphanContacts(String acId){
        boolean isDummy=false;
        //NS_DummyAccOrphanCon__c customsetdummy = new NS_DummyAccOrphanCon__c();
        //customsetdummy = NS_DummyAccOrphanCon__c.getValues(NS_StaticVariablesUtility.dummyAccount);
        NS_DummyAccOrphanCon__c customsetdummy = NS_DummyAccOrphanCon__c.getValues(NS_StaticVariablesUtility.dummyAccount);
        String dummyId=customsetdummy.NS_AccountId__c; 
        System.debug('>>>>>>>>>>>>*******>>>>>>>>>>>>>>>>>>>>dummyId :'+dummyId);
        if(dummyId.equalsIgnoreCase(acId)||acId==null){
            isDummy=true;
        }
        return isDummy;
    }
    
    @AuraEnabled
    public static Boolean runMatchLogic(){
        getAccount();//based on phone
        getContact();//based on phone
        getAssociatedAccounts();//based on contact
        if(ContactWrapperMap.isEmpty() && AccountWrapperMap.isEmpty())
            return false;
        else
            return true;
    }
    
    public static void getAccount(){
        total_size += [Select count() from Account where NS_StatusIndicator__c = :active AND 
                       (phone = :searchPhone OR NS_OfflineContactMobile__c = :searchPhone OR NS_OfflineContactWorkPhone__c = :searchPhone)];
        for(Account acc : [Select Id, Name, phone, NS_ClassCode__c,  NS_StatusIndicator__c, NS_OperatingStation__c, NS_OperatingStation__r.Name,
                           NS_ControllingStation__c,NS_OfflineContactMobile__c, NS_OfflineContactWorkPhone__c, RecordType.Name from Account 
                           where NS_StatusIndicator__c = :active 
                           AND (phone = :searchPhone)// OR NS_OfflineContactMobile__c = :searchPhone OR NS_OfflineContactWorkPhone__c = :searchPhone)
                           //LIMIT :list_size offset :counter
                          ]){
            NS_CTIMultiMatchHandler.AccountWrapper accWrap = new NS_CTIMultiMatchHandler.AccountWrapper(acc);
            AccountWrapperMap.put(acc.Id,accWrap);
            doMapping(acc.Id, null);
        }
        accountGlobalWrapper = new AccountMutiMatchWrapper(getDisableFirst(counter), getDisablePrevious(counter), getDisableNext(counter,total_size), getDisableLast(list_size, counter, total_size), total_size, counter+list_size , AccountWrapperMap.values());
    }
    
    /*Changed NS_WorkPhone__c to Phone-2times*/
    //Get Contact and Associated Account based on phone
    public static void getContact(){       
        con_total_size += [Select count() from Contact where NS_ContactStatus__c = :active AND (phone = :searchPhone OR HomePhone = :searchPhone OR MobilePhone = :searchPhone OR OtherPhone = :searchPhone OR Phone = :searchPhone)];
        for(Contact c : [Select Id, RecordTypeId, Name, Account.Id, Account.Name, Account.phone, Account.NS_ClassCode__c,  Account.NS_StatusIndicator__c, Account.NS_OperatingStation__c, Account.NS_OperatingStation__r.Name,
                         Email, NS_Preferred_Phone__c, HomePhone, NS_ContactStatus__c, MobilePhone, OtherPhone, Phone,Account.NS_ControllingStation__c, Account.RecordType.Name
                         from Contact 
                         where NS_ContactStatus__c = :active
                         AND (phone = :searchPhone OR HomePhone = :searchPhone OR MobilePhone = :searchPhone OR OtherPhone = :searchPhone OR Phone = :searchPhone)
                         //LIMIT :list_size offset :con_counter
                        ]){
            contactId.add(c.Id);
            //if(c.Name != AniOnlyContact ){
            //if(!c.Name.contains(AniOnlyContact) || (c.Name.contains(AniOnlyContact) && sysAdmin.equals(currentUserProfileName))){
            if(c.RecordTypeId != AniOnlyRTId || (c.RecordTypeId == AniOnlyRTId && sysAdmin.equals(currentUserProfileName))){
                NS_CTIMultiMatchHandler.ContactWrapper conWrap = new NS_CTIMultiMatchHandler.ContactWrapper(c);
                ContactWrapperMap.put(c.Id,conWrap);
            }                
            if(c.Account.Id != null){
                NS_CTIMultiMatchHandler.AccountWrapper accWrap = new NS_CTIMultiMatchHandler.AccountWrapper(c.Account.Id, c.Account.Name, c.Account.Phone, c.Account.NS_ClassCode__c, c.Account.NS_StatusIndicator__c, c.Account.NS_OperatingStation__c,c.Account.NS_OperatingStation__r.Name,c.Account.NS_ControllingStation__c,c.Account.RecordType.Name);
                AccountWrapperMap.put(c.Account.Id,accWrap);
                doMapping(c.Account.Id, c.Id);
            }
        }
        contactGlobalWrapper = new ContactMutiMatchWrapper(getDisableFirst(con_counter), getDisablePrevious(con_counter), getDisableNext(con_counter,con_total_size), false, con_total_size, con_counter+list_size , ContactWrapperMap.values());
        accountGlobalWrapper = new AccountMutiMatchWrapper(getDisableFirst(counter), getDisablePrevious(counter), getDisableNext(counter,total_size), false, total_size, counter+list_size , AccountWrapperMap.values());
    }
    
    //get Associated Account based on Contact
    public static void getAssociatedAccounts(){
        for(NS_AssociatedAccount__c aa : [Select Id, NS_ContactName__c, NS_AccountName__c, NS_AccountName__r.Name,NS_AccountName__r.NS_OperatingStation__r.Name ,
                                            NS_AccountName__r.Phone, NS_AccountName__r.NS_ClassCode__c, NS_AccountName__r.NS_StatusIndicator__c,
                                            NS_AccountName__r.NS_OperatingStation__c,NS_AccountName__r.NS_ControllingStation__c,NS_AccountName__r.RecordType.Name FROM NS_AssociatedAccount__c
                                            where NS_ContactName__c = :contactId
                                         ]){
            NS_CTIMultiMatchHandler.AccountWrapper accWrap = new NS_CTIMultiMatchHandler.AccountWrapper(
                                                                    aa.NS_AccountName__c,aa.NS_AccountName__r.Name,
                                                                    aa.NS_AccountName__r.Phone,aa.NS_AccountName__r.NS_ClassCode__c,
                                                                    aa.NS_AccountName__r.NS_StatusIndicator__c,
                                                                    aa.NS_AccountName__r.NS_OperatingStation__c,
                                                                    aa.NS_AccountName__r.NS_OperatingStation__r.Name,
                                                                    aa.NS_AccountName__r.NS_ControllingStation__c,
                                                                    aa.NS_AccountName__r.RecordType.Name
                                                                    );
            AccountWrapperMap.put(aa.NS_AccountName__c,accWrap);
            doMapping(aa.NS_AccountName__c, aa.NS_ContactName__c);
        }
        accountGlobalWrapper = new AccountMutiMatchWrapper(getDisableFirst(counter), getDisablePrevious(counter), getDisableNext(counter,total_size), false, total_size, counter+list_size , AccountWrapperMap.values());
    }
     @AuraEnabled
    public static String associateAccount(Map<String,String> myMap){
        //List<String> result=new List<String>();
        String result;
        try{
        String accId = myMap.get('accId');
        String conId = myMap.get('conId');
        NS_AssociatedAccount__c assocAc=new NS_AssociatedAccount__c();
        assocAc.NS_AccountName__c=accId;
        assocAc.NS_ContactName__c=conId;        
        Database.SaveResult srList = Database.insert(assocAc);        
            if(srList.isSuccess()){
                result=String.valueOf(srList.isSuccess());
            }
        }catch(Exception e){
             result=e.getMessage();
        }
        return result;
    }    
    @AuraEnabled
    public static AccountMutiMatchWrapper getMatchedAccounts(){
        List<AccountWrapper> listToSortByName = new List<AccountWrapper>();
        List<AccountWrapper> listToSortByPhone = new List<AccountWrapper>();
        List<AccountWrapper> sortedAccountlist = new List<AccountWrapper>();
        for(AccountWrapper accwrp:accountGlobalWrapper.accountRecords){
            if(accwrp.isExactMatch){
                listToSortByPhone.add(accwrp);
            }else{
               listToSortByName.add(accwrp); 
            }
        }
        //listToSortByName = accountGlobalWrapper.accountRecords;
        listToSortByName.sort();
        listToSortByPhone.sort();
        sortedAccountlist.addall(listToSortByPhone);
        sortedAccountlist.addall(listToSortByName);
        accountGlobalWrapper.accountRecords = sortedAccountlist;
        return accountGlobalWrapper;
    }
    
    /*
     *  These two methods handle the Initial search - End :
     */
    
    /*
     * Following methods handle the Manual action performed by the Agent - Start:
     */
    @AuraEnabled
    public static void getAccountByPhone(String param){
        searchPhone = param;
        getAccount();
    }
    
    @AuraEnabled
    public static void getAccountByName(String param){
        String searchParam =  specialCharacterReg.matcher('%'+param+'%').replaceAll('%');
        searchParam = multiplePercentileReg.matcher(searchParam).replaceAll('%');
        total_size += [Select count() from Account where NS_StatusIndicator__c = :active AND Name LIKE  :searchParam];
        
        for(Account acc : [Select Id, Name, NS_ClassCode__c, Phone, NS_StatusIndicator__c, NS_OperatingStation__c, NS_OperatingStation__r.Name,NS_ControllingStation__c,RecordType.Name from Account 
                           where NS_StatusIndicator__c = :active AND Name LIKE  :searchParam 
                           //LIMIT :list_size offset :counter
                          ]){
            NS_CTIMultiMatchHandler.AccountWrapper accWrap = new NS_CTIMultiMatchHandler.AccountWrapper(acc);
            AccountWrapperMap.put(acc.Id,accWrap);
            doMapping(acc.Id, null);
        }
    }
    
    @AuraEnabled
    public static void getContactByPhone(String param){
        searchPhone = param;
        getContact();
    }
    /*Changed NS_WorkPhone__c to Phone*/
    @AuraEnabled
    public static List<ContactWrapper> getContactByAccId(Id accId, String ANI){       
        setPhoneNumber(ANI);
        for(Contact c : [Select Id, RecordTypeId, Name, Account.Id, Account.Name, Email, NS_Preferred_Phone__c, NS_ContactStatus__c ,
                         MobilePhone, OtherPhone, Phone, HomePhone
                         from Contact where NS_ContactStatus__c = :active AND Account.Id = :accId
                        ]){
            contactId.add(c.Id);
            if(c.RecordTypeId != AniOnlyRTId || (c.RecordTypeId == AniOnlyRTId && sysAdmin.equals(currentUserProfileName))){
                NS_CTIMultiMatchHandler.ContactWrapper conWrap = new NS_CTIMultiMatchHandler.ContactWrapper(c);
                ContactWrapperMap.put(c.Id,conWrap);
            }                 
            
        }
        getAssociatedContacts(accId);
        List<ContactWrapper> contactDataByNameSort = new List<ContactWrapper>();
        List<ContactWrapper> contactDataByPhoneSort = new List<ContactWrapper>();
        List<ContactWrapper> sortedContactList = new List<ContactWrapper>();
        for(ContactWrapper conwrp:ContactWrapperMap.values()){
            if(conwrp.isExactMatch ||conwrp.Other_PhoneMatch || conwrp.WorkPhoneMatch || conwrp.Other_Phone2Match){
               contactDataByPhoneSort.add(conwrp); 
            }else{
               contactDataByNameSort.add(conwrp); 
            }
        }
        contactDataByNameSort.sort();
        contactDataByPhoneSort.sort();
        sortedContactList.addAll(contactDataByPhoneSort);
        sortedContactList.addAll(contactDataByNameSort);
        return sortedContactList;
        //return ContactWrapperMap.values();
    }
    /*Changed NS_WorkPhone__c to Phone-2times*/
    public static void getAssociatedContacts(Id accId){
        for(NS_AssociatedAccount__c aa : [Select Id, NS_ContactName__c,NS_ContactName__r.RecordTypeId, NS_ContactName__r.Name, NS_ContactName__r.Account.Id, NS_ContactName__r.Account.Name,
                                          NS_ContactName__r.Email, NS_ContactName__r.NS_Preferred_Phone__c, NS_ContactName__r.NS_ContactStatus__c,
                                          NS_ContactName__r.MobilePhone, NS_ContactName__r.OtherPhone, NS_ContactName__r.Phone, NS_ContactName__r.HomePhone
                                          FROM NS_AssociatedAccount__c
                                          where NS_AccountName__c = :accId AND
                                          NS_ContactName__r.NS_ContactStatus__c = :active
                                         ]){
            if((aa.NS_ContactName__r.RecordTypeId != AniOnlyRTId) || (aa.NS_ContactName__r.RecordTypeId == AniOnlyRTId && sysAdmin.equals(currentUserProfileName)) && aa.NS_ContactName__r.NS_ContactStatus__c.equals(active)){
                NS_CTIMultiMatchHandler.ContactWrapper conWrap = new NS_CTIMultiMatchHandler.ContactWrapper(
                                                                    aa.NS_ContactName__c,
                                                                    aa.NS_ContactName__r.MobilePhone,
                                                                    aa.NS_ContactName__r.OtherPhone,
                                                                    aa.NS_ContactName__r.Phone,
                                                                    aa.NS_ContactName__r.Name,
                                                                    aa.NS_ContactName__r.Account.Id,aa.NS_ContactName__r.Account.Name,
                                                                    aa.NS_ContactName__r.Email,
                                                                    aa.NS_ContactName__r.NS_Preferred_Phone__c,
                                                                    aa.NS_ContactName__r.NS_ContactStatus__c,
                                                                    aa.NS_ContactName__r.HomePhone
                                                                    );
            ContactWrapperMap.put(aa.NS_ContactName__c,conWrap);
            }
        }
    }
      /*Changed NS_WorkPhone__c to Phone*/
    @AuraEnabled
    public static void getContactByName(String param){
        String searchParam =  specialCharacterReg.matcher('%'+param+'%').replaceAll('%');
        searchParam = multiplePercentileReg.matcher(searchParam).replaceAll('%');
        con_total_size += [Select count() from Contact where NS_ContactStatus__c = :active AND (Name LIKE :searchParam)];
        for(Contact con : [Select Id, Name, FirstName,Account.Id, Account.Name, Email, NS_Preferred_Phone__c, NS_ContactStatus__c,
                           MobilePhone, OtherPhone, Phone, HomePhone
                           from Contact where NS_ContactStatus__c = :active AND (Name LIKE :searchParam)
                           //LIMIT :list_size offset :con_counter
                          ]){
            NS_CTIMultiMatchHandler.ContactWrapper conWrap = new NS_CTIMultiMatchHandler.ContactWrapper(con);
            ContactWrapperMap.put(con.Id,conWrap);
        }
    }
    
    @AuraEnabled
    public static List<ContactWrapper> getMatchedContacts(String accId){
        List<ContactWrapper> returnList = new List<ContactWrapper>();
        runMatchLogic();
        if(!AccountContactIdMap.isEmpty() && AccountContactIdMap.containsKey(accId)){
            for(Id conId : AccountContactIdMap.get(accId)){
                returnList.add(ContactWrapperMap.get(conId));       
            }
        }
        return returnList;
    }
    /*
     *  Following methods handle the Manual action performed by the Agent - End:
    */
    
    /*
     *  Following methods handle the Search and Pagination action performed by the Agent - Start:
    */
    @AuraEnabled
    public static AccountMutiMatchWrapper fetchNextRecords(String param, Integer offset, Integer nameOrPhone, Integer reclimit) { //user clicked next button
        counter = Integer.valueOf(offset);
        list_size = Integer.valueOf(reclimit);
        getAccountByName(param);
        getAccountByPhone(param);
        AccountMutiMatchWrapper ammw = new AccountMutiMatchWrapper(getDisableFirst(counter), getDisablePrevious(counter), getDisableNext(counter,total_size), getDisableLast(list_size, counter, total_size), total_size, counter+list_size , AccountWrapperMap.values());
        return ammw;
    }
    
    @AuraEnabled
    public static ContactMutiMatchWrapper fetchNextConRecords(String param, Integer offset, Integer nameOrPhone, Integer reclimit)  { //user clicked next button
        con_counter = Integer.valueOf(offset);
        list_size = Integer.valueOf(reclimit);
        getContactByName(param);
        getContactByPhone(param);
        List<ContactWrapper> contactDataByNameSort = ContactWrapperMap.values();
        contactDataByNameSort.sort();
        ContactMutiMatchWrapper cmmw = new ContactMutiMatchWrapper(getDisableFirst(con_counter), getDisablePrevious(con_counter), getDisableNext(con_counter,con_total_size), false, con_total_size, con_counter+list_size , contactDataByNameSort);
        return cmmw;
    }
    /*
     *  Following methods handle the Search and Pagination action performed by the Agent - End:
    */
    
    /*
     *  Following methods finds the exact match - Start:
    */
   /* private static void markExactMatch(String objectName){
        
    }*/
    /*
     *  Following methods finds the exact match - End:
    */
    
    /*
     * Following are the helper methods : Start
    */  
    public static void doMapping(Id AccId, Id conId){
        if(!AccountContactIdMap.containsKey(AccId)){
            Set<Id> conIds = new Set<Id>();
            AccountContactIdMap.put(AccId, conIds);
        }
        if(conId != null){
            AccountContactIdMap.get(AccId).add(conId);
        }
    }
    
    @AuraEnabled
    public static boolean updateCustomSettings(Id accId, Id conId){       
        try{
        Database.delete ([select id from ManageContactAndUserIds__c where User_Id_del__c= :UserInfo.getUserId() LIMIT 50000]);   
             Database.upsertResult results= Database.upsert(new ManageContactAndUserIds__c(
                Name = UserInfo.getUserId(),
                Account_Id__c = accId,
                Contact_Id__c=conId,
                User_Id_del__c=UserInfo.getUserId()       
            ));
            //Error handling
            if(!results.isSuccess()) {
                Exception__c excep = new Exception__c();
                excep.Class_Name__c = 'NS_CTIMultiMatchHandler';
                excep.Method_Name__c = 'updateCustomSettings';
                System.debug('Error: '+results.getErrors()); 
                for(Database.Error err : results.getErrors()){
                    excep.Description__c = err.getMessage();
                    break;
                }
                insert excep;
            }
         //End error handling   
            
        String uniqueId=UserInfo.getUserId()+conId;
        Database.delete ( [select id from Case_Origin__c where User_Id__c= :UserInfo.getUserId() LIMIT 50000]);      
        Database.upsert( new Case_Origin__c(
                 Name = uniqueId,
                User_Id__c = UserInfo.getUserId(),
                From_Caller_Selection_page__c=true       
        ));
        }
        catch(Exception exp ){
             NS_StaticVariablesUtility.createExceptionRecord(exp, 'Multimatch', 'updateCustomSetting');
        }
        return isDummyAcForOrphanContacts(accId);
    }
    /*
     * Following are the helper methods : End
    */
    
    @AuraEnabled
    public static Integer Beginning() { //user clicked beginning
        counter = 0;
        return counter;
    }

    @AuraEnabled
    public static Integer Previous(Integer offset) { //user clicked previous button
        counter -= Integer.valueOf(offset);
        return counter;
    }

    @AuraEnabled
    public static Integer Next(Integer offset) { //user clicked next button
        counter += Integer.valueOf(offset);
        return counter; 
    }
    
    @AuraEnabled
    public static Integer End(Integer reclimit) { //user clicked end
        counter = total_size - math.mod(total_size, reclimit);
        return counter;
    }
        
    @AuraEnabled
    public static Integer conBeginning() { //user clicked beginning
        con_counter = 0;
        return con_counter;
    }
    
    @AuraEnabled
    public static Integer conPrevious(Integer offset) { //user clicked previous button
        con_counter -= Integer.valueOf(offset);
        return con_counter;
    }
    
    @AuraEnabled
    public static Integer conNext(Integer offset) { //user clicked next button
      con_counter += Integer.valueOf(offset);
      return con_counter; 
    }
    
    @AuraEnabled
    public static Boolean getDisableFirst(Integer counter) { 
      if (counter == 0) 
          return true ; 
      else 
          return false;
    }
    
    @AuraEnabled
    public static Boolean getDisableLast(Integer reclimit, Integer counter, Integer total_size) { 
      if (total_size - counter > reclimit) 
          return false ; 
      else 
          return true;
    }
    
    @AuraEnabled
    public static Boolean getDisablePrevious(Integer counter) { 
      if (counter > 0) 
          return true ; 
      else 
          return false;
    }

    @AuraEnabled
    public static Boolean getDisableNext(Integer counter, Integer total_size) { //this will disable the next and end buttons
      if (counter + list_size < total_size) 
          return true; 
      else 
          return false;
    }

    @AuraEnabled
    public static Integer getTotal_size() {
      return total_size;
    }

    @AuraEnabled
    public static Integer getPageNumber() {
      return counter/list_size + 1;
    }

    @AuraEnabled
    public static Integer getTotalPages() {
        if (math.mod(total_size, list_size) > 0) {
            return total_size/list_size + 1;
        } else {
            return (total_size/list_size);
        }
    }
    
    @AuraEnabled
    public static DMLResult saveContactDetails(String Id, String data, String sn) {
        Contact conUpdate = new Contact();
        conUpdate.Id = Id;
        if(sn.equals('1')){
            conUpdate.Phone = formatphonenumber(data,false);
        }
        if(sn.equals('2')){
            conUpdate.MobilePhone = formatphonenumber(data,false);
        }
        if(sn.equals('3')){
            conUpdate.OtherPhone = formatphonenumber(data,false);
        }
        if(sn.equals('4')){
            conUpdate.HomePhone = formatphonenumber(data,false);
        }
        if(sn.equals('5')){
            conUpdate.Email = data;
        }
        DMLResult dr = new DMLResult();
        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.allowSave = true;
        dml.DuplicateRuleHeader.runAsCurrentUser = true; 
        //Account duplicateAccount = new Account(Name='dupe');
        Database.SaveResult sr = Database.update(conUpdate, dml);
        //Database.SaveResult sr = Database.update(conUpdate,false);
        if (sr.isSuccess()) {
            // Operation was successful, so get the ID of the record that was processed
            //String message =  'Update Successful for : ' + sr.getId()+'';
            String message =  'Contact Updated';
            dr.code='0';
            dr.description = message;
        }
        else {
            String errorDesc = 'ERROR - ';               
            for(Database.Error err : sr.getErrors()) {
                errorDesc += 'The following error has occurred.';                    
                errorDesc += err.getStatusCode() + ': ' + err.getMessage();
                errorDesc += ' fields that affected this error: ' + err.getFields();
            }
            dr.code='1';
            dr.description = errorDesc;
        }
        return dr;
    }
    
    public static String formatphonenumber(String cphone, boolean yes) {
        String fphone = cphone.replaceAll('\\D','');
        
        if (yes && fphone.length() == 10) {
            fphone = formatphonenum(fphone);
        }
        return fphone;
    }
        
    static String formatphonenum (String s) {
        s = '(' + s.substring(0, 3) + ') ' + s.substring(3, 6) + '-' + s.substring(6);
        return s;
    }
    @AuraEnabled
    public static Id getOfflineAccountId(){        
        return [SELECT DeveloperName,Id,Name FROM RecordType where Sobjecttype='Account' and developername = 'NS_OfflineCustomer'].Id;
    }
    /* Wrapper Classes - Start*/
    public class ContactWrapper implements Comparable{
        @AuraEnabled public String Id;
        @AuraEnabled public String ContactName;
        @AuraEnabled public String AccountId;
        @AuraEnabled public String AccountName;
        @AuraEnabled public String Email;
        @AuraEnabled public String PreferredPhone;
        @AuraEnabled public String ContactStatus;
        @AuraEnabled public String Mobile_Phone;
        @AuraEnabled public String Other_Phone;
        @AuraEnabled public String Other_Phone2;
        @AuraEnabled public String WorkPhone;
        @AuraEnabled public Boolean isExactMatch=false;
        @AuraEnabled public Boolean Other_PhoneMatch=false;
        @AuraEnabled public Boolean Other_Phone2Match=false;
        @AuraEnabled public Boolean WorkPhoneMatch=false;
        
        public Integer compareTo(Object objToCompare){
            return ContactName.compareTo(((ContactWrapper)objToCompare).ContactName);
        }
        
        /*Changed NS_WorkPhone__c to Phone*/
        public ContactWrapper(Contact con){
            Id = con.Id;
            ContactName = con.Name;
            AccountId = con.Account.Id;
            AccountName = con.Account.Name;
            Email = con.Email;         
            ContactStatus = con.NS_ContactStatus__c; 
            
            if(con.MobilePhone != null ){
                Mobile_Phone = formatphonenumber(con.MobilePhone, true);   
                if(con.MobilePhone.equals(searchPhone)){
                    isExactMatch = true;
                }
            }
            
            if(con.OtherPhone != null){
                Other_Phone = formatphonenumber(con.OtherPhone, true);
                if(con.OtherPhone.equals(searchPhone)){
                    Other_PhoneMatch = true;
                } 
            } 
            if(con.Phone != null){
                WorkPhone = formatphonenumber(con.Phone, true);
                if(con.Phone.equals(searchPhone)){
                    WorkPhoneMatch = true;
                }    
            }
            if(con.HomePhone != null){
                Other_Phone2 = formatphonenumber(con.HomePhone, true);
                if(con.HomePhone.equals(searchPhone)){
                    Other_Phone2Match = true;
                }    
            }
            if(con.NS_Preferred_Phone__c != null ){
                PreferredPhone = formatphonenumber(con.NS_Preferred_Phone__c, true);
            }
       }
        
        public ContactWrapper(Id conId,String conMobilePhone, String conOtherPhone, String conNSWorkPhone, String Name, Id conAccountId, String conAccountName, String conEmail, String conPreferredPhone, String conContactStatus, String otherPhone2){
            Id = conId;
            ContactName = Name;
            AccountId = conAccountId;
            AccountName = conAccountName;
            Email = conEmail;
            ContactStatus = conContactStatus;             
                    
            if(conMobilePhone != null ){
                Mobile_Phone = formatphonenumber(conMobilePhone, true);   
                if(conMobilePhone.equals(searchPhone)){
                    isExactMatch = true;
                }
            }
            
            if(conOtherPhone != null){
                Other_Phone = formatphonenumber(conOtherPhone, true);
                if(conOtherPhone.equals(searchPhone)){
                    Other_PhoneMatch = true;
                } 
            } 
            if(conNSWorkPhone != null){
                WorkPhone = formatphonenumber(conNSWorkPhone, true);
                if(conNSWorkPhone.equals(searchPhone)){
                    WorkPhoneMatch = true;
                }    
            } 
            if(otherPhone2 != null){
                Other_Phone2 = formatphonenumber(otherPhone2, true);
                if(otherPhone2.equals(searchPhone)){
                    Other_Phone2Match = true;
                }    
            }
            if(conMobilePhone != null ){
                PreferredPhone = formatphonenumber(conPreferredPhone, true);
            }
        } 
    }
    
    public class AccountWrapper implements Comparable{
        @AuraEnabled public String Id;
        @AuraEnabled public String Name;
        @AuraEnabled public String Phone;
        @AuraEnabled public String ClassCode;            
        @AuraEnabled public String StatusIndicator;
        @AuraEnabled public String OperatingStation;
        @AuraEnabled public String ControllingStation;
        @AuraEnabled public String AccountRecordType;
        @AuraEnabled public Boolean isExactMatch=false; 
        
        String opStationConcat = '';
        
        public AccountWrapper(Id accId, String accName, String Phn, String NS_ClassCode, String NS_StatusIndicator, String NS_OperatingStation,String NS_OperatingStationName,String NS_ControllingStation,String NS_AccountRecordType){
            Id = accId;
            Name = accName == null ? '-':accName;
            ClassCode = NS_ClassCode;
            
            if(Phn != null){
                Phone = formatphonenumber(Phn,true);
                if(Phn.equals(searchPhone)){
                    isExactMatch = true;
                }
            }
            
            StatusIndicator = NS_StatusIndicator;
            if(NS_OperatingStation != null){
                if(NS_OperatingStationName != null){
                    opStationConcat = NS_OperatingStationName;
                }
            }
            
            OperatingStation = opStationConcat;
            ControllingStation = NS_ControllingStation;
            AccountRecordType = NS_AccountRecordType;
        }        
                
        public AccountWrapper(Account acc){
            Id = acc.Id;
            Name = acc.Name == null ? '-':acc.Name;
            ClassCode = acc.NS_ClassCode__c;
            
            if(acc.Phone != null){
                Phone = formatphonenumber(acc.Phone,true);
                if(acc.Phone.equals(searchPhone)){
                    isExactMatch = true;
                }
            }
            
            StatusIndicator = acc.NS_StatusIndicator__c;
            
            if(acc.NS_OperatingStation__c != null){
                if(acc.NS_OperatingStation__r.Name != null){
                    opStationConcat = acc.NS_OperatingStation__r.Name;
                }
            }
            
            OperatingStation = opStationConcat;
            ControllingStation = acc.NS_ControllingStation__c;
            AccountRecordType = acc.RecordType.Name;
        }
        
        public Integer compareTo(Object objToCompare){
            return Name.compareTo(((AccountWrapper)objToCompare).Name);
        }
    }
    
    public class AccountMutiMatchWrapper{
        @AuraEnabled public Boolean first;
        @AuraEnabled public Boolean prev;
        @AuraEnabled public Boolean next;
        @AuraEnabled public Boolean last;
        @AuraEnabled public Integer totalRecCount;
        @AuraEnabled public Integer currentRecCount;
        @AuraEnabled public List<AccountWrapper> accountRecords;
        
        public AccountMutiMatchWrapper(){}
        
        public AccountMutiMatchWrapper(Boolean fst, Boolean prv, Boolean nxt, Boolean lst, Integer totalRecCnt, Integer currentRecCnt, List<AccountWrapper> accountRecs) {
            first = fst;
            prev = prv;
            next = nxt;
            last = lst;
            totalRecCount = totalRecCnt;
            currentRecCount = currentRecCnt;
            accountRecords = accountRecs;    
        }
    }
    public class ContactMutiMatchWrapper{
        @AuraEnabled public Boolean first;
        @AuraEnabled public Boolean prev;
        @AuraEnabled public Boolean next;
        @AuraEnabled public Boolean last;
        @AuraEnabled public Integer totalRecCount;
        @AuraEnabled public Integer currentRecCount;
        @AuraEnabled public List<ContactWrapper> contactRecords;
        
        public ContactMutiMatchWrapper(){}
        
        public ContactMutiMatchWrapper(Boolean fst, Boolean prv, Boolean nxt, Boolean lst, Integer totalRecCnt, Integer currentRecCnt, List<ContactWrapper> contactRecs){
            first = fst;
            prev = prv;
            next = nxt;
            last = lst;
            totalRecCount = totalRecCnt;
            currentRecCount = currentRecCnt;
            contactRecords = contactRecs;
        }
    }
    
    public class DMLResult{
        @AuraEnabled public String code = '1';
        @AuraEnabled public String description = 'ERROR';
        
        public DMLResult(){
        }
    }
    /* Wrapper Classes - End*/
}