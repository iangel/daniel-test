@isTest
Public class VFC_OrgChartMaster_Clone_Test{
    Public static testMethod void VFC_OrgChartMaster_Clone_Test(){
        
        Release__c rl = new Release__c();
        rl.Name = Testing_Utility_Constants.ReleaseName;        
        Database.Insert(rl,false);
        
        Business_Objectives__c bo = new Business_Objectives__c();
        bo.Name = Testing_Utility_Constants.BusinessObjectiveName;
        bo.Release__c = rl.Id;        
        Database.Insert(bo,false);        
        
        Value_Drivers__c vd = new Value_Drivers__c();
        vd.Name = Testing_Utility_Constants.ValueDriverName;
        vd.Business_Objectives__c = bo.Id;
        Database.Insert(vd,false);
        
        
        Tactics__c tc = new Tactics__c();
        tc.Name = Testing_Utility_Constants.TacticsName;
        tc.Value_Drivers__c = vd.Id;
        Database.Insert(tc,false);
        
        
        KPIs__c kp = new KPIs__c();
        kp.Name = Testing_Utility_Constants.KPISName;
        kp.Tactics__c = tc.Id;
        Database.Insert(kp,false);
       
        
        ApexPages.StandardController cntrlr = new ApexPages.StandardController(rl);
        apexpages.currentPage().getParameters().put('id',rl.Id);
        
        VFC_OrgChartMaster_Clone  vorcl = new VFC_OrgChartMaster_Clone(cntrlr);
        
        VFC_OrgChartMaster_Clone.releaseClass orgrel = new VFC_OrgChartMaster_Clone.releaseClass();
        VFC_OrgChartMaster_Clone.BusinessObjClass orgbs= new VFC_OrgChartMaster_Clone.BusinessObjClass();
        VFC_OrgChartMaster_Clone.ValueDriversClass orgvd = new VFC_OrgChartMaster_Clone.ValueDriversClass();
        VFC_OrgChartMaster_Clone.TacticsClass orgTc = new VFC_OrgChartMaster_Clone.TacticsClass();
        VFC_OrgChartMaster_Clone.KPISClass orgKPI = new VFC_OrgChartMaster_Clone.KPISClass();
        
        
    
    }

}