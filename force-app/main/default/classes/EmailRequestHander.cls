global class EmailRequestHander implements Messaging.InboundEmailHandler {
      global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
          Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
          try{              
              Email_Request__c er = new Email_Request__c();
              er.From_Address__c = email.fromAddress;
              er.To_Address__c = email.toAddresses[0];
              er.Email_Body__c = email.plainTextBody;
              er.subject__c = email.subject;
              
              insert er;
              result.success = true;
            }
            catch(Exception e){
            }
        
        return result;
  }
  }