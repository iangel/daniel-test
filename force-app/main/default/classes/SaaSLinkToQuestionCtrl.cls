/** 
 *  Author : Accenture 
 *  Description : Controller class for SaaSLinkToQuestion
 *  Created Date : 23\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  23\06\2015        created 
 *
 */
public class SaaSLinkToQuestionCtrl
{
    private  Question_Log__c questionObj;
    private List<RequestWrapper> requestWrapLst;
    public  List<RequestWrapper> selectedrequestWrapLst {get;set;}
    
   /**
    * Constructor   
    *
    */  
    public SaaSLinkToQuestionCtrl(ApexPages.StandardController controller)
     {
        questionObj  = (Question_Log__c)controller.getRecord();
        selectedrequestWrapLst = new List<RequestWrapper>(); 
    

    }

    public ApexPages.StandardSetController con 
    {
        get 
        {
            if(con == null) 
            {
                con = new ApexPages.StandardSetController(Database.getQueryLocator([Select name, Id,Request_Description__c from Request__c ]));            
                con.setPageSize(10);
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
     */    
     public Boolean hasNext {
        get {
            return con.getHasNext();
        }
        set;
    }
   
   
   /**
     * Update Selected Question When User select the request 
     *
     * @param args none.
     * @return none 
     *
     */   
    public void updateSelectedRequest() 
    {
        
        Map<String, RequestWrapper>  selectRequestedMap =  new  Map<String, RequestWrapper>();
        Set<String> pageReqId = new Set<String>();
        
        for(RequestWrapper wrapObj : requestWrapLst)
        {
            pageReqId.add(wrapObj.requestListObj.id);    
        }
        
        for(RequestWrapper wrapObj : selectedrequestWrapLst)
        {
            selectRequestedMap.put(wrapObj.requestListObj.id, wrapObj );    
        }
        
        selectedrequestWrapLst.clear();
        
        Set<String> mapKeySet = selectRequestedMap.keySet();
        mapKeySet.removeAll(pageReqId);
        selectedrequestWrapLst.addAll(selectRequestedMap.values());
        List<RequestWrapper> requestWrapLst= getSelectedElement();
        selectedrequestWrapLst.addAll(requestWrapLst);
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
     *  Get all Selected Record
     *
     *
     */   
    public List<RequestWrapper> getSelectedElement()
    {
        List<RequestWrapper> slectedRequest = new List<RequestWrapper>();    
        if(requestWrapLst!= null)
        {
            for(RequestWrapper wrapObj : requestWrapLst)
            {
                if(wrapObj.checked)
                {
                    slectedRequest.add(wrapObj);    
                }
            }
        }
        return slectedRequest;
    }  
    
   /**
    * Link to Request 
    *
    *
    */   
    public void linkToRequest()
    {
        List<RequestWrapper> slectedReq = new List<RequestWrapper>();  
        List<Related_Request__c> insertLinkReq=  new  List<Related_Request__c>();
        String errMsg = null;
        for(RequestWrapper wrapObj : selectedrequestWrapLst)
        {
             if(wrapObj.checked)
             {
                  slectedReq.add(wrapObj);   
             }
        }
        if(slectedReq.size() == 0)
        {
              SaaSUtility.displayErrMsg(SaaSTextConstant.LINK_TO_REQ_NO_RECORDS_ERR_MSG );    
              return;
        }            
        
        for(RequestWrapper wrapObj : slectedReq )
        {
            Related_Request__c relObj =  new Related_Request__c();  
            relObj.Question_Log__c = questionObj.id;
            relObj.Request__c = wrapObj.requestListObj.id;
            insertLinkReq.add(relObj);  
        }
        errMsg  = SaaSUtility.insertSobject(insertLinkReq);
        if(errMsg!=null)
        {
            SaaSUtility.displayErrMsg(errMsg);
        }
        else
        {       
            SaaSUtility.displaySuccessMsg(SaaSTextConstant.LINK_TO_REQ_RECORDS_RECORDS_INSERT_MSG); 
        }            
    }
    
    
    
    
    
    
}