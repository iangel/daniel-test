/** 
 *  Author : Accenture 
 *  Description : Controller class for SaaSOverviewComp Component
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  05\06\2015        created 
 *
 */ 
public with sharing class SaaSOverviewCompCtrl
{    
    public String projectPhase {get;set;}
    public String valueSessionPrjName {get;set;}
    public String pageName {get;set;}
    public boolean success{get;set;}
    public boolean isInsert {get;set;}    
    public List<Value_Delivery_Setup__c> dynamciContentLst {get;set;}
    public Value_Delivery_Setup__c itemList {get;set;}
    public List<String> mapKeys {get;set;}
 //   public boolean flag{get;set;}
    public Map<ID,List<String>> accordianContent {get;set;}
    public Value_Delivery_Setup__c valueDeliveryObj {get;set;}
    public Integer objectiveSequenceNo {get;set;}
    public Integer optionSequenceNo {get;set;}
    private String bussinessObjectID {get;set;}
             
   // New Changes     
    private List<Value_Delivery_Objectives_Options__c> valueDeliveryOption {get;set;}
    public Value_Delivery_Objectives_Options__c valueDelOptionObj{get;set;}
    public Value_Delivery_Setup__c valueDeliveryObjectiveObj {get;set;}
    public String bussinesOnjectiveOption {get;set;}
    public Value_Delivery_Objectives_Options__c  newObjectivesOptions {get;set;}
    /**
     * Constructor   
     *
     */       
    public SaaSOverviewCompCtrl()
    {  

        objectiveSequenceNo  = 0 ;
        optionSequenceNo = 0;
        success = false;
    //    flag = false;    
        isInsert  = false;     
        accordianContent  = new Map<ID,List<String>>();  
        valueDeliveryObj = new Value_Delivery_Setup__c();     
        newObjectivesOptions = new Value_Delivery_Objectives_Options__c();
        valueSessionPrjName = SaaSUtility.getValueSessionProjectName();
        valueDelOptionObj = new Value_Delivery_Objectives_Options__c(); 
        valueDeliveryObj.Value_Delivery_Session__c = SaaSUtility.getLoggedInValueSession();                                                                                         
    }    
  
    /**
     * Save Value Delivery Setup Data 
     *
     */   
    public void updateValueDeliveryObjective()
    {    
        success = false;
        String errMsg ='';
        if(valueDeliveryObjectiveObj <> null)
        {
            errMsg = validateBusinessObjective(valueDeliveryObjectiveObj, false); 
        }          
        if(errMsg != null)
        {
            SaaSUtility.displayErrMsg(errMsg);
            return ;
        }               
        try
        {    
            System.debug('objectiveSequenceNo--->' +objectiveSequenceNo );           
    //        valueDeliveryObjectiveObj.Sequence_Order__c = objectiveSequenceNo ;
            System.debug('valueDeliveryObjectiveObj--->' +valueDeliveryObjectiveObj );            
            
            reArrangeSection(valueDeliveryObjectiveObj, true);
            success = true;
           // objectiveSequenceNo =  0;
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
    }
    /**
     * Validate the Date Entered by the user.
     *
     */  
    private String validateBusinessObjective(Value_Delivery_Setup__c setupObj, boolean isInsert)
    {
        String errMsg = null; 
        
        if(setupObj.Component_Title__c == null || setupObj.Component_Title__c== SaaSTextConstant.EMPTY_STRING )
        {            
            errMsg = SaaSTextConstant.OVERVIEW_COMP_EMPTY_TITLE_ERR_MSG;   
        }       
        else if(isInsert && ( bussinesOnjectiveOption == null || bussinesOnjectiveOption == SaaSTextConstant.EMPTY_STRING))
        {
            errMsg = SaaSTextConstant.OVERVIEW_COMP_EMPTY_CONTENT_ERR_MSG;
        }    
        return errMsg;
    }
    
    /**
     * Rearrange the Section based on the input
     *
     */
     private void reArrangeSection(Value_Delivery_Setup__c setupObj, Boolean isUpdate)
     {  
         System.debug('setupObj ' + setupObj );
         System.debug('isUpdate -- ' + isUpdate );         
         Boolean isDuplicate = true;
         Decimal sequenceNo = 1;
         List<Value_Delivery_Setup__c> valueDeliveryLst  = new List<Value_Delivery_Setup__c>(); 
         
         if(setupObj.Sequence_Order__c !=null )
         {
             List<Value_Delivery_Setup__c> setUpObjLst = getSetUpData(isUpdate, setupObj);             
             for(Decimal i =0; i < setUpObjLst.size();  i++ )
             {
                 
                 if(setupObj.Sequence_Order__c -1 == (i) && isDuplicate)
                 {    
                     valueDeliveryLst.add(setupObj); 
                     setupObj.Sequence_Order__c  = sequenceNo;
                     isDuplicate = false;  
                     sequenceNo++;           
                 }   
                 Value_Delivery_Setup__c Obj =  setUpObjLst.get(Integer.ValueOf(i));
                 
                 Obj.Sequence_Order__c = sequenceNo;
                 sequenceNo++;
                 valueDeliveryLst.add(Obj);
             }
             if(isDuplicate)
             {
                  setupObj.Sequence_Order__c = sequenceNo;
                  valueDeliveryLst.add(setupObj); 
             }
             
          }
          else
          {
          
                valueDeliveryLst.add(setupObj);           
          }
          try
          {
              upsert valueDeliveryLst;
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
    }          
    /**
     * Get Value Delivery Setup Data 
     *
     */  
    private List<Value_Delivery_Setup__c> getSetUpData(Boolean isUpdate, Value_Delivery_Setup__c setupObj)
    {
        if(isUpdate)
        {
            return [select  Sequence_Order__c  from Value_Delivery_Setup__c  where Value_Delivery_Session__c = :setupObj.Value_Delivery_Session__c and   Project_Phase__c  = :setupObj.Project_Phase__c and id != :setupObj.id  order by Sequence_Order__c  ];
        }        
        return [select  Sequence_Order__c  from Value_Delivery_Setup__c  where  Value_Delivery_Session__c = :setupObj.Value_Delivery_Session__c and  Project_Phase__c  = :setupObj.Project_Phase__c   order by Sequence_Order__c  ];
    }    
    /**
     * Get all Bussiness Objective
     *
     */  
    public List<Value_Delivery_Setup__c> overViewDetail
    {
        get
        {
            String selectedSession =  SaaSUtility.getLoggedInValueSession();          
            List<Value_Delivery_Setup__c>  objectiveAttendies = [Select id, Component_Title__c ,name, (select id, Completed__c,Option_Description__c  from Value_Delivery_Objectives_Options__R  order by Sequence_No__c) from Value_Delivery_Setup__c where Project_Phase__c = :projectPhase and Value_Delivery_Session__c = :selectedSession order by Sequence_Order__c Nulls Last];
            return objectiveAttendies;
        }
        set;        
    }    
   /**
    * Get Value Delivery Session Options during edit and Delete 
    *
    */ 
    public void getValueDeliveryOption()
    {
         success  = false;
         String itemkey= SaaSUtility.getURLParameter(SaaSTextConstant.VALUE_DELIVERY_OPTIONS_ID_URL_PARAM); 
         system.debug('----itemkey=='+itemkey);   
         valueDelOptionObj  = [ select Objectives_and_Attendees_for_Participant__c   ,Sequence_No__c,id,Completed__c,Option_Description__c from Value_Delivery_Objectives_Options__c  WHERE id =:itemkey];                                                               
         system.debug('====tem=='+valueDelOptionObj);
         if(valueDelOptionObj.Sequence_No__c != null)
             optionSequenceNo = Integer.valueOf(valueDelOptionObj.Sequence_No__c);
    }
    /**
    * Delete Value Delivery options
    *
    */ 
    public void deleteValueDeliveryOption()
    {
        try
        {
            if(valueDelOptionObj !=null)
            {
                 delete valueDelOptionObj;
            }
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
    }
    
   /**
    *  Update Value Delivery options 
    *
    */     
    public void updateValueDeliveryOption()
    {
       success  = false;
       String errMsg = validateValueDeliveryOption(valueDelOptionObj);       
       if(errMsg != null)
       {
           SaaSUtility.displayErrMsg( errMsg );
            return ;
       } 
       try
       {              
          // valueDelOptionObj.Sequence_No__c = optionSequenceNo; 
           //upsert valueDelOptionObj;
           //optionSequenceNo=  0;
           reArrangeSection(valueDelOptionObj,true);           
           success = true;
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
      
    }
   /**
    *  Validate Bussiness objective Option 
    *
    */ 
    private String validateValueDeliveryOption(Value_Delivery_Objectives_Options__c obj)
    {
        String errMsg = null;
        if(obj.Option_Description__c == SaaSTextConstant.EMPTY_STRING ||     obj.Option_Description__c == null)
        {
           errMsg  =  SaaSTextConstant.BUSSINESS_OPTION_TITLE_EMPTY_ERR_MSG; 
        }
        return errMsg ;
    }
    
    /**
    *  Get Value Delivery Bussiness Objective during edit and delete 
    *
    */      
    public void getValueDeliveryObjective()
    {
         success  = false;         
         String itemkey= SaaSUtility.getURLParameter(SaaSTextConstant.VALUE_DELIVERY_SETUP_ID_URL_PARAM );
         valueDeliveryObjectiveObj   = [ select Component_Title__c ,Project_Phase__c  , Value_Delivery_Session__c,Sequence_Order__c ,Name ,id from Value_Delivery_Setup__c  WHERE id =:itemkey];                                                               
         if(  valueDeliveryObjectiveObj.Sequence_Order__c != null)
         {
             objectiveSequenceNo = Integer.valueOf(valueDeliveryObjectiveObj.Sequence_Order__c); 
         }
         System.debug('----objectiveSequenceNo '+objectiveSequenceNo  );
                  
    }
   /**
    *  Delete Value Delivery Objective
    *
    */ 
    public void deleteValueDeliveryObjective()
    {
        try
        {
            if(valueDeliveryObjectiveObj   !=null)
            {
                 delete valueDeliveryObjectiveObj   ;
            }
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
    }
    
   /**
    * Insert Value Delivery Setup record 
    *
    */   
    public void addValueDelivery()
    {
       List<Value_Delivery_Objectives_Options__c> optionsLst = null;
       isInsert  = false;
       String errMsg = validateBusinessObjective(valueDeliveryObj, true);       
       if(errMsg != null)
       {          
            SaaSUtility.displayErrMsg(errMsg);
            return ;
       }     
//       valueDeliveryObj.Sequence_Order__c = objectiveSequenceNo ;          
       valueDeliveryObj.Project_Phase__c  = projectPhase;
       valueDeliveryObj.Name = pageName ;
       valueDeliveryObj.Value_Delivery_Session__c = SaaSUtility.getLoggedInValueSession();
       reArrangeSection(valueDeliveryObj, false);  
       optionsLst = createBusinessOptions(bussinesOnjectiveOption,valueDeliveryObj.id );
       insert optionsLst;
       bussinesOnjectiveOption =  null;
       valueDeliveryObj = new Value_Delivery_Setup__c();
       valueDeliveryObj.Value_Delivery_Session__c = SaaSUtility.getLoggedInValueSession();
       isInsert = true;
       objectiveSequenceNo  = 0;
    }
    
   /**
    *  While Creating the new Business Overview Section Split the contents to Bullet points.
    * 
    * @ return Business options
    *
    */       
    private List<Value_Delivery_Objectives_Options__c> createBusinessOptions(String options,String parentID)
    {
         List<Value_Delivery_Objectives_Options__c> optionsLst = new List<Value_Delivery_Objectives_Options__c>();
         integer i = 1;
         for(String str : options.split(SaaSTextConstant.NEW_LINE_REG_EX))
         {
             if(str!= null && str.trim()!= SaaSTextConstant.EMPTY_STRING)
             {
                 Value_Delivery_Objectives_Options__c obj = new Value_Delivery_Objectives_Options__c();
                 obj.Objectives_and_Attendees_for_Participant__c  = parentID;
                 obj.Option_Description__c = str;
                 obj.Sequence_No__c=i;
                 i++;
                 optionsLst.add(obj);
             }        
         } 
         return optionsLst;  
    }   
    /**
     *  Read Url Paremter for inserting Busisness option
     *
     */ 
    public void assignBusinessObjectiveID()
    {
        success  = false;
        String itemkey= SaaSUtility.getURLParameter(SaaSTextConstant.VALUE_DELIVERY_SETUP_ID_URL_PARAM);   
        bussinessObjectID =  itemkey;
    }
    /**
     *  Insert New Business Option
     *
     */     
    public void insertBusinessOption()
    { 
        success  = false;
        String errMsg = validateValueDeliveryOption(newObjectivesOptions );       
        if(errMsg != null)
        {
           SaaSUtility.displayErrMsg( errMsg );
            return ;
        } 
        try
        {  
           newObjectivesOptions.Objectives_and_Attendees_for_Participant__c =   bussinessObjectID;            
           //newObjectivesOptions.Sequence_No__c = optionSequenceNo;            
           //upsert newObjectivesOptions;
           reArrangeSection(newObjectivesOptions,false);
           
           optionSequenceNo=  0;
           success = true;
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
        newObjectivesOptions = new Value_Delivery_Objectives_Options__c();   
    } 
    
    /**
     * Get all business options.
     *
     */
    private List<Value_Delivery_Objectives_Options__c  > getBusinessOptions(Boolean isUpdate, Value_Delivery_Objectives_Options__c  options)
    {
        if(isUpdate)
        {
            return [select  Objectives_and_Attendees_for_Participant__c  ,Sequence_No__c from Value_Delivery_Objectives_Options__c   where Objectives_and_Attendees_for_Participant__c = :options.Objectives_and_Attendees_for_Participant__c  and id != :options.id  order by Sequence_No__c ];
        }        
        return [select Objectives_and_Attendees_for_Participant__c  ,Sequence_No__c from Value_Delivery_Objectives_Options__c   where Objectives_and_Attendees_for_Participant__c = :options.Objectives_and_Attendees_for_Participant__c   order by Sequence_No__c ];
    } 
    
     /**
     * Rearrange the Section based on the input
     *
     */
     private void reArrangeSection(Value_Delivery_Objectives_Options__c  businessOpt, Boolean isUpdate)
     {  
         Boolean isDuplicate = true;
         Decimal sequenceNo = 1;
         List<Value_Delivery_Objectives_Options__c  > valueDeliveryLst  = new List<Value_Delivery_Objectives_Options__c  >(); 
         
         if(businessOpt.Sequence_No__c !=null )
         {
             List<Value_Delivery_Objectives_Options__c> setUpObjLst = getBusinessOptions(isUpdate, businessOpt);             
             for(Decimal i =0; i < setUpObjLst.size();  i++ )
             {
                 
                 if(businessOpt.Sequence_No__c -1 == (i) && isDuplicate)
                 {    
                     valueDeliveryLst.add(businessOpt); 
                     businessOpt.Sequence_No__c = sequenceNo;
                     isDuplicate = false;  
                     sequenceNo++;           
                 }   
                 Value_Delivery_Objectives_Options__c  Obj =  setUpObjLst.get(Integer.ValueOf(i));
                 
                 Obj.Sequence_No__c = sequenceNo;
                 sequenceNo++;
                 valueDeliveryLst.add(Obj);
             }
             if(isDuplicate)
             {
                  businessOpt.Sequence_No__c = sequenceNo;
                  valueDeliveryLst.add(businessOpt); 
             }
             
          }
          else
          {
          
                valueDeliveryLst.add(businessOpt);           
          }
          try
          {
              upsert valueDeliveryLst;
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
    }             
}