/** 
 *  Author : Accenture 
 *  Description : Controller class for SaaSCreateRequest
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  05\06\2015        created 
 *
 */
public class SaaSCreateRequestCtrl
{
    private Boolean isConvertToReq = false; 
    public Boolean isSaved {get;set;}    
    public Request__c requestObj  {get;set;}
    public List<Release__c> releaseLst {get;set;} 
    //public Id reqid {get;set;}
    public Boolean isDetail {get;set;}
    private Related_Request__c relatRequest;
    
   /**
    * Construtor 
    * @param ApexPages.StandardController controller
    *
    */    
    public SaaSCreateRequestCtrl(ApexPages.StandardController controller)
    {
        Boolean isClone = false; 
        Request__c tempRequest = null;
        String release = null;
        isSaved  = false;        
        List<Request__c>  requestLst = null;        
        isClone  = SaaSUtility.getURLParameter(SaaSTextConstant.IS_CLONE_URL_PARAM) == SaaSTextConstant.NUMERIC_ONE ?true:false;
        isConvertToReq = SaaSUtility.getURLParameter(SaaSTextConstant.CONVERT_QUEST) == SaaSTextConstant.NUMERIC_ONE ?true:false;     
        isDetail = SaaSUtility.getURLParameter(SaaSTextConstant.DETAIL_URL_PARAM ) == SaaSTextConstant.NUMERIC_ONE  ?true:false;     
        release =  SaaSUtility.getURLParameter(SaaSTextConstant.RELEASEID_URL_PARAM );
        
              
        tempRequest = (Request__c )controller.getRecord();
        
        // Check if this is edit mode
        if(tempRequest.id != null )
        {
            requestLst = Database.query(SaaSUtility.getCreatableFieldsSOQL(SaaSTextConstant.REQUEST_OBJ_API_NAME , 'id=\''+tempRequest.id+'\''));
            if(requestLst.size() > 0)
            {
                requestObj = requestLst.get(0);  
            }
        }  
        else 
        {
            requestObj= new Request__c();
        }  
              
        if(isClone)
        {
            requestObj= requestObj.clone();
            requestObj.ownerID = Userinfo.getUserID();
        }               
        // Check if Question has to be converted to Request 
        if(isConvertToReq)
        {
            String questionID = SaaSUtility.getURLParameter(SaaSTextConstant.CONVERT_QUEST_ID);
            List<Question_Log__c> questionLst =  [Select id,Question__c, answer__c from Question_Log__c where id =:questionID ];

            if(questionLst.size () > 0)
            {
                relatRequest = new Related_Request__c();
                relatRequest.Question_Log__c =  questionLst.get(0).id;
                requestObj.Request_Description__c = SaaSTextConstant.QUESTION + SaaSTextConstant.NEXT_LINE + questionLst.get(0).Question__c;
                requestObj.Request_Description__c  =  requestObj.Request_Description__c +   SaaSTextConstant.NEXT_LINE+  SaaSTextConstant.RESPONSE;
                requestObj.Request_Description__c  =  requestObj.Request_Description__c +   (questionLst.get(0).answer__c!= null?questionLst.get(0).answer__c :'') ;
            }
        }
        if(release !=null && release.trim() != SaaSTextConstant.EMPTY_STRING )
        {
            requestObj.Release__c = release ;
        }

        
       
        
    }
   
   /**
    * Save the Request record
    * @return 
    *
    */                   
    public PageReference saveRequest() 
    {                
        PageReference pageRef= null;        
        String errMSg = null;
        try
        {         
            errMSg  =  validateKeyDecision();
            if(errMSg   != null)
            {
                 SaaSUtility.displayErrMsg(errMSg);           
                return null;
            }                             
            upsert requestObj;            
            if(isConvertToReq &&relatRequest !=null && relatRequest.Question_Log__c!=null )
            {
                relatRequest.Converted_Request__c = true;
                relatRequest.Request__c = requestObj.id;
                upsert relatRequest;
            }     
            SaaSUtility.displaySuccessMsg(SaaSTextConstant.REQUEST_RECORD_SAVE_MSG); 
            isSaved  = true;            
        }
        catch(DmlException e)
        {
            SaaSUtility.displayErrMsg(e.getDmlMessage(0) );           
        } 
        catch(Exception e)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.EXCEPTION_ERR_MSG );         
            e.getMessage();        
        }
        return pageRef;
    }  
    
  
   /**
    * Validate the data entered by the user.
    * @return String errmsg
    *
    */       
    @TestVisible private String validateKeyDecision()
    {
        String errMsg = null;                          
        if(requestObj.Status__c==Null || requestObj.Status__c==SaaSTextConstant.EMPTY_STRING)
        {
            errMsg =    SaaSTextConstant.REQUEST_STATUS_EMPTY_ERR_MSG;
        }
            
        if(requestObj.Request_Description__c== Null || requestObj.Request_Description__c==SaaSTextConstant.EMPTY_STRING)
        {
            errMsg =    SaaSTextConstant.REQUEST_DESC_EMPTY_ERR_MSG; 
        }
         
        if(requestObj.Release__c== Null || requestObj.Release__c+''==SaaSTextConstant.EMPTY_STRING)
        {
            errMsg =    SaaSTextConstant.REQUEST_PLANNED_RELEASE_EMPTY_ERR_MSG; 
        }
            
        if(requestObj.Request_Type__c== Null || requestObj.Request_Type__c==SaaSTextConstant.EMPTY_STRING)
        {
            errMsg =    SaaSTextConstant.REQUEST_TYPE_EMPTY_ERR_MSG; 
        }            
        return errMsg; 
    }   
     /**
    * Create new Request
    * 
    *    
    */    
    public void createNewRequest()
    {
        isDetail = false;
        requestObj = new   Request__c ();
    }              
}