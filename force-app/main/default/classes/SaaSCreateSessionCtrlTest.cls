@isTest
public class SaaSCreateSessionCtrlTest
{
    public static testMethod void validateCreateSession() 
    {
        Release__c rel = new Release__c();
        rel.Name = 'Test Release ';
        rel.Id = null;
        rel.Plan_Start_Date__c = System.today();
        rel.Release_Planned_End_Date__c= System.today() + 10;
        rel.Status__c = 'Red';
        rel.Description__c = 'Test description ';
       
        insert rel;
        
        Value_Delivery_Session__c vds = new Value_Delivery_Session__c();
        vds.Description__c = 'test data';
        vds.Name='VALUE Delivery Session template';
        vds.End_Date__c = System.today() + 10; 
        vds.Start_Time__c=system.now();
        vds.Releases__c = rel.id;
        insert vds;
        
       Value_Delivery_Setup__c vds1 = new Value_Delivery_Setup__c();
      //vds1.TeamDescription__c= 'test Description' ;
       vds1.Value_Delivery_Session__c=vds.id;
      // vds1.Component_Content__c='test content';
       vds1.Component_Title__c='test title';  
      // vds1.Role__c='test role';
       vds1.Sequence_Order__c=25;
      // vds1.Team_Name__c='test name';
       vds1.Project_Phase__c='test';
       insert vds1;
       
       Value_Delivery_Objectives_Options__c Vdo1=new Value_Delivery_Objectives_Options__c();
       Vdo1.Option_Description__c='Test Description';
       Vdo1.Sequence_No__c=314564613;
       Vdo1.Objectives_and_Attendees_for_Participant__c=vds1.id;
       insert Vdo1; 
       
        Value_Delivery_Objectives_Options__c vdo2 = new Value_Delivery_Objectives_Options__c();
         
        vdo2.Objectives_and_Attendees_for_Participant__c = vds1.id;
       
        insert vdo2;
     
  
        SaasCreateSessionCtrl controller = new SaasCreateSessionCtrl();
        SaasCreateSessionCtrl.BusinessOptionWrpper objBusOpt = new SaasCreateSessionCtrl.BusinessOptionWrpper(vdo2);
        
        controller.selectedSession = 'existingSession';
        controller.selectPrjAndSessionSetp();
        controller.selectCreateSessionSetp();
        
        //controller.selectPrjAndSessionSetp();
        controller.validateSession();
        controller.createSessionPrevoiusStep();
        controller.releaseID =rel.id; 
        controller.createSessionPrevoiusStep();
        controller.sessionID =  vds.id;               
        controller.createSessionPrevoiusStep();
        controller.valueDeliverySesObj.Releases__c = rel.id; 

        controller.createSessionPrevoiusStep();        
        
        
        controller.createSessionNextStep();
        controller.valueDeliverySesObj.name = 'Test'; 
        controller.createSessionNextStep();
        controller.valueDeliverySesObj.name = 'Test';         
        controller.initlizeValueDeliverySession();
      
        controller.finish();
        controller.step1();
        controller.objectiveDetailPrevious();
        controller.previous();
        controller.getReleaseList1();
        controller.getdetailSession();
        controller.step1();
       
    }
    
    static testMethod void validateCreateSession1()
    {
        Release__c rel = new Release__c();
        rel.Name = 'Test Release ';
        rel.Id = null;
        rel.Plan_Start_Date__c = System.today();
        rel.Release_Planned_End_Date__c= System.today() + 10;
        rel.Status__c = 'Red';
        rel.Description__c = 'Test description ';
        insert rel;
        
        Value_Delivery_Session__c vds = new Value_Delivery_Session__c();
        vds.Name='VALUE Delivery Session template';
        vds.Description__c = 'test data';
        vds.End_Date__c = System.today() + 10; 
        vds.Start_Time__c=system.now();
        vds.Releases__c = rel.id;
        insert vds;
        
       Value_Delivery_Setup__c vds1 = new Value_Delivery_Setup__c();
      // vds1.TeamDescription__c= 'test Description' ;
       vds1.Value_Delivery_Session__c=vds.id;
     //  vds1.Component_Content__c='test content';
       vds1.Component_Title__c='test title';  
      // vds1.Role__c='test role';
       vds1.Sequence_Order__c=25;
     //  vds1.Team_Name__c='test name';
        vds1.Project_Phase__c='test';
       insert vds1;
       
       
        Value_Delivery_Objectives_Options__c vdo2 = new Value_Delivery_Objectives_Options__c();
         
        vdo2.Objectives_and_Attendees_for_Participant__c = vds1.id;
       
        insert vdo2;
       
       SaasCreateSessionCtrl controller = new SaasCreateSessionCtrl();
       SaasCreateSessionCtrl.BusinessOptionWrpper objBusOpt = new SaasCreateSessionCtrl.BusinessOptionWrpper(vdo2);
        
       controller.selectedSession = null;
       controller.releaseID =rel.id;
        controller.selectCreateSessionSetp();
        controller.selectPrjAndSessionSetp();
        controller.createSessionPrevoiusStep();
       controller.prjPhase = 'pagNo'; 
       controller.initlizeValueDeliverySession();
       controller.next();
       controller.previous();
       controller.cancel();
       
       
     
    }
    
    static testMethod void validateSession2()
    {
       Release__c rel = new Release__c();
        rel.Name = 'Test Release ';
        rel.Id = null;
        rel.Plan_Start_Date__c = System.today();
        rel.Release_Planned_End_Date__c= System.today() + 10;
        rel.Status__c = 'Red';
        rel.Description__c = 'Test description ';
        insert rel;
        
        Value_Delivery_Session__c vds = new Value_Delivery_Session__c();
        vds.Name='VALUE Delivery Session template';
        vds.Description__c = 'test data';
        vds.End_Date__c = System.today() + 10; 
        vds.Start_Time__c=system.now();
        vds.Releases__c = rel.id;
        insert vds;
        
        
        
       Value_Delivery_Setup__c vds1 = new Value_Delivery_Setup__c();
     //vds1.TeamDescription__c= 'test Description' ;
       vds1.Value_Delivery_Session__c=vds.id;
   //    vds1.Component_Content__c='test content';
       vds1.Component_Title__c='test title';  
   //    vds1.Role__c='test role';
       vds1.Sequence_Order__c=25;
   //    vds1.Team_Name__c='test name';
       vds1.Project_Phase__c='test';
       
       insert vds1; 
       
        Value_Delivery_Objectives_Options__c vdo2 = new Value_Delivery_Objectives_Options__c();
         
        vdo2.Objectives_and_Attendees_for_Participant__c = vds1.id;
       
        insert vdo2;
        
       // BusinessOptionWrpper objBusOpt = new BusinessOptionWrpper(vdo2);
        
        SaasCreateSessionCtrl controller = new SaasCreateSessionCtrl();
        SaasCreateSessionCtrl.BusinessOptionWrpper objBusOpt = new SaasCreateSessionCtrl.BusinessOptionWrpper(vdo2);
        controller.selectedSession = 'template';
        controller.selectCreateSessionSetp();
        
        controller.sessonStartDate=system.now();
        controller.sessonEndDate=System.today() + 10;
       
    }
    public static testMethod void validateCreateSession2() 
    {
        Release__c rel = new Release__c();
        rel.Name = 'Test Release ';
        rel.Id = null;
        rel.Plan_Start_Date__c = System.today();
        rel.Release_Planned_End_Date__c= System.today() + 10;
        rel.Status__c = 'Red';
        rel.Description__c = 'Test description ';
       
        insert rel;
        
        Value_Delivery_Session__c vds = new Value_Delivery_Session__c();
        vds.Description__c = 'test data';
        vds.Name='VALUE Delivery Session template';
        vds.End_Date__c = System.today() + 10; 
        vds.Start_Time__c=system.now();
        vds.Releases__c = rel.id;
        insert vds;
        
       Value_Delivery_Setup__c vds1 = new Value_Delivery_Setup__c();
     //  vds1.TeamDescription__c= 'test Description' ;
       vds1.Value_Delivery_Session__c=vds.id;
     //  vds1.Component_Content__c='test content';
       vds1.Component_Title__c='test title';  
     //  vds1.Role__c='test role';
       vds1.Sequence_Order__c=25;
    //   vds1.Team_Name__c='test name';
       vds1.Project_Phase__c=null;
       insert vds1;
       
       Value_Delivery_Objectives_Options__c Vdo1=new Value_Delivery_Objectives_Options__c();
       Vdo1.Option_Description__c='Test Description';
       Vdo1.Sequence_No__c=314564613;
       Vdo1.Objectives_and_Attendees_for_Participant__c=vds1.id;
       insert Vdo1; 
       
        Value_Delivery_Objectives_Options__c vdo2 = new Value_Delivery_Objectives_Options__c();
         
        vdo2.Objectives_and_Attendees_for_Participant__c = vds1.id;
       
        insert vdo2;
     
  
        SaasCreateSessionCtrl controller = new SaasCreateSessionCtrl();
       // SaasCreateSessionCtrl.BusinessOptionWrpper objBusOpt = new SaasCreateSessionCtrl.BusinessOptionWrpper(vdo2);
        
        controller.selectedSession = 'existingSession';
        controller.selectPrjAndSessionSetp();
        controller.selectCreateSessionSetp();
        
        //controller.selectPrjAndSessionSetp();
        controller.validateSession();
        controller.createSessionPrevoiusStep();
        controller.releaseID =rel.id; 
        controller.createSessionPrevoiusStep();
        controller.sessionID =  vds.id;               
        controller.createSessionPrevoiusStep();
        controller.valueDeliverySesObj.Releases__c = rel.id; 

        controller.createSessionPrevoiusStep();        
        
        
        controller.createSessionNextStep();
        controller.valueDeliverySesObj.name = 'Test'; 
        controller.createSessionNextStep();
        controller.valueDeliverySesObj.name = 'Test';         
        controller.initlizeValueDeliverySession();
        controller.finish();
        controller.step1();
        controller.objectiveDetailPrevious();
        controller.previous();
        controller.getReleaseList1();
        controller.getdetailSession();
        controller.step1();
       
    }
}