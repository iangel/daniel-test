@isTest
private class NS_CarRequestWrapperTest {
/*Constants*/
    public static final string USER_REP = 'OSS Rep';
    @isTest
    static void wrapperTest(){
        Profile agent = UserTestFactory.createProfile(USER_REP);
        User testUser = UserTestFactory.createUser(25,agent.Id);  
        system.runAs(testUser){
        NS_CarRequestWrapper css= new NS_CarRequestWrapper('accepted', '0', 'Y', 'Y', '1','Y','Y','Y','Y','Y','Y','Y');
    	system.test.StartTest();
    	System.assertNotEquals(null, css);
        
         System.test.StopTest();
        }
    }
}