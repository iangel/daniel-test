/**@author  Accenture
* @Created Date 2018-03-11
* @version  1.0
* @description This class handles all inbound email send to email service email address for case creation. 
*
*Modification History
*************************************************************************************************
MODIFIED DATE       MODIFIED BY         DESCRIPTION
*************************************************************************************************
06/26/2019          Gidon Payenson      IM02506283 – EmailToCase functionality for similar queue
													 metadata email strings
07/09/2019          Daniel Glaser       IM02509476 - Email function within ConnectNS not working properly 
07/09/2019          Daniel Glaser       IM02319098 - Undeliverable emails													 
-------------------------------------------------------------------------------------------------

*/ 
global without sharing class NS_EmailtoCaseHandler implements Messaging.InboundEmailHandler {
    List<OrgWideEmailAddress> owdEmails;
    /*
    * handleInboundEmail method of InboundEmailHandler interface is being overriden to create case based on email services.
    */
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.Inboundenvelope envelope) 
    {
        final String className = 'NS_EmailtoCaseHandler';
        String METHOD_NAME='handleInboundEmail';
        Case cse = new Case();        
        String caseNum='';
        String toAddress='';
        String toAddresses='';
        String ccAddresses='';
        String forwardingEmails='';
        String emailHtmlBody = email.HtmlBody;
        String emailBody = email.plainTextBody;
        String searchStr = email.subject+email.plainTextBody;
        String owd = System.Label.NS_NoReplyOrgWideAddress;
        String noReplyMsg = 'This is a no reply mail and this inbox is not being monitored';
        String message='Please ensure that the Norfolk Southern email address you are attempting to contact is populated in the email "To" line.';
        Boolean createNewCase = true;
        Set<String> emailToExclude = new Set<String>();
        String queueName = '';
        string libAddress = '';
        ID queueId;
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        //IM02506283 - Gidon -- 06/26/19  -- map to keep EmailToQueue metadata. Key = Forwarding_Address__c
        Map<string,NS_EmailToQueue__mdt>  emailToQueueMdtMap = new Map<string,NS_EmailToQueue__mdt>();
        try{
            List<Attachment> allAttachment = new List<Attachment>();   
            Set <String> emailaddr = new Set<String> ();

            for(NS_EmailToQueue__mdt allEmail :[SELECT Queue_Id__c, Label, Routing_Email_1__c ,Forwarding_Address__c 
                                                FROM NS_EmailToQueue__mdt LIMIT 50000]){ //gp
                // system.debug('NS_EmailToQueue__mdt allEmail ' + allEmail);
                if(allEmail.Forwarding_Address__c != null){
                    emailaddr.add(allEmail.Forwarding_Address__c);
                    emailToQueueMdtMap.put(allEmail.Forwarding_Address__c,allEmail); //gp
                }
                if(allEmail.Label.equalsIgnoreCase(NS_StaticVariablesUtility.NS_EMAILTOLIBRARY)){
                    libAddress = allEmail.Forwarding_Address__c;
                    system.debug('libAddress '+libAddress);
                }
            }

            //If to address  or  cc address is available.
            //system.debug('NS_EmailToCaseHandler:email.toAddresses= ' + email.toAddresses);
			//system.debug('NS_EmailToCaseHandler:emailaddr= ' + emailaddr);
			
            if(email.toAddresses != null ) {
                for(String addr : email.toAddresses){
                    
                    for(String frwdAdd : emailaddr){ 
                         //IM02506283 - Gidon -- 06/26/19  -- replaced with split. 
                         									//frwdAdd contains semicolon separated email addresses 
                        //if(frwdAdd.toLowerCase().contains(addr.toLowerCase())){ 
                        //system.debug('NS_EmailToCaseHandler:frwdAdd.toLowerCase= ' + frwdAdd.toLowerCase());
                        //system.debug('NS_EmailToCaseHandler:addr.toLowerCase= ' + addr.toLowerCase());
                    	For (string splitAddr: frwdAdd.split(';')) {  //IM02506283 - Gidon -- 06/26/19  -- split to find exact match 
                            if(splitAddr.toLowerCase() == addr.toLowerCase()){ 
                                //if(toAddress == ''){  //IM02506283 - Gidon -- 06/26/19 no need any more
                                    toAddress = addr;
                                //}
                                emailToExclude.add(addr); 
                                //IM02506283 - Gidon -- 06/26/19 added 2 lines to get values from map
                                queueId = (ID)emailToQueueMdtMap.Get(frwdAdd).Queue_Id__c;
                                queueName = emailToQueueMdtMap.Get(frwdAdd).Label; //gp
                           }
                        if (toAddress != '') break; //IM02506283 - Gidon -- 06/26/19 -- break when match found
                        }
                    if (toAddress != '') break; //IM02506283 - Gidon -- 06/26/19 -- break when match found 
                    }
                if (toAddress != '') break; //IM02506283 - Gidon -- 06/26/19 -- break when match found  
                }
            }
            
            //If to address is not a part of metadata forwarding emails, search for cc address instead.
            //if(toAddress == '' && email.ccAddresses != null){
            //if(email.ccAddresses != null) //IM02506283 - Gidon -- 06/26/19  -- replaced with split. 
                         									//frwdAdd contains semicolon separated email addresses 
            if(email.ccAddresses != null && toAddress == ''){ //IM02506283 - Gidon -- 06/26/19  -- only ifno match in To Address   
                for(String ccAddr : email.ccAddresses){
                    for(String frwdAdd : emailaddr){
                        //system.debug('NS_EmailToCaseHandler:frwdAdd.toLowerCase= ' + frwdAdd.toLowerCase());
                        //system.debug('NS_EmailToCaseHandler:ccAddr.toLowerCase()= ' + ccAddr.toLowerCase());
                        For (string splitAddr: frwdAdd.split(';')) { //IM02506283 - Gidon -- 06/26/19  -- use split for exact match
                            if(splitAddr.toLowerCase() == ccAddr.toLowerCase()){
                                //if(toAddress == ''){ //IM02506283 - Gidon -- 06/26/19  -- redundant, since breaking
                                toAddress = ccAddr;
                                //}
                                emailToExclude.add(ccAddr); 
                                //IM02506283 - Gidon -- 06/26/19 added 2 lines to get values from map
                                queueId = (ID)emailToQueueMdtMap.Get(frwdAdd).Queue_Id__c;
                                queueName = emailToQueueMdtMap.Get(frwdAdd).Label;
                             
                            }
                    	if(toAddress != '') break; //IM02506283 - Gidon -- 06/26/19 -- break when match found
                        }
                    if(toAddress != '') break; //IM02506283 - Gidon -- 06/26/19 -- break when match found
                    }
                if(toAddress != '') break; //IM02506283 - Gidon -- 06/26/19 -- break when match found
                }
            }
            system.debug('toAddress '+toAddress);
            if(toAddress != ''){
                if(owd.equalsIgnoreCase(toAddress) || ''.equalsIgnoreCase(toAddress)){
                    sendBounceBack(email, noReplyMsg);
                }
                
                /*The attachment needs to be stored in Salesforce Library if email is sent to Custom Label>NS_LibraryEmail
                *Request# 1464
                *Developer: Jyoti
                *Date: 01/21/2019
                */
                //Code modification done for D-1152 by Ananya on 6/7/2019 
                /*else if(Label.NS_LibraryEmail.equalsIgnoreCase(toAddress)){
                    createLibraryFile(email);    
                }               
                
                else if(toAddress.contains(Label.NS_LibraryEmail)){
                    createLibraryFile(email);    
                }*/             
                
                else if(libAddress.toLowerCase().contains(toAddress.toLowerCase())){
                	system.debug('call createlibraryfile');
                    createLibraryFile(email);
                }
               
                //
                //End of change for Request# 1464    
                else{ 
                    if(email.toAddresses != null){
                        for(String emailId : email.toAddresses){
                            toAddresses += emailId+NS_StaticVariablesUtility.NS_SemiColon;
                        }
                    }
                    if(email.ccAddresses != null){
                        for(String emailId : email.ccAddresses){
                            ccAddresses += emailId+NS_StaticVariablesUtility.NS_SemiColon;
                        }
                    }
                    /* gp
                    for(NS_EmailToQueue__mdt casePriorityMappings : [SELECT Label, DeveloperName, Queue_Id__c,
                                                                     Forwarding_Address__c,Routing_Email_1__c 
                                                                     FROM NS_EmailToQueue__mdt LIMIT 50000]){
                                                                         
                                                                         
                       if(casePriorityMappings.Forwarding_Address__c != null && 
                          					String.valueOf(casePriorityMappings.Forwarding_Address__c).contains(toAddress)){
                             queueId = (ID)casePriorityMappings.Queue_Id__c;
                             queueName = casePriorityMappings.Label;
                             break;
                        }
                                                                         
                   }
                   */ 
                    pattern myPattern = pattern.compile(NS_StaticVariablesUtility.NS_Regex);
                    matcher myMatcher = myPattern.matcher(searchStr);
                    Integer count =limits.getLimitQueryRows();
                    String queueEmail = [SELECT Id, Name, Email FROM Group where Type = 'Queue' and Id = :queueId].Email;
                    owdEmails = [SELECT Id, Address FROM OrgWideEmailAddress where Address = :queueEmail];
                    //Get First match
                    //
                    
                    while (myMatcher.find()) {
                        List<String> parts = (myMatcher.group(0)).split(NS_StaticVariablesUtility.NS_Colon);
                        if(!parts.isEmpty()){
                            caseNum = parts[1];
                        } 
                        break;                
                    }
                    
                    // 1.23.2019, update to use matches()
                    /*if (myMatcher.matches()) {
                        List<String> parts = (myMatcher.group(0)).split(NS_StaticVariablesUtility.NS_Colon);
                        caseNum = parts[1]; 
                    }*/
                    
                    try {
                        List<Contact> vCon = [SELECT Id,AccountId, Name, Email FROM Contact WHERE Email = :email.fromAddress LIMIT:count];
                        if(!String.isEmpty(caseNum)){
                            List<Case> caseList = [Select id,casenumber,IsClosed from Case where casenumber = :caseNum.trim() LIMIT 1];
                            if(!caseList.isEmpty()){
                                cse = caseList[0];
                                createNewCase = false;
                            }                    
                        }
						system.debug('NS_EmailtoCaseHandler handleInboundEmail text body length '+email.plainTextBody.length());
						// IM02319098 can only copy 32000 characters to description
                        if(email.plainTextBody != null && email.plainTextBody.length() > NS_StaticVariablesUtility.NS_EmailTextBodyLimit){
                            emailBody = emailBody.substring(0, NS_StaticVariablesUtility.NS_EmailTextBodyLimit);
                        }
                        if(email.HtmlBody != null && email.HtmlBody.length() > NS_StaticVariablesUtility.NS_emailBodyLimit){
                            emailHtmlBody = emailHtmlBody.substring(0, NS_StaticVariablesUtility.NS_emailBodyLimit);
                        }    
                        List<String> allEmails = new List<String>();
                        String lastEmailToCc = NS_StaticVariablesUtility.CONST_BLANK;
                        for(String lstEmail : toAddresses.split(';')){
                            if(!emailToExclude.contains(lstEmail)){
                                allEmails.add(lstEmail);
                            }else{
                                forwardingEmails += lstEmail+' ';
                            }
 
                        }
                        for(String lstccEmail : ccAddresses.split(';')){
                            if(!emailToExclude.contains(lstccEmail)){
                                allEmails.add(lstccEmail);                            
                            }else{
                                forwardingEmails += lstccEmail+' ';
                            }
                        } 
                        forwardingEmails = forwardingEmails.trim();
                        if(forwardingEmails.length() > 255){
                            forwardingEmails = forwardingEmails.substring(0, 256);
                        }
                        if(!allEmails.isEmpty()){
                            for(String emailId : allEmails){
                                lastEmailToCc += emailId+NS_StaticVariablesUtility.NS_SemiColon;
                            }
                        }
                        if(createNewCase){
                            //String body=emailBody.replace('\u2028','\n');   
                            system.debug('NS_EmailtoCaseHandler handleInboundEmail: description length '+emailBody.length());                         
                            Case cseSobj = new Case();
                            cseSobj.put('Queue_Type__c',queueName);
                            cseSobj.put('Description',emailBody); 
                            cseSobj.put('subject',email.subject);
                            cseSobj.put('Origin',NS_StaticVariablesUtility.NS_Email);
                            cseSobj.put('Priority',NS_StaticVariablesUtility.NS_LOW);
                            cseSobj.put('Status',NS_StaticVariablesUtility.NS_NEW);
                            cseSobj.put('ownerID',queueId);
                            Integer hashcode = (Date.today()+''+NS_StaticVariablesUtility.NS+''+emailBody+''+email.subject).hashcode();
                            cseSobj.put('NS_Email_Service_Message_ID__c',String.valueOf(hashcode));
                            cseSobj.put('RecordTypeId',Schema.SObjectType.case.getRecordTypeInfosByName()
                                .get(NS_StaticVariablesUtility.NS_EmailToCaseRT).getRecordTypeId()); 
                            if(!vCon.isEmpty() && vCon.size() == 1){
                                cseSobj.put('ContactId',vCon[0].Id);
                            }
                            
                            if(lastEmailToCc!=NS_StaticVariablesUtility.CONST_BLANK){
                                cseSobj.put('NS_LastEmailAddresses__c',lastEmailToCc);
                            }
                            cseSobj.put('NS_Email_1__c',email.fromAddress);
                            cseSobj.put('Forwarding_Emails__c',forwardingEmails);
                                                      
                            
                            List<String> emailFieldApiNames = new List<String>();
                            //add all 25 email field api name starting from 2.
                            for(Integer apiNameIndex = 2; apiNameIndex <= 25 ; apiNameIndex ++){
                                emailFieldApiNames.add('NS_Email_'+apiNameIndex+'__c');
                            }
                            
                            
                            for(Integer i=0; i<allEmails.size(); i++){
                                if(i == emailFieldApiNames.size()){
                                    break;
                                }
                                cseSobj.put(emailFieldApiNames.get(i),allEmails.get(i));
                                //to avoid going beyond 25 emails and throw exception.
                            }                            
                            
                            Database.insert(cseSobj);                         
 
                            cse = [Select id,casenumber,NS_LastEmailAddresses__c,Subject,IsClosed from Case where Id = :cseSobj.Id LIMIT 1];
                        }
                        
                        if(cse != null){
                            //Attach email to the email related list
                            EmailMessage emailMsg = new EmailMessage(); // Created a EmailMessage and copy all details from above.
                            emailMsg.ToAddress=toAddresses;
                            emailMsg.CcAddress=ccAddresses;
                            if(createNewCase){
                                emailMsg.Subject=email.subject+NS_StaticVariablesUtility.Space+NS_StaticVariablesUtility.Hyphen+
                                    NS_StaticVariablesUtility.Space+NS_StaticVariablesUtility.NS_CASENUMBER+NS_StaticVariablesUtility.Space+
                                    NS_StaticVariablesUtility.NS_Colon+NS_StaticVariablesUtility.Space+cse.casenumber;
                            }
                            else{
                                emailMsg.Subject=email.subject;
                                if(lastEmailToCc!=NS_StaticVariablesUtility.CONST_BLANK && cse.IsClosed==false){
                                    cse.NS_LastEmailAddresses__c = lastEmailToCc;
                                    cse.NS_WFAutoRelease__c = true;
                                    update cse;
                                }
                            }
                            if(emailHtmlBody==null){
                                emailMsg.TextBody=emailBody;
                            }else{
                              emailMsg.HtmlBody=emailHtmlBody;
                            }
                            emailMsg.ParentId = cse.Id; //Attach with the case
                            emailMsg.MessageDate = system.now();
                            emailMsg.Status='0';
                            emailMsg.Incoming=true;
                            emailMsg.FromAddress=email.fromAddress;                    
                            Database.insert(emailMsg);
                            
                            if (email.binaryAttachments != null && email.binaryAttachments.size() > 0) {
                                
                                for (integer i = 0; i < email.binaryAttachments.size(); i++) {
                                    allAttachment.add(new Attachment(
                                        ParentId = emailMsg.Id,
                                        Name = email.binaryAttachments[i].filename,
                                        Body = email.binaryAttachments[i].body));
                                    
                                }                      
                            }
                            if(email.plainTextBody.length() > NS_StaticVariablesUtility.NS_EmailBodyLimit|| 
                              email.htmlBody.length() > NS_StaticVariablesUtility.NS_EmailBodyLimit){

	                            // Dan IM02319098 - Undeliverable emails
	                            //********************************************
	                            string strbody = email.htmlBody;
	                            string strhtmlbody = '';
	                            integer striplen = 0; //  NS_StaticVariablesUtility.NS_EmailTextBodyLimit;
	                            integer index = 0;
	                            system.debug('Process clips of html data '+strbody.length());
	                            if (strbody.length() > 0 && strbody.contains('src')) {
		                            integer p = 0;
		                            do {
		                            	striplen += NS_StaticVariablesUtility.NS_emailBodyLimit;
		                            	if (striplen >= email.htmlBody.length() ) {
		                            		striplen = email.htmlBody.length();
		                            		system.debug('Reached max length ');
		                            	}
		
		                            	string replacedstr = email.htmlBody.substring(p, striplen); 
		                            	system.debug('replace html data to '+striplen+ ' from P= '+p);
		                           		strhtmlbody += replacedstr.replaceall('src','');
		                            	
		                            	system.debug('index '+index+'Strip len '+striplen);
		                            	index++;
		                            	p+=NS_StaticVariablesUtility.NS_emailBodyLimit;
		                            	
		                            } while (p < email.htmlBody.length());
		                            index--;
		                         
		                            system.debug('Total clips of data '+index);
		                            system.debug('htmlbody rebuilt');
	                            } else {
	                            	strhtmlbody = email.htmlBody;
	                            	system.debug('htmlbody Contains no src html length '+strhtmlbody.length());
	                            }
	                            //********************************************
	                            // END Dan IM02319098 - Undeliverable emails
                            
                                //Gets attached to Attachment related List
                                Attachment att = new Attachment(
                                    ParentId = emailMsg.Id,
                                    IsPrivate = false,
                                    ContentType = 'application/pdf',
                                    Name = email.subject+NS_StaticVariablesUtility.Space+NS_StaticVariablesUtility.Hyphen+
                                    NS_StaticVariablesUtility.Space+cse.casenumber+NS_StaticVariablesUtility.Dot+NS_StaticVariablesUtility.PDF,
                                    // Body = blob.toPDF(email.htmlBody.replaceall('src','')));
                                    Body = blob.toPDF(strhtmlbody));  // Dans test
                                    
                                system.debug('body size '+email.htmlBody.length());
                                system.debug('PDF body size '+att.Body.size());
                                allAttachment.add(att);
                                
                                
                            }
                            
                            
                            Database.insert(allAttachment);
                            //sendAutoResponse(email,cse,emailToExclude); //Autorespnse emails are being sent from workflow
                        }             
                        result.success = true;
                    }
                    catch(Exception e){
                        NS_StaticVariablesUtility.createExceptionRecord(e, className, className);
                    }
                }
            }
            else{
                sendBounceBack(email, message);
            }
        }catch(Exception ex){
            
            NS_StaticVariablesUtility.createExceptionRecord(ex, className, METHOD_NAME ); 
        }
        return result;
    }

   /*
    * This method sends the bounce back message to customer if they are trying to reply back on noreply address
    */ 
    public void sendBounceBack(Messaging.InboundEmail email, String Message){
        
        String className='NS_EmailtoCaseHandler';
        String subjectMsg='No Reply Mail';
        String METHOD_NAME='sendBounceBack';
        try{
            Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();        
            semail.toAddresses = new List <String> {email.fromAddress};
            semail.setSubject(subjectMsg);
            semail.setplainTextBody(Message);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { semail });
        }
        catch (Exception e) {
            NS_StaticVariablesUtility.createExceptionRecord(e, className, METHOD_NAME ); 
        }
    }
    
    /*The attachment needs to be stored in Salesforce Library if email is sent to Custom Label>NS_LibraryEmail
    *Request# 1464
    *Developer: Jyoti
    *Date: 01/21/2019
    */
    public void createLibraryFile(Messaging.InboundEmail email){
        List<ContentFolder> rampFolder = new List<ContentFolder>();
        List<ContentFolder> monthFolder = new List<ContentFolder>();
        String eSubject;
        Id parentFolder;
        try{
            //ContentWorkspace is Library, e.g. Automotive Library
            
            ContentWorkspace cw = [SELECT Id, Name FROM ContentWorkspace WHERE Name =: Label.NS_LibraryName LIMIT 100];

            //ContentFolder is File
            ContentFolder cf = [SELECT Id,Name FROM ContentFolder WHERE Name =: cw.Id LIMIT 100];

            List < ContentFolderLink > cfl = [SELECT Id, ContentFolderId, ParentEntityId
                                             FROM ContentFolderLink
                                             WHERE ParentEntityId = : cw.Id LIMIT 100];
            if (cfl.size() > 0) {
                //All punctuation characters except ' and \
                String regExp = '[|,|.|\\,||"||:|~|!|@|#|$|%|^|&|*|_|+|=|<|>|?|\\(|\\)|\\{|\\}|\\;|\\\'"]';
                
                //Prepare a string from email subject in uppercase and without punctuation 
                // eSubject = ((email.subject).replaceAll(regExp, NS_StaticVariablesUtility.CONST_BLANK)).toUpperCase()+ '%';
                          
                  eSubject = email.subject.trim() +'%';

                //Library Folder name is ramp name which is expected in email subject
                  rampFolder = [SELECT Id, Name, ParentContentFolderId FROM ContentFolder where Name LIKE: eSubject and ParentContentFolderId =: cf.Id];
                 
                //If ramp folder is not present, file will be created inside 'Automotive Library'
                if(rampFolder.isEmpty()){
                    parentFolder = cf.Id;
                }
                //If Ramp folder is present then look for current month folder with name as 'yyyy-mm'
                else{
                    String yearMonth = String.valueOf((System.today()).year())+ '-'+ String.valueOf((System.today()).month());  
                    monthFolder = [SELECT Id, Name, ParentContentFolderId FROM ContentFolder where ParentContentFolderId =: rampFolder[0].Id AND Name=:yearMonth LIMIT 100];
                    if(monthFolder.isEmpty()){
                        monthFolder.add(new ContentFolder(Name = yearMonth, ParentContentFolderId = rampFolder[0].Id));
                        Insert monthFolder;
                    }
                    //File will be created inside the month folder
                    parentFolder = monthFolder[0].Id;
                }    

            }
            List<ContentVersion>cvList = new List<ContentVersion>();
            List<ContentDocumentLink> cdlList = new List<ContentDocumentLink>();
            //Create the files with title as 'email subject yyyy-MM-dd HH-mm'
            for (Messaging.InboundEmail.BinaryAttachment binAttach : email.binaryAttachments) {
                ContentVersion conInsert = new ContentVersion();
                if(eSubject == null){
                    conInsert.Title = '';
                }
                else{
                    conInsert.Title = eSubject.removeEnd('%') +' '+ (system.now()).format('yyyy-MM-dd HH-mm','America/New_York');
                }
                conInsert.VersionData = binAttach.body;
                conInsert.PathOnClient = '/' + binAttach.fileName ;
                cvList.add(conInsert);
            }
            insert cvList; //File insert
            //create the junction object ContentDocumentLink, file access is defined here
            cvList = [select id, ContentDocumentId from ContentVersion WHERE Id in :cvList];
            for (ContentVersion cv : cvList) {
                ContentDocumentLink cl = new ContentDocumentLink();
                cl.ContentDocumentId = cv.ContentDocumentId;
                cl.LinkedEntityId = cw.Id;
                cl.ShareType = 'I';
                cl.Visibility = 'AllUsers';
                cdlList.add(cl);
            }
            insert cdlList;
            
            //Update the parent Folder
            //
            //ContentVersion cv =[SELECT ContentDocumentId FROM ContentVersion WHERE Id = : cvList[0].Id];
            SET<ID> cvIdList = new SET<ID>();
            List<ContentFolderMember> conFol= new List<ContentFolderMember>();
            for(ContentVersion cv1: cvList)
            {
                cvIdList.add(cv1.ContentDocumentId);
            }
                           
            conFol = [SELECT ChildRecordId,Id,ParentContentFolderId,SystemModstamp FROM ContentFolderMember WHERE ChildRecordId IN : cvIdList LIMIT 100]; //cv.ContentDocumentId]cvList[0].ContentDocumentId;
            for(ContentFolderMember cfol : conFol)
            {
               cfol.ParentContentFolderId = parentFolder;
            }       
            //upsert fol;
            update conFol;           
            
        }
        catch(Exception ex){
            NS_StaticVariablesUtility.createExceptionRecord(ex, 'NS_EmailtoCaseHandler', 'createLibraryFile' );
        }
    }
}