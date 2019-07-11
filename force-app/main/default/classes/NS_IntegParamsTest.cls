@isTest
private class NS_IntegParamsTest {
    /*Constants*/
    public static final string USER_REP = 'OSS Rep';
    /*Constants*/
    public static final string TEST_VALUE = 'TEST';
    
    @isTest
    static void testParams() {
        Profile agent = UserTestFactory.createProfile(USER_REP);
        User testUser = UserTestFactory.createUser(25,agent.Id);  
        String expectedValue = testUser.Id;
        system.runAs(testUser){
            system.test.StartTest();
            NS_IntegParams datum= new NS_IntegParams();
            datum.setClassCode(TEST_VALUE);
            datum.setServingRoad(TEST_VALUE);
            datum.setStationCode(TEST_VALUE);
            datum.setUserId(UserInfo.getUserId());
            datum.setEquipInt(TEST_VALUE)    ;
            datum.setEquipNr(TEST_VALUE);
            datum.setWaybillSrNr(TEST_VALUE);
            System.assertEquals(datum.getWaybillSrNr(),TEST_VALUE );
            System.assertEquals(datum.getEquipNr(),TEST_VALUE );
            System.assertEquals(datum.getEquipInt(),TEST_VALUE );
            System.assertEquals(datum.getClassCode(), TEST_VALUE);
            System.assertEquals(datum.getstationCode(), TEST_VALUE);
            System.assertEquals(datum.getServingRoad(), TEST_VALUE);
            System.assertEquals(datum.getUserId(), expectedValue);
            System.test.StopTest();
        }
    }
}