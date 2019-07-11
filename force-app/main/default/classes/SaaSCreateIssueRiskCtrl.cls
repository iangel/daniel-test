/** 
 *  Author : Accenture 
 *  Description : Controller class for SaaSReleaseListView  
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  05\06\2015        created 
 *
 */
public class SaaSCreateIssueRiskCtrl 
{
    public Issues_Risks__c issueRiskObj {get;set;}
    public Date loggedDate {get;set;}
    public Date targetResolutionDate {get;set;}
    public string release {get;set;}  
    public Boolean isSaved {get;set;} 
    public String issueRiskType {get;set;}  
    public Boolean disableRecType {get;set;}  
    public Boolean isDetail {get;set;}
    /**
     * Construtor 
     * @param ApexPages.StandardController controller
     *
     */
    public SaaSCreateIssueRiskCtrl (ApexPages.StandardController controller) 
    {    
        isSaved  = false;
        Issues_Risks__c tempIssueRiskObj = null;
        List<Issues_Risks__c>  issueRiskLst = null;
        Boolean isClone =false;
        issueRiskType  = SaaSTextConstant.EMPTY_STRING;
        tempIssueRiskObj = (Issues_Risks__c)controller.getRecord();
        release =  SaaSUtility.getURLParameter(SaaSTextConstant.RELEASEID_URL_PARAM );
        isDetail = SaaSUtility.getURLParameter(SaaSTextConstant.DETAIL_URL_PARAM ) == SaaSTextConstant.NUMERIC_ONE  ?true:false;
        isClone =   SaaSUtility.getURLParameter(SaaSTextConstant.IS_CLONE_URL_PARAM) == SaaSTextConstant.NUMERIC_ONE  ? true :false;  
        disableRecType = isClone? true:false;
        disableRecType = isDetail ? true:false;
 //       issueRiskType  =  (tempIssueRiskObj.id != null)?tempIssueRiskObj.RecordType.developerName:SaaSTextConstant.EMPTY_STRING;      

          // Check if this is edit mode
        if(tempIssueRiskObj.id != null )
        {
            issueRiskLst  = Database.query(SaaSUtility.getCreatableFieldsSOQL(SaaSTextConstant.ISSUE_RISK_OBJ_API_NAME, 'id=\''+tempIssueRiskObj.id+'\''));
            if(issueRiskLst.size() > 0)
            {
                issueRiskObj= issueRiskLst.get(0); 
                issueRiskType  =  SaaSUtility.getRecordTypeDeveloperName(issueRiskLst.get(0).recordTypeID);
                targetResolutionDate = issueRiskObj.Target_Resolution_Date__c;
                loggedDate = issueRiskObj.Logged_Date__c;  
            }
        }  
        else 
        {
            issueRiskObj= new Issues_Risks__c();
        }        
        if(isClone)
        {
            issueRiskObj= issueRiskObj.clone();
            issueRiskObj.ownerID = Userinfo.getUserID();
        }     
        if(release !=null && release.trim() != SaaSTextConstant.EMPTY_STRING )
        {
            issueRiskObj.Release__c = release ;
        }
    }
      
   /**
    * Save the IssueRisk record
    * @return 
    *
    */   
    public PageReference saveIssueRisk() 
    {                
        PageReference pageRef= null; 
        String errMsg = null;       
        try
        {
            
            issueRiskObj.Target_Resolution_Date__c = targetResolutionDate;
            issueRiskObj.Logged_Date__c = loggedDate; 
            List<RecordType> recLst = [Select id from RecordType where  SobjectType = :SaaSTextConstant.ISSUE_RISK_OBJ_API_NAME and developerName = :issueRiskType ];        
            if(recLst.size() > 0)
            {
                issueRiskObj.recordTypeID  = recLst.get(0).id;
            }
            errMsg  =validateKeyDecision(); 
            if(errMsg  != null)
            {
                SaaSUtility.displayErrMsg(errMsg   );  
                System.debug('errMsg---'+ errMsg  );   
                return null;
            }
            upsert issueRiskObj; 
            SaaSUtility.displaySuccessMsg(SaaSTextConstant.ISSUE_RISK_SAVE_MSG);
            isSaved  = true; 
        }
        catch(DmlException e)
        {
            SaaSUtility.displayErrMsg(e.getDmlMessage(0) );           
        } 
        catch(Exception e)
        {
             SaaSUtility.displayErrMsg(SaaSTextConstant.EXCEPTION_ERR_MSG );          
        }
        return pageRef;
    }    
    
   /**
    *  Get all record type of the Issue and risk object
    * @return List<SelectOption>
    *
    */         
    public List<SelectOption> getRecordType() 
    {
        List<SelectOption> recType = new List<SelectOption>();
         recType.add(new SelectOption(SaaSTextConstant.EMPTY_STRING ,SaaSTextConstant.NONE_PICKLIST_VALUE ));
        List<RecordType> rcordType1 = [Select id ,Name,DeveloperName from RecordType where SobjectType = :SaaSTextConstant.ISSUE_RISK_OBJ_API_NAME];
        for(RecordType obj : rcordType1 )
        {
              recType.add(new SelectOption(obj.DeveloperName,Obj.name));
        }
        return recType;
    }
    
   /**
    * Disable Record Type picklsit once picklis is modified 
    * @return none
    *
    */  
    public void disbaleRecordType()
    {
       if(issueRiskType  != SaaSTextConstant.EMPTY_STRING)
       {
            disableRecType = true;
       }            
    }
     
   /**
    * Validate the data entered by the user.
    * @return String errmsg
    *
    */       
    @TestVisible private String validateKeyDecision()
    {
        String errMsg = null; 
        
        if(issueRiskObj.Status__c== Null || issueRiskObj.Status__c==SaaSTextConstant.EMPTY_STRING)
        {
            errMsg = SaaSTextConstant.ISSUE_STATUS_EMPTY_ERR_MSG; 
        }                             
        else if(issueRiskObj.Priority__c== Null || issueRiskObj.Priority__c==SaaSTextConstant.EMPTY_STRING)
         {
             errMsg = SaaSTextConstant.ISSUE_PRIORITY_EMPTY_ERR_MSG ;
         }
            
         else if(issueRiskObj.Description__c== Null || issueRiskObj.Description__c==SaaSTextConstant.EMPTY_STRING)
         {
             errMsg = SaaSTextConstant.ISSUE_DESC_EMPTY_ERR_MSG; 
         }
         else if(issueRiskObj.Target_Resolution_Date__c == Null)
        {
             errMsg = SaaSTextConstant.ISSUE_TARGET_RESOLUTION_DATE_ERR_MSG;      
        }
        else if(issueRiskType == Null || issueRiskType ==SaaSTextConstant.EMPTY_STRING)
        {
             errMsg =SaaSTextConstant.SELECT_REQUEST_TYPE_ERR_MSG;
        }  
        return errMsg; 
    }    
    
     /**
    * Create new issue OR Risk 
    * 
    *    
    */    
    public void createIssueOrRisk()
    {
        isDetail = false;
        issueRiskObj  = new   Issues_Risks__c ();
        loggedDate  = null;    
        targetResolutionDate  = null;
        issueRiskType  = SaaSTextConstant.EMPTY_STRING;  
        disableRecType  = false;                  
    }
}