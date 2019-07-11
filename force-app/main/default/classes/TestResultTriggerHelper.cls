public class TestResultTriggerHelper {
    public static void updateStatusOnTestScenario(List<Test_Result__c> testResults){
        Set<Id> testScenes =  new Set<Id>();
        integer count=0;
        List<Test_Case__c> testSceneUpdate = new List<Test_Case__c>();
        try{
            For(Test_Result__c tr:testResults){
                testScenes.add(tr.Test_Case__c);
            }
            //Check all Test Results for the testScenes
            For(Test_Case__c testScene:[SELECT Id,Execution_Status__c,(select id,Test_Result__c from Test_Results1__r order by Test_Result__c desc) FROM Test_Case__c Where Id In: testScenes]){
                For(Test_Result__c tr:testScene.Test_Results1__r){
                    system.debug('tr-->'+tr);
                    If(tr.Test_Result__c.equals('Failed')){
                        testScene.Execution_Status__c = 'Failed';
                        break;
                    }
                    else If(tr.Test_Result__c.equals('Not Started') || tr.Test_Result__c.equals('In Progress')){
                        testScene.Execution_Status__c = 'Pending';
                    }
                    else{
                        count=count+1;
                    }
                }
                if(count==(testScene.Test_Results1__r).size()){
                    testScene.Execution_Status__c = 'Passed';
                }
                count=0;
                system.debug('testScene-->'+testScene);
                testSceneUpdate.add(testScene);
            }
            system.debug('testSceneUpdate-->'+testSceneUpdate);
            update testSceneUpdate;  
    	}
        catch(Exception ex){
             system.debug('ex: '+ex);  
             system.debug('ex line no: '+ex.getLineNumber());  
        }
    }        
}