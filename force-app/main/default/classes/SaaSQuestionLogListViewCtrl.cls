/** 
 *  Author : Accenture 
 *  Description : Controller class for SaaSQuestionLogListView
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  05\06\2015        created 
 *
 */ 
public class SaaSQuestionLogListViewCtrl
{
    private List<SaaSQuestionLogWrapper> QuesLogWrapLst;
    public String searchtxt {get;set;}
    public Boolean isAccRep  {get;set;}
    
   /**
    * Constructor   
    *
    */          
    public SaaSQuestionLogListViewCtrl()
    {        
        isAccRep = SaaSUtility.isAccentureRepresentative();
        searchtxt = '';
    }    
    
    public ApexPages.StandardSetController con 
    {
        get 
        {
            if(con == null) 
            {
                //con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Submitter__r.name,Assigned_To__r.name, (Select ID from Responses__r ), Question__c,Expected_Close_Date__c, Request__r.name, Capability__c ,Priority__c, Status__c, Description__c,Requested_Date__c,Id, recordType.name,recordType.DeveloperNAme, Name FROM Question_Log__c Order By CreatedDate DESC]));            
                con = new ApexPages.StandardSetController(Database.query(getSoql()));
                con.setPageSize(SaaSTextConstant.LIST_VIEW_PAGE_SIZE);
              }   
            return con;
        }
        set;
    }
    

   /**
     * Get Selected Element from the List
     *
     * @param args none.
     * @return List<Release__c> 
     *
     */    
    public List<SaaSQuestionLogWrapper> getQuesLogWrapLst() 
    {
        QuesLogWrapLst= new List<SaaSQuestionLogWrapper>();
        for (Question_Log__c QuesObj : (List<Question_Log__c>)con.getRecords())
            QuesLogWrapLst.add(new SaaSQuestionLogWrapper(QuesObj));

        return QuesLogWrapLst;
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
    * Search for the question record  
    *
    * @param args none.     
    * @return none 
    *
    */         
    public void search()
    {
        // con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Submitter__r.name,Assigned_To__r.name, (Select ID from Responses__r limit 1), Question__c,Expected_Close_Date__c, Request__r.name, Capability__c ,Priority__c, Status__c, Description__c,Requested_Date__c,Id, recordType.Name, Name FROM Question_Log__c where name like : ('%'+searchtxt+'%' )  ]));            
         // con.setPageSize(25);  
         if(searchtxt!= null)
        {
            searchtxt =searchtxt.trim();
        }
        con = new ApexPages.StandardSetController(Database.query(getSoql()));
        con.setPageSize(SaaSTextConstant.LIST_VIEW_PAGE_SIZE);
  
    }    
   /**
    * Delete Question 
    *
    * @param args none.     
    * @return none 
    *
    */      
   public void deleteQuestion()
   {
        List<Question_Log__c > deleteQuest = getSelectedElement();
        String errMsg= null;
         
        if(deleteQuest.size() == 0)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.DELETE_SELECT_ONE_RECORD_ERR_MSG ); 
            return ;            
        }   
        errMsg =  SaaSUtility.deleteSobject(deleteQuest);
        if(errMsg != null)
        {
            SaaSUtility.displayErrMsg(errMsg);
        }
        else
        {
             con = null;
             SaaSUtility.displaySuccessMsg(SaaSTextConstant.DELETE_SELECT_ONE_RECORD_SAVE_MSG );
        }                   
    
    }
    /**
     * Navigate to Selected Record to Edit
     *
     * @param args none.
     * @return List<Release__c> 
     *
     */         
    public PageReference updateQuestion()
    {
        List<Question_Log__c> questionLst = getSelectedElement();
        if(questionLst.size() > 1)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.EDIT_MULTIPLE_SELECT_ERR_MSG );                   
            return null;
        }
        
        if(questionLst .size() == 0)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.EDIT_SELECT_ONE_RECORD_ERR_MSG );                          
            return null;            
        }          
        return new PageReference(SaaSTextConstant.CREATE_QUESTION_VF_PAGE_NAME_URL  +'?id='+questionLst.get(0).id);                     
    }
     /**
     * Navigate to Selected Record to LinkToRequest
     *
     * @param args none.
     * @return List<Release__c> 
     *
     */         
    public PageReference linkToRequest()
    {
        List<Question_Log__c> questionLst = getSelectedElement();
        if(questionLst.size() > 1)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.EDIT_MULTIPLE_SELECT_ERR_MSG );                   
            return null;
        }
        
        if(questionLst .size() == 0)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.EDIT_SELECT_ONE_RECORD_ERR_MSG );                          
            return null;            
        }          
        return new PageReference(SaaSTextConstant.Link_To_QUESTION_VF_PAGE_NAME_URL+'?id='+questionLst.get(0).id);                     
    }
    /**
     * Navigate to Selected Record to convert question to request
     *
     * @param args none.
     * @return PageReference 
     *
     */  
    public PageReference convertToRequest()
    {
         List<Question_Log__c> questionLst = getSelectedElement();
        if(questionLst.size() > 1)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.CONVERT_QUEST_MULTIPLE_SELECT_ERR_MSG );                   
            return null;
        }
        
        if(questionLst .size() == 0)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.CONVERT_QUEST_SELECT_ONE_RECORD_ERR_MSG );                          
            return null;            
        }          
        return new PageReference(SaaSTextConstant.CREATE_REQUEST_VF_PAGE_NAME_URL+'?'+SaaSTextConstant.CONVERT_QUEST+'=1&&'+SaaSTextConstant.CONVERT_QUEST_ID+'='+questionLst.get(0).id);  
    }
   /**
     * Navigate to Selected Record to Clone
     *
     * @param args none.
     * @return PageReference  
     *
     */     
    public PageReference cloneQuestion()
    {

        List<Question_Log__c> cloneQuest = getSelectedElement();
        if(cloneQuest.size() > 1)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.CLONE_SELECT_ONE_RECORD_ERR_MSG );                   
            return null;
        }
        
        if(cloneQuest.size() == 0)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.CLONE_MULTIPLE_SELECT_ERR_MSG );                          
            return null;            
        }          
        return new PageReference(SaaSTextConstant.CREATE_QUESTION_VF_PAGE_NAME_URL +'?isClone=1&&id='+cloneQuest.get(0).id);                 
    }
    /**
     * Get Selected Element from the List
     *
     * @param args none.
     * @return List<Release__c> 
     *
     */         
    public List<Question_Log__c > getSelectedElement()
    {
        List<Question_Log__c > slectedQuestion = new List<Question_Log__c >();    
        if(QuesLogWrapLst!= null)
        {
            for(SaaSQuestionLogWrapper wrapObj : QuesLogWrapLst)
            {
                if(wrapObj.checked)
                {
                    slectedQuestion.add(wrapObj.questionLogObj);    
                }
            }
        }
        return slectedQuestion;
    }
      /**
     * Navigate to Comments page 
     *
     * @param args none.
     * @return List<Release__c> 
     *
     */    
    public PageReference commentQuestion()
    {
        PageReference pegRef = null;
        List<Question_Log__c > commentQuestion = getSelectedElement();
        if(commentQuestion.size() > 1)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.COMMENT_MULTIPLE_SELECT_ERR_MSG);        
            return null;
        }
        
        if(commentQuestion.size() == 0)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.COMMENT_SELECT_ONE_RECORD_ERR_MSG ); 
            return null;            
        }  
        
        if(commentQuestion.get(0).recordType.DeveloperNAme == SaaSTextConstant.VALUE_DELIVERY_QUESTION_RECORD_TYPE)
        {
            pegRef = new  PageReference(SaaSTextConstant.CREATE_QUESTION_RESP_VF_PAGE_NAME_URL+'?id='+commentQuestion.get(0).id);            
        }
        else
        {                
             pegRef = new  PageReference(SaaSTextConstant.CREATE_QUESTION_VF_PAGE_NAME_URL +'?id='+commentQuestion.get(0).id); 
        }    
        pegRef.setRedirect(true);
        return pegRef;             
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
        String soql = 'Select recordType.DeveloperNAme  ,Submitter__r.name,Assigned_To__r.name,Question__c,Expected_Close_Date__c, Request__r.name,Status__c,Description__c,Requested_Date__c,Id,Name FROM Question_Log__c where ';
               soql = soql +  'name like  \'%'+searchtxt+'%\'  or ';
               soql = soql +  'Assigned_To__r.name like  \'%'+searchtxt+'%\'  or ';
               soql = soql +  'Submitter__r.name like  \'%'+searchtxt+'%\'  or ';
               soql = soql +  'Status__c like \'%'+searchtxt+'%\'  Order By ' + sortField + ' ' + sortDir + ' NULLS LAST' ; 
               
        System.debug('soql-----' + soql );               
        
        return soql;  
                   
    }      
}