@isTest
public class NS_TransitExceptionDetailTest {
    
    /*Constants*/
    public static final string USER_REP = 'OSS Rep';
    public final  static String GARDN ='GARDN';
    
    @isTest
    static void testTransitDetailData() {
        Profile agent = UserTestFactory.createProfile(USER_REP);
        User testUser = UserTestFactory.createUser(25,agent.Id);  
        system.runAs(testUser){
            Account acc = AccountTestFactory.createOnlineServiceAccountRecord(NS_StaticVariablesUtility.Name);            
            String accId= (String)acc.id;
            NS_IntegParams datum= new NS_IntegParams();
            datum.setClassCode(acc.NS_ClassCode__c);
            datum.setStationCode(GARDN);
            datum.setUserId(UserInfo.getUserId());
             datum.setEquipInt('equipInt');
            datum.setEquipNr('equipNr');
            datum.setWaybillSrNr('waybillSrNr');
            System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
            system.test.StartTest();
            NS_TransitExceptionDetail testObj= new NS_TransitExceptionDetail();
            System.assert(testObj.invokeCallout(datum)<>null);
            System.assert(testObj.responseParser(NS_StaticVariablesUtility.getMockTransitExDetailResBody(),datum.getWaybillSrNr())<>null);    
            System.test.StopTest();
        }
    }
}