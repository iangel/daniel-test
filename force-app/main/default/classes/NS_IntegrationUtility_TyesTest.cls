@isTest
private class NS_IntegrationUtility_TyesTest {
 @isTest
    static void testNS_IntegrationUtility_Tyes() {
    System.assertNotEquals(null,NS_IntegrationUtility_Tyes.prepareSignedBody(NS_WsRequestBodyFactory.getMockReqBody()));
    }
}