@isTest
private class NS_PipeLineDataTest  {
    /*Constants*/
    public static final string USER_REP = 'OSS Rep';
    /*Constants*/
    public static final string NS = 'NS';
    @isTest
    static void testPipeLineData() {
        Profile agent = UserTestFactory.createProfile(USER_REP);
       	User testUser = UserTestFactory.createUser(25,agent.Id);
        system.runAs(testUser){
        Account acc = AccountTestFactory.createOnlineServiceAccountRecord(NS_StaticVariablesUtility.Name);            
        String accId= (String)acc.id;
            System.debug('acc id:'+acc.id);
        NS_IntegParams datum= new NS_IntegParams();
        datum.setClassCode(acc.NS_ClassCode__c);
        datum.setServingRoad(NS);
        datum.setStationCode(NS_PipeLineData.GARDN);
        datum.setUserId(UserInfo.getUserId());
        System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
        system.test.StartTest();
        NS_PipeLineData testObj= new NS_PipeLineData();
        System.assert(testObj.invokeCallout(datum)<>null);
        System.assert(testObj.responseParser(NS_WsRequestBodyFactory.getPipeLineMockResponseAEMS())<>null);    
        System.test.StopTest();
        }
    }
    
}