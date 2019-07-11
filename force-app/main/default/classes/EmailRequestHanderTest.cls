@isTest
public class EmailRequestHanderTest{

  static testmethod void testEmailRequest(){ 
    EmailRequestHander objconfirm = new EmailRequestHander ();

    // Create a new email, envelope object and Attachment

    Messaging.InboundEmail email = new Messaging.InboundEmail();

    Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();

    email.subject = 'This is the Email Subject';

    email.plainTextBody = 'Hello, this a test email body. For testing purposes only.';

    email.fromAddress = 'test.testing@gmail.com';
    
    email.toAddresses = new List<String>{'test1.testing@gmail.com'};

    objconfirm.handleInboundEmail(email, envelope);


    Messaging.InboundEmailResult result = objconfirm.handleInboundEmail(email, envelope);
    System.assertEquals( result.success  ,true);

 }
 }