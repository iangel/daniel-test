public class ChildCaseWrapper { 
     @AuraEnabled
   public Id AccountId {get;set;}
     @AuraEnabled
   public Id ContactId {get;set;}
     @AuraEnabled
   public String Subject {get;set;}
     @AuraEnabled
   public Id ParentId {get;set;}
     @AuraEnabled
   public Boolean Message {get;set;}
}