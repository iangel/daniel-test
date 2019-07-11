@isTest
private class Cls_MilestoneGanttChart_Test{ 
    /* Passing test data */
  static testMethod void myTestMethodreleaseidnull() { 
    string gants='test';
    string s = 'Green';
    date startdate;
    date enddate;
    
    
    string[] str = new string[] {};
    
     Release__c res = new Release__c();
        res.Name='Test';
        //res.Program__c=acctmaster2.id;
        //ph.Phase_Start_Date__c=system.today();
        //ph.Phase_End_Date__c=system.today();
        insert res;
            
                          
        Milestone__c objMile = new Milestone__c();
           objMile.Milestone_Name__c = 'TestMilestone';
           objMile.Release__c = res.Id;
           objMile.Progress__c ='In Progress'; 
           objMile.Milestones__c = 'Requirements Definition'; 
           objMile.Actual_Start_Date__c =system.now().adddays(-4).date();
           objMile.Actual_End_Date__c = system.now().adddays(-2).date();
            
           objMile.Planned_Start_Date__c = system.now().adddays(-4).date();
           objMile.Planned_End_Date__c = system.today()+7;
           
           insert objMile;  
           
         Key_Action_Decision__c key = new Key_Action_Decision__c();
          key.Name = 'Key Decision';   
          key.Priority__c = 'Normal'; 
          Key.Status__c = 'In Progress';
          key.Description__c = 'Test Description'; 
          key.Display_on_Timeline__c = true;
          key.Related_Release__c = res.Id;
          //key.Due_Date__c = system.today()+2;
          key.Completed_Date__c = system.today()+3;
          
         insert key;                                                  
       
        Test.startTest();
    
  ApexPAges.StandardController sc = new ApexPages.StandardController(objMile);
  ApexPages.CurrentPage().getparameters().put('id', res.id);

  Cls_MilestoneGanttChart testController = new Cls_MilestoneGanttChart(sc);
    
  testController.ganttJson=gants;
  testController.selectedmilestoneValues = 'Requirements Definition';
  testController.color='Green';
  testController.startdate=objMile.Planned_Start_Date__c;
  testController.enddate=objMile.Planned_End_Date__c;
  testController.getmilestoneValues();
  testController.getStatusValues();
  testController.setselectedcheckboxvalues(str);
  testController.getselectedcheckboxvalues();
  testController.searchresults();
  
  Test.stopTest();         
    }
    
  static testMethod void myTestMethodreleaseidnotnull() { 
    string gants='test';
    string color = 'Green';
    date startdate;
    date enddate;
    string selectedmilestoneValues = null;
    string[] str = new string[] {'Not Started'};
     Release__c res = new Release__c();
        res.Name='Test';
        //res.Program__c=acctmaster2.id;
        //ph.Phase_Start_Date__c=system.today();
        //ph.Phase_End_Date__c=system.today();
        insert res;
           
        Milestone__c objMile = new Milestone__c();
           objMile.Milestone_Name__c = 'TestMilestone';
           objMile.Release__c = res.Id;
           objMile.Progress__c ='In Progress'; 
           //objMile.Planned_Start_Date__c = system.now().adddays(-4).date();
           //objMile.Planned_End_Date__c = system.today()+7;
           objMile.Milestones__c = 'Requirements Definition'; 
           objMile.Planned_Start_Date__c = system.now().adddays(-4).date();
           objMile.Planned_End_Date__c = system.today()+7;
           
           insert objMile;  
           
         Key_Action_Decision__c key = new Key_Action_Decision__c();
          key.Name = 'Key Decision';   
          key.Priority__c = 'Normal'; 
          Key.Status__c = 'In Progress';
          key.Description__c = 'Test Description'; 
          key.Display_on_Timeline__c = true;
          key.Related_Release__c = res.Id;
          key.Due_Date__c = system.today()+2;
          key.Completed_Date__c = system.today()+2;
          
         insert key;                                                  
       
        Test.startTest();
    
  ApexPAges.StandardController sc = new ApexPages.StandardController(objMile);
   
  ApexPages.CurrentPage().getparameters().put('ReleaseId', res.Id);
  //ApexPages.CurrentPage().getparameters().put('Id', res.Id);
   
  Cls_MilestoneGanttChart testController = new Cls_MilestoneGanttChart(sc);
    
  testController.ganttJson=gants;
  
  testController.getmilestoneValues();
  testController.getStatusValues();
  testController.startdate=objMile.Actual_Start_Date__c;
  testController.enddate=objMile.Actual_End_Date__c;
  testController.setselectedcheckboxvalues(str);
  testController.getselectedcheckboxvalues();
  testController.searchresults();
  
  Test.stopTest();         
    }
    
    
  static testMethod void myTestMethodmilestonetypenotnull() { 
    string gants='test';
    string color = 'Green';
    date startdate;
    date enddate;
    
    
    string[] str = new string[] {'In Progress'};
     Release__c res = new Release__c();
        res.Name='Test';
        //res.Program__c=acctmaster2.id;
        //ph.Phase_Start_Date__c=system.today();
        //ph.Phase_End_Date__c=system.today();
        insert res;
           
        Milestone__c objMile = new Milestone__c();
           objMile.Milestone_Name__c = 'TestMilestone';
           objMile.Release__c = res.Id;
           objMile.Progress__c ='In Progress'; 
           //objMile.Planned_Start_Date__c = system.now().adddays(-4).date();
           //objMile.Planned_End_Date__c = system.today()+7;
           objMile.Milestones__c = 'Requirements Definition'; 
           objMile.Planned_Start_Date__c = system.now().adddays(-4).date();
           objMile.Planned_End_Date__c = system.today()+7;
           
           insert objMile;  
           
         Key_Action_Decision__c key = new Key_Action_Decision__c();
          key.Name = 'Key Decision';   
          key.Priority__c = 'Normal'; 
          Key.Status__c = 'In Progress';
          key.Description__c = 'Test Description'; 
          key.Display_on_Timeline__c = true;
          key.Related_Release__c = res.Id;
          key.Due_Date__c = system.today()+2;
          key.Completed_Date__c = system.today()+2;
          
         insert key;                                                  
       
        Test.startTest();
    
  ApexPAges.StandardController sc = new ApexPages.StandardController(objMile);
   
  ApexPages.CurrentPage().getparameters().put('ReleaseId', res.Id);
  //ApexPages.CurrentPage().getparameters().put('Id', res.Id);
   
  Cls_MilestoneGanttChart testController = new Cls_MilestoneGanttChart(sc);
    
  testController.ganttJson=gants;
  testController.selectedmilestoneValues = 'Requirements Definition';
  testController.getmilestoneValues();
  testController.getStatusValues();
  testController.startdate=objMile.Actual_Start_Date__c;
  testController.enddate=objMile.Actual_End_Date__c;
  testController.setselectedcheckboxvalues(str);
  testController.getselectedcheckboxvalues();
  testController.searchresults();
  
  Test.stopTest();         
    }  
      

}