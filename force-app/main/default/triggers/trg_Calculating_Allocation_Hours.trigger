trigger trg_Calculating_Allocation_Hours on Allocation_Details__c (after Insert,after update) {
    List<Allocation_Details__c> adLst = new List<Allocation_Details__c>();
    List<Allocation_Details__c> upadLst = new List<Allocation_Details__c>();
    Set<Id> alcIds = new Set<Id>();
    
        for(Allocation_Details__c ad: Trigger.new){
            if(ad.Vacation_Hours__c != null && ad.Vacation_Hours__c >0 && ((trigger.oldMap.get(ad.Id).Allocation_Hours__c!= ad.Allocation_Hours__c  ||ad.Allocation_Hours__c == ad.Vacation_Hours__c)||(trigger.oldMap.get(ad.Id).Vacation_Hours__c != ad.Vacation_Hours__c))){
                   alcIds.add(ad.Id);               
                   /*Decimal alchours = ad.Allocation_Hours__c - ad.Vacation_Hours__c;
                   ad.Allocation_Hours__c = Integer.Valueof(alchours);
                   adLst.add(ad);*/
            }
        }
    
        
   
    upadLst = [Select id,Allocation_Hours__c,Vacation_Hours__c from Allocation_Details__c WHERE ID IN: alcIds];
    System.debug('Updated allocation LIst is >>>>>'+upadLst);
    if(!upadLst.isempty()){
        for(Allocation_Details__c ald : upadLst){
           if(ald.Vacation_Hours__c != null && ald.Vacation_Hours__c >0 && ald.Allocation_Hours__c != Null && ald.Allocation_Hours__c>0){
            Allocation_Details__c add = new Allocation_Details__c();
            add.Id = ald.Id;
            If(ald.Allocation_Hours__c >= ald.Vacation_Hours__c)
                add.Allocation_Hours__c = ald.Allocation_Hours__c - ald.Vacation_Hours__c;
            adLst.add(add);
            }
        }
    }
    if(!adLst.isempty()){
        if(checkRecursive_trgrecursive.runOnce())
            update adLst;
    }
   
}