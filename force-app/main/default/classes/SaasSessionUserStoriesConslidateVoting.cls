/** 
 *  Author : Accenture 
 *  Description : Controller class for SaasSessionUserStories page
 *  Created Date : 14\03\2016
 * 
 *  Version History :
 *  Date              Changes 
 *  14\03\2016        created 
 *
 */ 
 
Public with sharing class SaasSessionUserStoriesConslidateVoting
{
    public  Value_Delivery_Session_User_Stories__c sessionuserStoryObj {get;set;} 
    public List<User_Story_Options__c> optionLst  {get;set;} 
    public List<UserVote> usersResponseLst {get;set;} 
    public String Phase{get;set;}
    public String valueSessionPrjName {get;set;}
    public String SessionOutcome{get;set;}  
    public String clientHash  {get;set;}  
  
    public SaasSessionUserStoriesConslidateVoting(ApexPages.StandardController controller) 
    {
        sessionuserStoryObj = (Value_Delivery_Session_User_Stories__c) controller.getRecord();
        valueSessionPrjName = SaaSUtility.getValueSessionProjectName();
        sessionOutcome =sessionuserStoryObj.Value_Delivery_Session_Outcomes__r.Name;
        phase =sessionuserStoryObj.Value_Delivery_Session_Outcomes__r.Phase__c;  
        usersResponseLst = new List<UserVote>();        
        optionLst = [select id,User_Story_Option__c,(Select Vote__c , User__c,User_Story_Option__c from Vote_User_Story__R) from User_Story_Options__c where Value_Deliver_Session_User_Stories__c = :sessionuserStoryObj.id order by CreatedDate ];          
        Map<String,UserStoryOptionAndUserVote> optionUserVoteMap =  new Map<String,UserStoryOptionAndUserVote>();
        Set<Id> userIdset = new Set<ID>();
        
        for(User_Story_Options__c obj  : optionLst)
        {           
            for(Vote_User_Story__c voteObj : obj.Vote_User_Story__R)
            { 
                UserStoryOptionAndUserVote wrapObj =  new UserStoryOptionAndUserVote();
                wrapObj.optionObj =  obj;
                wrapObj.userVote = voteObj;
                wrapObj.userRespone  = voteObj.Vote__c?'Yes':'No';
                optionUserVoteMap.put(''+obj.id+voteObj.User__c,wrapObj); 
                userIdset.add(voteObj.User__c);     
            }        
        }
        
        for(ID userID : userIdset)
        {
            UserVote userVoteObj  = new UserVote();
            userVoteObj.userID = ''+userID;  
            userVoteObj.isReadOnly = true;
            userVoteObj.hash=        SaaSUtility.generateHash(10);           
            for(User_Story_Options__c obj  : optionLst)
            {
                if(optionUserVoteMap.get(''+obj.id+userID )!=null)
                {
                    userVoteObj.userOptionsLst.add(optionUserVoteMap.get(''+obj.id+userID ));         
                } 
                else
                {
                    UserStoryOptionAndUserVote wrapObj =  new UserStoryOptionAndUserVote();
                    wrapObj.optionObj = obj;
                    wrapObj.userVote  = new Vote_User_Story__c(); 
                    wrapObj.userVote.User_Story_Option__c = obj.id;  
                    userVoteObj.userOptionsLst.add(wrapObj);         
                }                        
            }            
            usersResponseLst.add(userVoteObj);         
        }
    }
    
    public void add()
    {
        UserVote wrap= new UserVote();
        wrap.hash=        SaaSUtility.generateHash(10);  
        for(User_Story_Options__c obj  : optionLst)
        {
             UserStoryOptionAndUserVote wrapObj =  new UserStoryOptionAndUserVote();
             wrapObj.optionObj = obj;
             wrapObj.userVote  = new Vote_User_Story__c(); 
             wrap.userOptionsLst.add(wrapObj);         
        }
        usersResponseLst.add(wrap);     
    }
    
    public void save()
    {
        List<Vote_User_Story__c> userVoteLst  = new  List<Vote_User_Story__c>();
        String errMsg = validateUserVote();
        if(errMsg !=null)
        {
            SaaSUtility.displayErrMsg(errMsg);  
            return;
        }
        for(UserVote  userVote: usersResponseLst)
        {
            for(UserStoryOptionAndUserVote usrResponse : userVote.userOptionsLst  )
            {
                if(usrResponse.userRespone != null && usrResponse.userRespone != '')
                {
                    usrResponse.userVote.User__C = userVote.userID;
                    usrResponse.userVote.Vote__c =  usrResponse.userRespone== 'Yes' ? true : false;
                    if(usrResponse.userVote.User_Story_Option__c == null)
                    {
                        usrResponse.userVote.User_Story_Option__c =usrResponse.optionObj.Id;
                    }  
                    userVoteLst.add(usrResponse.userVote);  
                }
               
            }  
             
        }
      
        upsert userVoteLst;  
         SaaSUtility.displaySuccessMsg('Participant  votes are saved.');
    }
    private String validateUserVote()
    {
        String errMsg = null;
        Set<String> usrIDSet = new Set<String>();
        for(UserVote  obj : usersResponseLst)
        {
            if(obj.userID == null || obj.userID == '' )            
            {
                errMsg = 'Participant Name cannot be blank';
                break;
            }
            if(!usrIDSet.contains(obj.userID))
            {
                usrIDSet.add(obj.userID); 
            }
            else
            {
                errMsg = 'Participant Name is repeated.';  
                break;  
            }    
        }
        
        return errMsg ;       
    }
    
    
    
    
    
    public class UserVote
    {
        public Boolean isReadOnly {get;set;} 
        public String hash{get;set;}
        public String userID {get;set;}
        public List<UserStoryOptionAndUserVote> userOptionsLst {get;set;}
        public UserVote()
        {
            userOptionsLst = new List<UserStoryOptionAndUserVote>();
        }
    }
    
    public class UserStoryOptionAndUserVote
    {
        public User_Story_Options__c  optionObj {get;set;} 
        public String userRespone {get;set;} 
        public Vote_User_Story__c userVote {get;set;} 
    }
    
    public void remove()
    {    
        List<UserVote> newChildList = new List<UserVote>();
        List<Vote_User_Story__c> delUserVote = new List<Vote_User_Story__c>();
        try
        {
         
        for (UserVote sow : usersResponseLst) 
        {
            if (sow.hash != clientHash) 
            {
                    newChildList.add(sow);
            }
            if(sow.hash == clientHash)
            {
                for(UserStoryOptionAndUserVote obj : sow.userOptionsLst  )
                {
                    if(obj.userVote.id !=null)
                    {
                        delUserVote.add(obj.userVote);
                    }
                }
            }                  
        }    
        usersResponseLst   = newChildList;
        if(delUserVote.size() > 0)
            {
                delete delUserVote;
            }
             }
        catch(Exception e )
        {
             e.getMessage();
        }
        
    
    }
}