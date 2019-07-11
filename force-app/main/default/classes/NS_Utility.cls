public without sharing class NS_Utility {
    
    public static void databaseSvResult(List<Database.SaveResult> srList, String methodNm, String classNm)
    {
        List<Exception__c> expList = new List<Exception__c>();
       
        for (Database.SaveResult sr : srList) {
            if (!sr.isSuccess()) {
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred.'); 
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Fields that affected this error: ' + err.getFields());
                    Exception__c excep = new Exception__c();
                    excep.Class_Name__c = classNm;
                    excep.Method_Name__c = methodNm;
                    //excep.Description__c = err.getStatusCode()+' : '+err.getMessage();
                    expList.add(excep);
                }
            } 
        }
        try{
            if(!expList.isEmpty()){
                insert expList;
            }    
        }
        catch(exception exp){
            system.debug('Error in Exception insertion for '+classNm +', '+methodNm+': '+exp.getMessage()) ;
        }
    }
    
    public static void databaseDelResult(List<Database.DeleteResult > srList, String methodNm, String classNm)
    {
        List<Exception__c> expList = new List<Exception__c>();
       
        for (Database.DeleteResult sr : srList) {
            if (!sr.isSuccess()) {
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred.'); 
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Fields that affected this error: ' + err.getFields());
                    Exception__c excep = new Exception__c();
                    excep.Class_Name__c = classNm;
                    excep.Method_Name__c = methodNm;
                    excep.Description__c = err.getStatusCode()+' : '+err.getMessage();
                    expList.add(excep);
                }
            } 
        }
        try{
            if(!expList.isEmpty()){
                insert expList;
            }    
        }
        catch(exception exp){
            system.debug('Error in Exception insertion for '+classNm +', '+methodNm+': '+exp.getMessage()) ;
        }
    }
}