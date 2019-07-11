/** 
 *  Author : Accenture 
 *  Description : Controller class for SaaDCreateRelease
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  05\06\2015        created 
 *
 */
public class SaaSUtility
{
   /**
    *  Returns a dynamic SOQL statement for the whole object, includes only creatable fields since we will be inserting a cloned result of this query 
    * @return  soql
    *
    */   
    public static string getCreatableFieldsSOQL(String objectName, String whereClause)
    {           
        String selects = SaaSTextConstant.EMPTY_STRING ;                   
        if (whereClause == null || whereClause ==SaaSTextConstant.EMPTY_STRING){ return null; } 
          
        // Get a map of field name and field token 
        Map<String, Schema.SObjectField> fMap = Schema.getGlobalDescribe().get(objectName.toLowerCase()).getDescribe().Fields.getMap(); 
        Set<string> selectFields = new Set<string>(); 
        selectFields.add('Name');  
        if (fMap != null){ 
            for (Schema.SObjectField ft : fMap.values()){ // loop through all field tokens (ft) 
                Schema.DescribeFieldResult fd = ft.getDescribe(); // describe each field (fd) 
                if (fd.isCreateable()){ // field is creatable 
                    selectFields.add(fd.getName()); 
                } 
            } 
        } 
          
        if (!selectFields.isEmpty()){ 
            for (string s:selectFields){ 
                selects += s + ','; 
            } 
            if (selects.endsWith(',')){selects = selects.substring(0,selects.lastIndexOf(','));} 
              
        }           
        return 'SELECT ' + selects + ' FROM ' + objectName + ' WHERE ' + whereClause;           
    }   
   /**
    *  Returns Record type ID 
    * @return  record type ID 
    *
    */
    public static String getRecordTypeID(String sobjectType , String developerName)
    {
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType= :sobjectType  AND developerName=:developerName LIMIT 1];    
        return rt.id+'';
    }
   /**
    *  Returns Record type Developer Name
    * @return  Returns Record type Developer Name
    *
    */
     public static String getRecordTypeDeveloperName(String recordTypeId)
     {
        String developerNAme= '';        
        List<RecordType> recTypeLst = [SELECT Id,DeveloperNAme FROM RecordType WHERE id = :recordTypeId ];    
        if(recTypeLst.size() > 0)
        {
            developerNAme = recTypeLst.get(0).DeveloperNAme;
        }
        return developerNAme;
     }
    
    
    /**
    *  Diaplays Error msg on the Vf page 
    *
    */
    public static void displayErrMsg(String msg)
    {
        SaaSPageMessages.addMessage(new SaaSPageMessages.PageMessage(SaaSPageMessages.Severity.WARN,  msg));                                    
    }    
   /**
    *  Diaplays Sucess msg on the Vfpage 
    *
    */
    public static void displaySuccessMsg(String msg)
    {
        SaaSPageMessages.addMessage(new SaaSPageMessages.PageMessage(SaaSPageMessages.Severity.confirm,  msg));                                    
    }    
    
   /**
    *  Return True if client team is loged in to application 
    *
    */    
    public static Boolean isAccentureRepresentative()
    {
        Boolean temp = true;
        String loggedInUserPid = Userinfo.getProfileID();
        List<Profile> profileLst  = [Select Name from Profile where id = :Userinfo.getProfileID()  and Name = :System.label.SaaS_Client_Value_Delivery_Team_Profile_Name ];       
        if(profileLst.size() > 0)
        {        
            temp = false;
        }            
        return temp;
    }
   /**
    *  Returns Url parameter value 
    *
    */    
    public static String getURLParameter(String key)
    {
        return Apexpages.currentpage().getparameters().get(key);
    }
    
   /**
    *  Deletes given sobject 
    *
    */        
    public static String deleteSobject(List<Sobject> delObj)
    {
       String errMsg = null;
        try
        {
            delete delObj;          
        }
        catch(DmlException e )            
        {
            errMsg = e.getDmlMessage(0);    
        }
        catch(Exception e)
        {
             errMsg = SaaSTextConstant.EXCEPTION_ERR_MSG ;                
        }      
        return errMsg;        
    }    
    /**
    *  Inserts given sobject 
    *
    */      
    public static String insertSobject(List<Sobject> insertSobj)
    {
       String errMsg = null;
        try
        {
            upsert insertSobj;          
        }
        catch(DmlException e )            
        {
            errMsg = e.getDmlMessage(0);    
        }
        catch(Exception e)
        {
             errMsg = SaaSTextConstant.EXCEPTION_ERR_MSG ;                
        }      
        return errMsg;        
    }    
    
    /*
    public static List<String> getMultiSelectPickListValue(String objNameApiName , String fieldApiName)
    {
        List<String> lstPickvals=new List<String>();
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(objNameApiName );//From the Object Api name retrieving the SObject
        Sobject Object_name = targetType.newSObject();
        Schema.sObjectType sobject_type = Object_name.getSObjectType(); //grab the sobject that was passed
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); //describe the sobject
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); //get a map of fields for the passed sobject
        List<Schema.PicklistEntry> pick_list_values = field_map.get(fieldApiName).getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
    
        for (Schema.PicklistEntry a : pick_list_values) 
        { 
            //for all values in the picklist list
            lstPickvals.add(a.getValue());//add the value  to our final list
        }
        return lstPickvals;
    }
    
    public Set<String> getSelectedPickList(String selValue)
    {
        Set<String> selValSet = new Set<String>();
                
        if(selValue!= null && selValue.trim() != '')
        {
            for(String strObj :selValue.split(';'))
            {
                selValSet.add(strObj);    
            }           
        }        
        return selValSet;         
    
    }
    */
    
   /**
    * 
    * Get Logged in user Value Delivery Session *
    */         
    public static String getLoggedInValueSession()
    {
       Value_Delivery_User_Config__c valueDeliveryObj =  Value_Delivery_User_Config__c.getInstance(Userinfo.getUserID());
        if(valueDeliveryObj != null)
        {
            return valueDeliveryObj.Selected_Session__c; 
        } 
       return null;
    }
     /**
    *
    * this is for  Delivery Setup..
    */
    Public Static Value_Delivery_Setup__c getDelieverySetup(Id ParentID,String Project_phase, string component_title){
    
     Value_Delivery_Setup__c  deliverySetup = new Value_Delivery_Setup__c ();
     deliverySetup.Value_Delivery_Session__c =ParentID;
     deliverySetup.Project_Phase__c = Project_phase ;
     deliverySetup.Component_Title__c=component_title;
     return deliverySetup ;
    
    }
    /**
    *
    * this is for  objectives options..
    */
    Public Static Value_Delivery_Objectives_Options__c getDelieveryObjectives(Id ParentID,String description){
    
     Value_Delivery_Objectives_Options__c objectivesOptions = new Value_Delivery_Objectives_Options__c();
     objectivesOptions.Objectives_and_Attendees_for_Participant__c =  ParentID;
     objectivesOptions.Option_Description__c =description;
     return objectivesOptions;
    
    }
    /**
     *  Get Session Project Name 
     *
     */ 
     public static String getValueSessionProjectName()
     {
         String prjName  = '';
         List<Value_Delivery_Session__c> releaseLst = [Select Releases__r.name from Value_Delivery_Session__c  where  id = :getLoggedInValueSession()];
         if(releaseLst.size() > 0)    
         {
             prjName =    releaseLst.get(0).Releases__r.name; 
         }
         return prjName;
     }
    
    
   /**
    *  Save Logged in Value Delivery Session 
    * 
    */          
    public static String getLoggedInValueSession(String sessionID)
    {
       Value_Delivery_User_Config__c valueDeliveryObj =  Value_Delivery_User_Config__c.getInstance(Userinfo.getUserID());
       
        if(valueDeliveryObj != null)
        {
            valueDeliveryObj.Selected_Session__c = sessionID; 
        
        }
        else 
        {
            valueDeliveryObj = new Value_Delivery_User_Config__c();
            valueDeliveryObj.SetupOwnerId = Userinfo.getUserID();
            valueDeliveryObj.Selected_Session__c     = sessionID;  
        }
        upsert valueDeliveryObj;
       return null;
    }
   /**
    *  Generate the Hash code 
    *  @param Count to generate the hash code.
    *  @return String-Hash code 
    */
    public static String generateHash(Integer count) 
    {
        String chars = SaaSTextConstant.CHARS;
        String hash =SaaSTextConstant.EMPTY_STRING; 
        try
        {
            for (integer i = 0; i < count; i++) {
                Integer rnum = Math.floor(Math.random() * chars.length()).intValue();
                hash += chars.substring(rnum,rnum+1);
            }
        }
        catch(Exception e)
        {
            e.getMessage();
        }
            
        return hash;
    }
    
   /**
    *  Clear All Page Error Msg 
    * 
    *
    */
    public static void clearPageErrMsg()
    {
        ApexPages.getMessages().clear();
    }
    
}