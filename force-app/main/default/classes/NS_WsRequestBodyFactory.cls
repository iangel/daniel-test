/*======================================================================================================
* @Class Name : NS_WsRequestBodyFactory
* @author : Accenture
* @Purpose: This class serves as a factory to prepare body for making HTTP callouts.
* @created date: 09-01-2018
* @Change Logs:                                 
----------------------------------------------------------------------------------------------------------
Developer name        Date          Description        
----------------------------------------------------------------------------------------------------------
@Arjun Ghosh          09-01-2019    Request No.   , Phase-II
==========================================================================================================*/
public class NS_WsRequestBodyFactory{
    /*Customer Summary body */   
    public Final Static String tyes = 'http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity';
    public static String resetUserIdOnNull(String uId){
        if(uId == null || uId == ''){
            uId = 'SFDC1';    
        } 
        return uId;
    }
     public static String getLOPAReqBody(String uId, String cCode, String sCode){
        String body = '<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:tyes="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity">';
        body += '<tem:GetLOPAMetricsReport>';
        body += '<tem:request>';
        body += '<tyes:UserId>'+resetUserIdOnNull(uId)+'</tyes:UserId>';
        body += '<tyes:ClassCode>'+cCode+'</tyes:ClassCode>';//T25
        body += '<tyes:StationCode>'+sCode+'</tyes:StationCode>';//659
        body += '</tem:request>';
        body += '</tem:GetLOPAMetricsReport>';
        body += '</soapenv:Body>';        
        return body;
    }
     
     public static String getTransitExCountReqBody(String uId, String cCode, String sCode){
        String body = '<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:tyes="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity">';
        body += '<tem:GetTransitExceptionQueueCounts>';
        body += '<tem:request>';
        body += '<tyes:UserId>'+resetUserIdOnNull(uId)+'</tyes:UserId>';
        body += '<tyes:ClassCode>'+cCode+'</tyes:ClassCode>';//F01
        body += '<tyes:StationCode>'+sCode+'</tyes:StationCode>';//148H
        body += '</tem:request>';
        body += '</tem:GetTransitExceptionQueueCounts>';
        body += '</soapenv:Body>';
        return body;
    }
          /* ================================================
* @Method Name : getCarRequestBody
* @author id: arjun.c.ghosh@accenture.com
* @Purpose: This method is used to create the request body Cryto Sign it and remove the X.509 tags from it for CAR_REQUEST_SERVICE(TEAMS) only
* @Parameters: String classcode, String Operating Station code, String Serving Road, String Start Week Date
* @return: String
* @created date: 02-01-2019
==================================================*/ 
     public static String getCarRequestBody(String cCode, String oSCode, String sRoad, String startWeekDate, String userId){        
        String body = '<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" >';
        body += '<tem:GetCarRequestSummary>';
        body += '<tem:ClassCode>'+cCode+'</tem:ClassCode>';
        body += '<tem:OperationStation>'+oSCode+'</tem:OperationStation>';        
        body += '<tem:ServingRoad>'+sRoad+'</tem:ServingRoad>';
        body += '<tem:StartWeekDate>'+startWeekDate+'</tem:StartWeekDate>';
        body += '<tem:RacfId>'+ resetUserIdOnNull(userId)+'</tem:RacfId>';
        body += '</tem:GetCarRequestSummary>';
        body += '</soapenv:Body>';
        
        return body;
    }
    
    public static String getCarRequestMockResBody(){
        String carRequestMockRes = '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">';
    carRequestMockRes+='<s:Body>';
        carRequestMockRes+='<GetCarRequestSummaryResponse xmlns="http://tempuri.org/">';
            carRequestMockRes+='<GetCarRequestSummaryResult xmlns:a="http://schemas.datacontract.org/2004/07/NS.TEAMS.Web.Api.WCF.CarRequest.EmptyCarRequestService" xmlns:i="http://www.w3.org/2001/XMLSchema-instance">';
                carRequestMockRes+='<a:CarRequestSummaryList xmlns:b="http://schemas.datacontract.org/2004/07/NS.TEAMS.Domain.Models.CarRequest">';
                    carRequestMockRes+='<b:CarRequestSummary>';
                        carRequestMockRes+='<b:Accepted>40</b:Accepted>';
                        carRequestMockRes+='<b:CustomerPattern>COVERED HOPPER, SMALL CUBE</b:CustomerPattern>';
                        carRequestMockRes+='<b:Fulfilled>11</b:Fulfilled>';
                        carRequestMockRes+='<b:LoadFill>0</b:LoadFill>';
                        carRequestMockRes+='<b:MarketingPriorityRank>542</b:MarketingPriorityRank>';
                        carRequestMockRes+='<b:OrderFill>0</b:OrderFill>';
                        carRequestMockRes+='<b:Projected>0</b:Projected>';
                        carRequestMockRes+='<b:RequestFill>0</b:RequestFill>';
                        carRequestMockRes+='<b:Requested>40</b:Requested>';
                        carRequestMockRes+='<b:StartWeekDate>5/6/2019</b:StartWeekDate>';
                        carRequestMockRes+='<b:SurplusShortage>-29</b:SurplusShortage>';
                        carRequestMockRes+='<b:WeeklyFillTarget>50</b:WeeklyFillTarget>';
                    carRequestMockRes+='</b:CarRequestSummary>';
                carRequestMockRes+='</a:CarRequestSummaryList>';
                carRequestMockRes+='<a:RequestStatus>Success</a:RequestStatus>';
                carRequestMockRes+='<a:WarningIndicator />';
            carRequestMockRes+='</GetCarRequestSummaryResult>';
        carRequestMockRes+='</GetCarRequestSummaryResponse>';
    carRequestMockRes+='</s:Body>';
carRequestMockRes+='</s:Envelope>';
        
        return carRequestMockRes;
    } 
     public static String getTransitExDetailReqBody(String uId, String cCode, String sCode, String EquipmentInit, String EquipmentNr, String WaybillSrNr){
        String body = '<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:tyes="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity" xmlns:tyes1="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.TransitExceptionQueue">';
        body += '<tem:GetTransitExceptionQueueDetails>';
        body += '<tem:request>';
        body += '<tyes:UserId>'+resetUserIdOnNull(uId)+'</tyes:UserId>';
        body += '<tyes:ClassCode>'+cCode+'</tyes:ClassCode>';
        body += '<tyes:StationCode>'+sCode+'</tyes:StationCode>';
        body += '<tyes1:EqInit>'+EquipmentInit+'</tyes1:EqInit>';//MTTX
        body += '<tyes1:EqNr>'+EquipmentNr+'</tyes1:EqNr>';// 0000941468
        body += '<tyes1:WaybillSerNr>'+WaybillSrNr+'</tyes1:WaybillSerNr>';//6174184322
        body += '</tem:request>';
        body += '</tem:GetTransitExceptionQueueDetails>';
        body += '</soapenv:Body>';
        
        return body;
    }
    
     public static String getCustomerRouteReportReqBody(String uId, String cCode, String sCode){
        String body = '<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:tyes="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity">';
        body += '<tem:GetCustomerRouteReport>';
        body += '<tem:request>';
        body += '<tyes:UserId>'+resetUserIdOnNull(uId)+'</tyes:UserId>';//jkd4b
        body += '<tyes:ClassCode>'+cCode+'</tyes:ClassCode>';//B52
        body += '<tyes:StationCode>'+sCode+'</tyes:StationCode>';//09141        
        body += '</tem:request>';
        body += '</tem:GetCustomerRouteReport>';
        body += '</soapenv:Body>';
        
        return body;
    }
     public static String getCustomerSummaryReqBody(String uId, String cCode, String sCode){
        String body = '<soapenv:Body xmlns:soapenv="'+NS_IntegrationUtility.SOAP_NS+'" xmlns:tem="'+NS_IntegrationUtility.TEM+'" xmlns:tyes="'+tyes+'">';
        body += '<tem:GetCustomerSummary>';     
        body += '<tem:request>'; 
        body += '<tyes:UserId>'+resetUserIdOnNull(uId)+'</tyes:UserId>';         
        body += '<tyes:ClassCode>'+cCode+'</tyes:ClassCode>';         
        body += '<tyes:StationCode>'+sCode+'</tyes:StationCode>';
        body += '</tem:request>';
        body += '</tem:GetCustomerSummary>';
        body += '</soapenv:Body>';
        
        return body;
    }
       public static String getCustomerSummaryMockResBody(){
        String cusSumRes = '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">';
        cusSumRes += '<s:Body>';
        cusSumRes += '<GetCustomerSummaryResponse xmlns="http://tempuri.org/">';
        cusSumRes += '<GetCustomerSummaryResult xmlns:a="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity.CustomerSummary" xmlns:i="http://www.w3.org/2001/XMLSchema-instance">';
        cusSumRes += '<Status xmlns="http://schemas.datacontract.org/2004/07/Tyes.Web.SalesForce.Service.Entity">';
        cusSumRes += '<Code>0</Code>';
        cusSumRes += '<Message/>';
        cusSumRes += '</Status>';
        cusSumRes += '<a:BusinessName>FABRICATION PLANT</a:BusinessName>';
        cusSumRes += '<a:ClassCode>F01</a:ClassCode>';
        cusSumRes += '<a:EquipmentSummary>';
        cusSumRes += '<a:OnTrackDetails>';
        cusSumRes += '<a:EmptyCount>69</a:EmptyCount>';
        cusSumRes += '<a:Length>5479</a:Length>';
        cusSumRes += '<a:LoadCount>22</a:LoadCount>';
        cusSumRes += '<a:TotalCount>91</a:TotalCount>';
        cusSumRes += '<a:Weight>4230</a:Weight>';
        cusSumRes += '</a:OnTrackDetails>';
        cusSumRes += '</a:EquipmentSummary>';
        cusSumRes += '<a:NotifyStations xmlns:b="http://schemas.microsoft.com/2003/10/Serialization/Arrays">';
        cusSumRes += '<b:string>ATLANTA, GA</b:string>';
        cusSumRes += '</a:NotifyStations>';
        cusSumRes += '<a:Schedule>';
        cusSumRes += '<a:CustomerSummaryServiceSchedule>';
        cusSumRes += '<a:CutOffDayOfWeek>Monday</a:CutOffDayOfWeek>';
        cusSumRes += '<a:CutoffTimeDisplay>6:59 AM</a:CutoffTimeDisplay>';
        cusSumRes += '<a:ScheduleCloseTime>3:59 PM</a:ScheduleCloseTime>';
        cusSumRes += '<a:ScheduleDayOfWeek>Monday</a:ScheduleDayOfWeek>';
        cusSumRes += '<a:ScheduleOpenTime>7:59 AM</a:ScheduleOpenTime>';
        cusSumRes += '</a:CustomerSummaryServiceSchedule>';
        cusSumRes += '</a:Schedule>';
        cusSumRes += '<a:SpecialInstructions xmlns:b="http://schemas.microsoft.com/2003/10/Serialization/Arrays">';
        cusSumRes += '<b:string>GE-98 FAB JOB- SWITCH LIST 5/11/18&#xD;';
        cusSumRes += '</b:string>';
        cusSumRes +='<b:string>12-06-17 - ***DO NOT DELETE***&#xD;';
		cusSumRes += '</b:string>';
        cusSumRes += '</a:SpecialInstructions>';
        cusSumRes += '<a:StateAbbreviation>GA</a:StateAbbreviation>';
        cusSumRes += '<a:StationName>ATLANTA</a:StationName>';
        cusSumRes += '<a:SummaryBullets xmlns:b="http://schemas.microsoft.com/2003/10/Serialization/Arrays">';
        cusSumRes += '<b:string>Order for Placement</b:string>';
        cusSumRes += '<b:string>Operating Division - GEORGIA</b:string>';
        cusSumRes += '</a:SummaryBullets>';
        cusSumRes += '</GetCustomerSummaryResult>';
        cusSumRes += '</GetCustomerSummaryResponse>';
        cusSumRes += '</s:Body>';
        cusSumRes += '</s:Envelope>';
        
        return cusSumRes;
    }
    
    
    /*Debosmeeta- Request body for TEP server.
    */
    public static String ManageOnlineCustomerContactTEP(String uId, List<NS_OnlineCustomerContactTEP.ManageOnlineCustomerContactWrapperTEP> CustomerContactWrapperList){
        String body = '<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v1="http://www.nscorp.com/tep/customerchange/v1.0">';
        for(NS_OnlineCustomerContactTEP.ManageOnlineCustomerContactWrapperTEP mocw : CustomerContactWrapperList){
            body += '<v1:PublishContactRequest>';
            body += '<v1:Contact>';
            body += '<v1:ContactSourceName>'+ mocw.ContactSourceName+'</v1:ContactSourceName>';
            body += '<v1:ContactType>'+mocw.ContactType+'</v1:ContactType>';
            body += '<v1:DisplayName>'+mocw.DisplayName+'</v1:DisplayName>';
            body += '<v1:DisplayImage>'+mocw.DisplayImage+'</v1:DisplayImage>';
            body += '<v1:ContactUserId>'+mocw.ContactUserId+'</v1:ContactUserId>';
            body += '<v1:ContactRole>'+mocw.ContactRole+'</v1:ContactRole>';
            body += '<v1:ContactStatus>'+mocw.ContactStatus+'</v1:ContactStatus>';
            body += '<v1:NameTitle>'+mocw.NameTitle+'</v1:NameTitle>';
            body += '<v1:FirstName>'+mocw.FirstName+'</v1:FirstName>';
            body += '<v1:MiddleName>'+mocw.MiddleName+'</v1:MiddleName>';
            body += '<v1:LastName>'+mocw.LastName+'</v1:LastName>';
            body += '<v1:NameSuffix>'+mocw.NameSuffix+'</v1:NameSuffix>';
            body += '<v1:JobTitle>'+mocw.JobTitle+'</v1:JobTitle>';
            body += '<v1:ContactTimezone>'+mocw.ContactTimezone+'</v1:ContactTimezone>';
            body += '<v1:Comments>'+mocw.Comments+'</v1:Comments>';
            body += '<v1:UserId>'+resetUserIdOnNull(uId)+'</v1:UserId>';
            body += '<v1:SourceCode>'+mocw.SourceCode+'</v1:SourceCode>';
            body += '<v1:Confidentiality>'+mocw.Confidentiality+'</v1:Confidentiality>';
            body += '</v1:Contact>';
            if(mocw.PhoneNumber!=NS_OnlineCustomerContactTEP.BLANK){
                body += '<v1:ContactPhone>';
                body += '<v1:PhoneType>'+mocw.PhoneType+'</v1:PhoneType>';
                body += '<v1:PhonePriority>'+mocw.PhonePriority+'</v1:PhonePriority>';
                body += '<v1:PhoneNumber>'+mocw.PhoneNumber+'</v1:PhoneNumber>';
                body += '<v1:ProviderName>'+mocw.ProviderName+'</v1:ProviderName>';
                body += '<v1:Comments>'+mocw.PhoneComments+'</v1:Comments>';
                body += '</v1:ContactPhone>';
            }
            if(mocw.MobilePhoneNumber!=NS_OnlineCustomerContactTEP.BLANK){
                body += '<v1:ContactPhone>';
                body += '<v1:PhoneType>'+mocw.MobilePhoneType+'</v1:PhoneType>';
                body += '<v1:PhonePriority>'+mocw.MobilePhonePriority+'</v1:PhonePriority>';
                body += '<v1:PhoneNumber>'+mocw.MobilePhoneNumber+'</v1:PhoneNumber>';
                body += '<v1:ProviderName>'+mocw.MobileProviderName+'</v1:ProviderName>';
                body += '<v1:Comments>'+mocw.MobilePhoneComments+'</v1:Comments>';
                body += '</v1:ContactPhone>';
            }
            if(mocw.OtherPhoneNumber1!=NS_OnlineCustomerContactTEP.BLANK){
                body += '<v1:ContactPhone>';
                body += '<v1:PhoneType>'+mocw.OtherPhoneType1+'</v1:PhoneType>';
                body += '<v1:PhonePriority>'+mocw.OtherPhonePriority1+'</v1:PhonePriority>';
                body += '<v1:PhoneNumber>'+mocw.OtherPhoneNumber1+'</v1:PhoneNumber>';
                body += '<v1:ProviderName />';
                body += '<v1:Comments />';
                body += '</v1:ContactPhone>';
            }
            if(mocw.OtherPhoneNumber2!=NS_OnlineCustomerContactTEP.BLANK){
                body += '<v1:ContactPhone>';
                body += '<v1:PhoneType>'+mocw.OtherPhoneType2+'</v1:PhoneType>';
                body += '<v1:PhonePriority>'+mocw.OtherPhonePriority2+'</v1:PhonePriority>';
                body += '<v1:PhoneNumber>'+mocw.OtherPhoneNumber2+'</v1:PhoneNumber>';
                body += '<v1:ProviderName />';
                body += '<v1:Comments />';
                body += '</v1:ContactPhone>';
            }
            if(mocw.FaxPhoneNumber!=NS_OnlineCustomerContactTEP.BLANK){
                body += '<v1:ContactPhone>';
                body += '<v1:PhoneType>'+mocw.FaxPhoneType+'</v1:PhoneType>';
                body += '<v1:PhonePriority>'+mocw.FaxPhonePriority+'</v1:PhonePriority>';
                body += '<v1:PhoneNumber>'+mocw.FaxPhoneNumber+'</v1:PhoneNumber>';
                body += '<v1:ProviderName />';
                body += '<v1:Comments />';
                body += '</v1:ContactPhone>';
            }
            body += '<v1:ContactAddress>';
            body += '<v1:StreetAddressType>'+mocw.StreetAddressType+'</v1:StreetAddressType>';
            body += '<v1:Street_Address>'+mocw.Street_Address+'</v1:Street_Address>';
            body += '<v1:City>'+mocw.City+'</v1:City>';
            body += '<v1:State_Province_Region>'+mocw.State_Province_Region+'</v1:State_Province_Region>';
            body += '<v1:State_Province_Region_Abbreviation>'+mocw.State_Province_Region_Abbreviation+'</v1:State_Province_Region_Abbreviation>';
            body += '<v1:Country>'+mocw.Country+'</v1:Country>';
            body += '<v1:ZipCode>'+mocw.ZipCode+'</v1:ZipCode>';
            body += '<v1:Comments>'+mocw.AddressComments+'</v1:Comments>';
            body += '</v1:ContactAddress>';
            body += '<v1:ContactMedia>';
            body += '<v1:MediaType>'+mocw.MediaType+'</v1:MediaType>';
            body += '<v1:Media>'+mocw.Media+'</v1:Media>';
            body += '<v1:Comments>'+mocw.MediaComments+'</v1:Comments>';
            body += '</v1:ContactMedia>';
            body += '<v1:ContactCommodity>';
            body += '<v1:CommodityType>'+mocw.CommodityType+'</v1:CommodityType>';
            body += '<v1:CommodityDesc>'+mocw.CommodityDesc+'</v1:CommodityDesc>';
            body += '</v1:ContactCommodity>';
            body += '</v1:PublishContactRequest>';
        }    
        body += '</soapenv:Body>';
        
        return body;
    }
       public static String getPipeLineReqBodyAEMS( String sCode){
        String body ='<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:aem="http://aemsws.integration.aems.nscorp.com">';
        body +=  '<aem:getEquipmentSummary>';
        body += '<aem:operatingStationCode>'+sCode+'</aem:operatingStationCode>';
         body+='</aem:getEquipmentSummary>';
        body +=  '</soapenv:Body>';
        return body;
    }
    public static String getPipeLineMockResponseAEMS(){
    String body ='<?xml version="1.0" encoding="UTF-8"?>';
	body+='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">';
   	body+='<soapenv:Body>';
    body+='<getEquipmentSummaryResponse xmlns="http://aemsws.integration.aems.nscorp.com">';
    body+='<getEquipmentSummaryReturn>';
    body+='<onsite>0</onsite>';
    body+='<receiving>0</receiving>';
    body+='</getEquipmentSummaryReturn>';
    body+='</getEquipmentSummaryResponse>';
    body+='</soapenv:Body>';
 	body+='</soapenv:Envelope>';
     return body;
    }
    public static String getMockReqBody(){
        String body ='<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:mock="http://mockUrl.com">';
        body +=  '<mock:parent>';
        body += '<mock:child>'+'</mock:child>';
         body+='</mock:parent>';
        body +=  '</soapenv:Body>';
        return body;
    }
    public static String getMockResponse(){
    String body = '{"example":"Response"}';
	
     return body;
    }
}