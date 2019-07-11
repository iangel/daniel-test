public class SaaSCreateUserStoriesCtrl
{
    private Boolean isClone = false;
    public Boolean isDetail {get;set;}
    public Boolean isSaved {get;set;}
    public Boolean isValDel {get;set;}
    public String valueSessionPrjName {get;set;}
    public String currentSessionName {get;set;}
    public String currentSessionId {get;set;}

    public User_Story__c userStoryObj {get;set;}
    public List<UserStoryOptionWrapper> userStoryOptionLst  {get;set;}
    public String clientHash {get;set;}
    /**
     * Construtor 
     * @param ApexPages.StandardController controller
     *
     */
    public SaaSCreateUserStoriesCtrl (ApexPages.StandardController controller)
    {
        User_Story__c tempUserStory = null;
        isValDel = false;
        valueSessionPrjName = SaaSUtility.getValueSessionProjectName();
       /* currentSessionId = SaaSUtility.getLoggedInValueSession();
        List<Value_Delivery_Session_Outcomes__c > sessionLst = [Select name,Value_Delivery_Session__c from Value_Delivery_Session_Outcomes__c where  Value_Delivery_Session__c= :currentSessionId ];
        currentSessionname = sessionLst[0].Name;*/
        String release = null;
        if(SaaSUtility.getURLParameter('isValDel') == 'true')
        {
            isValDel  = true;
        }
        List<User_Story__c>  userStoryLst = null;
        tempUserStory = (User_Story__c)controller.getRecord();
        isSaved  = false;
        isClone  = ( SaaSUtility.getURLParameter(SaaSTextConstant.IS_CLONE_URL_PARAM ) == SaaSTextConstant.NUMERIC_ONE )?true:false;
        release =  SaaSUtility.getURLParameter(SaaSTextConstant.RELEASEID_URL_PARAM );
        
         isDetail = SaaSUtility.getURLParameter(SaaSTextConstant.DETAIL_URL_PARAM ) == SaaSTextConstant.NUMERIC_ONE  ?true:false;
        // Check if this is edit mode
        if(tempUserStory.id != null )
        {
            userStoryLst = Database.query(SaaSUtility.getCreatableFieldsSOQL(SaaSTextConstant.USER_STORIES_OBJ_API_NAME, 'id=\''+tempUserStory.id+'\''));
            if(userStoryLst.size() > 0)
            {
                userStoryObj= userStoryLst.get(0);  
            }
        }  
        else 
        {
            userStoryObj= new User_Story__c();
            
            if(isValDel)
            {
                String sessionId = SaaSUtility.getURLParameter('sessionId');
                
                if(sessionId != null && sessionId != '')
                {
                    List<Value_Delivery_Session_Outcomes__c>  outComeLst = [Select id,Value_Delivery_Session__r.Releases__c from Value_Delivery_Session_Outcomes__c where id = :sessionId  ];
                    if(outComeLst.size() > 0)
                    {                
                        userStoryObj.Release__c  = outComeLst.get(0).Value_Delivery_Session__r.Releases__c;
                    }                        
                }                    
            }
        }        
        if(isClone)
        {
            userStoryObj= userStoryObj.clone();
            userStoryObj.ownerID = Userinfo.getUserID();
        }  
       if(release !=null && release.trim() != SaaSTextConstant.EMPTY_STRING )
        {
            userStoryObj.Release__c = release ;
        }
        initlizeOptions();
    }
    
   /**
    * Save the release record
    * @return 
    *
    */           
    public void saveUserStory() 
    {      
        PageReference pageRef= null;        
       
        
        String errMsg = validateUserStory();
        // Check any error data is entered by user
        if(errMsg !=null)
        {
            SaaSUtility.displayErrMsg(errMsg);  
            return;
        }
        errMsg = validateOptions();
        // Check any error data is entered by user
        if(errMsg !=null)
        {
            SaaSUtility.displayErrMsg(errMsg);  
            return;
        }
        try
        {            
            upsert userStoryObj; 
            saveUserStoryOption();
            SaaSUtility.displaySuccessMsg(SaaSTextConstant.USER_STORIES_SAVE_MSG );
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
    private String validateUserStory()
    {
        String errMsg = null; 
       // userStoryObj.Release__c = valueSessionPrjName;
        String releaseID  = userStoryObj.Release__c; 
        if(userStoryObj.Name== null)
        {
             errMsg = SaaSTextConstant.USER_STORY_NAME_BLANK_ERR_MSG;      
        }  
        else if(releaseID == null || releaseID.trim() == '')
        {
             errMsg = SaaSTextConstant.USER_STORY_RELATED_RELEASE_ERR_MSG ;      
        }
    
        else if(userStoryObj.User_Story_Description__c == null  || userStoryObj.User_Story_Description__c.trim() == '')
        {
             errMsg = SaaSTextConstant.USER_STORY_DESC_BLANK_ERR_MSG;      
        }  
    
        return errMsg; 
    }    
   /**
    * Create new Release 
    * 
    *    
    */    
    public void createNewUserStory()
    {
        isDetail = false;
        userStoryObj = new   User_Story__c();
        userStoryOptionLst  = new List<UserStoryOptionWrapper>();
        
    }
    
    public  void addUserStoryOptions()
    {
        try
        {   
            User_Story_Options__c newPart  = new User_Story_Options__c();
            UserStoryOptionWrapper  wrapObj  = new UserStoryOptionWrapper(userStoryOptionLst.size()+1 , newPart  , SaaSUtility.generateHash(10));
            if(isValDel)
            {
                String sessionId = SaaSUtility.getURLParameter('sessionId');
                if(sessionId != null)
                {
                    wrapObj.valueDeliverySession    = sessionId;
                }                
            }    
            userStoryOptionLst.add(wrapObj  );
        }
        catch(Exception e )
        {
             e.getMessage();
        }
    }
     /**
     *  Wrapper Class for Participants Sobject
     *
     */    
    public class UserStoryOptionWrapper
    {
        public User_Story_Options__c obj {get;set;}
        public String valueDeliverySession {get;set;}
        public Boolean checked {get;set;}
        public Boolean disableLookup {get;set;}
        
        public String hash { get; set; }
        public Integer index { get; set; }
        
        /**
         * Constructor 
         *
         */          
        public UserStoryOptionWrapper(User_Story_Options__c sobj)
        {
            obj = new User_Story_Options__c();
            obj = sobj;
            checked = false;
            disableLookup  = false;
            
        }       
        public UserStoryOptionWrapper(Integer i, User_Story_Options__c q ,String h) 
        {
              index = I;
              obj  = Q;
              hash  = h;
        }
    }
    public void initlizeOptions()
    {
        userStoryOptionLst  = new List<UserStoryOptionWrapper>();
        
        for(User_Story_Options__c obj  :  [select User_Story_Option__c,Value_Deliver_Session_User_Stories__c ,Value_Deliver_Session_User_Stories__r.Value_Delivery_Session_Outcomes__c from User_Story_Options__c where Value_Deliver_Session_User_Stories__r.User_Story__c = :userStoryObj.id])        
        {          
            UserStoryOptionWrapper objWrap  = new UserStoryOptionWrapper(userStoryOptionLst.size()+1 , obj , SaaSUtility.generateHash(10));
            objWrap.valueDeliverySession = obj.Value_Deliver_Session_User_Stories__r.Value_Delivery_Session_Outcomes__c; 
            userStoryOptionLst.add(objWrap  );         
            objWrap.disableLookup = true;
        }
    }
    
    public void remove()
    {
         List<User_Story_Options__c>  removeLst =new List<User_Story_Options__c>();
        try
        {
            List<UserStoryOptionWrapper> newChildList = new List<UserStoryOptionWrapper>();
            system.debug('=====userStoryOptionLst=='+userStoryOptionLst);
            for (UserStoryOptionWrapper sow : userStoryOptionLst) 
            {
            system.debug('====sow=='+sow);
            system.debug('====clientHash=='+clientHash);
                if (sow.hash != clientHash) 
                {
                    newChildList.add(sow);
                } 
                if(sow.hash == clientHash && sow.obj.Id!= null ) 
                {
                    removeLst.add(sow.obj); 
                }
            }        
            userStoryOptionLst = newChildList;
            
            if(removeLst.size() > 0)
            {
                delete removeLst;
            }
        }
        catch(Exception e )
        {
             e.getMessage();
        }
    }
    
    @TestVisible
    private void saveUserStoryOption()
    {
        Set<Id> valueDeliverySessOutcomeIdSet = new Set<Id>();         
        Map<String,Value_Delivery_Session_User_Stories__c> userSessionOutomeMap = new Map<String,Value_Delivery_Session_User_Stories__c>(); 
        List<User_Story_Options__c>  usrStryOptionLst  = new List<User_Story_Options__c>();
        List<Value_Delivery_Session_User_Stories__c> sessionUserStoryLst = new List<Value_Delivery_Session_User_Stories__c>(); 
        Map<String,Value_Delivery_Session_User_Stories__c> insertSessionStory = new Map<String,Value_Delivery_Session_User_Stories__c>();
                         
        for(UserStoryOptionWrapper obj : userStoryOptionLst)
        {
             valueDeliverySessOutcomeIdSet.add(obj.valueDeliverySession);  
        }
        for(Value_Delivery_Session_User_Stories__c  obj : [Select id , User_Story__c, Value_Delivery_Session_Outcomes__c  from Value_Delivery_Session_User_Stories__c where Value_Delivery_Session_Outcomes__c   in :valueDeliverySessOutcomeIdSet and User_Story__c = :userStoryObj.id])
        {
            userSessionOutomeMap.put(''+obj.User_Story__c+obj.Value_Delivery_Session_Outcomes__c , obj);     
        }
        
 
         for(UserStoryOptionWrapper obj : userStoryOptionLst)
         {
             System.debug('obj---- ' + userStoryObj.id  + obj.valueDeliverySession);
             if(!userSessionOutomeMap.keySet().contains(''+userStoryObj.id+obj.valueDeliverySession))
             {            
                 Value_Delivery_Session_User_Stories__c temp = new Value_Delivery_Session_User_Stories__c();
                 temp.User_Story__c = userStoryObj.id;
                 temp.Value_Delivery_Session_Outcomes__c  = obj.valueDeliverySession; 
                 sessionUserStoryLst.add(temp); 
                 insertSessionStory.put(''+userStoryObj.id+obj.valueDeliverySession,temp);
                 userSessionOutomeMap.put( ''+userStoryObj.id+obj.valueDeliverySession ,temp );
             }  
                       
         }                  
         
         System.debug('userSessionOutomeMap==='+ insertSessionStory);             
          
         upsert sessionUserStoryLst;  
         
        for(Value_Delivery_Session_User_Stories__c  obj : sessionUserStoryLst)
        {
            userSessionOutomeMap.put(''+obj.User_Story__c+obj.Value_Delivery_Session_Outcomes__c , obj);     
        }
         
         
                
         for(UserStoryOptionWrapper obj : userStoryOptionLst)
         {
             if(userSessionOutomeMap.keySet().contains(''+userStoryObj.id+obj.valueDeliverySession))
             {
                 if(obj.obj.Id == null)
                 {                 
                     obj.obj.Value_Deliver_Session_User_Stories__c = userSessionOutomeMap.get(''+userStoryObj.id+obj.valueDeliverySession).id;
                 }
                 usrStryOptionLst.add(obj.obj);              
             }
         }
        System.debug('usrStryOptionLst------'+ usrStryOptionLst); 
        upsert usrStryOptionLst;
        updatelookupToReadOnly();
    }
    
    @TestVisible
    private void updatelookupToReadOnly()
    {
        for(UserStoryOptionWrapper obj : userStoryOptionLst)
        {
            obj.disableLookup = true;
        }
    }
    
    public String validateOptions()
    {
        String errMsg = null;
        for(UserStoryOptionWrapper obj : userStoryOptionLst)
        {
            if((obj.obj.User_Story_Option__c == null || obj.obj.User_Story_Option__c.trim() == '' )  )
            {
                errMsg  = 'Enter option description.';                   
                break;
            }
           /* if((obj.valueDeliverySession  == null || obj.valueDeliverySession.trim() == '') )
            {
                errMsg  = 'Enter Value  User story Session.';                   
                break;
            }*/
            
        }
        return errMsg; 
    }
    
    
    
}