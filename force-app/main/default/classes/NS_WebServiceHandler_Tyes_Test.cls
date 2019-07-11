/*
This class provides Mock reponse for NS webservice Implementation
Developer    : Accenture Solutions
Date         : 1-24-2018
*/

@isTest
private class NS_WebServiceHandler_Tyes_Test{
    @isTest static void testgetCustomerSummary() {
        System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
        NS_WebServiceHandler_Tyes.invoke_TYES_getCustomerSummary('jkd4b','F01','148H');
    }
    
    @isTest static void testLOPA() {
        System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
        NS_WebServiceHandler_Tyes.invoke_LOPA('jkd4b','T25','659');
    }
    
    @isTest static void testRouteReport() {
        System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
        NS_WebServiceHandler_Tyes.invoke_CustomerRouteReport('jkd4b','B52','09141');
    }
    
     @isTest static void testTransitExceptionCount() {
        System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
        NS_WebServiceHandler_Tyes.invoke_TransitExceptionCount('jkd4b','B52','09141');
    }
    
    @isTest static void testTransitExceptionDetail() {
        System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
        NS_WebServiceHandler_Tyes.invoke_TransitExceptionDetail('jkd4b','B52','09141','equipmentInit','equipmentNr','waybillSrNr');
    }
       
}