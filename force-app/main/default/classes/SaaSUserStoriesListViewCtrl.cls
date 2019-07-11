public class SaaSUserStoriesListViewCtrl
{
    private List<UserStoriesWrapper> UserStoriesWrapLst;
    public String searchtxt {get;set;}
   /**
    * Constructor        
    *
    */  
    public SaaSUserStoriesListViewCtrl()
    {
        searchtxt = '';
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
        
        System.debug('-----' + con.getRecords());
        
        for (User_Story__c storyObj : (List<User_Story__c>)con.getRecords())
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
        // con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Name,Priority__c, Status__c, Description__c,Decision_Outcome__c,Due_Date__c,RecordType.Name FROM User_Story__c  where name like : ('%'+searchtxt+'%' )   Order By Name limit 100]));            
        // con.setPageSize(5);    
        if(searchtxt!= null)
        {
            searchtxt =searchtxt.trim();
        }
          con = new ApexPages.StandardSetController(Database.query(getSoql()));
          con.setPageSize(SaaSTextConstant.LIST_VIEW_PAGE_SIZE);      
       
    }    
      
    /**
     * Delete Selected Record
     *
     * @param args none.
     * @return PageReference 
     *
     */    
    public void deleteUserStory()
    {
        String errMsg = null;
        List<User_Story__c> delUserStory = getSelectedElement();
        if(delUserStory.size () > 0)
        {
            errMsg  = SaaSUtility.deleteSobject(delUserStory);
            if(errMsg !=null)
            {
                 SaaSUtility.displayErrMsg(errMsg );      
            }            
            else
            {
                con = null;
                SaaSUtility.displaySuccessMsg(SaaSTextConstant.DELETE_SELECT_ONE_RECORD_SAVE_MSG );
            } 
        }
        else 
        {
             SaaSUtility.displayErrMsg(SaaSTextConstant.DELETE_SELECT_ONE_RECORD_ERR_MSG );      
        }            
    
    }
    
         
    /**
     * Navigate to Update key action page 
     *
     * @param args none.
     * @return PageReference 
     *
     */  
    public PageReference updateUserStory()
    {
        PageReference pageRef = null;
        List<User_Story__c > updateUserStory = getSelectedElement();
        if(updateUserStory.size() > 1)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.EDIT_MULTIPLE_SELECT_ERR_MSG );            
            return null;
        }
        
        if(updateUserStory.size() == 0)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.EDIT_SELECT_ONE_RECORD_ERR_MSG );                   
            return null;            
        }          
       pageRef = new  PageReference(SaaSTextConstant.CREATE_USER_STORIES_VF_PAGE_NAME_URL+'?id='+updateUserStory.get(0).id);
       pageRef.setRedirect(true); 
       return   pageRef;
    }
   /**
     * Navigate to Selected Record to Clone
     *
     * @param args none.
     * @return PageReference  
     *
     */    
    public PageReference cloneUserStory()
    {
        PageReference pageRef = null;
        List<User_Story__c > cloneUserStory = getSelectedElement();
        if(cloneUserStory.size() > 1)
        {
             SaaSUtility.displayErrMsg(SaaSTextConstant.CLONE_SELECT_ONE_RECORD_ERR_MSG );                   
            return null;
        }
        else if(cloneUserStory.size() == 0)
        {
             SaaSUtility.displayErrMsg(SaaSTextConstant.CLONE_MULTIPLE_SELECT_ERR_MSG );                  
            return null;            
        }               
        pageRef = new PageReference(SaaSTextConstant.CREATE_USER_STORIES_VF_PAGE_NAME_URL +'?isClone=1&&id='+cloneUserStory.get(0).id); 
        pageRef.setRedirect(true);                     
        return pageRef;                 
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
        String soql = 'Select Name,Priority__c, Release__r.Name, User_Story_Description__c,Capability__r.Name FROM User_Story__c  where ';
               soql = soql +  'name like  \'%'+searchtxt+'%\'  or ';
               soql = soql +  'Release__r.name like  \'%'+searchtxt+'%\'  or ';
               soql = soql +  'Priority__c like \'%'+searchtxt+'%\'  Order By ' + sortField + ' ' + sortDir + ' NULLS LAST' ; 
               
        System.debug('soql-----' + soql );               
        
        return soql ;
    }      
  
}