@isTest
private class NS_LopaDataWrapperTest {
/*Constants*/
    public static final string USER_REP = 'OSS Rep';
    @isTest
    static void wrapperTest(){
        Profile agent = UserTestFactory.createProfile(USER_REP);
        User testUser = UserTestFactory.createUser(25,agent.Id);  
        system.runAs(testUser){
        NS_LopaDataWrapper css= new NS_LopaDataWrapper('4', '0', '0', '0.00%', '0.00%','0.00%','0.00%','0','32');
    	system.test.StartTest();
    	System.assertNotEquals(null, css);
        
         System.test.StopTest();
        }
    }
}