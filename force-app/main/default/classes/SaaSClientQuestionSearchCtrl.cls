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
public with sharing class SaaSClientQuestionSearchCtrl 
{

    private List<SaaSQuestionLogWrapper> QuesLogWrapLst;
    
    public Question_Log__c questionLogObj {get;set;}
    public Boolean searchDisplay  {get;set;}
    public Boolean isAccRep  {get;set;}
    
    
    /**
     * Constructor   
     *
     */      
    public SaaSClientQuestionSearchCtrl()
    {
        searchDisplay = true;           
        questionLogObj  = new Question_Log__c();
        questionLogObj.Scope__c = SaaSUtility.getURLParameter(SaaSTextConstant.SCOPE_URL_PARAM);
        isAccRep   = SaaSUtility.isAccentureRepresentative();
    //    initilizeDomain();
    }
    
    /**
     * Search for the Records 
     *
     * @param args none.
     * @return none 
     *
     */     
    public void search()
    {
        searchDisplay = true;
        con = new ApexPages.StandardSetController(Database.query( getSearchSoql()));      
        con.setPageSize(SaaSTextConstant.LIST_VIEW_PAGE_SIZE);      
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
 
        pegRef = new  PageReference(SaaSTextConstant.CREATE_QUESTION_VF_PAGE_NAME_URL +'?id='+commentQuestion.get(0).id); 
        pegRef.setRedirect(true);
        return pegRef;             
    }
            
    public ApexPages.StandardSetController con 
    {
        get 
        {
            if(con == null) 
            {
                        
//              con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Scope__c,Question__c,Domain__c, Name, (Select ID from Responses__r limit 1) FROM Question_Log__c where  Scope__c =:questionLogObj.Scope__c  and Domain__C includes('Account Management;Assets/Install Base')   Order  By Name]));            
            //    con = new ApexPages.StandardSetController(Database.getQueryLocator( getSearchSoql()));            
                con = new ApexPages.StandardSetController(Database.query(getSearchSoql()));                          
                con.setPageSize(SaaSTextConstant.LIST_VIEW_PAGE_SIZE);
            }
            return con;
        }
        set;
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
     * Get Records form the Standardset controller 
     *
     * @param args none.
     * @return none 
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
     * Navigate to Selected Record to Add to Request 
     *
     * @param args none.
     * @return PageReference 
     *
     */     
    public PageReference linkToRequest()
    {

        List<Question_Log__c> questionLst = getSelectedElement();
        if(questionLst.size() > 1)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.LINK_TO_REQ_MULTIPLE_SELECT_ERR_MSG );                   
            return null;
        }
        
        if(questionLst.size() == 0)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.LINK_TO_REQ_SELECT_ONE_RECORD_ERR_MSG );                          
            return null;            
        }          
        return new PageReference(SaaSTextConstant.Link_To_QUESTION_VF_PAGE_NAME_URL +'?id='+questionLst.get(0).id);                 
    } 
    /**
     * Navigate to Selected Record to Edit
     *
     * @param args none.
     * @return PageReference 
     *
     */     
    public PageReference editQuestion()
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
        return new PageReference(SaaSTextConstant.CREATE_QUESTION_VF_PAGE_NAME_URL +'?id='+questionLst.get(0).id);                 
    } 
    
    
    /**
     * Navigate to Selected Record to convert to Request
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
      *  On initial fetch all records and Display 
      *
      * @param args none.
      * @return PageReference 
      */
     public void initilizeDomain()
     {               
        Schema.DescribeFieldResult fieldResult = Question_Log__c.Domain__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        questionLogObj.Domain__c = SaaSTextConstant.EMPTY_STRING;
        for( Schema.PicklistEntry f : ple)
        {
            questionLogObj.Domain__c = questionLogObj.Domain__c +';'+ f.getValue();
            
            //options.add(new SelectOption(f.getLabel(), f.getValue()));
            
        }       
     }
   /**
    * get domain for the dynamic soql 
    * @param args none.
    * @return PageReference 
    *
    */
    private String getDomainForSoql()
    {
         String s1 = (questionLogObj.Domain__c==null?'':questionLogObj.Domain__c)+SaaSTextConstant.EMPTY_STRING;
         String domains = SaaSTextConstant.EMPTY_STRING;
         List<String> domainValues = s1.split(';');
         for(Integer i = 0; i< domainValues.size() ; i++)
         {
            if(i == 0)
            {
                domains = domains  + ' \'';
            }
            domains = domains + domainValues[i] + '\'';
                       
            if(i != (domainValues.size() - 1))
            {
                domains = domains + ', \'';
            }
            else
            {
                domains = domains + SaaSTextConstant.EMPTY_STRING;
            }
        }
        System.Debug('temp '+domains  );
        return domains;             
    } 
    
   /**
    * Get dynamic soql 
    * @param args none.
    * @return string soql
    *
    */
    public String getSearchSoql()
    {
        String soql = 'SELECT Question__c ,Scope__c,Domain__c,Id,Industry__c, Name,OwnerId  FROM Question_Log__c where ' ;
        String domain  = null; 
        
        if(!isAccRep)
        {
            questionLogObj.Is_Value_Delivery_Question__c  = true;  
        }
       
        soql  = soql  + ' Is_Value_Delivery_Question__c  = ' + questionLogObj.Is_Value_Delivery_Question__c ; 
      //        String soql = 'SELECT Question__c ,Scope__c,Domain__c,Id,Industry__c, Name,OwnerId  FROM Question_Log__c where Is_Value_Delivery_Question__c =true and Scope__c=\''+questionLogObj.Scope__c +'\'  and recordTypeID= \''+SaaSUtility.getRecordTypeID('Question_Log__c','Value_Delivery_Question_Log') +'\' ';

       if(questionLogObj.Scope__c  != null && questionLogObj.Scope__c.trim() != '' )
       {
            soql = soql + ' and Scope__c  = \''+questionLogObj.Scope__c +'\'';
       }
       
       domain  = getDomainForSoql();        
       if(domain != null && domain.trim() !='' && domain.trim() != '\'\'' )
       {
           soql = soql + ' and Domain__c includes (' + domain   + ') ';     
       }
       soql = soql + ' Order By ' + sortField + ' ' + sortDir + ' NULLS LAST' ; 
               
        System.debug('soql-----' + soql );               
        
       return soql;  
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
    
     
}