/** 
 *  Author : Accenture 
 *  Description : Controller class for SaaSRequestListView
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  05\06\2015        created 
 *
 */
public class SaaSRequestListViewCtrl
{

    private List<RequestWrapper> requestWrapLst;
    public String searchtxt {get;set;}
    /**
     * Constructor   
     *
     */    
    public SaaSRequestListViewCtrl ()
    {
        searchtxt = '';
    }    
    
    public ApexPages.StandardSetController con 
    {
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
     * Get Records form the Standardset controller 
     *
     * @param args none.
     * @return none 
     *
     */ 
    public List<RequestWrapper> getrequestWrapLst() 
    {
        requestWrapLst= new List<RequestWrapper>();
        for (Request__c  requestObj : (List<Request__c >)con.getRecords())
            requestWrapLst.add(new RequestWrapper(requestObj));

        return requestWrapLst;
    }
        
   /**
     * indicates whether there are more records after the current page set.
     *
     * @param args none.
     * @return none 
     *
     */    public Boolean hasNext {
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
     */        public Boolean hasPrevious {
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
     *  Request Wrapper Class 
     *
     */   
    public class RequestWrapper
    {
        public Boolean checked{ get; set;}
        public Request__c requestListObj{ get; set;}  
        
        public RequestWrapper(Request__c c)
        {
            requestListObj = c;
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
        // con = new ApexPages.StandardSetController(Database.getQueryLocator([Select name, Id,Request_Title__c,Request_Description__c,Request_Type__c,Status__c,Total_Priority_Ranking__c,Total_Estimate_Bottom_Up__c,Release__r.Status_Update__c from Request__c  where name like : ('%'+searchtxt+'%' )   Order By Name limit 100]));            
       //  con.setPageSize(5);  
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
    public void deleteRequest()
    {
        String errMsg  = null;
        List<Request__c > delRequest = getSelectedElement();
        if(delRequest.size () > 0)
        {
           errMsg  = SaaSUtility.deleteSobject(delRequest);
           if(errMsg  != null)
           {
                SaaSUtility.displayErrMsg(errMsg   );    
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
     * Navigate to Update Request page 
     *
     * @param args none.
     * @return PageReference 
     *
     */    
    public PageReference updateRequest()
    {
        List<Request__c > updateRequest = getSelectedElement();
        if(updateRequest.size() > 1)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.EDIT_MULTIPLE_SELECT_ERR_MSG );               
            return null;
        }
        
        if(updateRequest.size() == 0)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.EDIT_SELECT_ONE_RECORD_ERR_MSG );           
            return null;            
        }          
        return  new  PageReference(SaaSTextConstant.CREATE_REQUEST_VF_PAGE_NAME_URL+'?id='+updateRequest.get(0).id);                 
    }
    /**
     * Navigate to Selected Record to Clone
     *
     * @param args none.
     * @return List<Release__c> 
     *
     */     
    public PageReference cloneRequest()
    {

        List<Request__c > cloneRequest = getSelectedElement();
        if(cloneRequest.size() > 1)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.CLONE_SELECT_ONE_RECORD_ERR_MSG );                   
            return null;
        }
        
        if(cloneRequest.size() == 0)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.CLONE_MULTIPLE_SELECT_ERR_MSG );                          
            return null;            
        }          
        return new PageReference(SaaSTextConstant.CREATE_REQUEST_VF_PAGE_NAME_URL +'?isClone=1&&id='+cloneRequest.get(0).id);                 
    }
    
   /*public void approveRequest()
    {
        List<Request__c> aprvRequest = getSelectedElement();
        List<Approval.ProcessSubmitRequest> approvalLst = new List<Approval.ProcessSubmitRequest>();
        if(aprvRequest.size() == 0)
        {
            SaaSPageMessages.addMessage(new SaaSPageMessages.PageMessage(SaaSPageMessages.Severity.WARN, 'Please select atleast one record to clone.'));                  
            return ;            
        }  
        for(Request__c req:aprvRequest)
        {
             Approval.ProcessSubmitRequest AppRequest = new Approval.ProcessSubmitRequest();
             AppRequest.setComments('Submitting price change request for approval');
             AppRequest.setObjectId(req.id);
             approvalLst.add(AppRequest);
    
        }
          Approval.ProcessResult[] result = Approval.process(approvalLst, true);
        
    }*/  
    
    /**
     * Get Selected Element from the list
     *
     * @param args none.
     * @return List<Release__c> 
     *
     */       
    public List<Request__c > getSelectedElement()
    {
        List<Request__c > slectedRequest = new List<Request__c >();    
        if(requestWrapLst!= null)
        {
            for(RequestWrapper wrapObj : requestWrapLst)
            {
                if(wrapObj.checked)
                {
                    slectedRequest.add(wrapObj.requestListObj);    
                }
            }
        }
        return slectedRequest;
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
        String soql = 'Select name, Id,Request_Title__c,Request_Description__c,Request_Type__c,Status__c,Release__r.name from Request__c where ';
               soql = soql +  'name like  \'%'+searchtxt+'%\'  or ';
               soql = soql +  'Request_Title__c like  \'%'+searchtxt+'%\'  or '; 
              // soql = soql +  'Request_Type__c like  \'%'+searchtxt+'%\'  or '; 
               soql = soql +  'Capability__r.name like  \'%'+searchtxt+'%\' or ';
               soql = soql +  'Status__c like \'%'+searchtxt+'%\'  Order By ' + sortField + ' ' + sortDir + ' NULLS LAST' ;
               
               
        return soql;              
    }         
}