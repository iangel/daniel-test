/** 
 *  Author : Accenture 
 *  Description : Controller class for SaasSessionUserStories page
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  05\06\2015        created 
 *
 */ 
 
public with sharing class SaasSessionUserStories 
{
    public Value_Delivery_Session_Outcomes__c sessOutcomeObj {get;set;}
    public String valueSessionPrjName {get;set;}
    private List<UserStoriesWrapper> UserStoriesWrapLst;
    public String searchtxt {get;set;}
    private Set<Id> sessionUserStoriesSet = new Set<Id>();
    Public Id Release;
     /**
     * Constructor   
     *
     */ 
    public SaasSessionUserStories(ApexPages.StandardController controller) 
    {
        sessOutcomeObj= (Value_Delivery_Session_Outcomes__c )controller.getRecord();
        Value_Delivery_Session__c valuedeliverysession =[select id,Releases__c from Value_Delivery_Session__c where id =:sessOutcomeObj.Value_Delivery_Session__c];
        Release = valuedeliverysession.Releases__c;
        system.debug('===Release==='+Release);
        valueSessionPrjName = SaaSUtility.getValueSessionProjectName();
        for(Value_Delivery_Session_User_Stories__c userStories: [Select User_Story__c,Value_Delivery_Session_Outcomes__c from  Value_Delivery_Session_User_Stories__c where Value_Delivery_Session_Outcomes__c =:sessOutcomeObj.ID])
        {
            sessionUserStoriesSet.add(userStories.User_Story__c);
        } 
        
   }    
    
    
    
    public ApexPages.StandardSetController con 
    {
        get 
        {
            if(con == null) 
            {
                //con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Name,Priority__c, Status__c, Description__c,Decision_Outcome__c,Due_Date__c,RecordType.Name FROM User_Story__c  Order By CreatedDate DESC]));            
                con = new ApexPages.StandardSetController(Database.query(getSoql()));
                con.setPageSize(SaaSTextConstant.LIST_VIEW_PAGE_SIZE);
            }
            return con;
        }
        set;
    }

   /**
    * Get Records form the Standardset controller 
    *
    * @param args none.
    * @return none 
    *
    */ 
    public List<UserStoriesWrapper> getUserStoriesWrapLst() 
    {
        
        UserStoriesWrapLst= new List<UserStoriesWrapper>();
        List<User_Story__c> userStoryLst =(List<User_Story__c>)con.getRecords();
        for(User_Story__c storyObj: userStoryLst )
        {       
            UserStoriesWrapLst.add(new UserStoriesWrapper(storyObj));
        }
        return UserStoriesWrapLst;
    }
       
    /**
     * indicates whether there are more records after the current page set.
     *
     * @param args none.
     * @return none 
     *
     */       
     public Boolean hasNext {
        get {
            return con.getHasNext();
        }
        set;
    }

    /**
     * indicates whether there are more records before the current page set.
     *
     * @param args none.
     * @return none 
     *
     */    
    public Boolean hasPrevious {
        get {
            return con.getHasPrevious();
        }
        set;
     }

   /**
     *  returns the previous page of records
     *
     * @param args none.
     * @return none 
     *
     */   
     public void previous() {
         con.previous();
     }

    /**
     *  returns the next page of records
     *
     * @param args none.
     * @return none 
     *
     */       
     public void next() {
         con.next();
     }

   /**
    *  UserStoriesWrapper Wrapper Class 
    *
    */   
    public class UserStoriesWrapper
    {
        public Boolean checked{ get; set;}
        public User_Story__c  UserStoryObj{ get; set;}  
        
        public UserStoriesWrapper(User_Story__c  c)
        {
            UserStoryObj= c;
            checked = false;
        }      
    }
  /**     
   * Search for Key Decision records for given Srtring 
   *
   * @param args none.
   * @return PageReference 
   *
   */       
    public void search()
    {           
        if(searchtxt!= null)
        {
            searchtxt =searchtxt.trim();
        }
          con = new ApexPages.StandardSetController(Database.query(getSoql()));
          con.setPageSize(SaaSTextConstant.LIST_VIEW_PAGE_SIZE);             
    }    
  
    /**
     * Get Selected Element from the List
     *
     * @param args none.
     * @return List<User_Story__c > 
     *
     */     
    public List<User_Story__c > getSelectedElement()
    {
        List<User_Story__c> slectedUserStory = new List<User_Story__c >();    
        if(UserStoriesWrapLst!= null)
        {
            for(UserStoriesWrapper wrapObj : UserStoriesWrapLst)
            {
                if(wrapObj.checked)
                {
                    slectedUserStory.add(wrapObj.UserStoryObj);    
                }
            }
        }
        return slectedUserStory;
    }
    
     /**
    * To set a Direction either in ascending order or descending order.
    *
    */       
    public String sortDir 
    {   
       get  { if (sortDir == null) {  sortDir = SaaSTextConstant.ASCENDING_SORT_ORDER ; } return sortDir;}
       set;
    }

   /**
    * The current field to sort by. defaults to last name
    *
    */  
    public String sortField 
    {

        get  { if (sortField == null) {sortField = SaaSTextConstant.NAME_FIELD_API_NAME ; } return sortField;  }
        set;
    }
    
   /**
    * Sort List View By Column
    *
    */  
    public void sortByColumn()
    {
         sortDir = sortDir.equals(SaaSTextConstant.ASCENDING_SORT_ORDER ) ? SaaSTextConstant.DESCENDING_SORT_ORDER  :  SaaSTextConstant.ASCENDING_SORT_ORDER ;
         search();
         
    }
    
   /**
    * Get Soql For the List View
    *
    */          
    private String getSoql()
    {
       //String soql = 'Select Name,Priority__c, Release__r.Name, User_Story_Description__c,Capability__r.Name FROM User_Story__c  where ID NOT IN : sessionUserStoriesSet AND Release__c = \'' + sessOutcomeObj.Value_Delivery_Session__r.Releases__c + '\'';                          
        String soql = 'Select Name,Priority__c, Release__r.Name, User_Story_Description__c,Capability__r.Name FROM User_Story__c  where ID NOT IN : sessionUserStoriesSet AND Release__c = \'' + Release + '\'';                          

          soql =  soql + ' Order By ' + sortField + ' ' + sortDir + ' NULLS LAST' ;                            
           return soql ;
        
    }      
    
    /**
     * Import User Stories into value Delivery Sessions
     *
     */
    public PageReference importUserStories()
    {
       Id UserId; 
       List<Value_Delivery_Session_User_Stories__c> userLinkLst  = new   List<Value_Delivery_Session_User_Stories__c>();        

        List<User_Story__c> userStoryLst =  getSelectedElement();
      
        // Check if any user story is selected
        if(userStoryLst.size() ==0 )
        {
            SaaSUtility.displayErrMsg('Select User Stories to import.' );   
            return null;
        }
        for(User_Story__c userStoryObj : userStoryLst ) 
        {
            Value_Delivery_Session_User_Stories__c obj = new Value_Delivery_Session_User_Stories__c();
            obj.User_Story__c = userStoryObj.id;
            obj.Value_Delivery_Session_Outcomes__c = sessOutcomeObj.id;  
            //obj.Name=sessOutcomeObj.name +'_'+ Date.Today();
            userLinkLst.add(obj);  
        }           
        
        try
        {   
            insert userLinkLst; 
            PageReference orderPage = new PageReference('/apex/SaaSSessionOutcomeDetail?id=' + sessOutcomeObj.id);
            orderPage.setRedirect(true);
            return orderPage;   
        }
        catch(Exception e )
        {
        
        }
        return null;           
    }    
}