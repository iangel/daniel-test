@isTest
public class NS_TransitExpTest {
  /*Constants*/
    public static final string USER_REP = 'OSS Rep';
    public final  static String GARDN ='GARDN';
    
     @isTest
    static void testTransitData() {
        Profile agent = UserTestFactory.createProfile(USER_REP);
       	User testUser = UserTestFactory.createUser(25,agent.Id);  
        system.runAs(testUser){
        Account acc = AccountTestFactory.createOnlineServiceAccountRecord(NS_StaticVariablesUtility.Name);            
        String accId= (String)acc.id;
        NS_IntegParams datum= new NS_IntegParams();
        datum.setClassCode(acc.NS_ClassCode__c);
        datum.setStationCode(GARDN);
        datum.setUserId(UserInfo.getUserId());
        System.Test.setMock(HttpCalloutMock.class, new NscorpWSCalloutRequestHandler_Mock());
        system.test.StartTest();
        NS_TransitExp testObj= new NS_TransitExp();
        System.assert(testObj.invokeCallout(datum)<>null);
      System.assert(testObj.responseParser(NS_StaticVariablesUtility.getMockTransitExCountResBody())<>null);    
        System.test.StopTest();
        }
    }
}