/** 
 *  Author : Accenture 
 *  Description : Controller class for SaaSCreateQuestionLog
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  05\06\2015        created 
 *
 */
public class SaaSCreateQuestionLogCtrl
{
    public  Question_Log__c QuesLogObj {get;set;}
    public Boolean isDetail {get;set;}
    public Boolean isCreate {get;set;}   
    public String questionType {get;set;}     
    public Date requestedDate{get;set;}
    public Date expectedCloseDate{get;set;}
    public Boolean disableRecType {get;set;}  
    public boolean showanswer {get;set;}  
  //  public Response__c userRespose {get;set;}
    public Id RecordToDelete {get; set;}
    public Boolean isSaved {get;set;}            
    public Boolean isAccentureRepresentative{get;set;}
    
    
   /**
    * Constructor   
    * @param args ApexPages.StandardController.
    *
    */   
    public SaaSCreateQuestionLogCtrl(ApexPages.StandardController controller) 
    {
     
        String requestID = null;
        List<Question_Log__c> questionLogLst = null;
        Boolean isClone = false; 
        Question_Log__c tempQuestObj = null;
        questionType =SaaSTextConstant.EMPTY_STRING;
        isAccentureRepresentative= SaaSUtility.isAccentureRepresentative();
        showanswer = false;
        isCreate = false;
        isSaved = false;
        isDetail = SaaSUtility.getURLParameter(SaaSTextConstant.DETAIL_URL_PARAM ) ==  SaaSTextConstant.NUMERIC_ONE ?true:false;
        isClone =   SaaSUtility.getURLParameter(SaaSTextConstant.IS_CLONE_URL_PARAM) ==  SaaSTextConstant.NUMERIC_ONE ? true :false; 
        disableRecType = isDetail? true :false;
        
        tempQuestObj = (Question_Log__c)controller.getRecord();   
        requestID  = SaaSUtility.getURLParameter(SaaSTextConstant.REQUEST_ID_URL_PARAM);
      //  questionType = (tempQuestObj.id != null)?tempQuestObj.RecordType.developerName:SaaSTextConstant.EMPTY_STRING;

        if(tempQuestObj.id != null )
        {
            questionLogLst = Database.query(SaaSUtility.getCreatableFieldsSOQL(SaaSTextConstant.QUESTION_OBJ_API_NAME, 'id=\''+tempQuestObj.id+'\''));
            if(questionLogLst.size() > 0)
            {
                quesLogObj = questionLogLst.get(0);  
                questionType  = SaaSUtility.getRecordTypeDeveloperName(questionLogLst.get(0).recordTypeID);
                requestedDate =   questionLogLst.get(0).Requested_Date__c;
                expectedCloseDate =   questionLogLst.get(0).Expected_Close_Date__c;  
            /*    List<Response__c> respLst = [select id,Response__c,Question_Log__c  from Response__c where Question_Log__c = :quesLogObj.id  and User__C = :userInfo.getUserId()];
                if(respLst.size () > 0)
                {
                    userRespose  = respLst.get(0);
                    showanswer  = true;

                }else
                {
                    userRespose  = new Response__c();
                    userRespose.user__c = userinfo.getUserId();  
                } */
            }
        }  
        else 
        {
            QuesLogObj = new Question_Log__c();
         //   userRespose  = new Response__c();
         //   userRespose.user__c = userinfo.getUserId();  
            isCreate = true;
        }
        
        if(isClone)
        {
            QuesLogObj = QuesLogObj.clone();
         //   userRespose  = new Response__c();
        //    userRespose.user__c = userinfo.getUserId();  
            QuesLogObj.ownerID = Userinfo.getUserID();
            showanswer  = false;
            isCreate = true;

        }
        if(requestID != null && requestID.trim()  != SaaSTextConstant.EMPTY_STRING)
        {
            quesLogObj.Request__c = requestID;
        }
    
    } 
    
        
   /**
    * Save Question 
    * @param args ApexPages.StandardController.
    *
    */        
    public void saveQuestionLog() 
    {                
        String errMsg = null;   
        List<Question_Log__c> questionLst = new List<Question_Log__c>();
        
        quesLogObj.Requested_Date__c = requestedDate;
        quesLogObj.Expected_Close_Date__c = expectedCloseDate;   
        
        List<RecordType> recLst = [Select id from RecordType where  SobjectType = :SaaSTextConstant.QUESTION_OBJ_API_NAME and developerName = :questionType];        
        if(recLst.size() > 0)
        {
            quesLogObj.recordTypeID  = recLst.get(0).id;
        }
        errMsg = validateQuestion();
        // Check if user has entered some invalid data 
        if(errMsg != null)
        {
            SaaSUtility.displayErrMsg(errMsg); 
            return;
        }                                  
        questionLst.add(quesLogObj);
        
        errMsg = SaaSUtility.insertSobject(questionLst);  
        if(errMsg != null)
        {
           SaaSUtility.displayErrMsg(errMsg);     
           return;
        }
        else 
        {
            isSaved  = true;
            SaaSUtility.displaySuccessMsg(SaaSTextConstant.QUESTION_RESPONSE_RECORD_SAVE_MSG );            
        }        
    }
    
   /**
    * Validate the data entered by the user.
    * @return String errmsg
    *
    */    
    @TestVisible private String validateQuestion()
    {
        String errMsg = null;              
        // Validation for Value Delivery Question Type 
        if(questionType == SaaSTextConstant.VALUE_DELIVERY_QUESTION_RECORD_TYPE)
        {
            if(quesLogObj.Scope__c == null || quesLogObj.Scope__c == SaaSTextConstant.EMPTY_STRING)
            {
                errMsg = SaaSTextConstant.QUESTION_SCOPE_EMPTY_ERR_MSG;
            }
            else if(quesLogObj.Sub_Capability__c == null || quesLogObj.Sub_Capability__c == SaaSTextConstant.EMPTY_STRING)
            {
              errMsg =   SaaSTextConstant.QUESTION_SUB_CAPABILITY_EMPTY_ERR_MSG; 
            }
            else if(quesLogObj.Industry__c == Null || quesLogObj.Industry__c ==SaaSTextConstant.EMPTY_STRING )
            {
                errMsg = SaaSTextConstant.QUESTION_INDUSTRY_EMPTY_ERR_MSG;
            }
            else if(quesLogObj.Domain__c== Null || quesLogObj.Domain__c==SaaSTextConstant.EMPTY_STRING )
            {
                errMsg = SaaSTextConstant.QUESTION_DOMAIN_EMPTY_ERR_MSG ;
            }
            
        }
        else if(questionType == SaaSTextConstant.SAAS_QUESTION_RECORD_TYPE)                
        {

            
            if(QuesLogObj.Submitter__c== Null)
            {
                errMsg =  SaaSTextConstant.QUESTION_SUBMITTER_EMPTY_ERR_MSG;
            }
                      
            else if(QuesLogObj.Request__c == Null)
            {
                errMsg =  SaaSTextConstant.QUESTION_REQUEST_EMPTY_ERR_MSG;
            }
        }
        if(questionType == Null || questionType.trim() ==SaaSTextConstant.EMPTY_STRING)
        {
            errMsg =  SaaSTextConstant.QUESTION_RECORD_TYPE_ERROR_MSG;
        } 
        else if(QuesLogObj.Question__c== Null || QuesLogObj.Question__c.trim() ==SaaSTextConstant.EMPTY_STRING)
        {
            errMsg =  SaaSTextConstant.QUESTION_FIELD_EMPTY_ERR_MSG;
        }
        //elseif()
        
        return errMsg; 
    }          
       
   /**
    * Get all record type of question object 
    * @return List<SelectOption>
    *
    */   
    public List<SelectOption> getRecordType() 
    {
        List<SelectOption> recType = new List<SelectOption>();
        recType.add(new SelectOption(SaaSTextConstant.EMPTY_STRING,SaaSTextConstant.NONE_PICKLIST_VALUE ));
        
        List<RecordType> rcordType1 = [Select id ,Name,developerName from RecordType where SobjectType = :SaaSTextConstant.QUESTION_OBJ_API_NAME];
        for(RecordType obj : rcordType1 )
        {
              recType.add(new SelectOption(obj.developerName ,Obj.name));
        }
        return recType;
    }
    
    /**
    *  Disable record type picklist field after picklist is selected 
    * 
    */ 
    public void disbaleRecordType()
    {
        if(questionType != SaaSTextConstant.EMPTY_STRING)
        {
          disableRecType = true;
        }          
    }
 
 
     /**
     * Navigate to Selected Record to convert question to request
     *
     * @param args none.
     * @return PageReference 
     *
     */  
    public PageReference convertToRequest()
    {       
        return new PageReference(SaaSTextConstant.CREATE_REQUEST_VF_PAGE_NAME_URL+'?'+SaaSTextConstant.CONVERT_QUEST+'=1&&'+SaaSTextConstant.CONVERT_QUEST_ID+'='+QuesLogObj.id);  
    } 
   /**
     * Get All Related Request
     *
     * @return List<Related_Request__c >
     *
     */
    public List<Related_Request__c > getRelatedReqLst() 
    {
        return [Select Id, Question_Log__c ,Question_Log__r.name,Request__r.name,Request__r.Request_Description__c,Request__c,Converted_Request__c from Related_Request__c where Question_Log__c = :quesLogObj.id ];      
    } 
     
 
   /**
    * Delete Related Request
    *
    * @param args none.
    * @return none
    *
    */
    public void deleteRecord()
    {
         List<Related_Request__c >   relRequest=[Select Id,Request__c from Related_Request__c where id = :RecordToDelete  ];
         delete relRequest;
    }
    
   /**
    * Create new Question
    * 
    */    
    public void createQuestion()
    {
        isDetail = false;
        quesLogObj = new   Question_Log__c ();
        
        requestedDate = null;    
        expectedCloseDate = null;
        questionType = SaaSTextConstant.EMPTY_STRING;  
        disableRecType  = false;       
        isCreate  = true;     
        showanswer = false; 
    }
    
}