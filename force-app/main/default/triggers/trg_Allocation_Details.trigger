trigger trg_Allocation_Details on Employee_Allocation__c (After Insert) {

    List<Allocation_Details__c> allDtlsLst = new List<Allocation_Details__c>();
    List<Employee_Allocation__c> empAllLst = new List<Employee_Allocation__c>();
    List<Vacation__c> vacLst = new List<Vacation__c>();
    //Map<Id,Vacation__c> vacLst = new Map<Id,Vacation__c>();
    List<Holiday_List__c> holidyLst = Holiday_List__c.getAll().values();

    for (Employee_Allocation__c ora : trigger.new) {
             empAllLst.add(ora);
             integer j = 0;
             Integer currentYear = Date.today().year();
             Date startdateoftheyear = Date.newInstance(currentYear, 1, 1);
             Date enddateoftheyear = Date.newInstance(currentYear, 12, 31);
             // integer Weeks = 0;
             //integer weeks = Weeks.weeksBetween(startdateoftheyear, enddateoftheyear).getWeeks();
            
             for(integer i=0; i<53; i++){
             
                Allocation_Details__c ald = new Allocation_Details__c();
                Vacation__c vc = new Vacation__c();
                Date myDate = startdateoftheyear + j;
                j= j+7;
                Date weekStart = myDate.toStartofWeek()+1;
                Integer periousYear =weekStart.year();
                if(periousYear == currentYear){
                    ald.Employee_Allocation_Details__c = ora.Id;                  
                    ald.Weekly_Start_Date__c = weekStart;          
                    allDtlsLst.add(ald);
                    
                   /* vc.Contact__c = ora.Employee_Name__c;
                    vc.Weekly_Start_Date__c = weekStart;
                    vacLst.add(vc);*/
                }   
            }
            System.debug('holidyLst is >>>>>>'+holidyLst);
            System.debug('holidyLst size is >>>>>>'+holidyLst.size());
            
            System.debug('country is from Custom setting >>>>'+ora.Employee_Name__r.country__c);
            System.debug('EMployee Id is >>>>>'+ora.Employee_Name__c);
            String country =[Select id, Country__C from Employee__c WHERE ID =:ora.Employee_Name__c].Country__c;
            System.debug('COuntry is >>>>'+Country);
            if(!holidyLst.isempty()){
                for(Holiday_List__c el: holidyLst){
                     if(el.Country__c == country){
                            Vacation__c vac = new Vacation__c();
                            vac.Name = el.Name;
                            vac.Contact__c = ora.Employee_Name__c;
                            vac.Start_Date__c = el.Date_of_Holiday__c;
                            vac.End_Date__c = el.Date_of_Holiday__c; 
                            System.debug('vacation list is >>>>>>');                   
                            //vacLst.put(vac.Id,Vac);                    
                            vacLst.add(Vac);       
                            
                            System.debug('vacLst is as follwos>>>'+vacLst);             
                        }
                }
            }
    }
    System.debug('vacLst is as follwosassssssss>>>'+vacLst);
    System.debug('vacLst is as follwosassssssssize is>>>'+vacLst.size());
    
     if (allDtlsLst.isEmpty() == false) {
        upsert allDtlsLst;
    }
    if(!vacLst.isempty()){
       // Upsert vacLst.Values();
        Upsert vacLst;
        //Insert vacLst;
    }
    

   
    
    
    
    

}