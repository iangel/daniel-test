@isTest
private class NS_IntegrationUtility_TeamsTest {
 @isTest
    static void testNS_IntegrationUtility_Teams() {
	 system.test.StartTest();        
    System.assertNotEquals(null, NS_IntegrationUtility_Teams.prepareSignedBody(NS_WsRequestBodyFactory.getMockReqBody()));
         system.test.stopTest();
    }
}