/*
description  : This class is developed for end of shift turnover requirement.
developer    : Accenture Solutions pvt ltd
date         : 04-16-2018
*/
public  with sharing class NS_CaseReleaseController {
	
       final static String CLOSED = 'Closed';
       final static String CANCELLED = 'Cancelled';
       final static String CLASS_NAME = 'NS_CaseReleaseController';
       final static String GET_ASSIGNED_CASES = 'getAssignedCases';
       final static String RELEASE_CASE = 'releaseCase'; 
       final static String SET_RETAINOWNERSHIP = 'setRetainOwnership'; 	
    /**
	 * @description This method is developed for End of shift turnover, if the user dont want to retain case they will click case release button from my page.	 	 
	 * This method takes list cases to be released and display the list of open task related to cases.
	 * @param null
	 * @return List<Case> AssignedCaseList         
	 */
    @AuraEnabled 
    public static NSAssignedCaseListWrapper getAssignedCases(Decimal pageNumber,Integer recordNumber){ 
        	//NSAssignedCaseListWrapper caseWrapper = new NSAssignedCaseListWrapper();
        	NS_CaseReleaseController.NSAssignedCaseListWrapper caseWrapper =new NS_CaseReleaseController.NSAssignedCaseListWrapper();
        	try{                	        	            
         	Integer pageSize = recordNumber;
      	 	Integer offset 	 = ((Integer)pageNumber - 1) * pageSize; 
        	caseWrapper.AssgndPageSize = pageSize;
        	caseWrapper.AssgndPage	   = (Integer) pageNumber;
            caseWrapper.AssgndTotal    =  [select count() from case  WHERE NS_AssignedTo__c= :UserInfo.getUserID() 
                                           AND ToLabel(Status)!= :CLOSED
                                           AND ToLabel(Status)!= :CANCELLED LIMIT 1];
        
       		caseWrapper.AssignedCaseList= [SELECT CaseNumber,(Select Id from Tasks where ISCLOSED = false Limit 1),Subject,
                                          ToLabel(Priority),NS_AssignedTo__r.Name,ToLabel(Status),NS_RetainCaseOwnership__c,
                                           NS_InteractionReason__c,Contact.Name,Account.Name
                                          FROM Case WHERE NS_AssignedTo__c= :UserInfo.getUserID() AND ToLabel(Status)!= :CLOSED
                                          AND ToLabel(Status)!= :CANCELLED LIMIT :recordNumber OFFSET :offset];  
        }catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, GET_ASSIGNED_CASES);
       }
            return caseWrapper;                    
    }
    /**	 	 
	 * @description This method check if the retaincaseownership field is not checked and, once the user clicks on release button the assigned to field is made null.
	 * @param List<Case> null       
	 */
	@AuraEnabled     
    public static void releaseCase(List<Id> CaseToUpdate){        
         List<Case> caseReleaseList = new List<Case>();                 
        try{
        for(Case csobj:[SELECT CaseNumber,ID FROM Case WHERE ID IN :CaseToUpdate LIMIT :CaseToUpdate.size()]){            
              if(csobj!=null){                      
			 	csobj.NS_AssignedTo__c=null;
                caseReleaseList.add(csobj); 
               }
        }
        if(!caseReleaseList.isEmpty()){            
            //update caseReleaseList;
			Database.update(caseReleaseList,false);           
        }
        }catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, RELEASE_CASE);
       }
        
    }
    /**	 	 
	 * @description This method is created to update the Retain case field from the case release modal box
	 * @param List<Id>        
	 */
    @AuraEnabled
    public static void setRetainOwnership(List<Id> csId){        
        List<Case> updatelist= new List<Case>();                        
        try{
        for(Case  casobj:[select NS_RetainCaseOwnership__c from Case where Id IN :csId LIMIT :csId.size()]){            
            if(casobj!=null){ 
            casobj.NS_RetainCaseOwnership__c=!casobj.NS_RetainCaseOwnership__c;
            updatelist.add(casobj);
            }
        }
        if(!updatelist.isEmpty()){            
            //update updatelist;
            Database.update(updatelist,false);
        }
        }catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, SET_RETAINOWNERSHIP);
       }
    }
        
     /**	 	 
	 * @description This is a wrapper class which contains list of cases,assignedpage,assignedtotal and assigned pagesize object
	 * @param Null        
	 */ 
    public with sharing class NSAssignedCaseListWrapper {
    @AuraEnabled public Integer AssgndPageSize {get;set;}
    @AuraEnabled public Integer AssgndPage {get;set;}
    @AuraEnabled public Integer AssgndTotal {get;set;}
    @AuraEnabled public List<Case> AssignedCaseList {get;set;}
    
   }
}