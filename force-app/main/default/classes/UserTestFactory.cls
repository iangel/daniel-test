@isTest
public with sharing class UserTestFactory {
    /*Getting Current LoggedIn User TimeZone*/
    public static String getLoggedInUserTimeZoneSidKey(){
        User loggedInUser = new User();
        loggedInUser = [select TimeZoneSidKey from User where id =: UserInfo.getUserId() limit 1];
        return loggedInUser.TimeZoneSidKey;
    }
    /*Getting Profile*/
    public static Profile createProfile(String profNm) {
        Profile agentprof = [select id from profile where name=:profNm];
        return agentprof;
    }
  
    /*Creating Test User*/
    public static User createUser(Integer i, id profileId) {
        String timeZonevalue = getLoggedInUserTimeZoneSidKey();
        User usr = new User(
        FirstName = NS_StaticVariablesUtility.NAME+i,
        LastName = NS_StaticVariablesUtility.NAME,
        Email = NS_StaticVariablesUtility.NAME+'@test.com',
        Alias = NS_StaticVariablesUtility.NAME + i,
        Username = NS_StaticVariablesUtility.NAME + i + '@test.com',
        LocaleSidKey = 'en_US',
        TimeZoneSidKey = timeZonevalue,
        ProfileID =  profileId,
        LanguageLocaleKey = 'en_US',
        EmailEncodingKey  = 'UTF-8',
        Associated_Business_Unit__c	='OSS',    
        NS_Primary_Queue__c='OSS North');
        insert usr;
        return usr;
    }   
    /*Creating Test readonly User*/
    public static User createUserReadonly(Integer i, id profileId) {
        String timeZonevalue = getLoggedInUserTimeZoneSidKey();
        User usr = new User(
        FirstName = NS_StaticVariablesUtility.NAME+i,
        LastName = NS_StaticVariablesUtility.NAME,
        Email = NS_StaticVariablesUtility.NAME+'@testread.com',
        Alias = NS_StaticVariablesUtility.NAME + i,
        Username = NS_StaticVariablesUtility.NAME + i + '@testread.com',
        LocaleSidKey = 'en_US',
        TimeZoneSidKey = timeZonevalue,
        ProfileID =  profileId,
        LanguageLocaleKey = 'en_US',
        EmailEncodingKey  = 'UTF-8',
        Associated_Business_Unit__c	='OSS',    
        NS_Primary_Queue__c='OSS North');
        insert usr;
        return usr;
    }   
    public static User createNonOSSUser(Integer i, id profileId) {
        String timeZonevalue = getLoggedInUserTimeZoneSidKey();
        User usr = new User(
        FirstName = NS_StaticVariablesUtility.NAME+i,
        LastName = NS_StaticVariablesUtility.NAME,
        Email = NS_StaticVariablesUtility.NAME+'@test.com',
        Alias = NS_StaticVariablesUtility.NAME + i,
        Username = NS_StaticVariablesUtility.NAME + i + '@test.com',
        LocaleSidKey = 'en_US',
        TimeZoneSidKey = timeZonevalue,
        ProfileID =  profileId,
        LanguageLocaleKey = 'en_US',
        EmailEncodingKey  = 'UTF-8');//,
        //Associated_Business_Unit__c	='OSS',    
        //NS_Primary_Queue__c='Northern Region East (NRE)');
        insert usr;
        return usr;
    }
    
    public static User assignUserQueue(User usr){
      
      Group grp = new Group(Type='Queue', Name='OSS North');
      insert grp;
      QueueSObject que = new QueueSObject(SobjectType='Case', QueueId=grp.Id);
      insert que;
        
        Id userId = UserInfo.getUserId();
        
        Group g = [select Id from Group where Name='OSS North' AND Type = 'Queue' LIMIT 1];
        GroupMember member = new GroupMember();
		member.UserOrGroupId = userId;
		member.GroupId = g.Id;
        insert member;
        return usr;
    }
    
    public static User createAutoLeadUser(Integer i, id profileId) {
        String timeZonevalue = getLoggedInUserTimeZoneSidKey();
        Id RoleId = [SELECT Id FROM UserRole WHERE DeveloperName = 'Automotive_Leadership'].Id;
        User usr = new User(
        FirstName = NS_StaticVariablesUtility.NAME+i,
        LastName = NS_StaticVariablesUtility.NAME,
        Email = NS_StaticVariablesUtility.NAME+'@test.com',
        Alias = NS_StaticVariablesUtility.NAME + i,
        Username = NS_StaticVariablesUtility.NAME + i + '@test.com',
        LocaleSidKey = 'en_US',
        TimeZoneSidKey = timeZonevalue,
        ProfileID =  profileId,
        LanguageLocaleKey = 'en_US',
        EmailEncodingKey  = 'UTF-8',
        Associated_Business_Unit__c	='Automotive', 
        UserRoleId = RoleId,
        NS_Primary_Queue__c='Automotive - Bad Order');
        insert usr;
        return usr;
    }
}