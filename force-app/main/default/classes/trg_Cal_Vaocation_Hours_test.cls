@isTest
private class trg_Cal_Vaocation_Hours_test {
    
    private static testMethod void trg_Cal_Vaocation_Hours_test01(){
        
        
        
        //Create a New Employee  
        
        Employee__c emp = new Employee__c (
            Name = 'xyzFirst');
        insert emp;
        
        
        //Creating Release__c record 
        Release__c release= New Release__c();
        
        
        insert release;
        
        
        
        
        //Creating Employee_Allocation__c record 
        Employee_Allocation__c eallocation= new Employee_Allocation__c();
        eallocation.Employee_Name__c=emp.id;
        eallocation.End_Date__c=Date.newInstance(2018, 11, 30);
        eallocation.Release_Name__c=release.id;	
        
        insert eallocation;
        
        
        
        
        
        //Creating Allocation_Details__c record
        
        Allocation_Details__c allocation = new Allocation_Details__c();
        allocation.Employee_Allocation_Details__c=eallocation.id;      
        allocation.Weekly_Start_Date__c=Date.newInstance(2018, 11, 6);
        
        
        insert allocation;
        
        
        
        
        
        // Inserting a New record in Vacation Object   
        
        Vacation__c vacation=new Vacation__c();
        vacation.Name ='Test';
        vacation.Contact__c=emp.id;
        vacation.Start_Date__c=Date.newInstance(2018, 11, 6);
        vacation.End_Date__c= Date.newInstance(2018, 11, 17);
        
        
        insert vacation;
        
        
    }
    
    private static testMethod void trg_Cal_Vaocation_Hours_test02(){
        
        
        
        //Create a New Employee  
        
        Employee__c emp = new Employee__c (
            Name = 'xyzFirst');
        insert emp;
        
        
        //Creating Release__c record 
        Release__c release= New Release__c();
        
        
        insert release;
        
        
        
        
        //Creating Employee_Allocation__c record 
        Employee_Allocation__c eallocation= new Employee_Allocation__c();
        eallocation.Employee_Name__c=emp.id;
        eallocation.End_Date__c=Date.newInstance(2018, 11, 30);
        eallocation.Release_Name__c=release.id;	
        
        insert eallocation;
        
        
        
        
        
        //Creating Allocation_Details__c record
        
        Allocation_Details__c allocation = new Allocation_Details__c();
        allocation.Employee_Allocation_Details__c=eallocation.id;
        allocation.Allocation_Hours__c=3.0;
        allocation.Weekly_Start_Date__c=Date.newInstance(2018, 11, 6);
        
        
        insert allocation;
		allocation.Vacation_Hours__c=1;
        Update allocation;
        
        
        
        // Inserting a New record in Vacation Object   
        
        Vacation__c vacation=new Vacation__c();
        vacation.Name ='Test';
        vacation.Contact__c=emp.id;
        vacation.Start_Date__c=Date.newInstance(2018, 11, 6);
        vacation.End_Date__c= Date.newInstance(2018, 11, 6);
        
        
        insert vacation;
        
        
    }
    
}