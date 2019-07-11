public class SaaSPageTemplateCtrl 
{
    public String getUserPhotoUrl() 
    {
        list<user> userList = [select SmallPhotoUrl from user where id=:userinfo.getuserid()];
        return userList.get(0).SmallPhotoUrl ;
    }
    
      
    public List<Value_Delivery_Session_Outcomes__c> getDesginSessionOutcomes()
    {
        return [Select id, name, Phase__c from Value_Delivery_Session_Outcomes__c where Phase__c = 'Design' and Value_Delivery_Session__c = :SaaSUtility.getLoggedInValueSession()  ];        
    }
    
       public List<Value_Delivery_Session_Outcomes__c> getBuildSessionOutcomes()
    {
        return [Select id, name, Phase__c from Value_Delivery_Session_Outcomes__c where Phase__c = 'Build' and Value_Delivery_Session__c = :SaaSUtility.getLoggedInValueSession()  ];        
    }
    
      public List<Value_Delivery_Session_Outcomes__c> getInitiateSessionOutcomes()
    {
        return [Select id, name, Phase__c from Value_Delivery_Session_Outcomes__c where Phase__c = 'Initiate And Confirm' and Value_Delivery_Session__c = :SaaSUtility.getLoggedInValueSession()  ];        
    }
   
}