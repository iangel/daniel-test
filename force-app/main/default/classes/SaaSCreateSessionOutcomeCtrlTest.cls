@isTest
Public class SaaSCreateSessionOutcomeCtrlTest 
{
    static testMethod void validateCreateSessionOutcome() 
    {        
        Release__c rel = new Release__c();
        rel.Name = 'Test Release Data';
        rel.Id = null;
        rel.Plan_Start_Date__c = System.today();
        rel.Release_Planned_End_Date__c= System.today() + 10;
        rel.Status__c = 'Red';
        rel.Description__c = 'Test description ';
        insert rel;
        
        Value_Delivery_Session__c vds = new Value_Delivery_Session__c();
        vds.Description__c = 'test delivery data';
        vds.End_Date__c = System.today() + 10; 
        vds.Start_Time__c=system.now();
        vds.Releases__c = rel.id;
        insert vds;        
        
        Value_Delivery_Session_Outcomes__c objVDSO = new Value_Delivery_Session_Outcomes__c();
        objVDSO.Name = 'Test outcome Data';
        objVDSO.Phase__c = 'Design';
        objVDSO.Start_Date__c = system.today();
        objVDSO.End_Date__c = system.today()+10;
        objVDSO.Session_Outcome__c = 'Test data preparation';
        objVDSO.Value_Delivery_Session__c = vds.id; 
        insert objVDSO; 
  
        Value_Delivery_Key_Participants__c  vdp = new Value_Delivery_Key_Participants__c(); 
        vdp.name = 'TestName';
        vdp.Role__c = 'TestRole';
        vdp.Participant_Type__c = 'Accenture Team';
        vdp.Comments__c ='Test Comment';
        vdp.Session_Outcomes__c = objVDSO.id;
        insert vdp;
        
        List<Value_Delivery_Key_Participants__c> lstVDP = [select id, name, Role__c, Participant_Type__c,Comments__c from Value_Delivery_Key_Participants__c where id =:vdp.id LIMIT 1];
               
        Value_Delivery_Key_Participants__c vd = new Value_Delivery_Key_Participants__c();
        Integer i = 1;
        String s = 'Test';
        vd.name = 'TestNewName';
        vd.Role__c = 'TestNewRole';
        vd.Participant_Type__c = 'Accenture Team';
        vd.Comments__c ='TestNew Comment';
        vd.Session_Outcomes__c = objVDSO.id;
        insert vd;
        
        Value_Delivery_User_Config__c vdU = new Value_Delivery_User_Config__c();
        vdu.Name = 'TestUser';      
        vdu.Selected_Session__c= vds.Id;
        insert vdu;
        
        SaaSCreateSessionOutcomeCtrl ctrl = new SaaSCreateSessionOutcomeCtrl(new ApexPages.StandardController(objVDSO));                
        ctrl.sessonStartDate = Date.today();
        ctrl.sessonEndDate = Date.today()+10;
        ctrl.isDetail = false;
        ctrl.isInsert = false;
        ctrl.isSaved = false;
        ctrl.success = false;
        ctrl.participantsObj = lstVDP;        
        ctrl.sessOutcomeObj = objVDSO;

        SaaSCreateSessionOutcomeCtrl.ParticipantsWrapper pw = new SaaSCreateSessionOutcomeCtrl.ParticipantsWrapper(vdp);        
        SaaSCreateSessionOutcomeCtrl.ParticipantsWrapper pwList = new SaaSCreateSessionOutcomeCtrl.ParticipantsWrapper(i,vd,s);
        
        
        ctrl.newParticipantsLst.add(pwList);
        
        ctrl.saveSessionOutcome();
        
        ctrl.displayImport();
        
        ctrl.getImportParticipants();
        ctrl.add();
        
        
        ctrl.getAllKeyParticipants();        
        ctrl.importPreviousSessionOutome();
        ctrl.remove();
        
        
        
    }
    
    static testMethod void validateCreateSessionOutcomeNegative() 
    {
        Release__c rel = new Release__c();
        rel.Name = 'Test Release Data';
        rel.Id = null;
        rel.Plan_Start_Date__c = System.today();
        rel.Release_Planned_End_Date__c= System.today() + 10;
        rel.Status__c = 'Red';
        rel.Description__c = 'Test description ';
        insert rel;
        
        Value_Delivery_Session__c vds = new Value_Delivery_Session__c();
        vds.Description__c = 'test delivery data';
        vds.End_Date__c = System.today() + 10; 
        vds.Start_Time__c=system.now();
        vds.Releases__c = rel.id;
        insert vds;        
        
        Value_Delivery_Session_Outcomes__c objVDSO = new Value_Delivery_Session_Outcomes__c();
        objVDSO.Name = 'Test outcome Data';
        objVDSO.Phase__c = Null;
        objVDSO.Start_Date__c = system.today();
        objVDSO.End_Date__c = system.today()+10;
        objVDSO.Session_Outcome__c = Null;
        objVDSO.Value_Delivery_Session__c = vds.id; 
        insert objVDSO; 

        SaaSCreateSessionOutcomeCtrl ctrl = new SaaSCreateSessionOutcomeCtrl(new ApexPages.StandardController(objVDSO));
        
        ctrl.displayImport();
        ctrl.saveSessionOutcome();
        ctrl.importPreviousSessionOutome();
        ctrl.remove();
 
    }
}