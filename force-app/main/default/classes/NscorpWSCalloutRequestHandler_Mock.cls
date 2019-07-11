/*
This class provides Mock reponse for NS webservice Implementation
Developer    : Accenture Solutions
Date         : 1-24-2018
*/

@isTest
Global class NscorpWSCalloutRequestHandler_Mock implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader(NS_StaticVariablesUtility.Content_Type, NS_StaticVariablesUtility.contentType);
        System.debug('Request getHeader:'+req);
        if(req.getHeader(NS_StaticVariablesUtility.SOAPAction).equals(NS_StaticVariablesUtility.TYES_getCustomerSummary_Action)){
            res.setBody(NS_WsRequestBodyFactory.getCustomerSummaryMockResBody());        
            res.setStatusCode(NS_StaticVariablesUtility.SuccessStatusCode);
        }
        
        if(req.getHeader(NS_StaticVariablesUtility.SOAPAction).equals(NS_StaticVariablesUtility.LOPA_Action )){
            res.setBody(NS_StaticVariablesUtility.getLOPAMockResBody());        
            res.setStatusCode(NS_StaticVariablesUtility.SuccessStatusCode);
        }
        
        if(req.getHeader(NS_StaticVariablesUtility.SOAPAction).equals(NS_StaticVariablesUtility.CustomerRouteReport_Action )){
            res.setBody(NS_StaticVariablesUtility.getCustomerRouteMockResBody());        
            res.setStatusCode(NS_StaticVariablesUtility.SuccessStatusCode);
        }
        
        if(req.getHeader(NS_StaticVariablesUtility.SOAPAction).equals(NS_StaticVariablesUtility.TransitExceptionQueueCountsAction)){
            res.setBody(NS_StaticVariablesUtility.getMockTransitExCountResBody());        
            res.setStatusCode(NS_StaticVariablesUtility.SuccessStatusCode);
        }
        
        if(req.getHeader(NS_StaticVariablesUtility.SOAPAction).equals(NS_StaticVariablesUtility.TransitExceptionQueueDetailAction)){
            res.setBody(NS_StaticVariablesUtility.getMockTransitExDetailResBody());        
            res.setStatusCode(NS_StaticVariablesUtility.SuccessStatusCode);
        }      
        
        if(req.getHeader(NS_StaticVariablesUtility.SOAPAction).equals(NS_StaticVariablesUtility.VDNMaintenanceAction)){
            res.setBody(NS_StaticVariablesUtility.getVDNResponseBody());        
            res.setStatusCode(NS_StaticVariablesUtility.SuccessStatusCode);
        }      
         if(req.getHeader(NS_StaticVariablesUtility.SOAPAction).equals(NS_PipeLineData.PIPELINE_ACTION)){
            res.setBody(NS_WsRequestBodyFactory.getPipeLineMockResponseAEMS());        
            res.setStatusCode(NS_StaticVariablesUtility.SuccessStatusCode);
        }  
        if(req.getHeader(NS_StaticVariablesUtility.SOAPAction).equals(NS_StaticVariablesUtility.a1)){
            res.setBody(NS_StaticVariablesUtility.getCustomerRouteMockResBody());        
            res.setStatusCode(NS_StaticVariablesUtility.SuccessStatusCode);
        } 
        if(req.getHeader(NS_StaticVariablesUtility.SOAPAction).equals(NS_IntegrationUtility_Teams.CAR_REQ_SUMMARY_ACTION)){
            
            res.setBody(NS_WsRequestBodyFactory.getCarRequestMockResBody());        
            res.setStatusCode(NS_StaticVariablesUtility.SuccessStatusCode);
        } 
        if(req.getHeader(NS_StaticVariablesUtility.SOAPAction).equals(NS_StaticVariablesUtility.a_LOPA)){
            res.setBody(NS_StaticVariablesUtility.getLOPAMockResBody());        
            res.setStatusCode(NS_StaticVariablesUtility.SuccessStatusCode);
        } 
        if(req.getHeader(NS_StaticVariablesUtility.SOAPAction).equals(NS_IntegrationUtility.MOCK_ACTION)){
            res.setBody(NS_WsRequestBodyFactory.getMockResponse());        
            res.setStatusCode(NS_StaticVariablesUtility.SuccessStatusCode);
        } 
        if(req.getHeader(NS_StaticVariablesUtility.SOAPAction).equals(NS_OnlineCustomerContactTEP.TEPCONTACTUPDATEACTION)){
            res.setBody(NS_WsRequestBodyFactory.getMockResponse());        
            res.setStatusCode(NS_StaticVariablesUtility.SuccessStatusCode);
        } 
        return res;
    }
}