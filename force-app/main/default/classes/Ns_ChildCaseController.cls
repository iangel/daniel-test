/**@author  Accenture
* @Created Date 2019-Feb-15
* @version  1.0
* @description This class conatins methods which are invoked by  Child component to return account, contact ,subject. 
*/ 
public with sharing class Ns_ChildCaseController {
       

    @AuraEnabled
    public static ChildCaseWrapper getChildcase(Id caseId) {
        try {
            
            ChildCaseWrapper returnResult = new ChildCaseWrapper();
                  
            Case vc= [SELECT Id,status,accountId,contactId,subject,parentId,recordtypeid FROM Case 
                            where Id=: caseId LIMIT 1];
           Id requestRecord= [SELECT Id FROM RecordType WHERE Name =:NS_StaticVariablesUtility.ChildCase AND 
                            SobjectType =:NS_StaticVariablesUtility.NS_CASE Limit 1].id;
            // if(vc.parentId == null || vc.parentId == '')
           //if((String.isBlank(vc.parentId) || String.isEmpty(vc.parentId)) && vc.Status!='NS_Closed')
         // if(vc.Status!=NS_StaticVariablesUtility.NS_CLOSED){
        
            
           if(vc.Status!=NS_StaticVariablesUtility.NS_CLOSED){
            returnResult.AccountId = vc.accountId;
            returnResult.ContactId = vc.contactId;
            returnResult.Subject = vc.subject;
            returnResult.ParentId = vc.parentId;
			returnResult.Message = True;             
            return returnResult;
            }
            else{
               
            returnResult.AccountId = null;
            returnResult.ContactId = null;
            returnResult.Subject = NS_StaticVariablesUtility.Blank;
            returnResult.ParentId = null;
			returnResult.Message = False;  
            return returnResult;   
            }
                   
        } catch(DmlException e) {
           
            return null;
        }
    }
    
}