@isTest(SeeAllData=false)
public class NS_ExceptionDeleteSchedulerTest {

    static testMethod  void executeTest(){
        
        Exception__c exceptionMock= new  Exception__c();
        // exceptionMock.CreatedDate()= Datetime.newInstance(1960, 2, 17);
        insert exceptionMock;
        //Test.setCreatedDate(exceptionMock.Id, Datetime.now().addDays(0));
        system.debug('SOS '+exceptionMock.CreatedDate);
        test.startTest();
        SchedulableContext sc;
        NS_ExceptionDeleteScheduler testObj= new NS_ExceptionDeleteScheduler();
        testObj.execute(sc); 
        test.stopTest();
        System.debug('SOS Now '+[SELECT Id FROM Exception__c where CreatedDate = LAST_N_DAYS:31]);
        
    }
}