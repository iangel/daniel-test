/** 
 *  Author : Accenture 
 *  Description : Controller class for SaaSCreateSessionOutcome VF page
 *  Created Date : 05\12\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  05\12\2015        created 
 *
 */
public with sharing class SaaSCreateSessionOutcomeCtrl 
{
    public String valueSessionPrjName {get;set;}
    public DateTime sessonStartDate {get;set;}
    public DateTime sessonEndDate {get;set;}
    public Boolean isDetail {get;set;}
    public Boolean isSaved {get;set;}
    public Boolean success {get;set;}
    public Boolean isInsert {get;set;}
    public Boolean displayImportSec {get;set;}
    
    public Boolean displayimportPartcipants {get;set;}
    public List<SelectOption> sessionsOutcomeLst {get;set;} 
    public String sessOutcomeID {get;set;} 
    public Value_Delivery_Session_Outcomes__c sessOutcomeObj  {get;set;}
    public List<Value_Delivery_Key_Participants__c> participantsObj {get;set;}
    public Value_Delivery_Key_Participants__c newParticipantsObj {get;set;}
    public List<ParticipantsWrapper> newParticipantsLst {get;set;}
    public String clientHash { get; set; } //used to interact with dom elements 
    public List<ParticipantsWrapper> importParticipantLst {get;set;}
    public Boolean renderimporticon {get;set;}
    /**
     *  Wrapper Class for Participants Sobject
     *
     */    
    public class ParticipantsWrapper
    {
        public Value_Delivery_Key_Participants__c obj {get;set;}
        public Boolean checked {get;set;}
        public String hash { get; set; }
        public Integer index { get; set; }
        
        /**
         * Constructor 
         *
         */          
        public ParticipantsWrapper(Value_Delivery_Key_Participants__c sobj)
        {
            obj = new Value_Delivery_Key_Participants__c ();
            obj = sobj;
            checked = false;
            
        }       
        public ParticipantsWrapper(Integer i, Value_Delivery_Key_Participants__c q ,String h) 
        {
              index = I;
              obj  = Q;
              hash  = h;
        }
    }
    
    /**
     * Constructor 
     *
     */ 
    public SaaSCreateSessionOutcomeCtrl(ApexPages.StandardController controller) 
    {
        valueSessionPrjName = SaaSUtility.getValueSessionProjectName();
        renderimporticon  = false;
        newParticipantsLst = new List<ParticipantsWrapper>();
        importParticipantLst = new List<ParticipantsWrapper>();  
        displayimportPartcipants = false;
        displayImportSec = false;         
        sessOutcomeObj  = (Value_Delivery_Session_Outcomes__c ) controller.getRecord();      
        newParticipantsObj   = new Value_Delivery_Key_Participants__c();
        List<Value_Delivery_Session_Outcomes__c> outcomeLst= [Select id from Value_Delivery_Session_Outcomes__c where Value_Delivery_Session__c =:+SaaSUtility.getLoggedInValueSession() limit 1 ];
        if(outcomeLst.size() > 0)
        {
            renderimporticon   = true;
        }
    }
    
    /**
    *  Validate Session Out come Date
    * 
    * @return String
    */
    private String validateSessionOutcome()
    {
        String errMsg = null;
        if(sessOutcomeObj.Name == null || sessOutcomeObj.Name == SaaSTextConstant.EMPTY_STRING )
        {
            errMsg = SaaSTextConstant.SESSION_NAME_EMPTY_ERR_MSG;
        }
        else if (sessOutcomeObj.Phase__c == null || sessOutcomeObj.Phase__c  == SaaSTextConstant.EMPTY_STRING )
        {
            errMsg =SaaSTextConstant.SESSION_PHASE_EMPTY_ERR_MSG; 
        }
        return errMsg;
    }
    /**
    *  Validate Key Participants
    * 
    * @return String
    */
    private String validateKeyParticipants()
    {
        String errMsg = null;
        
        for(ParticipantsWrapper partWrap :newParticipantsLst)
        {
            if((partWrap.obj.Name == SaaSTextConstant.EMPTY_STRING  || partWrap.obj.Name ==  null) )
            {
                errMsg  = SaaSTextConstant.KEY_PARTICIPANTS_NAME_EMPTY_ERR_MSG;
                break;            
            } 
            else  if((partWrap.obj.Role__c == SaaSTextConstant.EMPTY_STRING  || partWrap.obj.Role__c ==  null) )
            {
                errMsg  = SaaSTextConstant.KEY_PARTICIPANTS_ROLE_EMPTY_ERR_MSG; 
                break;
            }
            
        }
        return errMsg;
    }
    
   /**
    * Save Sessionm Outcome.
    * 
    * @return String
    */    
    public pageReference saveSessionOutcome()
    {
        PageReference pageRef= null;        
        String errMSg = null;
        List<Value_Delivery_Key_Participants__c> partLst =null;       
        try
        {
            errMSg  =  validateSessionOutcome();           
            if(errMSg   != null)
            {
                SaaSUtility.displayErrMsg(errMSg);           
                return null;
            } 
            errMSg  =  validateKeyParticipants();
            if(errMSg   != null)
            {
                SaaSUtility.displayErrMsg(errMSg);           
                return null;
            } 
            sessOutcomeObj.Start_Date__c = sessonStartDate ;
            sessOutcomeObj.End_Date__c = sessonEndDate;
            system.debug('====ssssss=='+SaaSUtility.getLoggedInValueSession());
            sessOutcomeObj.Value_Delivery_Session__c = SaaSUtility.getLoggedInValueSession();
            system.debug('====mmmmm==='+sessOutcomeObj.Value_Delivery_Session__c);
            upsert sessOutcomeObj; 
            
            partLst = getParticipantsTosave(sessOutcomeObj);
            if(partLst.size() > 0)
            {
                upsert partLst;
            }
            pageRef = new PageReference(SaaSTextConstant.SESSION_OUTCOME_DETAIL_VF_PAGE_NAME_URL +'?id='+sessOutcomeObj.id);
                
        } 
        catch(DmlException e)
        {
            SaaSUtility.displayErrMsg(e.getDmlMessage(0));           
        } 
        catch(Exception e)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.EXCEPTION_ERR_MSG );         
            e.getMessage();        
        }
        return pageRef;
    }
    
    /**
    *  Get All Participants of the existing Selected Session
    * 
    * @return List
    */    
    public List<ParticipantsWrapper> getAllKeyParticipants()
    {
        importParticipantLst  = new  List<ParticipantsWrapper>();
        for(Value_Delivery_Key_Participants__c obj: [Select id, name,Role__c,Comments__c,Session_Outcomes__c from Value_Delivery_Key_Participants__c where  Session_Outcomes__c = :sessOutcomeID ])
        {
            importParticipantLst.add(new ParticipantsWrapper(obj));
        }       
        return null; 
    }
   /**
    *  Get All Participants from the Wrapper Object to Save 
    * 
    * @return List
    */  
    private List<Value_Delivery_Key_Participants__c> getParticipantsTosave(Value_Delivery_Session_Outcomes__c sessionObj)
    {
        List<Value_Delivery_Key_Participants__c> partLst = new List<Value_Delivery_Key_Participants__c>();
        
        for(ParticipantsWrapper wrapObj  : newParticipantsLst )
        {
            wrapObj.obj.Session_Outcomes__c =   sessionObj.id; 
            partLst.add(wrapObj.obj); 
        }
        
        for(ParticipantsWrapper wrapObj  : importParticipantLst  )
        {
            if(wrapObj.checked )
            {
                Value_Delivery_Key_Participants__c tempObj = wrapObj.obj.clone();
                tempObj.Session_Outcomes__c =   sessionObj.id; 
                partLst.add(tempObj ); 
            }                                
        }
        return partLst;
    }    
   /**
    *  Get All Participants from the Selected session.
    * 
    * @return List
    */    
    public List<SelectOption> getImportParticipants()
    {
        displayimportPartcipants =  true;
        sessionsOutcomeLst = new  List<SelectOption>(); 
        sessionsOutcomeLst.add(new SelectOption(SaaSTextConstant.EMPTY_STRING ,SaaSTextConstant.NONE_PICKLIST_VALUE ) );  
        for(Value_Delivery_Session_Outcomes__c obj : [ select id,name from Value_Delivery_Session_Outcomes__c where Value_Delivery_Session__c =:+SaaSUtility.getLoggedInValueSession()])
        {
            sessionsOutcomeLst.add(new SelectOption(obj.id,obj.name) );         
        }
        return sessionsOutcomeLst;
    }
    /**
    *  Add new Particapants 
    * 
    * @return List
    */    
    public void add() 
    {
        try
        {   
            Value_Delivery_Key_Participants__c newPart  = new Value_Delivery_Key_Participants__c();
            newParticipantsLst.add(new ParticipantsWrapper(newParticipantsLst.size()+1 , newPart  , SaaSUtility.generateHash(10)));
        }
        catch(Exception e )
        {
             e.getMessage();
        }
    }
   /**
    * Remove existing participants from the list.
    * 
    * @return List
    */  
    public void remove()
    {
        try
        {
            List<ParticipantsWrapper > newChildList = new List<ParticipantsWrapper >();
            for (ParticipantsWrapper sow : newParticipantsLst) 
            {
                if (sow.hash != clientHash) 
                {
                    newChildList.add(sow);
                } 
            }        
            newParticipantsLst = newChildList;
        }
        catch(Exception e )
        {
             e.getMessage();
        }
    }
   /**
    * Enble Select session picklist.
    * 
    * @return List
    */     
    public void displayImport()
    {
        displayImportSec = true;    
    }
    
    /**
     * Import Previous session outcome 
     *
     */
     public void importPreviousSessionOutome()
     {
         String str  = sessOutcomeObj.Session_Outcome__c;
         List<Value_Delivery_Session_Outcomes__c> outcomeLst= [Select Session_Outcome__c from Value_Delivery_Session_Outcomes__c where Value_Delivery_Session__c =:+SaaSUtility.getLoggedInValueSession() limit 1 ];
         if(outcomeLst.size() > 0)
         {
             sessOutcomeObj.Session_Outcome__c = outcomeLst.get(0).Session_Outcome__c +'  '+ str  ;
         }
     }
    
    
}