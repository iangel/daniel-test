@isTest
private class NS_GCSTest {
    /*Constants*/
    public static final string USER_REP = 'OSS Rep';
    @isTest
    static void wrapperTest(){
        Profile agent = UserTestFactory.createProfile(USER_REP);
        User testUser = UserTestFactory.createUser(25,agent.Id);  
        system.runAs(testUser){
            System.test.startTest();
        NS_GCS.CustomerSummarySchedule css= new NS_GCS.CustomerSummarySchedule('CutOffDOW', 'CutoffTimeDisp', 'SchCloseTime', 'SchDayOfWeek', 'SchOpenTime');
    	NS_GCS.EquipmentSummary es=new NS_GCS.EquipmentSummary('tname', 'EptyCount', 'Lnth', 'LoadCnt', 'TotalCnt', 'TotalWeight');
        NS_GCS.SummaryBullets sb=new NS_GCS.SummaryBullets('str1', 'str2');
    	System.assertNotEquals(null, css);
        
         System.test.StopTest();
        }
    }
    
}