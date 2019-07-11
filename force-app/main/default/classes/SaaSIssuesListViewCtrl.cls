/** 
 *  Author : Accenture 
 *  Description : Controller class for SaaSReleaseListView  
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  05\06\2015        created 
 *
 */
 
public class SaaSIssuesListViewCtrl
{
    private List<IssueRiskWrapper> issueRiskWrapLst;
    
    public String searchtxt {get;set;}  
      
    public SaaSIssuesListViewCtrl()
    {
        searchtxt = '';
    }    
    
    public ApexPages.StandardSetController con 
    {
        get 
        {
            if(con == null) 
            {
               // con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Release__r.name ,Milestone__r.name ,Priority__c, Status__c, Description__c,Target_Resolution_Date__c,Id,recordType.Name, Name FROM Issues_Risks__c Order By CreatedDate DESC]));            
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
    public List<IssueRiskWrapper> getIssueRiskWrapLst() 
    {
        issueRiskWrapLst = new List<IssueRiskWrapper>();
        for (Issues_Risks__c   issueObj : (List<Issues_Risks__c  >)con.getRecords())
            issueRiskWrapLst.add(new IssueRiskWrapper(issueObj));

        return issueRiskWrapLst;
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
     *  returns the first page of records
     *
     * @param args none.
     * @return none 
     *
     */    
     public void first() {
         con.first();
     }

    /**
     *  returns the last page of records
     *
     * @param args none.
     * @return none 
     *
     */       
     public void last() {
         con.last();
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
     *  IssueRisk Wrapper Class 
     *
     */   
    public class IssueRiskWrapper 
    {
        public Boolean checked{ get; set;}
        public Issues_Risks__c  issueRiskObj{ get; set;}  
        
        public IssueRiskWrapper (Issues_Risks__c  c)
        {
            issueRiskObj = c;
            checked = false;
        }      
    }
      /**
     * Search for relase records for given Srtring 
     *
     * @param args none.
     * @return PageReference 
     *
     */   
    public void search()
    {           
        // con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Release__r.name ,Milestone__r.name ,Priority__c, Status__c, Description__c,Target_Resolution_Date__c,Id,recordType.Name, Name FROM Issues_Risks__c where name like : ('%'+searchtxt+'%' )   Order By Name limit 100]));            
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
     * @return none
     *
     */    
    public void deleteIssues()
    {
        List<Issues_Risks__c> delIssues = getSelectedElement();
        if(delIssues.size () > 0)
        {
            Database.delete(delIssues);
            con = null;
            SaaSUtility.displaySuccessMsg(SaaSTextConstant.DELETE_SELECT_ONE_RECORD_SAVE_MSG );
        }
        else 
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.DELETE_SELECT_ONE_RECORD_ERR_MSG );      
        }            
    
    }
    /**
     * Navigate to Update page 
     *
     * @param args none.
     * @return PageReference 
     *
     */      
    public PageReference updateIssue()
    {

        List<Issues_Risks__c> updateIssue = getSelectedElement();
        if(updateIssue.size() > 1)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.EDIT_MULTIPLE_SELECT_ERR_MSG );                   
            return null;
        }
        
        if(updateIssue.size() == 0)
        {
           SaaSUtility.displayErrMsg(SaaSTextConstant.EDIT_SELECT_ONE_RECORD_ERR_MSG );           
            return null;            
        }          
        return  new  PageReference(SaaSTextConstant.CREATE_RISK_ISSUE_VF_PAGE_NAME_URL+'?id='+updateIssue.get(0).id);                 
    }
     /**
     * Navigate to Selected Record to Clone
     *
     * @param args none.
     * @return List<Release__c> 
     *
     */ 
    public PageReference cloneIssue()
    {

        List<Issues_Risks__c> cloneIssue = getSelectedElement();
        if(cloneIssue.size() > 1)
        {
           SaaSUtility.displayErrMsg(SaaSTextConstant.CLONE_SELECT_ONE_RECORD_ERR_MSG );               
            return null;
        }
        
        if(cloneIssue.size() == 0)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.CLONE_MULTIPLE_SELECT_ERR_MSG );                     
            return null;            
        }          
        return new PageReference(SaaSTextConstant.CREATE_RISK_ISSUE_VF_PAGE_NAME_URL+ '?isClone=1&&id='+cloneIssue.get(0).id);                 
    }
   /**
    * Get Selected Element from the List
    *
    * @param args none.
    * @return List<Release__c> 
    *
    */    
    public List<Issues_Risks__c> getSelectedElement()
    {
        List<Issues_Risks__c> slectedIssues = new List<Issues_Risks__c>();    
        if(issueRiskWrapLst!= null)
        {
            for(IssueRiskWrapper wrapObj : issueRiskWrapLst)
            {
                if(wrapObj.checked)
                {
                    slectedIssues.add(wrapObj.issueRiskObj);    
                }
            }
        }
        return slectedIssues;
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
        String soql = 'Select Release__r.name ,Milestone__r.name ,Priority__c, Status__c, Description__c,Target_Resolution_Date__c,Id,recordType.Name, Name FROM Issues_Risks__c where ';
               soql = soql +  'name like  \'%'+searchtxt+'%\'  or ';
               soql = soql +  'Release__r.name like  \'%'+searchtxt+'%\'  or ';
               soql = soql +  'Milestone__r.name like  \'%'+searchtxt+'%\'  or ';
               soql = soql +  'recordType.Name like  \'%'+searchtxt+'%\'  or ';
               soql = soql +  'Priority__c like  \'%'+searchtxt+'%\'  or ';
               soql = soql +  'Status__c like \'%'+searchtxt+'%\'  Order By ' + sortField + ' ' + sortDir + ' NULLS LAST' ; 
               
        System.debug('soql-----' + soql );               
        
        return soql;              
    } 

    
}