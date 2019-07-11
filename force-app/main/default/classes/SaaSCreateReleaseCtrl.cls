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
public class SaaSCreateReleaseCtrl
{
    private Boolean isClone = false;
    public Boolean isDetail {get;set;}
    public Boolean isSaved {get;set;}
    public Release__c releaseObj {get;set;}
    public Date relStartDate {get;set;}
    public Date relPlanDate {get;set;}
   // public Id releaseid {get;set;}
    
    /**
     * Construtor 
     * @param ApexPages.StandardController controller
     *
     */
    public SaaSCreateReleaseCtrl (ApexPages.StandardController controller)
    {
        Release__c tempRelease = null;
        String releaseID = null;
        List<Release__c >  releaseLst = null;
        tempRelease = (Release__c)controller.getRecord();
        isSaved  = false;
        isClone  = ( SaaSUtility.getURLParameter(SaaSTextConstant.IS_CLONE_URL_PARAM ) == SaaSTextConstant.NUMERIC_ONE )?true:false;
        system.debug ('isclone..........'+isClone);
        releaseID =  SaaSUtility.getURLParameter(SaaSTextConstant.RELEASEID_URL_PARAM ); 
         isDetail = SaaSUtility.getURLParameter(SaaSTextConstant.DETAIL_URL_PARAM ) == SaaSTextConstant.NUMERIC_ONE  ?true:false;
        // Check if this is edit mode
        if(tempRelease.id != null )
        {
            releaseLst = Database.query(SaaSUtility.getCreatableFieldsSOQL(SaaSTextConstant.RELEASE_OBJ_API_NAME , 'id=\''+tempRelease.id+'\''));
            if(releaseLst.size() > 0)
            {
                releaseObj= releaseLst.get(0);  
                relStartDate=   releaseLst.get(0).Release_Start_Date__c;
                relPlanDate=   releaseLst.get(0).Release_Planned_End_Date__c;
            }
        }  
        else 
        {
            releaseObj= new Release__c();
        }        
        if(isClone)
        {
            releaseObj= releaseObj.clone();
            releaseObj.ownerID = Userinfo.getUserID();
        }  
        if(releaseID !=null && releaseID.trim() != SaaSTextConstant.EMPTY_STRING  )
        {
            releaseObj.Parent_Release__c= releaseID ;
        }     
    }
    
   /**
    * Save the release record
    * @return 
    *
    */           
    public void saveRelease() 
    {      
        PageReference pageRef= null;        
        releaseObj.Release_Start_Date__c = relStartDate;
        releaseObj.Release_Planned_End_Date__c = relPlanDate; 
        
        String errMsg = validateKeyDecision();
        // Check any error data is entered by user
        if(errMsg !=null)
        {
            SaaSUtility.displayErrMsg(errMsg);  
            return;
        }
        
        try
        {            
            upsert releaseObj; 
            SaaSUtility.displaySuccessMsg(SaaSTextConstant.RELEASE_RECORD_SAVE_MSG );
            isSaved   = true;                                    
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
        
    } 
    
   /**
    * Validate the data entered by the user.
    * @return String errmsg
    *
    
    */       
    @TestVisible private String validateKeyDecision()
    {
        String errMsg = null; 
        if(releaseObj.Name== Null)
        {
             errMsg = SaaSTextConstant.RELEASE_NAME_NULL_ERR_MSG;      
        }  
        return errMsg; 
    }    
   /**
    * Create new Release 
    * 
    *    
    */    
    public void createNewRelease()
    {
        isDetail = false;
        releaseObj = new   Release__c();
        relStartDate = null;    
        relPlanDate = null;
    }
}