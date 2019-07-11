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
 
Public with sharing class SaasSessionUserStoriesResultCtrl{

 
//variable declartion...
    Public string Phase{get;set;}
    public String searchtxt{get;set;}
    Public string SessionOutcome{get;set;}
    public Set<String> userIDSet {get;set;}
    public List<String> optionIDLst {get;set;}
    public String valueSessionPrjName {get;set;}
    public List<ChartWarpper> chartLst {get;set;}
    public Map<String,String> voteValueMap  {get;set;}
    public List<UserVoteWrapper> userVoteLst {get;set;}
    public List<User_Story_Options__c> optionLst  {get;set;}
    Public Value_Delivery_Session_User_Stories__c sessionUserstory{get;set;}
    private Value_Delivery_Session_User_Stories__c sessionuserStoryObj {get;set;}

    
    //controller...
    public SaasSessionUserStoriesResultCtrl(ApexPages.StandardController controller) {
    
        sessionuserStoryObj = (Value_Delivery_Session_User_Stories__c) controller.getRecord();
        chartLst = new List<ChartWarpper>();
        userVoteLst  = new List<UserVoteWrapper>();
        voteValueMap  = new Map<String,String>();
        userIDSet = new Set<String>();
        optionIDLst = new List<String>();
        valueSessionPrjName = SaaSUtility.getValueSessionProjectName();
        sessionUserstory = new Value_Delivery_Session_User_Stories__c ();
        sessionUserstory = [select id,Value_Delivery_Session_Outcomes__r.Name,Value_Delivery_Session_Outcomes__r.Phase__c from Value_Delivery_Session_User_Stories__c where ID=:sessionuserStoryObj.ID ];
        SessionOutcome =sessionUserstory.Value_Delivery_Session_Outcomes__r.Name;
        Phase =sessionUserstory.Value_Delivery_Session_Outcomes__r.Phase__c;
        optionLst = [select id,User_Story_Option__c  , (Select Vote__c , User__c,User_Story_Option__c from Vote_User_Story__R) from User_Story_Options__c where Value_Deliver_Session_User_Stories__c = :sessionuserStoryObj.id order by CreatedDate ];
        Map<ID,ChartWarpper>  optionstoChartData = new Map<ID,ChartWarpper>();
        
        // Create Chart Data
        integer i =0;
        for(User_Story_Options__c obj  : optionLst)
        {
             optionIDLst.add(obj.id+'');   
            i++;
            if(optionstoChartData.get(obj.id) == null)
                {
                    ChartWarpper chartObj = new ChartWarpper();
                    chartObj.optionNo = 'Option ' + i;
                    optionstoChartData.put(obj.id, chartObj);
                    chartLst.add(chartObj);
                }   
            for(Vote_User_Story__c voteObj : obj.Vote_User_Story__R)
            {
                
                ChartWarpper chartObj = optionstoChartData.get(obj.id);
                if(voteObj.Vote__c)
                {
                    chartObj.noOfYes++;
                }      
                else 
                {
                    chartObj.noOfNo++;
                }
                userIDSet.add(voteObj.User__c);
                voteValueMap.put(''+obj.id+voteObj.User__c,(voteObj.Vote__c?'Yes':'No'));
                
                
            }
        }        
        Map<String,UserVoteWrapper>  usrVoteMap =  new Map<String,UserVoteWrapper>();
        for(User userObj :[Select id,name from user where id in :userIDSet])
        {
            for(User_Story_Options__c obj  : optionLst)
            {
                if(usrVoteMap.get(userObj.id+'') == null)
                {
                    UserVoteWrapper userVoteObj= new UserVoteWrapper();
                    usrVoteMap.put(userObj.id+'' ,userVoteObj) ;
                    userVoteLst.add(userVoteObj); 
                    userVoteObj.userName  = userObj.name; 
                }
                UserVoteWrapper  temp = usrVoteMap.get(userObj.id);

                String s =  voteValueMap.get(''+obj.id+userObj.id) == null? '-':voteValueMap.get(''+obj.id+userObj.id);
                temp.userVote.add(s);                                
               }
        }
        
       
    }
    public class ChartWarpper 
    {
        public String optionNo {get;set;}
        public Integer noOfYes {get;set;}
        public Integer noOfNo {get;set;}
        
        public ChartWarpper()
        {
            optionNo = ''; 
            noOfYes =  0;
            noOfNo = 0;            
        }
    }
    
    public class UserVoteWrapper
    {
        public String userName {get;set;}
        public List<String> userVote {get;set;}
        
        public UserVoteWrapper()
        {
            userName  = '';
            userVote  = new  List<String>();
        }
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
    * Get Soql For the List View
    *
    */          
    private String getSoql()
    {
        String soql = 'Select Name,User_Story_Option__c, Value_Deliver_Session_User_Stories__c FROM User_Story_Options__c where Value_Deliver_Session_User_Stories__c = \'' + sessionuserStoryObj .ID + '\'';                          
        soql =  soql + ' Order By ' + sortField + ' ' + sortDir + ' NULLS LAST' ;                            
        return soql ;
    }     
    public ApexPages.StandardSetController con{
        get 
        {
            if(con == null) 
            {
                con = new ApexPages.StandardSetController(Database.query(getSoql()));
                con.setPageSize(SaaSTextConstant.LIST_VIEW_PAGE_SIZE);
            }
            return con;
        }
        set;
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
}