Trigger RequestTrigger on Request__c (after insert) { 

    // Please uncomment the code once enable the Salesforce to Salesforce 
  
/*        // Define connection id 
        Id networkId = ConnectionHelper.getConnectionId('Accenture LLP (Strategic Alliance)');//JS is the connection name
                 
        List<Request__c> localRequests = new List<Request__c>();// List containing Request record ids which are shared
       
        // only share records created in this org 
        for (Request__c newRequest : TRIGGER.new) {
                 localRequests.add(newRequest);
           }
         
            
        if (localRequests.size() > 0) { 
            
            List<PartnerNetworkRecordConnection> requestConnections =  new  List<PartnerNetworkRecordConnection>(); 
            
            for(Request__c newRequest : localRequests){
                
                PartnerNetworkRecordConnection newConnection = new PartnerNetworkRecordConnection(LocalRecordId=newRequest.Id,ConnectionId = networkId,SendClosedTasks = false, SendOpenTasks = false, SendEmails = false); 
                requestConnections.add(newConnection);                
                 
            }
            
            if (requestConnections.size() > 0 )
                     insert(requestConnections);
        } */
}