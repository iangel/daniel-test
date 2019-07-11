public class NS_ExceptionDeleteScheduler Implements Schedulable {
     public void execute(SchedulableContext sc){
         List<Exception__c> monthOldExps = [SELECT Id FROM Exception__c where CreatedDate > LAST_N_DAYS:31 ];
         Database.DeleteResult[] delExps = Database.delete(monthOldExps,false);
         List<Exception__c> expList = new List<Exception__c>();
         for(Database.DeleteResult dr : delExps) {
            if(!dr.isSuccess()) {
                Exception__c excep = new Exception__c();
            	for(Database.Error err : dr.getErrors()) {
                    excep.Class_Name__c = 'NS_ExceptionDeleteScheduler';
                    excep.Method_Name__c = 'execute';
                    excep.Description__c = err.getStatusCode()+' : '+err.getMessage();
                    expList.add(excep);
                    break;
                }
            }
        }
        try{
            if(!expList.isEmpty()){
                insert expList;
            }    
        }
        catch(exception exp){
            system.debug('Error in Exception insertion for NS_ExceptionDeleteScheduler') ;
        }
     }
}