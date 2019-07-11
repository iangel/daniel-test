trigger trg_Cal_Vaocation_Hours on Vacation__c (After Insert) {   
    
    if(trigger.isAfter){
    Set<Id>  empLst = new Set<Id>();
    Set<Id> vacLst = new Set<Id>();
        for(Vacation__c vc : Trigger.new){
            empLst.add(vc.Contact__c);
            vacLst.add(Vc.Id);       
        }      
      List<Vacation__c> vaLst = [select Id, Name,Start_Date__c,Start_Date_of_Week_strt__c,End_Date_of_Week_End__c,
                                  End_Date__c from Vacation__c WHERE Contact__c IN: empLst];
      List<Allocation_Details__c> alDtls = [Select Id, Name,Weekly_Start_Date__c from Allocation_Details__c 
                                              WHERE Employee_Allocation_Details__r.Employee_Name__c IN: empLst
                                               ORDER BY Weekly_Start_Date__c ASC];
       System.debug('Allocation details list is>>>>'+alDtls);
       List<Vacation__c> vacUpnewLst = new List<Vacation__c>();
       Map<Id,Allocation_Details__c> upAlLst = new Map<Id,Allocation_Details__c>();
       
        List<Holiday_List__c> holidyLst = Holiday_List__c.getAll().values();
       for(Vacation__c vc: vaLst){
           for(Allocation_Details__c ad: alDtls){                
                    if(vc.Start_Date_of_Week_strt__c <= ad.Weekly_Start_Date__c && vc.End_Date_of_Week_End__c >= ad.Weekly_Start_Date__c){
                   
                       System.debug('end Date in a week');
                       
                       System.debug('Start Date of the week>>>>'+vc.Start_Date_of_Week_strt__c );
                       System.debug('End Date of the week<<<<<'+vc.End_Date_of_Week_End__c);
                       System.debug('Allocation Weekly start Date>>>>>>'+ad.Weekly_Start_Date__c);
                           if(vc.Start_Date_of_Week_strt__c == vc.End_Date_of_Week_End__c ||vc.Start_Date__c == vc.End_Date__c){
                               integer numberDaysDue = (vc.Start_Date__c.daysBetween(vc.End_Date__c))+1;
                               ad.Vacation_Hours__c = (numberDaysDue)*8;
                               upAlLst.put(ad.Id,ad);
                             System.debug('end Date in a week ifffffffffff');  
                           }else{
                               Date endDate_in_Week = vc.Start_Date_of_Week_strt__c.addDays(5);
                               if(vc.Start_Date__c <= endDate_in_Week && vc.Start_Date_of_Week_strt__c == ad.Weekly_Start_Date__c){                                                                      
                                   System.debug('else satatement of two weeks>>>>');
                                   integer numberDaysDue = vc.Start_Date__c.daysBetween(endDate_in_Week);
                                   ad.Vacation_Hours__c = (numberDaysDue)*8;
                                   upAlLst.Put(ad.id,ad);                                
                               }else if(vc.End_Date_of_Week_End__c != ad.Weekly_Start_Date__c){
                                   Date NumdaysWekStartAl = ad.Weekly_Start_Date__c.addDays(5);
                                   integer numberDaysDue = ad.Weekly_Start_Date__c.daysBetween(NumdaysWekStartAl);
                                   ad.Vacation_Hours__c = (numberDaysDue)*8;
                                   upAlLst.Put(ad.id,ad);
                               }else if(vc.End_Date_of_Week_End__c == ad.Weekly_Start_Date__c){
                                   integer numberDaysDue = (vc.End_Date_of_Week_End__c.daysBetween(vc.End_Date__c))+1;
                                   ad.Vacation_Hours__c = (numberDaysDue)*8;
                                   upAlLst.Put(ad.id,ad);
                               }
                           
                           }
                   
                    }                         
                
            }
       
        }
       List<Vacation__c> vacUpLst = [select Id,Start_Date__c,End_Date__c,No_of_Vacation_Days__c
                                        FROM Vacation__c WHERE ID IN:vacLst];
              for(Vacation__c vac: vacUpLst){
                      DateTime sDateTime = Date.ValueOf(vac.Start_Date__c);
                      DateTime eDateTime = Date.ValueOf(vac.End_Date__c);
                      Integer ndays = 1;
            
                    while (sDateTime < eDateTime) {
                        if (sDateTime.formatGMT('E') != 'Sat' && sDateTime.formatGMT('E') != 'Sun') {
                            ndays++;
                       }
                       sDateTime = sDateTime.addDays(1);                                             
                    }                    
                    vac.No_of_Vacation_Days__c = ndays;
                    vacUpnewLst.add(vac);
              }
              
      
       if(upAlLst.Values() != Null && !(upAlLst.Values().isempty()))
           Update upAlLst.Values();
       if(!vacUpnewLst.isempty())
           Update vacUpnewLst;
       
    }
}