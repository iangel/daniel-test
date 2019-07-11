@isTest
private class NS_RouteReportWrapperTest {
    
    /*Constants*/
    public static final string USER_REP = 'OSS Rep';
    @isTest
    static void wrapperTest(){
        Profile agent = UserTestFactory.createProfile(USER_REP);
        User testUser = UserTestFactory.createUser(25,agent.Id);  
        system.runAs(testUser){
        NS_RouteReportWrapper css= new NS_RouteReportWrapper('DB02', '09141', 'DECATUR', 'Y', 'Y','Y','Y','Y','Y','Y');
    	system.test.StartTest();
    	System.assertNotEquals(null, css);
        
         System.test.StopTest();
        }
    }

}