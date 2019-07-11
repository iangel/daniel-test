@isTest
public class VFC_EmployeeAllocation_Clone_Test {
    
    private static testMethod void VFC_EmployeeAllocation_Clone_Test(){
        
        
        
        Employee__c emp = new Employee__c();
        emp.Name = 'TestEMployyee';
        emp.Country__c='US';
        
        Insert emp;
        
        Release__c rl = new Release__c();
        rl.Name = 'TestRelease';
        Insert rl;

        
        Employee_Allocation__c EA = new Employee_Allocation__c();
        
        EA.Employee_Name__c=emp.id;
        EA.End_Date__c=Date.newInstance(2018, 2, 30);
        EA.Release_Name__c=rl.id;
        EA.Start_Date__c=Date.newInstance(2018, 1, 30);
        insert EA;
        
         Allocation_Details__c ad = new Allocation_Details__c();
        //ad.Name = 'TestWeek';
        ad.Employee_Allocation_Details__c = ea.Id;
        //ad.Year_of_Month__c = 'August';
        //ad.Release_Month__c = system.Today();
        //ad.Release_End_Month__c = system.Today().addDays(10);
        ad.Weekly_Start_Date__c = system.Today().addDays(0);
        Insert ad;
        
        
        
        ApexPages.StandardController sc = new ApexPages.StandardController(emp);
        VFC_EmployeeAllocation_Clone testAccPlan = new VFC_EmployeeAllocation_Clone(sc);
        
        PageReference pageRef = Page.VFP_EmployeeAllocation_Clone;
        pageRef.getParameters().put('id', emp.Id);
        Test.setCurrentPage(pageRef);
        
        
        testAccPlan.getmonths();
        testAccPlan.selectedmonth = 'January';
        testAccPlan.searchvalues();
        testAccPlan.selectedmonth = 'January';
        testAccPlan.searchvalues();
        testAccPlan.selectedmonth = 'February';
        testAccPlan.searchvalues();
        testAccPlan.selectedmonth = 'March';
        testAccPlan.searchvalues();
        testAccPlan.selectedmonth = 'April';
        testAccPlan.searchvalues();
        testAccPlan.selectedmonth = 'May';
        testAccPlan.searchvalues();
        testAccPlan.selectedmonth = 'June';
        testAccPlan.searchvalues();
        testAccPlan.selectedmonth = 'July';
        testAccPlan.searchvalues();
        testAccPlan.selectedmonth = 'August';
        testAccPlan.searchvalues();
        testAccPlan.selectedmonth = 'September';
        testAccPlan.searchvalues();
        testAccPlan.selectedmonth = 'October';
        testAccPlan.searchvalues();
        testAccPlan.selectedmonth = 'November';
        testAccPlan.searchvalues();
        testAccPlan.selectedmonth = 'December';
        testAccPlan.searchvalues();  
        testAccPlan.goback();
        testAccPlan.Updatevalues();
        testAccPlan.selectedmonth = '- None -';
        testAccPlan.enteredhours=01;
        testAccPlan.searchvalues();
        testAccPlan.Month='1';
        testAccPlan.Applyvalues();
  
        System.debug('SRV '+ [Select id FROM Employee_Allocation__c WHERE Employee_Name__c =:apexpages.currentPage().getParameters().get('id')]);
        
system.debug('SRV '+[select Id, Name,Employee_Name__c,Employee_Name__r.Name,Employee_Name__r.Project__c,End_Date__c,Release_Name__c,Year__c,
                                               Release_Name__r.Name,Start_Date__c,Release_Name__r.Proejct_Start_Date__c,Release_Name__r.Release_Start_Date__c,Release_Name__r.Release_Planned_End_Date__c,
                                               Release_Name__r.Project_End_Date__c
                                               FROM Employee_Allocation__c
                                               WHERE Employee_Name__c =: apexpages.currentPage().getParameters().get('id')]);        
    
        
    
    }
    
     private static testMethod void VFC_EmployeeAllocation_Clone_Test01(){
        
        
        
        Employee__c emp = new Employee__c();
        emp.Name = 'TestEMployyee';
        emp.Country__c='US';
        
        Insert emp;
        
        Release__c rl = new Release__c();
        rl.Name = 'TestRelease';
        Insert rl;

        
        Employee_Allocation__c EA = new Employee_Allocation__c();
        
        EA.Employee_Name__c=emp.id;
        EA.End_Date__c=Date.newInstance(2018, 11, 30);
        EA.Release_Name__c=rl.id;
        EA.Start_Date__c=Date.newInstance(2018, 11, 29);
        insert EA;
        
         Allocation_Details__c ad = new Allocation_Details__c();
        //ad.Name = 'TestWeek';
        ad.Employee_Allocation_Details__c = ea.Id;
        //ad.Year_of_Month__c = 'August';
        //ad.Release_Month__c = system.Today();
        //ad.Release_End_Month__c = system.Today().addDays(10);
        ad.Weekly_Start_Date__c = system.Today().addDays(0);
        Insert ad;
        
        
        
        ApexPages.StandardController sc = new ApexPages.StandardController(emp);
        VFC_EmployeeAllocation_Clone testAccPlan = new VFC_EmployeeAllocation_Clone(sc);
        
        PageReference pageRef = Page.VFP_EmployeeAllocation_Clone;
        pageRef.getParameters().put('id', emp.Id);
        Test.setCurrentPage(pageRef);

        testAccPlan.selectedmonth = '- None -';
        testAccPlan.enteredhours=01;
        testAccPlan.searchvalues();
        testAccPlan.Month='1';
        testAccPlan.Applyvalues();
  
        System.debug('SRV '+ [Select Allocation_Start_Date_Month__c,Allocation_End_Date_Month__c FROM Employee_Allocation__c WHERE Employee_Name__c =:apexpages.currentPage().getParameters().get('id')]);
        
system.debug('SRV '+[select Id, Name,Employee_Name__c,Employee_Name__r.Name,Employee_Name__r.Project__c,End_Date__c,Release_Name__c,Year__c,
                                               Release_Name__r.Name,Start_Date__c,Release_Name__r.Proejct_Start_Date__c,Release_Name__r.Release_Start_Date__c,Release_Name__r.Release_Planned_End_Date__c,
                                               Release_Name__r.Project_End_Date__c,
                                               (Select Id,Name,Year_of_Month__c,Employee_Allocation_Details__r.Release_Name__c from Allocation_Details__r)
                                               FROM Employee_Allocation__c
                                               WHERE Employee_Name__c =: apexpages.currentPage().getParameters().get('id')]);        
    
        
    
    }
}