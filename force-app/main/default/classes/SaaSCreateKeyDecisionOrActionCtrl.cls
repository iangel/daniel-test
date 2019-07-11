/** 
 *  Author : Accenture 
 *  Description : Controller class for SaaSCreateRelease
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  05\06\2015        created 
 *
 */
public class SaaSCreateKeyDecisionOrActionCtrl
{
    public Key_Action_Decision__c keyDecisionObj  {get;set;}
    public Boolean isDetail {get;set;}     
    public Date DueDate {get;set;}
    public Boolean isSaved {get;set;}        
   // public List<Release__c> releaseLst {get;set;}
   // public String release11{get;set;}    
    public String actionOrDecisionType {get;set;}     
    public Boolean disableRecType {get;set;}  

   /**
    * Construtor 
    *
    * @param ApexPages.StandardController controller
    *
    */
    public SaaSCreateKeyDecisionOrActionCtrl(ApexPages.StandardController controller) 
    {
        isSaved  = false; 
        String  releaseID = null;
        Key_Action_Decision__c tempKeyDecisionObj;
        List<Key_Action_Decision__c >  keyDecisionLst = null;  
        Boolean isClone = false;  
        
        
        tempKeyDecisionObj = (Key_Action_Decision__c )controller.getRecord();
        releaseID  =  SaaSUtility.getURLParameter(SaaSTextConstant.RELEASEID_URL_PARAM );
        isDetail = SaaSUtility.getURLParameter(SaaSTextConstant.DETAIL_URL_PARAM ) == SaaSTextConstant.NUMERIC_ONE  ?true:false;
       // if(isDetail ){disableRecType = true;}
                                        
        actionOrDecisionType  = SaaSTextConstant.EMPTY_STRING;
        isClone = SaaSUtility.getURLParameter(SaaSTextConstant.IS_CLONE_URL_PARAM) == SaaSTextConstant.NUMERIC_ONE ? true :false;
        disableRecType = isDetail? true:false;
        disableRecType = isClone? true:false; 
       // actionOrDecisionType = (tempKeyDecisionObj.id != null)?tempKeyDecisionObj.RecordType.developerName:SaaSTextConstant.EMPTY_STRING ;       
        
        
       
        if(tempKeyDecisionObj.id != null )
        {
            disableRecType  = true;
            keyDecisionLst = Database.query(SaaSUtility.getCreatableFieldsSOQL(SaaSTextConstant.KEY_ACTION_DECISION_OBJ_API_NAME, 'id=\''+tempKeyDecisionObj.id+'\''));
            if(keyDecisionLst.size() > 0)
            {
                keyDecisionObj = keyDecisionLst.get(0);  
                dueDate =   keyDecisionLst.get(0).Due_Date__c;    
                actionOrDecisionType  = SaaSUtility.getRecordTypeDeveloperName(keyDecisionLst.get(0).recordTypeID);
            }
        }  
        else 
        {
            KeyDecisionObj = new Key_Action_Decision__c();
        }
        
        if(isClone)
        {
            keyDecisionObj = keyDecisionObj.clone();
            keyDecisionObj.ownerID = Userinfo.getUserID();
        }
        if(releaseID  !=null && releaseID.trim() != SaaSTextConstant.EMPTY_STRING  )
        {
            keyDecisionObj.Related_Release__c= releaseID ;
        }              
    }
     /**
    * Save the KeyDecision record
    * @return 
    *
    */    
    public PageReference saveKeyDecision() 
    {                
        PageReference pageRef= null;    
        String errMsg = null;
        Key_Action_Decision__c  tempObj = null;       
        KeyDecisionObj.Due_Date__c = dueDate;
        List<RecordType> recLst = [Select id from RecordType where  SobjectType = :SaaSTextConstant.KEY_ACTION_DECISION_OBJ_API_NAME and developerName = :actionOrDecisionType ];
        
        if(recLst.size() > 0)
        {
            KeyDecisionObj.recordTypeID  = recLst.get(0).id;
        }
        errMsg = validateKeyDecision();
        
        if(errMsg != null)
        {
            SaaSUtility.displayErrMsg( errMsg);              
            return null;
        }                        
        try
        {            

            upsert  keyDecisionObj;
            SaaSUtility.displaySuccessMsg(SaaSTextConstant.KEY_ACTION_SAVE_MSG );       
            isSaved  = true;                               
        }
        catch(DmlException e )            
        {
            SaaSUtility.displayErrMsg(e.getDmlMessage(0));    
        }
        catch(Exception e)
        {
             SaaSUtility.displayErrMsg(SaaSTextConstant.EXCEPTION_ERR_MSG );                        
        }
        return pageRef;
    } 
    /**
    *  Get all record type of key Decision object 
    * @return String List<SelectOption> 
    *    
    */   
    public List<SelectOption> getRecordType() 
    {
        List<SelectOption> recType = new List<SelectOption>();
        recType.add(new SelectOption(SaaSTextConstant.EMPTY_STRING,SaaSTextConstant.NONE_PICKLIST_VALUE ));
        
        List<RecordType> rcordType1 = [Select id ,Name,developerName from RecordType where SobjectType =:SaaSTextConstant.KEY_ACTION_DECISION_OBJ_API_NAME];
        for(RecordType obj : rcordType1 )
        {
              recType.add(new SelectOption(obj.developerName ,Obj.name));
        }
        System.debug('recType--'+ recType);
        return recType;
    }
   /**
    * Disable the record type when its changed 
    * @return String none
    *    
    */   
    public void disbaleRecordType()
    {
        if(actionOrDecisionType != SaaSTextConstant.EMPTY_STRING)
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
        if(KeyDecisionObj.RecordTypeId == Null)
        {
            errMsg = SaaSTextConstant.SELECT_REQUEST_TYPE_ERR_MSG ;
        }
        else if(KeyDecisionObj.Name == Null)
        {
            errMsg =SaaSTextConstant.KEY_ACTION_NAME_ERROR_MSG;
        }
        else if(KeyDecisionObj.Status__c== Null || KeyDecisionObj.Status__c==SaaSTextConstant.EMPTY_STRING )
        {
            errMsg =SaaSTextConstant.KEY_ACTION_STATUS_ERROR_MSG;
        }
        else if(KeyDecisionObj.Priority__c== Null || KeyDecisionObj.Priority__c==SaaSTextConstant.EMPTY_STRING )
        {
            errMsg = SaaSTextConstant.KEY_ACTION_PRIORITY_ERR_MSG;
        }            
        else if(KeyDecisionObj.Due_Date__c== Null)
        {
            errMsg =SaaSTextConstant.KEY_ACTION_DUE_DATE_ERR_MSG; 
        }          
        else if(KeyDecisionObj.Description__c== Null || KeyDecisionObj.Description__c==SaaSTextConstant.EMPTY_STRING )
        {
             errMsg =  SaaSTextConstant.KEY_ACTION_DESCRIPTION_ERR_MSG; 
        }
        else if(KeyDecisionObj.Related_Release__c== Null || KeyDecisionObj.Related_Release__c+''==SaaSTextConstant.EMPTY_STRING  )
        {
            errMsg =SaaSTextConstant.KEY_ACTION_RELATED_RELEASE_ERR_MSG; 
        }
      //  else if(actionOrDecisionType == SaaSTextConstant.KEY_DECISION_RECORD_TYPE &&  (KeyDecisionObj.Options__c== null || KeyDecisionObj.Options__c ==SaaSTextConstant.EMPTY_STRING ))
       // {
      //       errMsg =  SaaSTextConstant.KEY_ACTION_OPTION_ERR_MSG; 
      //  }
        
        return errMsg;    
    }
    
   /**
    * Create new Action or Decision
    * 
    *    
    */    
    public void createActionOrDecision()
    {
        isDetail = false;
        keyDecisionObj  = new   Key_Action_Decision__c ();
        DueDate = null;    
        actionOrDecisionType = SaaSTextConstant.EMPTY_STRING;  
        disableRecType  = false;    
        
        System.debug('keyDecisionObj---'+keyDecisionObj );              
        System.debug('actionOrDecisionType  ' + actionOrDecisionType  );                      
    }
}