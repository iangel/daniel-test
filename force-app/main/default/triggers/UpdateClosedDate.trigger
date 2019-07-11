trigger UpdateClosedDate on Defect__c (before update) {

    List<Defect__c> oldDef = new List<Defect__c>((Defect__c[])Trigger.old);
    List<Defect__c> newDef = new List<Defect__c>((Defect__c[])Trigger.new);  

    try{
        String  CurStat = newDef.get(0).Current_status__c;
        String  PrevStat = oldDef.get(0).Current_status__c;

        if(CurStat.length()>=6){
            CurStat = newDef.get(0).Current_status__c.substring(0,6);
        }

        if(PrevStat.length()>=6){
            PrevStat = oldDef.get(0).Current_status__c.substring(0,6);
        }

        if(CurStat.equalsIgnoreCase('CLOSED')){
            newDef[0].Target_Completion_Date__c = null;
            if(!PrevStat.equalsIgnoreCase('CLOSED')){
                newDef[0].Closed_Date__c = datetime.now();
            }
        }

        if(!CurStat.equalsIgnoreCase('CLOSED') & PrevStat.equalsIgnoreCase('CLOSED')){
            newDef[0].Closed_Date__c = null;
        }
    }
    catch(NullPointerException e){
    }
}