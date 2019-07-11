public class SaasCreateSessionCtrl
{    
    public String selectedSession {get;set;} 
    public String releaseID{get;set;}
    public String sessionID{get;set;}
    public Value_Delivery_Session__c valueDeliverySesObj{get;set;}
    public DateTime sessonStartDate {get;set;}
    public DateTime sessonEndDate {get;set;}
    public List<String> projectPhaseLst  {get;set;}
    public Integer pagNo {get; set;}
    public Integer pagedispalyCount {get; set;}
    public Integer scectionCount {get; set;}
    public Integer noOfRecords {get; set;}
    public Map<String,List<Value_Delivery_Setup__c >> phaseToObjectiveMap {get;set;}
    public Map<String,List<BusinessOptionWrpper>> objectiveToOptionsMap {get;set;}
    public String prjPhase {get;set;}
    
     /**
    * wrapper for pagination
    *
    */ 
    public class BusinessOptionWrpper 
    {
        public Boolean selected {get;set;}
        public Value_Delivery_Objectives_Options__c busOptObj {get;set;}
        public BusinessOptionWrpper(Value_Delivery_Objectives_Options__c busOptObjs )
        {
            selected  = false;
            busOptObj = busOptObjs ;
        }
    }
    
     /**
    * Constructor 
    *
    */ 
    public SaasCreateSessionCtrl()
    {
        valueDeliverySesObj = new Value_Delivery_Session__c();
        sessionID = null;
        projectPhaseLst  = new List<String>();
        phaseToObjectiveMap =  new Map<String,List<Value_Delivery_Setup__c >>();
        objectiveToOptionsMap = new Map<String,List<BusinessOptionWrpper>>();
       
        pagNo =0;
        pagedispalyCount =0;
        scectionCount  =0;
        noOfRecords  =0;
       
    }
     /**
    * Navigate to Next page in the pagination 
    *
    */ 
    public PageReference selectCreateSessionSetp()
    {    
        String errMsg = null;
        //if no option is selected in radio button.
        if(selectedSession =='' || selectedSession  == null)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.SELECT_THE_SESSION_TYPE); 
            return NULL;
        } 
        List<Value_Delivery_Session__c> deliverySessionList = new List<Value_Delivery_Session__c>();
        if(selectedSession == 'template')
        {
        
            deliverySessionList = [Select Id,Name from Value_Delivery_Session__c where Name =:system.label.VALUE_Delivery_Session_template];        
            if(deliverySessionList.size() == 0)
            {
                SaaSPostInstallHandler   installObj = new SaaSPostInstallHandler();
                installObj.createSetupOverview(); 
                deliverySessionList = [Select Id,Name from Value_Delivery_Session__c where Name =:system.label.VALUE_Delivery_Session_template];        
                SessionId = deliverySessionList.get(0).ID;                    
                //SaaSUtility.displayErrMsg(SaaSTextConstant.PLEASE_CONTACT_SYSTEM_ADMINSTRATOR); 
                //return null;
            }
            else
            {
                SessionId = deliverySessionList.get(0).ID;
            }
        }    
        return selectedSession == 'existingSession'?Page.SaaSCreateSessionStep2 :Page.SaaSCreateSessionStep3 ;   
    }

    public PageReference selectPrjAndSessionSetp()
    {    
        if(releaseID=='' || releaseID == null)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.SELECT_PROJECT_FROM_DROPDOWN );  
            return null;
        }
        else if(sessionID=='' || sessionID== null)
        {
             SaaSUtility.displayErrMsg(SaaSTextConstant.SELECT_SESSION_FROM_DROPDOWN);  
             return null;
        }        
        return Page.SaaSCreateSessionStep3;
    }
      
   /**
    * Validate the session.
    * @return String errmsg
    *    
    */   
    public String validateSession()
    {
        String errMsg = null;
        String prjID = valueDeliverySesObj.Releases__c;
        if(valueDeliverySesObj.name == null || valueDeliverySesObj.name == '')
        {
            errMsg= SaaSTextConstant.PLEAS_ENTER_SESSION_NAME;    
        }
        else if(prjID  == null || prjID == '' )
        {
             errMsg= SaaSTextConstant.PLEAS_ENTER_PROJECT_NAME ;    
        }
        else if (sessonStartDate != null && sessonEndDate != null && (sessonEndDate < sessonStartDate))
        {
              errMsg= 'Session end date should be greater than start date. ';
        }
                
        return errMsg; 
        
    }
     /**
    * Navigate to previous page in the pagination 
    *
    */ 
    public PageReference createSessionPrevoiusStep()
    {
        if(selectedSession == 'existingSession'){
            return page.SaaSCreateSessionStep2; 
        }else{
           return page.SaaSCreateSession;
        }
    }
     /**
    * Navigate to Next page in the pagination 
    *
    */  
    public PageReference createSessionNextStep()
    {
        String errMsg = validateSession();  
        if(errMsg != null)
        {
            SaaSUtility.displayErrMsg(errMsg );  
            return null;
        }  
        //projectPhaseLst.clear();
         initlizeValueDeliverySession();
        return Page.SaaSCreateSessionStep4;
    }

    public void initlizeValueDeliverySession()
    {
      system.debug('===projectPhaseLst==='+projectPhaseLst.size()+projectPhaseLst);
      noOfRecords =0;
       projectPhaseLst.clear(); 
        phaseToObjectiveMap.clear();
        objectiveToOptionsMap.clear();
        List<Value_Delivery_Setup__c>   valueDeliverySetup =  [Select  (select id,Option_Description__c ,Sequence_No__c  from   Value_Delivery_Objectives_Options__r), name,Component_Title__c,Project_Phase__c,Value_Delivery_Session__c from Value_Delivery_Setup__c where Value_Delivery_Session__c = :sessionID  order by Project_Phase__c nulls Last];
        system.debug('===phaseToObjectiveMap=='+phaseToObjectiveMap);
        for(Value_Delivery_Setup__c valueDelSetup :valueDeliverySetup)        
        {
            if(phaseToObjectiveMap.get(valueDelSetup.Project_Phase__c) == null)
            {
                System.debug('___valueDelSetup.Value_Delivery_Objectives_Options__r___'+valueDelSetup.Project_Phase__c+'___'+valueDelSetup.Value_Delivery_Objectives_Options__r);
                if(valueDelSetup.Value_Delivery_Objectives_Options__r.size() > 0 && valueDelSetup.Project_Phase__c!=null)
                {
                    noOfRecords++;
                    List<Value_Delivery_Setup__c >  tempLst  =  new List<Value_Delivery_Setup__c >();
                    projectPhaseLst.add(valueDelSetup.Project_Phase__c); 
                    system.debug('======projectPhaseLst====='+projectPhaseLst);
                    phaseToObjectiveMap.put(valueDelSetup.Project_Phase__c,tempLst);                            
                    tempLst.add(valueDelSetup );                      
                    List<BusinessOptionWrpper> businessObjectiveOptions = new List<BusinessOptionWrpper>();
                    businessObjectiveOptions.addall(convertWrapper(valueDelSetup.Value_Delivery_Objectives_Options__r)); 
                    objectiveToOptionsMap.put(valueDelSetup.id,businessObjectiveOptions ); 
                }
            }
            else        
            {
            system.debug('===bbbbbbbbbbb='+valueDelSetup.Project_Phase__c+ valueDelSetup.Value_Delivery_Objectives_Options__r.size());
               if(valueDelSetup.Value_Delivery_Objectives_Options__r.size() > 0 && valueDelSetup.Project_Phase__c!=null) 
                {
                    noOfRecords++;
                     List<Value_Delivery_Setup__c > tempLst  =   phaseToObjectiveMap.get(valueDelSetup.Project_Phase__c);                     
                     tempLst.add(valueDelSetup );                      
                     List<BusinessOptionWrpper> businessObjectiveOptions = new List<BusinessOptionWrpper>();                     
                     businessObjectiveOptions.addall(convertWrapper(valueDelSetup.Value_Delivery_Objectives_Options__r));                       
                     objectiveToOptionsMap.put(valueDelSetup.id,businessObjectiveOptions );     
                }    
            }
        }
        
        if(projectPhaseLst.size() > 0)
        {
            prjPhase = projectPhaseLst.get(0);     
            scectionCount = phaseToObjectiveMap.get(prjPhase ).size()  ;  
        }                
    }
    
    public List<BusinessOptionWrpper> convertWrapper(List<Value_Delivery_Objectives_Options__c>  busOptLst)
    {
         List<BusinessOptionWrpper> busWrapObjLst = new List<BusinessOptionWrpper>();
         for(Value_Delivery_Objectives_Options__c obj :busOptLst)
         {
             
             busWrapObjLst.add(new BusinessOptionWrpper(obj) );    
         }       
         return busWrapObjLst;
    }
    /**
     *  Navigate to Next page in the pagination 
     *  
     *  @return nothing
     */
    public void next()
    {
    system.debug('====ssssssssssss====');
        try
        {
            pagNo++;
            if(pagNo >= projectPhaseLst.size() -1)
            {
                pagNo =  projectPhaseLst.size() -1;
            }
            prjPhase = projectPhaseLst.get(pagNo);        
            pagedispalyCount = pagedispalyCount    + scectionCount;        
            scectionCount = phaseToObjectiveMap.get(prjPhase).size() ;
            }
        catch(Exception e )
        {
            e.getMessage();
        }  
        
    }
     /**
     *  Navigate to Previous page in the pagination 
     *  
     *  @return nothing
     */
    public void previous()
    {
        try
        {
             pagNo--;
             if(pagNo == 0 ||  pagNo < 0)
             {
                 pagNo = 0;
             }
            prjPhase = projectPhaseLst.get(pagNo);
            pagedispalyCount= (pagedispalyCount- phaseToObjectiveMap.get(prjPhase ).size() );
            scectionCount = phaseToObjectiveMap.get(prjPhase ).size() ;        
        }
        catch(Exception e )
        {
            e.getMessage();
        }      
         
    }  
    
    public PageReference finish()
    {
        PageReference  pageRef = null;
        Map<String,Value_Delivery_Setup__c> bussinessObjectiveMap = getBusinessObjectInMap();        
        Map<String,Value_Delivery_Setup__c> insertBussinessObjectiveMap = new Map<String,Value_Delivery_Setup__c>();        
        Map<String,List<Value_Delivery_Objectives_Options__c >> insertObjectiveToOptionsMap = new Map<String,List<Value_Delivery_Objectives_Options__c>>();     
       try
        {
            upsert valueDeliverySesObj;             
            // Check if any option is selected       
            for(String str : objectiveToOptionsMap.keySet() )
            {         
                for(BusinessOptionWrpper warpObj: objectiveToOptionsMap.get(str) )
                {
                    // Check if optio is selected to insert 
                    if(warpObj.selected)
                    {
                        // Store parent of the business option in map
                        if(insertBussinessObjectiveMap.get(str)== null)
                        {
                            insertBussinessObjectiveMap.put(str,bussinessObjectiveMap.get(str)) ;
                        }
                        
                        //Store business option is map  
                        if(insertObjectiveToOptionsMap.get(str) == null)
                        {
                            List<Value_Delivery_Objectives_Options__c > tempLst = new List<Value_Delivery_Objectives_Options__c >();
                            tempLst.add(warpObj.busOptObj.clone());
                            insertObjectiveToOptionsMap.put(str,tempLst)  ;     
                        }
                        else
                        {
                              List<Value_Delivery_Objectives_Options__c > tempLst = insertObjectiveToOptionsMap.get(str);
                              tempLst.add(warpObj.busOptObj.clone()); 
                        }     
                    }     
                }
            }
            // Insert all Business Objective
            insert assignSessionIDForBussinessObj(valueDeliverySesObj, insertBussinessObjectiveMap.values());
            // Insert all Business Options
            insert  assignBusObjIDForBussOptionsObj(insertBussinessObjectiveMap ,insertObjectiveToOptionsMap );
            //Update the Custom Setting and redirect to the overview page
            SaaSUtility.getLoggedInValueSession(valueDeliverySesObj.id);
            pageRef = new PageReference(SaaSTextConstant.VALUE_DELIVERY_APPROACH_VF_PAGE_NAME_URL );
        }
        catch(DmlException e)
        {
            SaaSUtility.displayErrMsg(e.getDmlMessage(0));           
        } 
        catch(Exception e)
        {
            SaaSUtility.displayErrMsg(SaaSTextConstant.EXCEPTION_ERR_MSG );         
            e.getMessage();        
        }
        return pageRef; 
    }
    
    private List<Value_Delivery_Objectives_Options__c> assignBusObjIDForBussOptionsObj( Map<String,Value_Delivery_Setup__c> insertBussinessObjectiveMap ,Map<String,List<Value_Delivery_Objectives_Options__c >> insertObjectiveToOptionsMap )
    {
        List<Value_Delivery_Objectives_Options__c>  bussinessOptLst = new List<Value_Delivery_Objectives_Options__c>();
        for(String str :insertObjectiveToOptionsMap.keySet()  )
        {
            for(Value_Delivery_Objectives_Options__c  obj : insertObjectiveToOptionsMap.get(str))
            {
                obj.Objectives_and_Attendees_for_Participant__c =  insertBussinessObjectiveMap.get(str).id; 
                bussinessOptLst.add(obj);         
            }
        }  
        return bussinessOptLst; 
    }
     
    private Map<String,Value_Delivery_Setup__c > getBusinessObjectInMap()
    {
        Map<String,Value_Delivery_Setup__c > businessObjMap = new  Map<String,Value_Delivery_Setup__c>();
        
        for(String str : phaseToObjectiveMap.keySet())
        {
            for(Value_Delivery_Setup__c obj : phaseToObjectiveMap.get(str))
            {
                businessObjMap.put(obj.id,obj.clone()); 
            }
        }
        return businessObjMap; 
    }
@Testvisible
    private List<Value_Delivery_Setup__c> assignSessionIDForBussinessObj(Value_Delivery_Session__c sessObj, List<Value_Delivery_Setup__c> setupLst)
    {
        for(Value_Delivery_Setup__c obj : setupLst)
        {
            obj.Value_Delivery_Session__c  = sessObj.id;   
        }
        return setupLst;
    }
    public PageReference cancel()
    {
        return new PageReference(SaaSTextConstant.VALUE_DELIVERY_TAB_REDIRECT_VF_PAGE_NAME_URL);
    }
    
    public List<SelectOption> getReleaseList1()
    { 
        List<SelectOption> releaseList = new List<SelectOption>();
        releaseList.add(new SelectOption(SaaSTextConstant.EMPTY_STRING,SaaSTextConstant.NONE_PICKLIST_VALUE )); 
        List<release__c> relList = [Select id, name, Release__c from release__c];
        for(release__c release :relList)
        {
            releaseList.add(new SelectOption(release.Id,release.Name));     
        }
    
       return releaseList;   
   }
   
    public List<SelectOption> getdetailSession()
    { 
        List<SelectOption> sessionOptions = new List<SelectOption>();
        sessionOptions.add(new SelectOption(SaaSTextConstant.EMPTY_STRING,SaaSTextConstant.NONE_PICKLIST_VALUE) );  
        List<Value_Delivery_Session__c> sessionList = [Select id, name, Releases__c from Value_Delivery_Session__c where Releases__c = :releaseID];
        
        for(Value_Delivery_Session__c  sessionObj :sessionList)
        {
            sessionOptions.add(new SelectOption(sessionObj.Id,sessionObj.Name));     
        }
       return sessionOptions;   
   }
   
   public PageReference step1()
   {
      return Page.SaaSCreateSession;
   }
     
   public PageReference objectiveDetailPrevious()
   {
      system.debug('===projectPhaseLst==='+projectPhaseLst.size());
       return Page.SaaSCreateSessionStep3; 
   }
}