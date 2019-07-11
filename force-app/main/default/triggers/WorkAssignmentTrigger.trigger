trigger WorkAssignmentTrigger on Work_Assignment__c (before insert,before update){
    Map<String,String> ReqWithSubCapability= new Map<String,String>();
    List<String> listReqName= new List<String>();
        
    for(Work_Assignment__c waRec: trigger.new){
        listReqName.add(waRec.Requirement_Number__c);
    }
    for(Request__c reqRec: [SELECT Id, Mapping__c FROM Request__c WHERE Id IN :listReqName]){
        ReqWithSubCapability.put(reqRec.Id,reqRec.Mapping__c);
    }
    for(Work_Assignment__c waRec: trigger.new){
        waRec.Sub_Capability__c = ReqWithSubCapability.get(waRec.Requirement_Number__c) ;
    }
}