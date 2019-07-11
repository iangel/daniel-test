/*
Description  : This class covers the unit testing for NS_EmailToCaseHandler class
Developer    : Accenture Solutions
Date         : 20-06-2018

-----------------------------------------------------------------------
Developer name        Date          Description        
-----------------------------------------------------------------------
@Bharadwaj Urma    20-06-2018     Unit testing methods
*/
@isTest(SeeAllData=false)
private without sharing class NS_EmailToCaseHandlerTest{ 
/*
 * Test method to check if a case is getting created with below subject ,bodyline and the case owner
 */    
    private static testmethod void testNewCase_Positive(){ 
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(25,sysprof.Id);
        System.runAs( admin ){
        NS_EmailToCaseHandler emailServiceHandler = new NS_EmailToCaseHandler();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'This is the Email Subject';
        email.plainTextBody = 'Hello, this a test email body. For testing purposes only.testNewCase_Positive';
        email.HtmlBody = 'Hello, this a test email body. For testing purposes only.testNewCase_Positive';
        email.toAddresses = new List<String>{'tncsoautomotiveboml@nscorp.com'};
        envelope.fromAddress = 'test.testing@sometest.com';
		email.ccAddresses = new List<String>{'nsTest@testmail.com'};
        Messaging.InboundEmailResult result = emailServiceHandler.handleInboundEmail(email, envelope);
        System.assertEquals( result.success  ,true);  
        system.debug([select Id from Case where subject =: 'This is the Email Subject']);
        }
        
        
    }
    
    private static testmethod void testNewCase_Positive2(){ 
        /*List<String> queueEmail = new List<String>();
        for(Group emailAddr : [SELECT Email FROM Group WHERE DeveloperName = 'NS_UTSEnergy']){
            queueEmail.add(emailAddr.Email);
        }*/
        
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(25,sysprof.Id);
        System.runAs( admin ){
        NS_EmailToCaseHandler emailServiceHandler = new NS_EmailToCaseHandler();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'This is the Email Subject';
        email.plainTextBody = 'Hello, this a test email body. For testing purposes only.testNewCase_Positive2';
        email.HtmlBody = 'Hello, this a test email body. For testing purposes only.testNewCase_Positive2';
        email.toAddresses = new List<String>{'tncsoautomotiveboml@nscorp.com'};
        envelope.fromAddress = 'test.testing@sometest.com';
		email.ccAddresses = new List<String>{'nsTest1@testmail.com'};
         Messaging.InboundEmailResult result = emailServiceHandler.handleInboundEmail(email, envelope);
        System.assertEquals( result.success  ,true);  
        }       
              
        
    }
    
          
    private static testmethod void testExistingCase_Positive(){ 
      
        String emailToCaseRT = 'Email-to-Case';
      
        NS_EmailToCaseHandler emailServiceHandler1 = new NS_EmailToCaseHandler();
        Messaging.InboundEmail email1 = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope1 = new Messaging.InboundEnvelope();
        email1.subject = 'This is the Email Subject';
        email1.plainTextBody = 'Hello, this a test email body. For testing purposes only.testNewCase_Positive';
        email1.HtmlBody = 'Hello, this a test email body. For testing purposes only.testNewCase_Positive';
        email1.toAddresses = new List<String>{'tncsoautomotiveboml@nscorp.com'};
            //connectns.nsuat+automotivebadorder-uat02@gmail.com
        envelope1.fromAddress = 'test.testing@sometest.com';
		email1.ccAddresses = new List<String>{'nsTest@testmail.com'};
        Messaging.InboundEmailResult result1 = emailServiceHandler1.handleInboundEmail(email1, envelope1);
 
        Case cse = [select Id, casenumber from Case where subject =: 'This is the Email Subject' LIMIT 1];
        NS_EmailToCaseHandler emailServiceHandler = new NS_EmailToCaseHandler();

        // Create a new email, envelope object and Attachment
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'This is the Email Subject';
        email.plainTextBody = 'Hello, this a test email body. For testing purposes only. Case Number : '+cse.CaseNumber;
        email.HtmlBody = 'Hello, this a test email body. For testing purposes only.testExistingCase_Positive';
        email.toAddresses = new List<String>{'tncsoautomotiveboml@nscorp.com'};
        //email.toAddresses = toEmail;
        email.ccAddresses = new List<String>{'tncsoautomotiveboml@nscorp.com'};
        //email.ccAddresses = ccEmail;
        
        // add an Binary attachment
        Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
        attachment.body = blob.valueOf('my attachment text');
        attachment.fileName = 'textfileone.txt';
        attachment.mimeTypeSubType = 'text/plain';
        email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
      
        // add an Text atatchment
        Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
        attachmenttext.body = 'my attachment text';
        attachmenttext.fileName = 'textfiletwo3.txt';
        attachmenttext.mimeTypeSubType = 'texttwo/plain';
        email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };
      
        envelope.fromAddress = 'test.testing@sometest.com';
        
        Messaging.InboundEmailResult result = emailServiceHandler.handleInboundEmail(email, envelope);
        
        System.assertEquals( result.success  ,true);
    }
   
    
      
    private static testmethod void testNewCase_CreateLibrary(){ 
        /*List<String> queueEmail = new List<String>();
        for(Group emailAddr : [SELECT Email FROM Group WHERE DeveloperName = 'NS_AutomotiveEmpties']){
            queueEmail.add(emailAddr.Email);
        }*/
        
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User autoUser = UserTestFactory.createAutoLeadUser(25,sysprof.Id);
        
        // create content folder

        // ContentFolder cf = new ContentFolder(name='EmailTestFolder');
        // insert(cf);
       //  ContentFolderLink cfl = new ContentFolderLink( ParentEntityId=cf.id);
       // insert(cfl);
        
        System.runAs( autoUser ){
        NS_EmailToCaseHandler emailServiceHandler = new NS_EmailToCaseHandler();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'This is the Email Subject';
        email.plainTextBody = 'Hello, this a test email body. For testing purposes only.testNewCase_CreateLibrary';
        email.HtmlBody = 'Hello, this a test email body. For testing purposes only.testNewCase_CreateLibrary';
        // dg email.toAddresses = new List<String>{'tncsoautomotiveboml@nscorp.com'};
        email.toAddresses = new List<String>{'tncsoautomotivereports@nscorp.com'};
        envelope.fromAddress = 'test.testing@sometest.com';
		email.ccAddresses = new List<String>{'tncsoautomotiveboml@nscorp.com'};
		//email.ccAddresses = queueEmail;
        
        // add an Binary attachment
        Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
        attachment.body = blob.valueOf('my attachment text');
        attachment.fileName = 'textfileone.txt';
        attachment.mimeTypeSubType = 'text/plain';
        email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
      
        // add an Text atatchment
        Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
        attachmenttext.body = 'my attachment text';
        attachmenttext.fileName = 'textfiletwo3.txt';
        attachmenttext.mimeTypeSubType = 'texttwo/plain';
        email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };

        ContentWorkspace cw = [SELECT Id, Name, DefaultRecordTypeId,Description, DeveloperName, IsRestrictContentTypes, IsRestrictLinkedContentTypes, NamespacePrefix,
								RootContentFolderId, TagModel, WorkspaceType FROM ContentWorkspace WHERE Name =: Label.NS_LibraryName];
        system.debug('test ContentWorkspace +cw');
        list<ContentFolder> lcf = [SELECT Id,Name FROM ContentFolder];           
        system.debug('contentfolder size '+lcf.size() );
        list<case> newcase = [select id from case];
        if (newcase.size() > 0) {   
          system.debug('createdocs');
          // createdocs(newcase[0]);
          
        }
        
        // Messaging.InboundEmailResult result = emailServiceHandler.handleInboundEmail(email, envelope);
        emailServiceHandler.createLibraryFile(email);
        // System.assertEquals( result.success  ,true);  
        }       
        
    }
    
    private static testmethod void testNewCase_Positive4(){ 
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(25,sysprof.Id);
        System.runAs( admin ){
        NS_EmailToCaseHandler emailServiceHandler = new NS_EmailToCaseHandler();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'This is the Email Subject';
        email.plainTextBody = 'Hello, this a test email body. For testing purposes only.testNewCase_Positive4';
        email.HtmlBody = 'Hello, this a test email body. For testing purposes only.testNewCase_Positive4';
        email.toAddresses = new List<String>{'tncsoautomotiveboml@nscorp.com'};
        envelope.fromAddress = 'test.testing@sometest.com';
		email.ccAddresses = new List<String>{'tncsoautomotiveboml@nscorp.com; tncsoautomotiveboml@nscorp.com; tncsoautomotiveboml@nscorp.com'};
         Messaging.InboundEmailResult result = emailServiceHandler.handleInboundEmail(email, envelope);
        System.assertEquals( result.success  ,true);  
        }
        
        
    }
    
    private static testmethod void testNewCase_Positive5(){ 
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(25,sysprof.Id);
        System.runAs( admin ){
        NS_EmailToCaseHandler emailServiceHandler = new NS_EmailToCaseHandler();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'This is the Email Subject';
        email.plainTextBody = 'Hello, this a test email body. For testing purposes only.';
        email.HtmlBody = 'Hello, this a test email body. For testing purposes only.';
        email.toAddresses = new List<String>{'tncsoautomotiveboml@nscorp.com; tncsoautomotiveboml@nscorp.com; tncsoautomotiveboml@nscorp.com'};
        envelope.fromAddress = 'test.testing@sometest.com';
		email.ccAddresses = new List<String>{'tncsoautomotiveboml@nscorp.com; tncsoautomotiveboml@nscorp.com; tncsoautomotiveboml@nscorp.com; tncsoautomotiveboml@nscorp.com'};
         Messaging.InboundEmailResult result = emailServiceHandler.handleInboundEmail(email, envelope);
        System.assertEquals( result.success  ,true);  
        }
        
        
    }
    
    private static testmethod void testNewCase_Positive6(){ 
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(25,sysprof.Id);
        System.runAs( admin ){
        NS_EmailToCaseHandler emailServiceHandler = new NS_EmailToCaseHandler();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'This is the Email Subject';
        email.plainTextBody = 'Hello, this a test email body. For testing purposes only.testNewCase_Positive';
        email.HtmlBody = 'Hello, this a test email body. For testing purposes only.testNewCase_Positive';
        email.toAddresses = new List<String>{'tncsoautomotiveboml@nscorp.com'};
        envelope.fromAddress = 'test.testing@sometest.com';
		email.ccAddresses = new List<String>{'nsTest@testmail.com'};
        //Messaging.InboundEmailResult result = emailServiceHandler.handleInboundEmail(email, envelope);
        //System.assertEquals( result.success  ,true);
            
        // add an Binary attachment
        Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
        attachment.body = blob.valueOf('my attachment text');
        attachment.fileName = 'textfileone.txt';
        attachment.mimeTypeSubType = 'text/plain';
        email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
      
        // add an Text atatchment
        Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
        attachmenttext.body = 'my attachment text';
        attachmenttext.fileName = 'textfiletwo3.txt';
        attachmenttext.mimeTypeSubType = 'texttwo/plain';
        email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };
            
        Messaging.InboundEmailResult result = emailServiceHandler.handleInboundEmail(email, envelope);
        System.assertEquals( result.success  ,true);  
        }
        
        
    }
    
    private static testmethod void testNewCase_PositiveLarge(){ 
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(25,sysprof.Id);
        System.runAs( admin ){
        NS_EmailToCaseHandler emailServiceHandler = new NS_EmailToCaseHandler();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'This is the Large Email Subject';
        email.plainTextBody = createLargeString();
        email.HtmlBody = createLargehtml();
        email.toAddresses = new List<String>{'tncsoautomotiveboml@nscorp.com'};
        envelope.fromAddress = 'test.testing@sometest.com';
		email.ccAddresses = new List<String>{'nsTest@testmail.com'};
        Messaging.InboundEmailResult result = emailServiceHandler.handleInboundEmail(email, envelope);
        System.assertEquals( result.success  ,true);  
        system.debug([select Id from Case where subject =: 'This is the Large Email Subject']);
        }
        
        
    }    
    
    public static void createdocs(string caseid ){
   /*
        Document_Type__c docType = new Document_Type__c(LOB__c = 'NS Railroad',
                                                        External_Id__c = 'Auto',
                                                        Category__c = 'Entity');
        insert docType;
   */
         ContentVersion cv = new ContentVersion(
                Title = 'Test',
                PathOnClient = 'Test.jpg',
                VersionData = blob.valueof('Test Content Data'),
                IsMajorVersion = true 
              //  Case_Reference__c = caseid,
              //  Taxonomy_Reference__c = [select id,name from Document_Type__c where id =:docType.id][0].name
            );
            insert cv;

  	
    }
    
    public static string createLargeString() {
    	string basestring = 'The quick brown fox Ran up the railroad track. The fast the fox ran the train kept getting closer. This is a test of large str.';
    	string largestring = basestring.repeat(256);
    	return largestring;
    }

    public static string createLargehtml() {
    	string basestring = '<br/>The quick brown fox Ran up the railroad track.<br/> The fast the fox ran the train kept getting closer.<p/> This is a test of large str.<br/>';
    	string largestring = basestring.repeat(256);
    	largestring += 'src   123';
    	largestring = largestring.repeat(4);
    	return largestring;
    }
    
}