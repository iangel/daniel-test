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
public class SaaSKeyActionOrDecisionListViewCtrl
{
    private List<KeyDecisionWrapper> keyDecisionWrapLst;
    public String searchtxt {get;set;}
   /**
    * Constructor        
    *
    */  
    public SaaSKeyActionOrDecisionListViewCtrl()
    {
        searchtxt = '';
    }    
    
    public ApexPages.StandardSetController con 
    {
        get 
        {
            if(con == null) 
            {
                //con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Name,Priority__c, Status__c, Description__c,Decision_Outcome__c,Due_Date__c,RecordType.Name FROM Key_Action_Decision__c Order By CreatedDate DESC]));            
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
    public List<KeyDecisionWrapper> getkeyDecisionWrapLst() 
    {
        keyDecisionWrapLst= new List<KeyDecisionWrapper>();
        for (Key_Action_Decision__c decisionObj : (List<Key_Action_Decision__c>)con.getRecords())
            keyDecisionWrapLst.add(new KeyDecisionWrapper(decisionObj));

        return keyDecisionWrapLst;
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
    *  KeyDecisionWrapper Wrapper Class 
    *
    */   
    public class KeyDecisionWrapper
    {
        public Boolean checked{ get; set;}
        public Key_Action_Decision__c keyDecisionObj{ get; set;}  
        
        public KeyDecisionWrapper(Key_Action_Decision__c c)
        {
            keyDecisionObj= c;
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
        // con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Name,Priority__c, Status__c, Description__c,Decision_Outcome__c,Due_Date__c,RecordType.Name FROM Key_Action_Decision__c where name like : ('%'+searchtxt+'%' )   Order By Name limit 100]));            
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
    public void deleteKeyAction()
    {
        String errMsg = null;
        List<Key_Action_Decision__c> delKeyAction = getSelectedElement();
        if(delKeyAction.size () > 0)
        {
            errMsg  = SaaSUtility.deleteSobject(delKeyAction);
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
    public PageReference updateKeyAction()
    {
        PageReference pageRef = null;
        List<Key_Action_Decision__c> updateKeyAction= getSelectedElement();
        if(updateKeyAction.size() > 1)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.EDIT_MULTIPLE_SELECT_ERR_MSG );            
            return null;
        }
        
        if(updateKeyAction.size() == 0)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.EDIT_SELECT_ONE_RECORD_ERR_MSG );                   
            return null;            
        }          
       pageRef = new  PageReference(SaaSTextConstant.CREATE_KEY_DECISION_VF_PAGE_NAME_URL+'?id='+updateKeyAction.get(0).id);
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
    public PageReference cloneKeyAction()
    {
        PageReference pageRef = null;
        List<Key_Action_Decision__c> cloneKeyAction = getSelectedElement();
        if(cloneKeyAction.size() > 1)
        {
             SaaSUtility.displayErrMsg(SaaSTextConstant.CLONE_SELECT_ONE_RECORD_ERR_MSG );                   
            return null;
        }
        else if(cloneKeyAction.size() == 0)
        {
             SaaSUtility.displayErrMsg(SaaSTextConstant.CLONE_MULTIPLE_SELECT_ERR_MSG );                  
            return null;            
        }               
        pageRef = new PageReference(SaaSTextConstant.CREATE_KEY_DECISION_VF_PAGE_NAME_URL +'?isClone=1&&id='+cloneKeyAction.get(0).id); 
        pageRef.setRedirect(true);                     
        return pageRef;                 
    }
    /**
     * Get Selected Element from the List
     *
     * @param args none.
     * @return List<Key_Action_Decision__c> 
     *
     */     
    public List<Key_Action_Decision__c> getSelectedElement()
    {
        List<Key_Action_Decision__c> slectedKeyAction = new List<Key_Action_Decision__c>();    
        if(keyDecisionWrapLst!= null)
        {
            for(KeyDecisionWrapper wrapObj : keyDecisionWrapLst)
            {
                if(wrapObj.checked)
                {
                    slectedKeyAction.add(wrapObj.keyDecisionObj);    
                }
            }
        }
        return slectedKeyAction;
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
        String soql = 'Select Name,Priority__c, Status__c, Description__c,Decision_Outcome__c,Due_Date__c,RecordType.Name FROM Key_Action_Decision__c where ';
               soql = soql +  'name like  \'%'+searchtxt+'%\'  or ';
               soql = soql +  'RecordType.Name like  \'%'+searchtxt+'%\'  or ';
               soql = soql +  'Related_Capability__r.name like  \'%'+searchtxt+'%\'  or ';
               soql = soql +  'Priority__c like  \'%'+searchtxt+'%\'  or ';
               soql = soql +  'Status__c like \'%'+searchtxt+'%\'  Order By ' + sortField + ' ' + sortDir + ' NULLS LAST' ; 
               
        System.debug('soql-----' + soql );               
        
        return soql;              
    }      
  
}