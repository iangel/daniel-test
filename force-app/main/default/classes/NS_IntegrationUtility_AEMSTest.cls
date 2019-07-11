@isTest
private class NS_IntegrationUtility_AEMSTest {
 @isTest
    static void testNS_IntegrationUtility_AEMS() {
	 system.test.StartTest();        
    System.assertNotEquals(null, NS_IntegrationUtility_AEMS.prepareSignedBody(NS_WsRequestBodyFactory.getMockReqBody()));
         system.test.stopTest();
    }
}