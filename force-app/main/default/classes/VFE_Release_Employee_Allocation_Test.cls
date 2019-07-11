@isTest
Public class VFE_Release_Employee_Allocation_Test{
    Public static testMethod void VFE_Release_Employee_Allocation_Test(){
    
        Release__c rl = new Release__c();
        rl.Name = 'TestRelease';
        
        Insert rl;
        
        Employee__c emp = new Employee__c();
        emp.Name = 'TestEMployyee';
        Insert emp;
        
        Employee_Allocation__c ea = new Employee_Allocation__c();
        ea.Release_Name__c = rl.Id;
        ea.Employee_Name__c = emp.Id;
        ea.Start_Date__c = system.Today();
        ea.End_Date__c = system.Today().addDays(10);
        Insert ea;
        
        Allocation_Details__c ad = new Allocation_Details__c();
        //ad.Name = 'TestWeek';
        ad.Employee_Allocation_Details__c = ea.Id;
        //ad.Year_of_Month__c = 'August';
        //ad.Release_Month__c = system.Today();
        //ad.Release_End_Month__c = system.Today().addDays(10);
        ad.Weekly_Start_Date__c = system.Today().addDays(0);
        Insert ad;
        
        Vacation__c vc = new Vacation__c();
        vc.Name = 'TestVcation';
        vc.Contact__c = emp.Id;
        Insert vc;
        
        List<Allocation_Details__c> aldllst = new List<Allocation_Details__c >{ad};
        
        apexpages.currentPage().getParameters().put('id',rl.Id);
        
        VFE_Release_Employee_Allocation_Clone.EmployAllcation eal = new VFE_Release_Employee_Allocation_Clone.EmployAllcation(ea);
        eal.selected = true;
        ApexPages.StandardController contrlr = new ApexPages.StandardController(rl);
        VFE_Release_Employee_Allocation_Clone vrm = new VFE_Release_Employee_Allocation_Clone(contrlr);
        vrm.getmonths();
        vrm.searchvalues();
        vrm.Applyvalues();
        vrm.Updatevalues();
        vrm.goback();
        
        vrm.vacation = 40;
        vrm.enteredhours =30;
        vrm.selectedmonth = 'August';
        
        /*System.assertnotEquals(vrm.month,'January');
        System.assertnotEquals(vrm.month,'February');
        System.assertnotEquals(vrm.month,'March');
        System.assertnotEquals(vrm.month,'April');
        System.assertnotEquals(vrm.month,'May');
        System.assertnotEquals(vrm.month,'June');
        System.assertnotEquals(vrm.month,'July');
       // System.assertEquals(vrm.month,'August');
        //System.assertnotEquals(vrm.month,'September');
        System.assertnotEquals(vrm.month,'October');
        System.assertnotEquals(vrm.month,'November');
        System.assertnotEquals(vrm.month,'December');*/
    }
    
    Public static testMethod void VFE_Release_Employee_Allocation_Test1(){
    
        Release__c rl = new Release__c();
        rl.Name = 'TestRelease';
        
        Insert rl;
        
        Employee__c emp = new Employee__c();
        emp.Name = 'TestEMployyee';
        Insert emp;
        
        Employee_Allocation__c ea = new Employee_Allocation__c();
        ea.Release_Name__c = rl.Id;
        ea.Employee_Name__c = emp.Id;
        ea.Start_Date__c = system.Today();
        ea.End_Date__c = system.Today().addDays(10);
        Insert ea;
        
        Allocation_Details__c ad = new Allocation_Details__c();
        //ad.Name = 'TestWeek';
        ad.Employee_Allocation_Details__c = ea.Id;
        //ad.Release_Month__c = system.Today();
        //ad.Release_End_Month__c = system.Today().addDays(10);
        ad.Weekly_Start_Date__c = system.Today().addDays(0);
        Insert ad;
        
        Vacation__c vc = new Vacation__c();
        vc.Name = 'TestVcation';
        vc.Contact__c = emp.Id;
        Insert vc;
        
        List<Allocation_Details__c> aldllst = new List<Allocation_Details__c >{ad};
        
        apexpages.currentPage().getParameters().put('id',rl.Id);
        
        VFE_Release_Employee_Allocation_Clone.EmployAllcation eal = new VFE_Release_Employee_Allocation_Clone.EmployAllcation(ea);
        
        eal.selected = true;
        ApexPages.StandardController contrlr = new ApexPages.StandardController(rl);
        VFE_Release_Employee_Allocation_Clone vrm = new VFE_Release_Employee_Allocation_Clone(contrlr);
        vrm.getmonths();
        System.assertEquals(vrm.selectedmonth ,null);
        vrm.searchvalues();
        vrm.Applyvalues();
        vrm.Updatevalues();
        vrm.goback();
        
        
        
        vrm.vacation = 40;
        vrm.enteredhours =30;
        //vrm.selectedmonth = '- None -';
        
      
        }

     Public static testMethod void VFE_Release_Employee_Allocation_Test2(){
    
        Release__c rl = new Release__c();
        rl.Name = 'TestRelease';
        
        Insert rl;
        
        Employee__c emp = new Employee__c();
        emp.Name = 'TestEMployyee';
        Insert emp;
        
        Employee_Allocation__c ea = new Employee_Allocation__c();
        ea.Release_Name__c = rl.Id;
        ea.Employee_Name__c = emp.Id;
        ea.Start_Date__c = system.Today();
        ea.End_Date__c = system.Today().addDays(10);
        Insert ea;
        
        Allocation_Details__c ad = new Allocation_Details__c();
        //ad.Name = 'TestWeek';
        ad.Employee_Allocation_Details__c = ea.Id;
        //ad.Name = 'TestWeek1';        
        ad.Vacation_Hours__c = 50;
        ad.Planned_Vocation_Hours__c = 40;
        ad.Allocation_Hours__c = 50;
        //ad.Release_Month__c = system.Today();
        //ad.Release_End_Month__c = system.Today().addDays(10);
        ad.Weekly_Start_Date__c = system.Today().addDays(0);

        
        Vacation__c vc = new Vacation__c();
        vc.Name = 'TestVcation';
        vc.Contact__c = emp.Id;
        Insert vc;
        
        List<Allocation_Details__c> aldllst = new List<Allocation_Details__c >{ad};
        
        apexpages.currentPage().getParameters().put('id',rl.Id);
        
        VFE_Release_Employee_Allocation_Clone.EmployAllcation eal = new VFE_Release_Employee_Allocation_Clone.EmployAllcation(ea);
        
        eal.selected = False;
        ApexPages.StandardController contrlr = new ApexPages.StandardController(rl);
        VFE_Release_Employee_Allocation_Clone vrm = new VFE_Release_Employee_Allocation_Clone(contrlr);
        vrm.selectedmonth = 'august';
        vrm.enteredhours = 50;
        vrm.getmonths();
         
       // System.assertEquals(vrm.selectedmonth ,null);
        vrm.searchvalues();
        vrm.Applyvalues();
        vrm.Updatevalues();
        vrm.goback();
        
        
        
        vrm.vacation = 40;
        vrm.enteredhours =30;
        //vrm.selectedmonth = '- None -';
        
      
        }
         Public static testMethod void VFE_Release_Employee_Allocation_Test3(){
    
        Release__c rl = new Release__c();
        rl.Name = 'TestRelease';
        
        Insert rl;
        
        Employee__c emp = new Employee__c();
        emp.Name = 'TestEMployyee';
        Insert emp;
        
        Employee_Allocation__c ea = new Employee_Allocation__c();
        ea.Release_Name__c = rl.Id;
        ea.Employee_Name__c = emp.Id;
        ea.Start_Date__c = system.Today();
        ea.End_Date__c = system.Today().addDays(10);
        Insert ea;
        
        Allocation_Details__c ad = new Allocation_Details__c();
        //ad.Name = 'TestWeek';
        ad.Employee_Allocation_Details__c = ea.Id;
       // ad.Name = 'TestWeek1';        
        ad.Vacation_Hours__c = 50;
        ad.Planned_Vocation_Hours__c = 40;
        ad.Allocation_Hours__c = 50;
        //ad.Release_Month__c = system.Today();
        //ad.Release_End_Month__c = system.Today().addDays(10);
        ad.Weekly_Start_Date__c = system.Today().addDays(0);

        
        Vacation__c vc = new Vacation__c();
        vc.Name = 'TestVcation';
        vc.Contact__c = emp.Id;
        Insert vc;
        
        List<Allocation_Details__c> aldllst = new List<Allocation_Details__c >{ad};
        
        apexpages.currentPage().getParameters().put('id',rl.Id);
        
        VFE_Release_Employee_Allocation_Clone.EmployAllcation eal = new VFE_Release_Employee_Allocation_Clone.EmployAllcation(ea);
        
        eal.selected = False;
        ApexPages.StandardController contrlr = new ApexPages.StandardController(rl);
        VFE_Release_Employee_Allocation_Clone vrm = new VFE_Release_Employee_Allocation_Clone(contrlr);
        vrm.selectedmonth = '- None -';
        vrm.enteredhours = 50;
        vrm.getmonths();
         
       // System.assertEquals(vrm.selectedmonth ,null);
        vrm.searchvalues();
        vrm.Applyvalues();
        vrm.Updatevalues();
        vrm.goback();
        
        
        
       // vrm.vacation = 40;
        //vrm.enteredhours =30;
        //vrm.selectedmonth = '- None -';
        
      
        }
    

}