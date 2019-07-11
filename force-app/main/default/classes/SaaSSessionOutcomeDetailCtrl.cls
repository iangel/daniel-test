/** 
 *  Author : Accenture 
 *  Description : Controller class for SaaSSessionOutcomeDetail VF page
 *  Created Date : 05\12\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  05\12\2015        created 
 *
 */
public with sharing class SaaSSessionOutcomeDetailCtrl 
{ 
    
   
    public String valueSessionPrjName {get;set;}
    public DateTime sessonStartDate {get;set;}
    public DateTime sessonEndDate {get;set;}
    public Boolean isDetail {get;set;}
    public Boolean isSaved {get;set;}
    public Boolean success {get;set;}
    public Boolean isInsert {get;set;}
    Public Boolean profileFlag{get;set;}
    public Boolean displayimportPartcipants {get;set;}
    public List<OptionsWrapper> newOptionsLst {get;set;}
    public String clientHash { get; set; } //used to interact with dom elements 
    Public boolean voteFlag {get;set;}
    public List<SelectOption> sessionsOutcomeLst {get;set;} 
    public String sessOutcomeID {get;set;} 
    public Value_Delivery_Session_Outcomes__c sessOutcomeObj  {get;set;}
    public Value_Delivery_Key_Participants__c participantsObj {get;set;}
    public Value_Delivery_Key_Participants__c newParticipantsObj {get;set;}
    public User_Story__c newUserStoryObj {get;set;}
    public User_Story_Options__c newUserStoryOptionsObj {get;set;}
    Public Value_Delivery_Session_User_Stories__c newSessionUserStoriesObj{get;set;}
    public SessionUserStoryWrapper sessionUserStoryWrappObj {get;set;}
    public Value_Delivery_Session_User_Stories__c deleteSessionUsrStory{get;set;}
    /**
     *  Wrapper Class for Participants Sobject
     *
     */    
    public class OptionsWrapper
    {
        public User_Story_Options__c  obj {get;set;}
        public Boolean checked {get;set;}
        public String hash { get; set; }
        public Integer index { get; set; }
        
        /**
         * Constructor 
         *
         */          
        public OptionsWrapper(User_Story_Options__c sobj)
        {
            obj = new User_Story_Options__c ();
            obj = sobj;
            checked = false;
            
        }       
        public OptionsWrapper(Integer i, User_Story_Options__c q ,String h) 
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
    public SaaSSessionOutcomeDetailCtrl(ApexPages.StandardController controller) 
    {
        sessionUserStoryWrappObj  = new SessionUserStoryWrapper(); 
        valueSessionPrjName = SaaSUtility.getValueSessionProjectName();
        displayimportPartcipants = false;
        profileFlag = SaaSUtility.isAccentureRepresentative();
        List<Value_Delivery_Session_Outcomes__c> sessionOutcomeLst;
        sessOutcomeObj  = (Value_Delivery_Session_Outcomes__c ) controller.getRecord();      
        newParticipantsObj   = new Value_Delivery_Key_Participants__c();
        newUserStoryObj = new User_Story__c ();
        newSessionUserStoriesObj = new Value_Delivery_Session_User_Stories__c();
        newUserStoryOptionsObj  = new User_Story_Options__c ();
        newOptionsLst = new List<OptionsWrapper>();
        if(sessOutcomeObj.id != null){
            sessionOutcomeLst= [select SessionOwner__c , name,End_Date__c,Phase__c,Session_Outcome__c,Session_Owner__c,Start_Date__c,Value_Delivery_Session__c from Value_Delivery_Session_Outcomes__c where id= :sessOutcomeObj.id];
            if(sessionOutcomeLst.size() > 0){
                sessOutcomeObj  = sessionOutcomeLst.get(0);
                sessonStartDate =  sessOutcomeObj.Start_Date__c;
                sessonEndDate  =sessOutcomeObj.End_Date__c;
            }
            else{
                sessOutcomeObj  = new Value_Delivery_Session_Outcomes__c();
            }
        }       
    }
   /**
    * Save Session Outcome 
    *
    */ 
    public void saveSessionOutcome()
    {
        sessOutcomeObj.Start_Date__c = sessonStartDate ;
        sessOutcomeObj.End_Date__c = sessonEndDate  ;
        
        String errMsg = validateSessionOutcome();
        // Check any error data is entered by user
        if(errMsg !=null)
        {
            SaaSUtility.displayErrMsg(errMsg);  
            return;
        }
        
        try
        {            
            upsert sessOutcomeObj; 
            SaaSUtility.displaySuccessMsg(SaaSTextConstant.SESSION_RECORD_SAVE_MSG );
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
    @TestVisible      
    private String validateSessionOutcome()
    {
        String errMsg = null; 
        if(sessOutcomeObj.Name== Null || sessOutcomeObj.Name==SaaSTextConstant.EMPTY_STRING)
        {
             errMsg = SaaSTextConstant.SESSION_NAME_NULL_ERR_MSG;      
        } 
        if(sessOutcomeObj.Phase__c== Null)
        {
             errMsg = SaaSTextConstant.SESSION_PHASE_NULL_ERR_MSG;      
        } 
        return errMsg; 
    }   
    
   /**
    * Validate participants of the sessions
    * @return String errmsg
    *    
    */           
    public List<Value_Delivery_Key_Participants__c> getAllKeyParticipants()
    {        
        return [Select id, name,Role__c,Comments__c   from Value_Delivery_Key_Participants__c where  Session_Outcomes__c = :sessOutcomeObj.id];
    }
    
   /**
    *  Delete the participants of the session  
    *
    * @return String errmsg
    *    
    */  
    public void deleteParticipants()
    {
        try
        {
            if(participantsObj !=null)
            {
                 delete participantsObj;
            }
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
    *  Retervie Participants when  Edit or deleted is selected 
    *
    * @return void
    *    
    */  
    public void getParticipants()
    {
         SaaSUtility.clearPageErrMsg();
         success  = false;
         String itemkey= Apexpages.currentPage().getParameters().get(SaaSTextConstant.PARTICIPANTS_ID_URL_PARAM );            
         participantsObj = [ select id,name, Role__c ,Comments__c from Value_Delivery_Key_Participants__c WHERE id =:itemkey];                 
    } 
   /**
    * Update Selected Participants 
    *
    * @return void
    *    
    */
    public void updateParticipants()
    {
        try
        {
            success   = false;            
            String errMsg = validateParticipant(participantsObj );

            if(errMsg !=null)
            {
                SaaSUtility.displayErrMsg(errMsg);  
                return;
            }
            if(participantsObj !=null)
            {
                 upsert participantsObj;
                 success  = true;
            }
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
    * Insert New Participants 
    *
    * @return void
    *    
    */
    public void addPartcipants()
    {    
        try
        {
            isInsert = false;
            String errMsg = validateParticipant(newParticipantsObj);
            if(errMsg !=null)
            {
                SaaSUtility.displayErrMsg(errMsg);  
                return;
            }
            newParticipantsObj.Session_Outcomes__c = sessOutcomeObj.id;
            upsert newParticipantsObj;
            newParticipantsObj   = new Value_Delivery_Key_Participants__c();
            newParticipantsObj.Session_Outcomes__c = sessOutcomeObj.id;           
            isInsert = true;
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
    * Validate the Participants
    * @return String errmsg
    *    
    */
    @TestVisible
    private String validateParticipant(Value_Delivery_Key_Participants__c  partObj)
    {
         String errMsg = null;
         if(partObj.Name == null || partObj.Name == SaaSTextConstant.EMPTY_STRING    )
         {
             errMsg = SaaSTextConstant.PARTICIPANTS_NAME_BLANK_ERR_MSG;
         }
         else if (partObj.Role__c == null || partObj.Role__c== SaaSTextConstant.EMPTY_STRING    )
         {
             errMsg = SaaSTextConstant.PARTICIPANTS_ROLE_BLANK_ERR_MSG;
         }         
         return errMsg ;    
    }
    
    public List<SessionUserStoryWrapper>  getSessionUserStory()
    {        
        Map<String,SessionUserStoryWrapper> sessionUserStoryMaps = new   Map<String,SessionUserStoryWrapper>();  
      
        Set<String> sessionStoryId = new Set<String>();            
        for(Value_Delivery_Session_User_Stories__c obj : [Select Id, name,User_Story__c,User_Story__r.Priority__c,User_Story__r.User_Story_Description__c,Value_Delivery_Session_Outcomes__c,User_Story__r.Name from Value_Delivery_Session_User_Stories__c where  Value_Delivery_Session_Outcomes__c   = :sessOutcomeObj.Id])
        {
            sessionUserStoryMaps.put(obj.id+'', new SessionUserStoryWrapper(obj));  
        }        
        for(User_Story_Options__c   obj : [Select id ,Value_Deliver_Session_User_Stories__c,(select id from Vote_User_Story__r where User__c = :Userinfo.getUserId()) from User_Story_Options__c  where  Value_Deliver_Session_User_Stories__c  in :sessionUserStoryMaps.keyset()])
        {
                    system.debug('====options =='+obj );
           SessionUserStoryWrapper wrapObj = sessionUserStoryMaps.get(obj.Value_Deliver_Session_User_Stories__c);
            system.debug('====wrapObj =='+wrapObj );
            wrapObj.isVoted  = (obj.Vote_User_Story__r.size() > 0 || wrapObj.isVoted);   
            WrapObj.flag = true;
        } 
        for(Vote_User_Story__c obj : [Select id ,User_Story_Option__r.Value_Deliver_Session_User_Stories__c from Vote_User_Story__c where  User_Story_Option__r.Value_Deliver_Session_User_Stories__c in :sessionUserStoryMaps.keyset()])
        {
          system.debug('====options2222 =='+obj );
          SessionUserStoryWrapper wrapObj = sessionUserStoryMaps.get(obj.User_Story_Option__r.Value_Deliver_Session_User_Stories__c);
            WrapObj.voteFlag= true;
         } 
         return sessionUserStoryMaps.values(); 
    }
    
    
    
    public void getUserStoryOptions()
    {
        success  =  false;
        Set<ID> optionsIDSet = new Set<ID>();
        String itemkey= Apexpages.currentPage().getParameters().get('SessionsUserStorys');               
        List<Value_Delivery_Session_User_Stories__c> sessionUserStoryLst =   [Select (Select id from User_Story_Options__R) ,Id, name,User_Story__c,User_Story__r.User_Story_Description__c,Value_Delivery_Session_Outcomes__c,User_Story__r.Name from Value_Delivery_Session_User_Stories__c where id  = :itemkey];
        sessionUserStoryWrappObj  = new SessionUserStoryWrapper();
        for(Value_Delivery_Session_User_Stories__c obj :sessionUserStoryLst ) 
        {
            sessionUserStoryWrappObj.userStoryDesc  = obj.User_Story__r.name; 
                  
            for(User_Story_Options__c optionObj : obj.User_Story_Options__R)
            {
                optionsIDSet.add(optionObj.id);                 
            }
        }        
        
        for(User_Story_Options__c optionObj : [Select User_Story_Option__c,id ,(select id,Vote__c ,User__c  from Vote_User_Story__r where User__c = :UserInfo.getUserID()) from User_Story_Options__c where id in :optionsIDSet]) 
        {
            VoteUserStoryWrapper  voteObj =  new VoteUserStoryWrapper();
            if(optionObj.Vote_User_Story__r.size() > 0  )
            {
                voteObj.userVoteObj =  optionObj.Vote_User_Story__r.get(0);
                voteObj.optionDesc  = optionObj.User_Story_Option__c;
                voteObj.userVote  = voteObj.userVoteObj.Vote__c ? 'Yes':'No';               
            }
            else                    
            {
                Vote_User_Story__c  tempObj =  new Vote_User_Story__c();
                tempObj.User_Story_Option__c  = optionObj.id; 
                tempObj.user__c = UserInfo.getUserID(); 
                voteObj.userVoteObj = tempObj; 
                voteObj.optionDesc  = optionObj.User_Story_Option__c;
            }
            sessionUserStoryWrappObj.userStoryOptions.add(voteObj );
        } 
               
    } 
    public class SessionUserStoryWrapper    
    {
        public Value_Delivery_Session_User_Stories__c  sessionStoryObj {get;set;}
        public Boolean isVoted {get;set;}
        public String userStoryDesc {get;set;}
        public List<VoteUserStoryWrapper>  userStoryOptions {get;set;}
        Public Boolean flag{get;set;}
        Public Boolean voteFlag{get;set;}
        
        public SessionUserStoryWrapper(Value_Delivery_Session_User_Stories__c   obj , Boolean vote)
        {
            sessionStoryObj = obj;
            isVoted = vote;
            voteFlag = false;
            
            
        }    
        public SessionUserStoryWrapper(Value_Delivery_Session_User_Stories__c   obj)
        {
            sessionStoryObj = obj;
            isVoted = false;
            voteFlag = false;
            
        }   
        public SessionUserStoryWrapper()
        {
            userStoryOptions  = new List<VoteUserStoryWrapper    >();
            voteFlag = false;
        }     
    }
    
    public class VoteUserStoryWrapper    
    {
        public String userVote  {get;set;}
        public String optionDesc  {get;set;}
        public Vote_User_Story__c userVoteObj {get;set;}
    }        
    
    public void saveUserVote()
    {
        String errMsg = validateUserVote();
        if(errMsg !=null)
        {
            SaaSUtility.displayErrMsg(errMsg);  
            return;
        }
        list<Vote_User_Story__c>  userVoteLst = new List<Vote_User_Story__c>();
        if(sessionUserStoryWrappObj  != null)
        {
            for(VoteUserStoryWrapper  obj : sessionUserStoryWrappObj.userStoryOptions)
            {
                if(obj.userVote != null && obj.userVote != '' )
                {
                    obj.userVoteObj.Vote__c  =  obj.userVote == 'Yes'? true:false;
                }                
                userVoteLst.add(obj.userVoteObj); 
            }
        }            
        upsert userVoteLst;
        success =true;
    }
    @TestVisible
    private String validateUserVote()
    {
        String errormsg  = null;
        for(VoteUserStoryWrapper  obj : sessionUserStoryWrappObj.userStoryOptions)
        {
            if(obj.userVote  == null)
            {
                errormsg = 'Please select the vote';
                break;
            }
        }   
        return errormsg;       
    }
    Public void add()
    {
        try
        {   
            User_Story_Options__c newPart  = new User_Story_Options__c ();
            newOptionsLst.add(new OptionsWrapper(newOptionsLst.size()+1 , newPart  , SaaSUtility.generateHash(10)));
        }
        catch(Exception e )
        {
             e.getMessage();
        }
    }
    public void remove()
    {
        try
        {
            List<OptionsWrapper > newChildList = new List<OptionsWrapper >();
            for (OptionsWrapper sow : newOptionsLst) 
            {
                if (sow.hash != clientHash) 
                {
                    newChildList.add(sow);
                } 
            }        
            newOptionsLst = newChildList;
        }
        catch(Exception e )
        {
             e.getMessage();
        }
    }
    /**
    * Save User Story.
    * 
    * @return String
    */    
    public PageReference saveUserStory() {
        PageReference pageRef= null;        
        String errMSg = null;
        List<User_Story_Options__c> partLst =null;       
        try
        {
           upsert newUserStoryObj; 
           newSessionUserStoriesObj.Value_Delivery_Session_Outcomes__c = sessOutcomeObj.id;
           newSessionUserStoriesObj.User_Story__c = newUserStoryObj.id;

           upsert newSessionUserStoriesObj;
            
           partLst = getParticipantsTosave(newSessionUserStoriesObj);
           if(partLst.size() > 0)
           {
                upsert partLst;
           }
           isInsert = true;
           pageRef = new PageReference('/apex/SaasSessionUserStories?id=' + sessOutcomeObj.id);
                
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
    *  Get All options from the Wrapper Object to Save 
    * 
    * @return List
    */ 
    @TestVisible 
    private List<User_Story_Options__c> getParticipantsTosave(Value_Delivery_Session_User_Stories__c sessionObj)
    {
        List<User_Story_Options__c> partLst = new List<User_Story_Options__c>();
        
        for(OptionsWrapper wrapObj  : newOptionsLst)
        {
            wrapObj.obj.Value_Deliver_Session_User_Stories__c  = sessionObj.id;
            partLst.add(wrapObj.obj); 
        }
        
        
        return partLst;
    }   
    
    public void deleteSessionUserStory()
    {
         try
        {
            if(deleteSessionUsrStory !=null)
            {
                 delete deleteSessionUsrStory;
            }
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
    *  call method when click on delete link in userstory 
    * 
    */ 
    public void getSessionsUserStory()
    {
         SaaSUtility.clearPageErrMsg();
         success  = false;
         String itemkey= Apexpages.currentPage().getParameters().get('SessionsUserStorysID');            
         deleteSessionUsrStory = [ select id from Value_Delivery_Session_User_Stories__c WHERE id =:itemkey];                 
    } 
}