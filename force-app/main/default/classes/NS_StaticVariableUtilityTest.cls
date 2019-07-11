@isTest(SeeAllData=false)
private class NS_StaticVariableUtilityTest {
    @isTest
    static void nonServiceAccVDNMaintenanceTest(){
        NS_StaticVariablesUtility.nonServiceAccVDNMaintenance('uId', 'actionInd', 'vDNExten', 'phoneANI'); 
    }
    
    @isTest
    static void getVDNMaintenanceBodyTest(){
        NS_StaticVariablesUtility.getVDNMaintenanceBody('uId','actionInd','description','newVDNExten','oldVDNExten'); 
    }
    
    @isTest
    static void getCustomerVDNBodyTest(){
        NS_StaticVariablesUtility.getCustomerVDNBody('uId', 'cCode', 'sCode','vDNExt'); 
    }
    
    @isTest
    static void getTransitExCountReqBodyTest(){
        NS_StaticVariablesUtility.getTransitExCountReqBody('uId', 'cCode', 'sCode'); 
    }
    
    
    @isTest
    static void getTransitExDetailReqBodyTest(){
        NS_StaticVariablesUtility.getTransitExDetailReqBody('uId', 'cCode', 'sCode', 'equipmentInit', 'equipmentNr',  'waybillSrNr'); 
    }
    
    
    @isTest
    static void getCustomerSummaryReqBodyTest(){
        NS_StaticVariablesUtility.getCustomerSummaryReqBody('uId', 'cCode', 'sCode'); 
    }
    
    @isTest
    static void getLOPAReqBodyTest(){
        NS_StaticVariablesUtility.getLOPAReqBody('uId', 'cCode', 'sCode'); 
    }
    
    @isTest
    static void getCustomerRouteReportReqBodyTest(){
        NS_StaticVariablesUtility.getCustomerRouteReportReqBody('uId', 'cCode', 'sCode'); 
    }
    
    @isTest
    static void getCustomerSummaryMockResBodyTest(){
        NS_StaticVariablesUtility.getCustomerSummaryMockResBody(); 
    }
    
    @isTest
    static void getCustomerRouteMockResBodyTest(){
        NS_StaticVariablesUtility.getCustomerRouteMockResBody(); 
    }
    
    @isTest
    static void getLOPAMockResBodyTest(){
        NS_StaticVariablesUtility.getLOPAMockResBody(); 
    }
    
    
    @isTest
    static void getVDNResponseBodyTest(){
        NS_StaticVariablesUtility.getVDNResponseBody(); 
    }
    
    
    @isTest
    static void getValidFieldsForContactMaintenanceTest(){
        NS_StaticVariablesUtility.getValidFieldsForContactMaintenance(); 
    }
    
    @isTest
    static void getCustomerVDNBody_AbsoluteTest(){
        NS_StaticVariablesUtility.getCustomerVDNBody_Absolute('uId', 'cCode', 'sCode', 'VDNExt'); 
    }
    @isTest
    static void getMockTransitExCountResBodyTest(){
        NS_StaticVariablesUtility.getMockTransitExCountResBody(); 
    }
    @isTest
    static void getMockTransitExDetailResBodyTest(){
        NS_StaticVariablesUtility.getMockTransitExDetailResBody(); 
    }
    @isTest
    static void getMockTransitExDetailResBodyWithParamTest(){
        NS_StaticVariablesUtility.getMockTransitExDetailResBody('uId', 'cCode', 'sCode', 'EquipmentInit', 'EquipmentNr', 'WaybillSrNr'); 
    }
    
    @isTest
    static void innerClassTest(){
        NS_StaticVariablesUtility.OfflineAccAniMaintenanceWrapper OAM = new NS_StaticVariablesUtility.OfflineAccAniMaintenanceWrapper();
        OAM.ActionInd='';
        OAM.Old_Phone_ANI='';
        OAM.Phone_ANI='';
        OAM.VDNExten='';
        NS_StaticVariablesUtility.ManageOnlineCustomerContactWrapper MCCW = new NS_StaticVariablesUtility.ManageOnlineCustomerContactWrapper();
        MCCW.Action_Ind='';
        MCCW.ClassCode='';
        MCCW.Comment='';
        MCCW.Commodity='';
        MCCW.New_Cell_Phone='';
        MCCW.New_Email='';
        MCCW.New_Fax='';
        MCCW.New_First_Name='';
        MCCW.New_Last_Name='';
        MCCW.New_Mid_Name='';
        MCCW.New_Phone_1='';
        MCCW.New_Phone_1_Ext='';
        MCCW.New_Phone_2='';
        MCCW.New_Suffix='';
        MCCW.Old_Cell_Phone='';
        
        MCCW.ClassCode = 
            MCCW.Comment = '';
        MCCW.Commodity =  '';
        MCCW.New_Cell_Phone =  '';
        MCCW.New_Email =  '';
        MCCW.New_Fax =  '';
        MCCW.New_First_Name =  '';
        MCCW.New_Last_Name =  '';
        MCCW.New_Mid_Name =  '';
        MCCW.New_Phone_1 = '';
        MCCW.New_Phone_1_Ext =  '';
        MCCW.New_Phone_2 =  '';
        MCCW.New_Phone_2_Ext =  '';
        MCCW.New_Suffix = '';
        MCCW.Old_Cell_Phone = '';
        MCCW.Old_Email = '';
        MCCW.Old_Fax =  '';
        MCCW.Old_First_Name = '';
        MCCW.Old_Last_Name =  '';
        MCCW.Old_Mid_Name =  '';
        MCCW.Old_Phone_1 =  '';
        MCCW.Old_Phone_1_Ext =  '';
        MCCW.Old_Phone_2 =  '';
        MCCW.Old_Phone_2_Ext =  '';
        MCCW.New_Phone_3 =  '';
        MCCW.New_Phone_3_Ext =  '';
        MCCW.Old_Phone_3 =  '';
        MCCW.Old_Phone_3_Ext =  '';
        MCCW.Old_Suffix =  '';
        MCCW.Primary_Indicator =  '';
        MCCW.Role =  '';
        MCCW.StationCode =  '';
        MCCW.UserId =  ''; 
        NS_StaticVariablesUtility.ManageOnlineCustomerContactWrapper mocw = new NS_StaticVariablesUtility.ManageOnlineCustomerContactWrapper();
        
        List<NS_StaticVariablesUtility.ManageOnlineCustomerContactWrapper> CustomerContactWrapperList;
        CustomerContactWrapperList = new List<NS_StaticVariablesUtility.ManageOnlineCustomerContactWrapper>();
        CustomerContactWrapperList.add(mocw);
        NS_StaticVariablesUtility sss = new NS_StaticVariablesUtility();
        NS_StaticVariablesUtility.ManageOnlineCustomerContact('uId', CustomerContactWrapperList);
        
        NS_StaticVariablesUtility.OfflineAccAniMaintenanceWrapper aniMaintWrapperForCon = new NS_StaticVariablesUtility.OfflineAccAniMaintenanceWrapper();
        List<NS_StaticVariablesUtility.OfflineAccAniMaintenanceWrapper> offlineAccAniMaintenanceList = new List<NS_StaticVariablesUtility.OfflineAccAniMaintenanceWrapper>();
        offlineAccAniMaintenanceList.add(aniMaintWrapperForCon);
        NS_StaticVariablesUtility.offlineAccAniMaintenance('uId', 'ActionInd', offlineAccAniMaintenanceList);
        
        
        try{
            integer I=100/0;
        }Catch(Exception Exp)
        { 
            NS_StaticVariablesUtility.createExceptionRecord(exp, 'class_Name', 'method_Name');
        }
        
    }
    
    
    
}