public with sharing class VFC_EmployeeAllocation_Clone {
    Public List<Employee_Allocation__c> empAlLst {get;set;}
    Public List<Release__c> relsLst {get;set;}
    Public List<Employee__c> empLst {get;set;}
    Public List<Allocation_Details__c> allDtlLst{get;set;}
    Public List<EmployAllcation> emplWrapLst {get;set;}
    Public List<String> WeeksLst{get;set;}
    Public List<Vacation__c> vacnewLst {get;set;}
    Public Integer count{get;set;}
    
    Map<Id,Allocation_Details__c> las = new Map<Id,Allocation_Details__c>();
    
    public string selectedmonth {get;set;}
    Public Integer enteredhours{get;set;}
    Public map<string,string> distinctLastnames {get;set;}
    Public List<Allocation_Details__c> allDtlLst1 {get;set;}
    Public String Month{get;set;}
    Public List<Id> empIds {get;set;}
    Public List<vacation__c> vacLst{get;set;}
    
    Public Integer vacation {get;set;}
    
    Public Integer weeksize{get;set;}
    
    Public Date CurrentMonhDate;
    
    
    
    public VFC_EmployeeAllocation_Clone (ApexPages.StandardController controller) {
           vacLst = new List<Vacation__c>();
           empIds  = new List<Id>();
           empAlLst = new  List<Employee_Allocation__c>();
           relsLst = new List<Release__c>();
           empLst = new List<Employee__c>();
           emplWrapLst = new List<EmployAllcation>();
           allDtlLst = new List<Allocation_Details__c>();
           count =0;
           
           //allDtlLst1 = new List<Allocation_Details__c>();
           WeeksLst = new List<String>();
           distinctLastnames = new map<string,string>();
           List<Allocation_Details__c> alcdtl = new List<Allocation_Details__c>();
           vacnewLst = new List<vacation__c>();
           //Date CurrentMonthDate = Date.Valueof(date.today().format());
           Integer dtMonth = System.Today().MOnth();
           
           String monthcur = String.Valueof(System.Today().MOnth());
           if(Integer.Valueof(monthcur) < 10)
             monthcur = monthcur +''+'0';
           String  dtYear = String.Valueof(System.Today().Year());
           Integer curMonYr = Integer.Valueof(dtYear+''+monthcur);
           System.debug('Current Month and Year is>>>>>'+curMonYr);
                    
            if(dtMonth == 1) month = 'January'; 
            if(dtMonth == 2) month = 'February';
            if(dtMonth == 3) month = 'March';
            if(dtMonth == 4) month = 'April';
            if(dtMonth == 5) month = 'May';
            if(dtMonth == 6) month = 'June';
            if(dtMonth == 7) month = 'July';
            if(dtMonth == 8) month = 'August';
            if(dtMonth == 9) month = 'September';
            if(dtMonth == 10)month = 'October';
            if(dtMonth == 11) month = 'November';
            if(dtMonth == 12) month = 'December';
            
            System.debug('Month is>>>>'+month);
           
           for(Employee_Allocation__c ea : [select Id, Name,Employee_Name__c,Employee_Name__r.Name,Employee_Name__r.Project__c,End_Date__c,Release_Name__c,Year__c,
                                               Release_Name__r.Name,Start_Date__c,Release_Name__r.Proejct_Start_Date__c,Release_Name__r.Release_Start_Date__c,Release_Name__r.Release_Planned_End_Date__c,
                                               Release_Name__r.Project_End_Date__c
                                               FROM Employee_Allocation__c
                                               WHERE Employee_Name__c =: apexpages.currentPage().getParameters().get('id')
                                               
                                               ]){
                                               
                                               System.debug('Employee inside aalocation');
                                               
                                              String StartMonth = String.Valueof(ea.Start_Date__c.Month());
                                              if(Integer.Valueof(StartMonth ) < 10)
                                                 StartMonth = StartMonth +''+'0';
                                              String StartYr = String.Valueof(ea.Start_Date__c.Year());
                                              Integer StartMonthYr = Integer.Valueof(StartYr+''+StartMonth);
                                              
                                              System.debug('Start Month Date and Year **********'+StartMonthYr);
                                              
                                              
                                              String EndMonth = String.Valueof(ea.End_Date__c.Month());
                                               if(Integer.Valueof(EndMonth) < 10)
                                                 EndMonth  = EndMonth +''+'0';
                                              String EndYr = String.Valueof(ea.End_Date__c.Year());
                                              Integer EndMonthYr = Integer.Valueof(EndYr+''+EndMonth); 
                                              
                                              System.debug('End  Month Date and Year **********'+EndMonthYr );              
                                               
                             //CurrentMonhDate = date.newInstance(dtYear,mth,day);
                         if(StartMonthYr <= curMonYr && EndMonthYr >= curMonYr){  
                                                
                             empIds.add(ea.Employee_Name__r.Id);
                           emplWrapLst.add(new EmployAllcation(ea));
                       }
           }
            emplst = [select Id,(Select Id,Name,Vocation_Hours__c,Contact__c from Vacations__r) from Employee__c WHERE ID IN:empIds];           
            for(Employee__c ep : emplst){
                for(Vacation__c vc : ep.Vacations__r){        
                         vacnewLst.add(vc);        
                }    
            }
            
            for(Vacation__c voc : vacnewLst){
                
                vacLst.add(voc);
                
            }
            //System.debug('Vacation List is');
           
           //List<Vacation__c> vacLst = [Select Id,Contact__c from Vacation__c where Contact__c IN: empIds];
           
           
           //String monthName = [select Id,Weekly_Start_Date__c from Release__c where Id=:apexpages.currentPage().getParameters().get('id')].Weekly_Start_Date__c;
           //System.debug('Cuurent month from Release is>>>>>>>'+monthName);
           
           /*for(Allocation_Details__c a:[Select Id,Name,Employee_Allocation_Details__c,Day_Year__c,Vacation_Hours__c,Project_Start_Month__c,Allocation_Hours__c,Year_of_Month__c,Release_Month__c 
                            ,Employee_Allocation_Details__r.Start_Date__c,Weekly_Start_Date__c,Employee_Allocation_Details__r.End_Date__c,
                            Employee_Allocation_Details__r.Allocation_Start_Date_Month__c,Employee_Allocation_Details__r.Allocation_End_Date_Month__c   
                            FROM Allocation_Details__c
                           WHERE Employee_Allocation_Details__r.Release_Name__c =: apexpages.currentPage().getParameters().get('id')                           
                           ORDER by Weekly_Start_Date__c ASC]){
                            las.put(a.Id,a);
            }  */
            
            alcdtl =  [Select Id,Year_of_Month__c,Day_Year__c,Allocation_Hours__c,Vacation_Hours__c,Start_Date_of_the_Week__c,Weekly_Start_Date__c,Employee_Allocation_Details__r.Release_Name__r.Name,
                                    Employee_Allocation_Details__r.Allocation_Start_Date_Month__c,Employee_Allocation_Details__r.Allocation_End_Date_Month__c,
                                    Employee_Allocation_Details__r.Start_Date__c, Employee_Allocation_Details__r.End_Date__c,
                                    Employee_Allocation_Details__r.Week_Start_Allocation_Start_Date__c,Employee_Allocation_Details__r.Week_Start_Allocation_End_Date__c,
                                    Employee_Allocation_Details__r.Name 
                                    FROM Allocation_Details__c
                           WHERE Employee_Allocation_Details__r.Employee_Name__c =: apexpages.currentPage().getParameters().get('id')                           
                           ORDER by Weekly_Start_Date__c ASC];
                           
                               
            for(Allocation_Details__c adl: alcdtl){
                
                if(adl.Year_of_Month__c== month ){
                    allDtlLst.add(adl);
                }
            }
            for(Allocation_Details__c  a: allDtlLst){
                 if(a.Employee_Allocation_Details__r.Week_Start_Allocation_Start_Date__c <= a.Weekly_Start_Date__c && a.Employee_Allocation_Details__r.Week_Start_Allocation_End_Date__c >= a.Weekly_Start_Date__c ){ 
                    las.put(a.Id,a);
                 }
            }
             for(Allocation_Details__c u: allDtlLst){
                 
                 distinctLastnames.put(u.Day_Year__c,u.Day_Year__c);                                    
             }
             for(string s:distinctLastnames.values()){
               if(s != null){
                 WeeksLst.add(s);
                 }
             }
           
           weeksize = WeeksLst.Size();
    }
    
    public List<selectOption> getmonths() {
       
        List<selectOption> options = new List<selectOption>();
        
        map<Id,string> distinctLastnames = new map<Id,String>();
        //new list for holding all of the picklist options
        options.add(new selectOption('- None -', '- None -'));
        options.add(new selectOption('January', 'January'));
        options.add(new selectOption('February', 'February'));
        options.add(new selectOption('March', 'March'));
        options.add(new selectOption('April', 'April'));
        options.add(new selectOption('May', 'May'));
        options.add(new selectOption('June', 'June'));
        options.add(new selectOption('July', 'July'));
        options.add(new selectOption('August', 'August'));
        options.add(new selectOption('September', 'September'));
        options.add(new selectOption('October', 'October'));
        options.add(new selectOption('November', 'November'));
        options.add(new selectOption('December', 'December'));
            
         
        return options; //return the picklist options
    }
    
    Public PageReference searchvalues(){
        WeeksLst = new List<String>();
        allDtlLst= new List<Allocation_Details__c>();
        distinctLastnames = new map<string,string>();
        
        emplWrapLst = new List<EmployAllcation>();
        Integer mth;
        Integer Day;
        Integer dtYear;
            if(selectedmonth == 'January'){
                 mth = 1;
                 Day = 1;
            }
            if(selectedmonth == 'February'){
                 mth = 2;
                 Day = 1;
            }
            if(selectedmonth == 'March'){
                 mth = 3;
                 Day = 1;
            }
            if(selectedmonth == 'April'){
                 mth = 4;
                 Day = 1;
            }
            if(selectedmonth == 'May'){
                 mth = 5;
                 Day = 1;
            }
            if(selectedmonth == 'June'){
                 mth = 6;
                 Day = 1;
            }
            if(selectedmonth == 'July'){
                 mth = 7;
                 Day = 1;
            }
            if(selectedmonth == 'August'){
                 mth = 8;
                 Day = 1;
            }if(selectedmonth == 'September'){
                 mth = 9;
                 Day = 1;
            }
            if(selectedmonth == 'October'){
                 mth = 10;
                 Day = 1;
            }
            if(selectedmonth == 'November'){
                 mth = 11;
                 Day = 1;
             }
            if(selectedmonth == 'December'){
                 mth = 12;
                 Day = 1;
            }
            
            
             dtYear = System.Today().Year();
             
             if(dtYear != NUll && mth != Null && day != Null)   CurrentMonhDate = date.newInstance(dtYear,mth,day);
        
        
        if(selectedmonth != '- None -'){
        System.debug('Selected Month is <<<<<<'+selectedmonth);
        
        
        System.debug('Date from Selected Month>>>>>>'+CurrentMonhDate );
        
        if(CurrentMonhDate != Null){
        
        
        for(Employee_Allocation__c ea : [select Id, Name,Employee_Name__c,Employee_Name__r.Name,Employee_Name__r.Project__c,End_Date__c,Release_Name__c,Year__c,
                                               Release_Name__r.Name,Start_Date__c,Release_Name__r.Proejct_Start_Date__c,Release_Name__r.Release_Start_Date__c,Release_Name__r.Release_Planned_End_Date__c,
                                               Release_Name__r.Project_End_Date__c,
                                               (Select Id,Name,Year_of_Month__c,Employee_Allocation_Details__r.Release_Name__c from Allocation_Details__r)
                                               FROM Employee_Allocation__c
                                               WHERE Employee_Name__c =: apexpages.currentPage().getParameters().get('id')]){
                                               
                                              String currentMonth = String.ValueOf(CurrentMonhDate.Month());
                                              if(Integer.Valueof(currentMonth) < 10)
                                                 currentMonth= currentMonth+''+'0';
                                              String CurrentYear = String.Valueof(CurrentMonhDate.Year());
                                              Integer  CurrentMonYr = Integer.Valueof(CurrentYear+''+currentMonth);
                                              
                                              System.debug('Current Month Date and Year **********'+CurrentMonYr);
                                              
                                              String StartMonth = String.Valueof(ea.Start_Date__c.Month());
                                              if(Integer.Valueof(StartMonth) < 10)
                                                 StartMonth = StartMonth +''+'0';
                                              String StartYr = String.Valueof(ea.Start_Date__c.Year());
                                              Integer StartMonthYr = Integer.Valueof(StartYr+''+StartMonth);
                                              
                                              System.debug('Start Month Date and Year **********'+StartMonthYr);
                                              
                                              
                                              String EndMonth = String.Valueof(ea.End_Date__c.Month());
                                              if(Integer.Valueof(EndMonth) < 10)
                                                 EndMonth  = EndMonth +''+'0';
                                              String EndYr = String.Valueof(ea.End_Date__c.Year());
                                              Integer EndMonthYr = Integer.Valueof(EndYr+''+EndMonth);
                                              
                                              System.debug('Start Month Date and Year **********'+EndMonthYr);
                                               
                                               System.debug('Start Date&&&&&&&&&'+ea.Start_Date__c +'End Date>>>>>>>>'+ea.End_Date__c  );
                                            if(StartMonthYr <= CurrentMonYr && EndMonthYr >= CurrentMonYr){
                                                if(ea.Allocation_Details__r.size()>0){
                                                                empIds.add(ea.Employee_Name__r.Id);
                                                                    emplWrapLst.add(new EmployAllcation(ea));
                                                                
                                                }
                                            }
                                System.debug('wrapper added employee list is>>>>'+emplWrapLst);
                               
        }
        }
        /*allDtlLst  = [Select Id,Allocation_Hours__c,Employee_Allocation_Details__c,Vacation_Hours__c,Project_Start_Month__c,Start_Date_of_the_Week__c,Weekly_Start_Date__c,Year_of_Month__c,Day_Year__c
                            ,Employee_Allocation_Details__r.Allocation_Start_Date_Month__c,Employee_Allocation_Details__r.Allocation_End_Date_Month__c   
                            FROM Allocation_Details__c where Year_of_Month__c = : selectedmonth 
                            AND  Employee_Allocation_Details__r.Release_Name__c =: apexpages.currentPage().getParameters().get('id')
                            ORDER BY Weekly_Start_Date__c ASC ];*/
                            
                   for(Allocation_Details__c a: [Select Id,Year_of_Month__c,Day_Year__c,Allocation_Hours__c,Vacation_Hours__c,Start_Date_of_the_Week__c,Weekly_Start_Date__c,Employee_Allocation_Details__r.Release_Name__r.Name,
                                                  Employee_Allocation_Details__r.Allocation_Start_Date_Month__c,Employee_Allocation_Details__r.Allocation_End_Date_Month__c, 
                                                  Employee_Allocation_Details__r.Start_Date__c, Employee_Allocation_Details__r.End_Date__c, 
                                                  Employee_Allocation_Details__r.Week_Start_Allocation_Start_Date__c,Employee_Allocation_Details__r.Week_Start_Allocation_End_Date__c, 
                                                  Employee_Allocation_Details__r.Name
                                                  FROM Allocation_Details__c
                                                where Year_of_Month__c = : selectedmonth 
                                                AND  Employee_Allocation_Details__r.Employee_Name__c =: apexpages.currentPage().getParameters().get('id')
                                                ORDER BY Weekly_Start_Date__c ASC ]){
                            
                            
                                    allDtlLst.add(a);
                            
                   }
                   System.debug('All detail list is >>>>>>'+allDtlLst);
                   System.debug('All detail list Size is as  >>>>>>'+allDtlLst.size());
                   
                   for(Allocation_Details__c  a: allDtlLst){
                         if(a.Employee_Allocation_Details__r.Week_Start_Allocation_Start_Date__c <= a.Weekly_Start_Date__c && a.Employee_Allocation_Details__r.Week_Start_Allocation_End_Date__c >= a.Weekly_Start_Date__c ){ 
                            las.put(a.Id,a);
                         }
                    }
                             
                 if(allDtlLst.Size()>0){            
                     for(Allocation_Details__c u: allDtlLst){
                        
                         distinctLastnames.put(u.Day_Year__c,u.Day_Year__c);                                    
                     }
                 }
                 for(string s:distinctLastnames.values()){
                   if(s != null){
                     WeeksLst.add(s);
                     }
                 }
                 System.debug('Allocation Details as follows>>>>>'+allDtlLst);
                 weeksize = WeeksLst.Size();
        
        }else{
        
            /* allDtlLst  = [Select Id,Year_of_Month__c,Allocation_Hours__c ,Project_Start_Month__c,Employee_Allocation_Details__r.Employee_Name__r.Project__c,Day_Year__c,Start_Date_of_the_Week__c,Weekly_Start_Date__c
                              FROM Allocation_Details__c 
                              WHERE  Employee_Allocation_Details__r.Release_Name__c =: apexpages.currentPage().getParameters().get('id') 
                              ORDER BY Weekly_Start_Date__c ASC];*/
                              
                               for(Employee_Allocation__c ea : [select Id, Name,Employee_Name__c,Employee_Name__r.Name,Employee_Name__r.Project__c,End_Date__c,Release_Name__c,Year__c,
                                               Release_Name__r.Name,Start_Date__c,Release_Name__r.Proejct_Start_Date__c,Release_Name__r.Release_Start_Date__c,Release_Name__r.Release_Planned_End_Date__c,
                                               Release_Name__r.Project_End_Date__c,
                                               (Select Id,Name,Year_of_Month__c,Employee_Allocation_Details__r.Release_Name__c from Allocation_Details__r)
                                               FROM Employee_Allocation__c
                                               WHERE Employee_Name__c =: apexpages.currentPage().getParameters().get('id')
                                               AND (Allocation_Start_Date_Month__c=: month OR Allocation_End_Date_Month__c =: month)]){
                                               if(ea.Allocation_Details__r.size()>0){
                                                                empIds.add(ea.Employee_Name__r.Id);
                                                                    emplWrapLst.add(new EmployAllcation(ea));
                                                                
                                                }
                                  }
                              System.debug('Allocation Details as No Month follows>>>>>'+allDtlLst);  
                              for(Allocation_Details__c  at : [Select Id,Year_of_Month__c,Day_Year__c,Allocation_Hours__c,Vacation_Hours__c,Start_Date_of_the_Week__c,Weekly_Start_Date__c,Employee_Allocation_Details__r.Release_Name__r.Name,
                                                                  Employee_Allocation_Details__r.Allocation_Start_Date_Month__c,Employee_Allocation_Details__r.Allocation_End_Date_Month__c, 
                                                                  Employee_Allocation_Details__r.Start_Date__c, Employee_Allocation_Details__r.End_Date__c, 
                                                                  Employee_Allocation_Details__r.Week_Start_Allocation_Start_Date__c,Employee_Allocation_Details__r.Week_Start_Allocation_End_Date__c, 
                                                                  Employee_Allocation_Details__r.Name
                                                                  FROM Allocation_Details__c
                                                                  WHERE Employee_Allocation_Details__r.Employee_Name__c =: apexpages.currentPage().getParameters().get('id') 
                                                                  ORDER BY Weekly_Start_Date__c ASC]){
                                                    
                            
                                           if(at.Year_of_Month__c== Month){
                                                    allDtlLst.add(at);
                                            }
                                    
                              } 
                              
                              for(Allocation_Details__c  a: allDtlLst){
                                     if(a.Employee_Allocation_Details__r.Week_Start_Allocation_Start_Date__c <= a.Weekly_Start_Date__c && a.Employee_Allocation_Details__r.Week_Start_Allocation_End_Date__c >= a.Weekly_Start_Date__c ){ 
                                        las.put(a.Id,a);
                                     }
                                }   
                              
                              for(Allocation_Details__c u: allDtlLst){
                                     if(u.Year_of_Month__c== Month)
                                     distinctLastnames.put(u.Day_Year__c,u.Day_Year__c);                                    
                             }
                             for(string s:distinctLastnames.values()){
                               if(s != null){
                                 WeeksLst.add(s);
                                 }
                             }  
                             weeksize = WeeksLst.Size();
          }
        
        
        return null;
    }
    
    
    Public PageReference Applyvalues(){
         List<Employee_Allocation__c> selectedEmployee = new List<Employee_Allocation__c>();
         WeeksLst = new List<String>();
         allDtlLst= new List<Allocation_Details__c>();
         distinctLastnames = new map<string,string>();
         
    
         system.debug('yourVariable -->' + enteredhours);
 
          list<string> selectedName = new list<string>();
         for(EmployAllcation aa: emplWrapLst){
             if(aa.selected == true) {
                    selectedEmployee.add(aa.eal);
                    selectedName.add(aa.eal.Name);
                }
         }
        
         
            if(selectedmonth == '- None -' && enteredhours >0 && selectedName.size()>0){
                                 for(Allocation_Details__c al: [Select Id,Year_of_Month__c,Vacation_Hours__c,Day_Year__c,Allocation_Hours__c,Project_Start_Month__c,Start_Date_of_the_Week__c,Weekly_Start_Date__c,Employee_Allocation_Details__r.Release_Name__r.Name,
                              Employee_Allocation_Details__r.Start_Date__c, Employee_Allocation_Details__r.End_Date__c,
                              Employee_Allocation_Details__r.Week_Start_Allocation_Start_Date__c,Employee_Allocation_Details__r.Week_Start_Allocation_End_Date__c,
                              Employee_Allocation_Details__r.Allocation_Start_Date_Month__c,Employee_Allocation_Details__r.Allocation_End_Date_Month__c,Employee_Allocation_Details__r.Name 
                              FROM Allocation_Details__c
                              WHERE Employee_Allocation_Details__r.Name like: selectedName
                              ORDER by Weekly_Start_Date__c ASC]){
                               if(al.Year_of_Month__c== month ){
                                       allDtlLst.add(al);
                               }
                              
                   }
                   
                   for(Allocation_Details__c  a: allDtlLst){
                         if(a.Employee_Allocation_Details__r.Week_Start_Allocation_Start_Date__c <= a.Weekly_Start_Date__c && a.Employee_Allocation_Details__r.Week_Start_Allocation_End_Date__c >= a.Weekly_Start_Date__c ){ 
                            las.put(a.Id,a);
                         }
                    }
                              
                   for(Allocation_Details__c u: allDtlLst){
                     //if(u.Year_of_Month__c== u.Project_Start_Month__c)
                        distinctLastnames.put(u.Day_Year__c,u.Day_Year__c);
                                                         
                 }
                 for(string s:distinctLastnames.values()){
                   if(s != null){
                     WeeksLst.add(s);
                     }
                 }     
                 weeksize = WeeksLst.Size();                    
                              
            } else if(selectedmonth != '- None -' && enteredhours >0 && selectedName.size()>0){
                
                allDtlLst = [Select Id,Year_of_Month__c,Day_Year__c,Allocation_Hours__c,Vacation_Hours__c,Start_Date_of_the_Week__c,Weekly_Start_Date__c,Employee_Allocation_Details__r.Release_Name__r.Name,
                              Employee_Allocation_Details__r.Allocation_Start_Date_Month__c,Employee_Allocation_Details__r.Allocation_End_Date_Month__c, 
                              Employee_Allocation_Details__r.Start_Date__c, Employee_Allocation_Details__r.End_Date__c, 
                              Employee_Allocation_Details__r.Week_Start_Allocation_Start_Date__c,Employee_Allocation_Details__r.Week_Start_Allocation_End_Date__c, 
                              Employee_Allocation_Details__r.Name
                              FROM Allocation_Details__c
                              WHERE Employee_Allocation_Details__r.Name like: selectedName
                              AND Year_of_Month__c =: selectedmonth 
                              ORDER BY Weekly_Start_Date__c ASC
                              ];
                              
                    for(Allocation_Details__c  a: allDtlLst){
                         if(a.Employee_Allocation_Details__r.Week_Start_Allocation_Start_Date__c <= a.Weekly_Start_Date__c && a.Employee_Allocation_Details__r.Week_Start_Allocation_End_Date__c >= a.Weekly_Start_Date__c ){ 
                            las.put(a.Id,a);
                         }
                    }
                 for(Allocation_Details__c u: allDtlLst){
                     distinctLastnames.put(u.Day_Year__c,u.Day_Year__c);                                    
                 }
                 for(string s:distinctLastnames.values()){
                   if(s != null){
                     WeeksLst.add(s);
                     }
                 }      
                      
                 weeksize = WeeksLst.Size();           
            } else if(selectedmonth == '- None -' && enteredhours >0 && selectedName.size()==0){
                allDtlLst = [Select Id,Year_of_Month__c,Day_Year__c,Allocation_Hours__c,Vacation_Hours__c,Start_Date_of_the_Week__c,Weekly_Start_Date__c,Employee_Allocation_Details__r.Release_Name__r.Name,
                                    Employee_Allocation_Details__r.Allocation_Start_Date_Month__c,Employee_Allocation_Details__r.Allocation_End_Date_Month__c,
                                    Employee_Allocation_Details__r.Start_Date__c, Employee_Allocation_Details__r.End_Date__c,
                                    Employee_Allocation_Details__r.Week_Start_Allocation_Start_Date__c,Employee_Allocation_Details__r.Week_Start_Allocation_End_Date__c,
                                    Employee_Allocation_Details__r.Name 
                                    FROM Allocation_Details__c
                                    WHERE Employee_Allocation_Details__r.Employee_Name__c =:ApexPages.currentPage().getParameters().get('id') 
                                    ORDER BY Weekly_Start_Date__c ASC];
                        for(Allocation_Details__c  a: allDtlLst){
                             if(a.Employee_Allocation_Details__r.Week_Start_Allocation_Start_Date__c <= a.Weekly_Start_Date__c && a.Employee_Allocation_Details__r.Week_Start_Allocation_End_Date__c >= a.Weekly_Start_Date__c ){ 
                                las.put(a.Id,a);
                             }
                        }
            }
                
        for(Allocation_Details__c a: allDtlLst){
                 
                if(a.Employee_Allocation_Details__r.Week_Start_Allocation_Start_Date__c <= a.Weekly_Start_Date__c && a.Employee_Allocation_Details__r.Week_Start_Allocation_End_Date__c >= a.Weekly_Start_Date__c ){ 
                     a.id = a.Id;
                     if((a.Vacation_Hours__c+enteredhours)>40){
                         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Total hours for a week (vacation and allocated working hours) should not exceed 40 hours. Please review and resubmit the weekly allocation hours.'));
                      
                     }else{
                             a.Allocation_Hours__c =  enteredhours;
                     }
                     las.put(a.Id,a);
                }
             //las.add(a);
         }
          
        system.debug('selectedResource' + selectedEmployee);
        system.debug('lallocsumm --> ' + selectedName);
        //List<Allocation_Details__c> lasUpd = new List<Allocation_Details__c>();
        if(las.size()>0){
           //update  las;
        }   
          
         return null;
    }
    
    public PageReference Updatevalues(){
      
      // las = new List<Allocation_Details__c>();
       emplWrapLst = new List<EmployAllcation> ();
     // allDtlLst = new List<Allocation_Details__c>();
       /* if(UpdateLstFltr.isempty())
              Update UpdateLstFltr;*/
       
        if(!las.isempty()){
            update las.Values();
          }
        
        if(!allDtlLst.isempty())
            //Update allDtlLst;
            
            System.debug('Month is as follows>>>>>'+month);

                for(Employee_Allocation__c ea : [select Id, Name,Employee_Name__c,Employee_Name__r.Name,Employee_Name__r.Project__c,End_Date__c,Release_Name__c,Year__c,
                                                       Release_Name__r.Name,Start_Date__c,Release_Name__r.Proejct_Start_Date__c,Release_Name__r.Release_Start_Date__c,Release_Name__r.Release_Planned_End_Date__c,
                                                       Release_Name__r.Project_End_Date__c
                                                       FROM Employee_Allocation__c
                                                       WHERE Employee_Name__c =: apexpages.currentPage().getParameters().get('id')
                                                       AND (Allocation_Start_Date_Month__c=: month OR Allocation_End_Date_Month__c =: month)
                                                       ]){
                                          empIds.add(ea.Employee_Name__r.Id);
                                          emplWrapLst.add(new EmployAllcation(ea));
                                       
                 }
         System.debug('emplWrapLst********'+emplWrapLst);
        
       searchvalues();
        enteredhours =0;
        return null;
    }
    public PageReference goback(){   
    
      PageReference newpage = new Pagereference('/apex/VFP_EmployeeAllocation_Clone?Id='+ApexPages.currentPage().getParameters().get('id'));
        newpage.setRedirect(true);
        return newpage;
    }
   
    Public class EmployAllcation{
    
        Public Employee_Allocation__c eal{get;set;}
        Public boolean selected{get;set;}
        
        Public EmployAllcation(Employee_Allocation__c ea){
            eal = ea;
            selected= false;
        
        }
    }

}