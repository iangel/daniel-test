@isTest
private class NS_WSCalloutTest {
    /*Constants*/
    public static final string USER_REP = 'OSS Rep';
    /*Expected Response*/
    public static final String EXPECTED_VALUE = '{"example":"Response"}';
    /* Mock Endpoint*/
    public static final String ENDPOINT = 'http://mockEndpoint.com';
    @isTest
    static void testCallout() {
        Profile agent = UserTestFactory.createProfile(USER_REP);
        User testUser = UserTestFactory.createUser(25,agent.Id);  
        system.runAs(testUser){
            System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
            system.test.StartTest();
            String body =NS_WsRequestBodyFactory.getMockReqBody();
            //body = NS_WSCallout.prepareSignedBody(body);
            String res = NS_WSCallout.sendRequest(ENDPOINT, NS_IntegrationUtility.POST_METHOD, NS_IntegrationUtility.CONTENT_TYPE,NS_IntegrationUtility.MOCK_ACTION, body);
            System.assertEquals(res, EXPECTED_VALUE);
            System.test.StopTest();
        }
    }
}