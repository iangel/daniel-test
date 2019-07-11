@isTest
public class trg_Allocation_Details_Test {

     Public static testMethod void trg_Allocation_Details_Test(){
    
         Holiday_List__c hList = new Holiday_List__c();
         hList.Name ='Test';
         hList.Country__c ='US';
         insert hList;
         
         
        Release__c rl = new Release__c();
        rl.Name = 'TestRelease';
        
        Insert rl;
        
        Employee__c emp = new Employee__c();
        emp.Name = 'TestEMployyee';
        emp.Country__c='US';
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

    }
   
}