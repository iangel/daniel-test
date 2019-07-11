/*
    @Author: Accenture
    @CreatedDate: 1/18/2017
    @Description : This is controller for VFP_OrgChartMaster_Clone, using which will give the tree view.
    @Version: <V.1.0>
*/
public with sharing class VFC_OrgChartMaster_Clone {
    
    Private String rId{get; set;}
    
    Public List<ReleaseClass> wrprelLst{get;set;}
    
    Public String jsnstrLst{get;set;}
    Public set<Id> bobjIds {get; set;}
    Public Set<Id> valdrIds {get;set;}
    Public List<ValueDriversClass> vdLst{get;set;}
    Public List<BusinessObjClass> bslist {get;set;}
    Public List<TacticsClass> tacLst {get;set;}
    
      /*
        @Authohr: Accenture
        @CreatedDate:  1/18/2017
        @Description: with the help of Constructor will generate the JSON String and passed it to Page.
        @Return Type: N/A
        @Exception : N/A

    */ 
    public VFC_OrgChartMaster_Clone(ApexPages.StandardController controller) {
      
        rId = apexPages.currentPage().getParameters().get('id');
        Set<Id> bIds = new Set<Id>();
        List<Tactics__c> tIds = new LIst<Tactics__c>();
        //List<Value_Drivers__c> valdrvrsLst = new List<Value_Drivers__c>();
        
        String relname = [Select Id,Name from Release__C WHERE id =: rId].Name;
        List<Business_Objectives__c> busObjLst = [Select Id,Name,Release__c  from Business_Objectives__c
                                                     WHERE Release__c =:rId LIMIT 10000];
        
        /*List<Value_Drivers__c> valdrvrsLst = [Select ID,name,Business_Objectives__c,(Select Id,Name,Value_Drivers__c from Tactics1__r) from Value_Drivers__c
                                                WHERE  Business_Objectives__c IN :busObjLst];*/
                    
                    for(Value_Drivers__c vd: [Select ID,name,Business_Objectives__c,(Select Id,Name,Value_Drivers__c from Tactics1__r)
                                                FROM Value_Drivers__c
                                                WHERE  Business_Objectives__c IN :busObjLst LIMIT 10000]){
                                     //valdrvrsLst.add(vd);
                        for(Tactics__c tc: vd.Tactics1__r){
                            tIds.add(tc);                            
                        }
                        
                    }
                    
       // List<KPIs__c> kpisLst = [Select Id,name,Tactics__c from KPIs__c WHERE Tactics__c IN:tIds];
            
            ReleaseClass relc = new ReleaseClass();
            relc.Name = Testing_Utility_Constants.ReleaseName;
            relc.title = relname;
            relc.Children = new List<BusinessObjClass>();
            
            BusinessObjClass boc;                                   
            
            
        for(Business_Objectives__c bobj: busObjLst){
            boc = new BusinessObjClass();
            boc.Name = Testing_Utility_Constants.BusinessObjectiveName;
            boc.title = bobj.Name;
            boc.className = Testing_Utility_Constants.BobjclassName;
          
            boc.children = New List<ValueDriversClass>();
            
            for(Value_Drivers__c vd: [Select ID,name,Business_Objectives__c,(Select Id,Name,Value_Drivers__c from Tactics1__r)
                                                FROM Value_Drivers__c
                                                WHERE  Business_Objectives__c IN :busObjLst LIMIT 10000]){
            if(vd.Business_Objectives__c == bobj.Id){
                ValueDriversClass vdc = new ValueDriversClass();
                vdc.Name = Testing_Utility_Constants.ValueDriverName;
                vdc.title = vd.Name;
                vdc.className = Testing_Utility_Constants.valdrivrclassName;
                vdc.Children = new List<TacticsClass>();
                
                for(Tactics__c tc: vd.Tactics1__r){
                    TacticsClass tcc = new TacticsClass();
                    tcc.Name = Testing_Utility_Constants.TacticsName;
                    tcc.title = tc.Name;
                    tcc.className = Testing_Utility_Constants.tacticsClassName;
                    tcc.children = new List<KPISClass>();
                    for(KPIs__c k: [Select Id,name,Tactics__c from KPIs__c WHERE Tactics__c IN:tIds limit 10000]){
                        if(k.Tactics__c == tc.Id){
                        KPISClass kpname = new KPISClass();
                        kpname.name = Testing_Utility_Constants.KPISName;
                        kpname.title = k.name;
                        kpname.classname = Testing_Utility_Constants.KPISClassname;
                        tcc.children.add(kpname);
                        }
                        
                        
                    }
                    vdc.children.add(tcc);
                }
                boc.children.add(vdc);
                }
            }
            
            relc.children.add(boc);
        
        }
               /*Converting the JSON into the String format*/
                jsnstrLst = JSON.serialize(relc);        
                                
            }
    
     /*
        @Authohr: Accenture
        @CreatedDate:  1/18/2017
        @Description: Inner class for Release Class
        @Return Type: N/A
        @Exception : N/A

    */ 
    Public with sharing Class ReleaseClass{
        
        private String name{get;set;}
        private String title {get;set;}       
        
        Public List<BusinessObjClass> children {get;set;}
    }
     /*
        @Authohr: Accenture
        @CreatedDate:  1/18/2017
        @Description: Inner class for Business class
        @Return Type: N/A
        @Exception : N/A

    */     
    Public with sharing class BusinessObjClass{
        private String name{get;set;}
        private String title{get;set;}
        private string className {get;set;}
        private string color {get;set;}
        
        Public List<ValueDriversClass> children {get;set;}
        
    }
     /*
        @Authohr: Accenture
        @CreatedDate:  1/18/2017
        @Description: Inner class for Value driver class
        @Return Type: N/A
        @Exception : N/A

    */     
    Public with sharing class ValueDriversClass{
        private String name{get;set;}
        private String title{get;set;}
        private string className {get;set;}       
        
        Public List<TacticsClass> children {get;set;}
    
    }
     /*
        @Authohr: Accenture
        @CreatedDate:  1/18/2017
        @Description: Inner Class for Tactics Class
        @Return Type: N/A
        @Exception : N/A

    */     
    Public with sharing class TacticsClass{
        private String name{get;set;}
        private String title{get;set;}
        private string className {get;set;}
        
        Public List<KPISClass> children {get;set;}
    
    }
    /*
        @Authohr: Accenture
        @CreatedDate:  1/18/2017
        @Description: Inner Class for KPI 
        @Return Type: N/A
        @Exception : N/A

    */     
    Public with sharing Class KPISClass{
        private String name{get;set;}
        private String title{get;set;}
        private string className {get;set;}    
    
    }
    
    

}