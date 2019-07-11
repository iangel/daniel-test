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
public class SaaSReleaseListViewCtrl
{

   @TestVisible private List<ReleaseWrapper> releaseWrapLst;
    public Boolean isDeleteError {get;set;}   
    public String searchtxt {get;set;}   
    /**
     * Constructor   
     *
     */      
    public SaaSReleaseListViewCtrl() 
    {
        searchtxt = '';
    }    
    
    public ApexPages.StandardSetController con 
    {
        get 
        {
            if(con == null) 
            {
                //con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Name,Release__c,Plan_Start_Date__c,Release_Planned_End_Date__c,Status__c,Description__c,Status_Update__c FROM Release__c  Order By CreatedDate DESC]));            
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
    public List<ReleaseWrapper> getReleaseWrapLst() 
    {
        releaseWrapLst= new List<ReleaseWrapper>();
        for (Release__c releaseObj : (List<Release__c>)con.getRecords())
            releaseWrapLst.add(new ReleaseWrapper(releaseObj));

        return releaseWrapLst;
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
     *  Release Wrapper Class 
     *
     */   
    @TestVisible public class ReleaseWrapper
    {
        public Boolean checked{ get; set;}
        public Release__c releaseListObj{ get; set;}  
        
        public ReleaseWrapper(Release__c c)
        {
            releaseListObj = c;
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
       //  con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Name,Release__c,Plan_Start_Date__c,Release_Planned_End_Date__c,Status__c,Description__c,Status_Update__c FROM Release__c where name like : ('%'+searchtxt+'%' )   Order By Name limit 100]));            
       //  con.setPageSize(25);    
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
    public void deleteRelease()
    {
        isDeleteError = false;
        List<Release__c> delRelease = getSelectedElement();
        try
        {
            if(delRelease.size () > 0)
            {
                delete delRelease;
                con = null;
                SaaSUtility.displaySuccessMsg(SaaSTextConstant.DELETE_SELECT_ONE_RECORD_SAVE_MSG );
            }
            else 
            {
                
                SaaSUtility.displayErrMsg(SaaSTextConstant.DELETE_SELECT_ONE_RECORD_ERR_MSG );    
            }            
        }
        catch(DmlException e )            
        {
            SaaSUtility.displayErrMsg(e.getDmlMessage(0));    
        }
        catch(Exception e)
        {
             SaaSUtility.displayErrMsg(SaaSTextConstant.EXCEPTION_ERR_MSG );                
        }
        
    
    }
    
    /**
     * Navigate to Update release page 
     *
     * @param args none.
     * @return PageReference 
     *
     */        
    public PageReference updateRelease()
    {
        PageReference pageRef = null;
        List<Release__c> updateRelease = getSelectedElement();
        if(updateRelease.size() > 1)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.EDIT_MULTIPLE_SELECT_ERR_MSG ); 
            return null;
        }
        
        if(updateRelease.size() == 0)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.EDIT_SELECT_ONE_RECORD_ERR_MSG ); 
            return null;            
        }    
        pageRef = new PageReference(SaaSTextConstant.CREATE_RELEASE_VF_PAGE_NAME_URL +'?id='+updateRelease.get(0).id);                 
        pageRef.setRedirect(true);       
        return  pageRef;                 
    }
    /**
     * Navigate to Selected Record to Clone
     *
     * @param args none.
     * @return List<Release__c> 
     *
     */ 
    public PageReference cloneRelease()
    {
        PageReference pageRef = null;
        List<Release__c> cloneRelease = getSelectedElement();
        if(cloneRelease.size() > 1)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.CLONE_SELECT_ONE_RECORD_ERR_MSG );               
            return null;
        }
        
        if(cloneRelease.size() == 0)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.CLONE_MULTIPLE_SELECT_ERR_MSG );               
            return null;            
        }       
        pageRef = new PageReference(SaaSTextConstant.CREATE_RELEASE_VF_PAGE_NAME_URL+'?isClone=1&&id='+cloneRelease.get(0).id);                 
        pageRef.setRedirect(true); 
        return pageRef;
    }
        
    /**
     * Get Selected Element from the List
     *
     * @param args none.
     * @return List<Release__c> 
     *
     */    
    public List<Release__c> getSelectedElement()
    {
        List<Release__c> slectedRelease = new List<Release__c>();    
        if(releaseWrapLst!= null)
        {
            for(ReleaseWrapper wrapObj : releaseWrapLst)
            {
                if(wrapObj.checked)
                {
                    slectedRelease.add(wrapObj.releaseListObj);    
                }
            }
        }
        return slectedRelease;
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
        String soql = 'Select Name,Release__c,Release_Start_Date__c,Release_Planned_End_Date__c,Status__c,Description__c,Status_Update__c FROM Release__c where ';
               soql = soql +  'name like  \'%'+searchtxt+'%\'  or ';
               soql = soql +  'Status__c like \'%'+searchtxt+'%\'  Order By ' + sortField + ' ' + sortDir + ' NULLS LAST' ; 
               
        System.debug('soql-----' + soql );               
        
        return soql;              
    }        
}