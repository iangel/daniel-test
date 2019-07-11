@isTest
private class NS_CarRequestSummaryTest {
    
    /*Constants*/
    public static final string USER_REP = 'OSS Rep';
    public final  static String GARDN ='GARDN';
    
     @isTest
    static void testCarRequestSummary() {
        Profile agent = UserTestFactory.createProfile(USER_REP);
       	User testUser = UserTestFactory.createUser(25,agent.Id);  
        system.runAs(testUser){
        Account acc = AccountTestFactory.createOnlineServiceAccountRecord(NS_StaticVariablesUtility.Name);            
        String accId= (String)acc.id;
        NS_IntegParams datum= new NS_IntegParams();
        datum.setClassCode(acc.NS_ClassCode__c);
        datum.setStationCode(GARDN);
        datum.setUserId(UserInfo.getUserId());
        Date myDate = Date.today();
		Date weekStartSunday = myDate.toStartofWeek();
        /* For NS Requirement, Start of week is defined as Monday*/
        Date weekStart=weekStartSunday.addDays(1);
        System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
        system.test.StartTest();
        NS_CarRequestSummary testObj= new NS_CarRequestSummary();
        
        System.assert(testObj.invokeCallout(datum)<>null);
       System.assert(testObj.carRequestResponseParser(NS_WsRequestBodyFactory.getCarRequestMockResBody(),weekStart)<>null);    
        System.test.StopTest();
        }
    }

}