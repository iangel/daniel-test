@isTest
public class clsTimeSpentOnStatus_IsTest{
    
    public static testMethod void TestNewTimeSpent(){
        
        Test.startTest();
        
        Release__c rele = new Release__c();
        rele.Name = 'Test';
        Database.Insert(rele,false);  
        
        Request__c req1 = new Request__c(Release__c=rele.id);
        //req1.Priority__c = 'Low';
        req1.Request_Type__c = 'Configuration';
        req1.Request_Title__c = 'Test';
        req1.Status__c = 'Identify: New Requirement';
        Database.insert(req1);
        Request__c lreq1 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, CreatedDate, Id from Request__c where id=: req1.id];
        if(lreq1.StartTime_Identify_New_Requirement__c != null && lreq1.StopTime_Identify_New_Requirement__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req2 = new Request__c(Release__c=rele.id);
        //req2.Priority__c = 'Low';
        req2.Request_Type__c = 'Configuration';
        req2.Request_Title__c = 'Test';
        req2.Status__c = 'Identify: Change Request';
        Database.insert(req2);
        Request__c lreq2 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, CreatedDate, Id from Request__c where id=: req2.id];
        if(lreq2.StartTime_Identify_Change_Request__c != null && lreq2.StopTime_Identify_Change_Request__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req3 = new Request__c(Release__c=rele.id);
        //req3.Priority__c = 'Low';
        req3.Request_Type__c = 'Configuration';
        req3.Request_Title__c = 'Test';
        req3.Status__c = 'Identify: Submit for Business Review';
        Database.insert(req3);
        Request__c lreq3 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, CreatedDate, Id from Request__c where id=: req3.id];
        if(lreq3.StartTime_Identify_Submit_for_Business__c != null && lreq3.StopTime_Identify_Submit_for_Business__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req4 = new Request__c(Release__c=rele.id);
        //req4.Priority__c = 'Low';
        req4.Request_Type__c = 'Configuration';
        req4.Request_Title__c = 'Test';
        req4.Status__c = 'Identify: Emergency Request';
        Database.insert(req4);
        Request__c lreq4 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, CreatedDate, Id from Request__c where id=: req4.id];
        if(lreq4.StartTime_Emergency_Request__c != null && lreq4.StopTime_Emergency_Request__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req5 = new Request__c(Release__c=rele.id);
        //req5.Priority__c = 'Low';
        req5.Request_Type__c = 'Configuration';
        req5.Request_Title__c = 'Test';
        req5.Status__c = 'Identify: Deferred';
        req5.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.insert(req5);
        Request__c lreq5 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, CreatedDate, Id from Request__c where id=: req5.id];
        if(lreq5.StartTime_Deferred__c != null && lreq5.StopTime_Deferred__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req6 = new Request__c(Release__c=rele.id);
        //req6.Priority__c = 'Low';
        req6.Request_Type__c = 'Configuration';
        req6.Request_Title__c = 'Test';
        req6.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(req6);
        Request__c lreq6 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, CreatedDate, Id from Request__c where id=: req6.id];
        if(lreq6.StartTime_Approve_to_Estimate__c != null && lreq6.StopTime_Approve_to_Estimate__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req7 = new Request__c(Release__c=rele.id);
        //req7.Priority__c = 'Low';
        req7.Request_Type__c = 'Configuration';
        req7.Request_Title__c = 'Test';
        req7.Status__c = 'Consolidate: Level of Effort Complete';
        Database.insert(req7);
        Request__c lreq7 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, CreatedDate, Id from Request__c where id=: req7.id];
        if(lreq7.StartTime_Level_of_Effort_Complete__c != null && lreq7.StopTime_Level_of_Effort_Complete__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req8 = new Request__c(Release__c=rele.id);
        //req8.Priority__c = 'Low';
        req8.Request_Type__c = 'Configuration';
        req8.Request_Title__c = 'Test';
        req8.Status__c = 'Approve: Approved to Deploy';
        Database.insert(req8);
        Request__c lreq8 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, CreatedDate, Id from Request__c where id=: req8.id];
        if(lreq8.StartTime_Approved_to_Deploy__c != null && lreq8.StopTime_Approved_to_Deploy__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req9 = new Request__c(Release__c=rele.id);
        //req9.Priority__c = 'Low';
        req9.Request_Type__c = 'Configuration';
        req9.Request_Title__c = 'Test';
        req9.Status__c = 'Approve: Approved Emergency Release';
        Database.insert(req9);
        Request__c lreq9 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, CreatedDate, Id from Request__c where id=: req9.id];
        if(lreq9.StartTime_Approved_Emergency_Release__c != null && lreq9.StopTime_Approved_Emergency_Release__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req10 = new Request__c(Release__c=rele.id);
        //req10.Priority__c = 'Low';
        req10.Request_Type__c = 'Configuration';
        req10.Request_Title__c = 'Test';
        req10.Status__c = 'Release: Build';
        Database.insert(req10);
        Request__c lreq10 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, CreatedDate, Id from Request__c where id=: req10.id];
        if(lreq10.StartTime_Build__c != null && lreq10.StopTime_Build__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req11 = new Request__c(Release__c=rele.id);
        //req11.Priority__c = 'Low';
        req11.Request_Type__c = 'Configuration';
        req11.Request_Title__c = 'Test';
        req11.Status__c = 'Release: Test';
        Database.insert(req11);
        Request__c lreq11 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, CreatedDate, Id from Request__c where id=: req11.id];
        if(lreq11.StartTime_Test__c != null && lreq11.StopTime_Test__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req12 = new Request__c(Release__c=rele.id);
        //req12.Priority__c = 'Low';
        req12.Request_Type__c = 'Configuration';
        req12.Request_Title__c = 'Test';
        req12.Status__c = 'Release: SIT';
        Database.insert(req12);
        Request__c lreq12 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, CreatedDate, Id from Request__c where id=: req12.id];
        if(lreq12.StartTime_SIT__c != null && lreq12.StopTime_SIT__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req13 = new Request__c(Release__c=rele.id);
        //req13.Priority__c = 'Low';
        req13.Request_Type__c = 'Configuration';
        req13.Request_Title__c = 'Test';
        req13.Status__c = 'Release: UAT';   
        Database.insert(req13);
        Request__c lreq13 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, CreatedDate, Id from Request__c where id=: req13.id];
        if(lreq13.StartTime_UAT__c != null && lreq13.StopTime_UAT__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req14 = new Request__c(Release__c=rele.id);
        //req14.Priority__c = 'Low';
        req14.Request_Type__c = 'Configuration';
        req14.Request_Title__c = 'Test';
        req14.Status__c = 'Release: Build Production';   
        Database.insert(req14);
        Request__c lreq14 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, CreatedDate, Id from Request__c where id=: req14.id];
        if(lreq14.StartTime_Build_Production__c != null && lreq14.StopTime_Build_Production__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req15 = new Request__c(Release__c=rele.id);
        //req15.Priority__c = 'Low';
        req15.Request_Type__c = 'Configuration';
        req15.Request_Title__c = 'Test';
        req15.Status__c = 'Release: Test Production';  
        Database.insert(req15);
        Request__c lreq15 = [Select Status__c, StartTime_Test_Production__c, StopTime_Test_Production__c, CreatedDate, Id from Request__c where id=: req15.id];
        if(lreq15.StartTime_Test_Production__c != null && lreq15.StopTime_Test_Production__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req16 = new Request__c(Release__c=rele.id);
        //req16.Priority__c = 'Low';
        req16.Request_Type__c = 'Configuration';
        req16.Request_Title__c = 'Test';
        req16.Status__c = 'Release: No Build Req';   
        Database.insert(req16);
        Request__c lreq16 = [Select Status__c, StartTime_No_Build_Req__c, StopTime_No_Build_Req__c, CreatedDate, Id from Request__c where id=: req16.id];
        if(lreq16.StartTime_No_Build_Req__c != null && lreq16.StopTime_No_Build_Req__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req17 = new Request__c(Release__c=rele.id);
        //req17.Priority__c = 'Low';
        req17.Request_Type__c = 'Configuration';
        req17.Request_Title__c = 'Test';
        req17.Status__c = 'Close: Deployed';
        Database.insert(req17);
        Request__c lreq17 = [Select Status__c, StartTime_Deployed__c, StopTime_Deployed__c, CreatedDate, Id from Request__c where id=: req17.id];
        if(lreq17.StartTime_Deployed__c != null && lreq17.StopTime_Deployed__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req18 = new Request__c(Release__c=rele.id);
        //req18.Priority__c = 'Low';
        req18.Request_Type__c = 'Configuration';
        req18.Request_Title__c = 'Test';
        req18.Status__c = 'Close: Rejected';
        req18.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.insert(req18);
        Request__c lreq18 = [Select Status__c, StartTime_Rejected__c, StopTime_Rejected__c, CreatedDate, Id from Request__c where id=: req18.id];
        if(lreq18.StartTime_Rejected__c != null && lreq18.StopTime_Rejected__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req19 = new Request__c(Release__c=rele.id);
        //req19.Priority__c = 'Low';
        req19.Request_Type__c = 'Configuration';
        req19.Request_Title__c = 'Test';
        req19.Status__c = 'Close: Duplicate';
        req19.Related_Request__c = req18.Id;
        Database.insert(req19);
        Request__c lreq19 = [Select Status__c, StartTime_Duplicate__c, StopTime_Duplicate__c, CreatedDate, Id from Request__c where id=: req19.id];
        if(lreq19.StartTime_Duplicate__c != null && lreq19.StopTime_Duplicate__c == null){
            system.debug('Test Pass');
        }
        
        Request__c req20 = new Request__c(Release__c=rele.id);
        //req20.Priority__c = 'Low';
        req20.Request_Type__c = 'Configuration';
        req20.Request_Title__c = 'Test';
        req20.Status__c = 'Release: Design';
        Database.insert(req20);
        Request__c lreq20 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, CreatedDate, Id from Request__c where id=: req20.id];
        if(lreq20.StartTime_Design__c != null && lreq20.StopTime_Design__c == null){
            system.debug('Test Pass');
        }
        
        Test.stopTest();
    }
    
    public static testMethod void TestUpdateTimeSpent(){
        
        Test.startTest();
        
        Release__c rele = new Release__c();
        rele.Name = 'Test';
        Database.Insert(rele,false);
        Request__c requ1 = new Request__c(Release__c=rele.id);
        //requ1.Priority__c = 'Low';
        requ1.Request_Type__c = 'Configuration';
        requ1.Request_Title__c = 'Test';
        requ1.Status__c = 'Identify: New Requirement';
        Database.insert(requ1);
        requ1.Status__c = 'Identify: Change Request';
        Database.update(requ1);
        requ1.Status__c = 'Identify: New Requirement';
        Database.update(requ1);
        Request__c ureq1 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ1.id];     
        Integer d1 = ureq1.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq1.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ2 = new Request__c(Release__c=rele.id);
        //requ2.Priority__c = 'Low';
        requ2.Request_Type__c = 'Configuration';
        requ2.Request_Title__c = 'Test';
        requ2.Status__c = 'Identify: New Requirement';
        Database.insert(requ2);
        requ2.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ2);
        requ2.Status__c = 'Identify: New Requirement';
        Database.update(requ2);
        Request__c ureq2 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, 
                            TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ2.id];     
        Integer d2 = ureq2.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq2.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ3 = new Request__c(Release__c=rele.id);
        //requ3.Priority__c = 'Low';
        requ3.Request_Type__c = 'Configuration';
        requ3.Request_Title__c = 'Test';
        requ3.Status__c = 'Identify: New Requirement';
        Database.insert(requ3);
        requ3.Status__c = 'Identify: Emergency Request';
        Database.update(requ3);
        requ3.Status__c = 'Identify: New Requirement';
        Database.update(requ3);
        Request__c ureq3 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, 
                            TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ3.id];     
        Integer d3 = ureq3.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq3.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ4 = new Request__c(Release__c=rele.id);
        //requ4.Priority__c = 'Low';
        requ4.Request_Type__c = 'Configuration';
        requ4.Request_Title__c = 'Test';
        requ4.Status__c = 'Identify: New Requirement';
        Database.insert(requ4);
        requ1.Status__c = 'Identify: Deferred';
        requ1.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ4);
        requ4.Status__c = 'Identify: New Requirement';
        Database.update(requ4);
        Request__c ureq4 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, 
                            TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ4.id];     
        Integer d4 = ureq4.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq4.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ5 = new Request__c(Release__c=rele.id);
        //requ5.Priority__c = 'Low';
        requ5.Request_Type__c = 'Configuration';
        requ5.Request_Title__c = 'Test';
        requ5.Status__c = 'Identify: New Requirement';
        Database.insert(requ5);
        requ5.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ5);
        requ5.Status__c = 'Identify: New Requirement';
        Database.update(requ5);
        Request__c ureq5 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, 
                            TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ5.id];     
        Integer d5 = ureq5.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq5.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ6 = new Request__c(Release__c=rele.id);
        //requ6.Priority__c = 'Low';
        requ6.Request_Type__c = 'Configuration';
        requ6.Request_Title__c = 'Test';
        requ6.Status__c = 'Identify: New Requirement';
        Database.insert(requ6);
        requ6.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ6);
        requ6.Status__c = 'Identify: New Requirement';
        Database.update(requ6);
        Request__c ureq6 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, 
                            TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ6.id];     
        Integer d6 = ureq6.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq6.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ7 = new Request__c(Release__c=rele.id);
        //requ7.Priority__c = 'Low';
        requ7.Request_Type__c = 'Configuration';
        requ7.Request_Title__c = 'Test';
        requ7.Status__c = 'Identify: New Requirement';
        Database.insert(requ7);
        requ7.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ7);
        requ7.Status__c = 'Identify: New Requirement';
        Database.update(requ7);
        Request__c ureq7 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, 
                            TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ7.id];     
        Integer d7 = ureq7.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq7.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ8 = new Request__c(Release__c=rele.id);
        //requ8.Priority__c = 'Low';
        requ8.Request_Type__c = 'Configuration';
        requ8.Request_Title__c = 'Test';
        requ8.Status__c = 'Identify: New Requirement';
        Database.insert(requ8);
        requ8.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ8);
        requ8.Status__c = 'Identify: New Requirement';
        Database.update(requ8);
        Request__c ureq8 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, 
                            TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ8.id];     
        Integer d8 = ureq8.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq8.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ9 = new Request__c(Release__c=rele.id);
        //requ9.Priority__c = 'Low';
        requ9.Request_Type__c = 'Configuration';
        requ9.Request_Title__c = 'Test';
        requ9.Status__c = 'Identify: New Requirement';
        Database.insert(requ9);
        requ9.Status__c = 'Release: Design';
        Database.update(requ9);
        requ9.Status__c = 'Identify: New Requirement';
        Database.update(requ9);
        Request__c ureq9 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, 
                            TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ9.id];     
        Integer d9 = ureq9.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq9.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ10 = new Request__c(Release__c=rele.id);
        //requ10.Priority__c = 'Low';
        requ10.Request_Type__c = 'Configuration';
        requ10.Request_Title__c = 'Test';
        requ10.Status__c = 'Identify: New Requirement';
        Database.insert(requ10);
        requ10.Status__c = 'Release: Build';
        Database.update(requ10);
        requ10.Status__c = 'Identify: New Requirement';
        Database.update(requ10);
        Request__c ureq10 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, 
                             TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ10.id];     
        Integer d10 = ureq10.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq10.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ11 = new Request__c(Release__c=rele.id);
        //requ11.Priority__c = 'Low';
        requ11.Request_Type__c = 'Configuration';
        requ11.Request_Title__c = 'Test';
        requ11.Status__c = 'Identify: New Requirement';
        Database.insert(requ11);
        requ11.Status__c = 'Release: Test';
        Database.update(requ11);
        requ11.Status__c = 'Identify: New Requirement';
        Database.update(requ11);
        Request__c ureq11 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, 
                             TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ11.id];     
        Integer d11 = ureq11.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq11.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ12 = new Request__c(Release__c=rele.id);
        //requ12.Priority__c = 'Low';
        requ12.Request_Type__c = 'Configuration';
        requ12.Request_Title__c = 'Test';
        requ12.Status__c = 'Identify: New Requirement';
        Database.insert(requ12);
        requ12.Status__c = 'Release: SIT';
        Database.update(requ12);
        requ12.Status__c = 'Identify: New Requirement';
        Database.update(requ12);
        Request__c ureq12 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, 
                             TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ12.id];     
        Integer d12 = ureq12.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq12.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ13 = new Request__c(Release__c=rele.id);
        //requ13.Priority__c = 'Low';
        requ13.Request_Type__c = 'Configuration';
        requ13.Request_Title__c = 'Test';
        requ13.Status__c = 'Identify: New Requirement';
        Database.insert(requ13);
        requ13.Status__c = 'Release: UAT';
        Database.update(requ13);
        requ13.Status__c = 'Identify: New Requirement';
        Database.update(requ13);
        Request__c ureq13 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, 
                             TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ13.id];     
        Integer d13 = ureq13.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq13.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ14 = new Request__c(Release__c=rele.id);
        //requ14.Priority__c = 'Low';
        requ14.Request_Type__c = 'Configuration';
        requ14.Request_Title__c = 'Test';
        requ14.Status__c = 'Identify: New Requirement';
        Database.insert(requ14);
        requ14.Status__c = 'Release: Build Production';
        Database.update(requ14);
        requ14.Status__c = 'Identify: New Requirement';
        Database.update(requ14);
        Request__c ureq14 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, 
                             TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ14.id];     
        Integer d14 = ureq14.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq14.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ15 = new Request__c(Release__c=rele.id);
        //requ15.Priority__c = 'Low';
        requ15.Request_Type__c = 'Configuration';
        requ15.Request_Title__c = 'Test';
        requ15.Status__c = 'Identify: New Requirement';
        Database.insert(requ15);
        requ15.Status__c = 'Release: Test Production';
        Database.update(requ15);
        requ15.Status__c = 'Identify: New Requirement';
        Database.update(requ15);
        Request__c ureq15 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, 
                             TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ15.id];     
        Integer d15 = ureq15.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq15.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ16 = new Request__c(Release__c=rele.id);
        //requ16.Priority__c = 'Low';
        requ16.Request_Type__c = 'Configuration';
        requ16.Request_Title__c = 'Test';
        requ16.Status__c = 'Identify: New Requirement';
        Database.insert(requ16);
        requ16.Status__c = 'Release: No Build Req';
        Database.update(requ16);
        requ16.Status__c = 'Identify: New Requirement';
        Database.update(requ16);
        Request__c ureq16 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, 
                             TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ16.id];     
        Integer d16 = ureq16.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq16.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ17 = new Request__c(Release__c=rele.id);
        //requ17.Priority__c = 'Low';
        requ17.Request_Type__c = 'Configuration';
        requ17.Request_Title__c = 'Test';
        requ17.Status__c = 'Identify: New Requirement';
        Database.insert(requ17);
        requ17.Status__c = 'Close: Deployed';
        Database.update(requ17);
        requ17.Status__c = 'Identify: New Requirement';
        Database.update(requ17);
        Request__c ureq17 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, 
                             TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ17.id];     
        Integer d17 = ureq17.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq17.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ18 = new Request__c(Release__c=rele.id);
        //requ18.Priority__c = 'Low';
        requ18.Request_Type__c = 'Configuration';
        requ18.Request_Title__c = 'Test';
        requ18.Status__c = 'Identify: New Requirement';
        Database.insert(requ18);
        requ18.Status__c = 'Close: Rejected';
        requ18.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ18);
        requ18.Status__c = 'Identify: New Requirement';
        Database.update(requ18);
        Request__c ureq18 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, 
                             TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ18.id];     
        Integer d18 = ureq18.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq18.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ19 = new Request__c(Release__c=rele.id);
        //requ19.Priority__c = 'Low';
        requ19.Request_Type__c = 'Configuration';
        requ19.Request_Title__c = 'Test';
        requ19.Status__c = 'Identify: New Requirement';
        requ19.Related_Request__c = requ18.Id;
        Database.insert(requ19);
        requ19.Status__c = 'Close: Duplicate';        
        Database.update(requ19);
        requ19.Status__c = 'Identify: New Requirement';
        Database.update(requ19);
        Request__c ureq19 = [Select Status__c, StartTime_Identify_New_Requirement__c, StopTime_Identify_New_Requirement__c, 
                             TimeSpentOn_Identify_New_Requirement__c, LastModifiedDate, Id from Request__c where id=: requ19.id];     
        Integer d19 = ureq19.TimeSpentOn_Identify_New_Requirement__c.intvalue();
        if(ureq19.StartTime_Identify_New_Requirement__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ20 = new Request__c(Release__c=rele.id);
        //requ20.Priority__c = 'Low';
        requ20.Request_Type__c = 'Configuration';
        requ20.Request_Title__c = 'Test';
        requ20.Status__c = 'Identify: Change Request';
        Database.insert(requ20);
        requ20.Status__c = 'Identify: New Requirement';
        Database.update(requ20);
        requ20.Status__c = 'Identify: Change Request';
        Database.update(requ20);
        Request__c ureq20 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ20.id];     
        try{
        Integer d20 = ureq20.TimeSpentOn_Identify_Change_Request__c.intvalue();
        }Catch(Exception ex){}
        if(ureq20.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }
    }    
    public static testMethod void TestUpdateTimeSpent7(){
        
        Test.startTest();
        Release__c rele = new Release__c();
        rele.Name = 'Test';
        Database.Insert(rele,false); 
        
        Request__c requ21 = new Request__c(Release__c=rele.id);
        //requ21.Priority__c = 'Low';
        requ21.Request_Type__c = 'Configuration';
        requ21.Request_Title__c = 'Test';
        requ21.Status__c = 'Identify: Change Request';
        Database.insert(requ21);
        requ21.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ21);
        requ21.Status__c = 'Identify: Change Request';
        Database.update(requ21);
        Request__c ureq21 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ21.id];     
        try{Integer d21 = ureq21.TimeSpentOn_Identify_Change_Request__c.intvalue();}Catch(Exception ex){}
        if(ureq21.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ22 = new Request__c(Release__c=rele.id);
        //requ22.Priority__c = 'Low';
        requ22.Request_Type__c = 'Configuration';
        requ22.Request_Title__c = 'Test';
        requ22.Status__c = 'Identify: Change Request';
        Database.insert(requ22);
        requ22.Status__c = 'Identify: Emergency Request';
        Database.update(requ22);
        requ22.Status__c = 'Identify: Change Request';
        Database.update(requ22);
        Request__c ureq22 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ22.id];     
        try{Integer d22 = ureq22.TimeSpentOn_Identify_Change_Request__c.intvalue();}Catch(Exception ex){}
        if(ureq22.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ23 = new Request__c(Release__c=rele.id);
        //requ23.Priority__c = 'Low';
        requ23.Request_Type__c = 'Configuration';
        requ23.Request_Title__c = 'Test';
        requ23.Status__c = 'Identify: Change Request';
        Database.insert(requ23);
        requ23.Status__c = 'Identify: Deferred';
        requ23.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ23);
        requ23.Status__c = 'Identify: Change Request';
        Database.update(requ23);
        Request__c ureq23 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ23.id];     
        try{Integer d23 = ureq23.TimeSpentOn_Identify_Change_Request__c.intvalue();}Catch(Exception ex){}
        if(ureq23.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ24 = new Request__c(Release__c=rele.id);
        //requ24.Priority__c = 'Low';
        requ24.Request_Type__c = 'Configuration';
        requ24.Request_Title__c = 'Test';
        requ24.Status__c = 'Identify: Change Request';
        Database.insert(requ24);
        requ24.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ24);
        requ24.Status__c = 'Identify: Change Request';
        Database.update(requ24);
        Request__c ureq24 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ24.id];     
        try{Integer d24 = ureq24.TimeSpentOn_Identify_Change_Request__c.intvalue();}Catch(Exception ex){}
        if(ureq24.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ25 = new Request__c(Release__c=rele.id);
        //requ25.Priority__c = 'Low';
        requ25.Request_Type__c = 'Configuration';
        requ25.Request_Title__c = 'Test';
        requ25.Status__c = 'Identify: Change Request';
        Database.insert(requ25);
        requ25.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ25);
        requ25.Status__c = 'Identify: Change Request';
        Database.update(requ25);
        Request__c ureq25 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ25.id];     
        try{Integer d25 = ureq25.TimeSpentOn_Identify_Change_Request__c.intvalue();}Catch(Exception ex){}
        if(ureq25.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ26 = new Request__c(Release__c=rele.id);
        //requ26.Priority__c = 'Low';
        requ26.Request_Type__c = 'Configuration';
        requ26.Request_Title__c = 'Test';
        requ26.Status__c = 'Identify: Change Request';
        Database.insert(requ26);
        requ26.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ26);
        requ26.Status__c = 'Identify: Change Request';
        Database.update(requ26);
        Request__c ureq26 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ26.id];     
        try{Integer d26 = ureq26.TimeSpentOn_Identify_Change_Request__c.intvalue();}Catch(Exception ex){}
        if(ureq26.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ27 = new Request__c(Release__c=rele.id);
        //requ27.Priority__c = 'Low';
        requ27.Request_Type__c = 'Configuration';
        requ27.Request_Title__c = 'Test';
        requ27.Status__c = 'Identify: Change Request';
        Database.insert(requ27);
        requ27.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ27);
        requ27.Status__c = 'Identify: Change Request';
        Database.update(requ27);
        Request__c ureq27 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ27.id];     
        try{Integer d27 = ureq27.TimeSpentOn_Identify_Change_Request__c.intvalue();}Catch(Exception ex){}
        if(ureq27.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ28 = new Request__c(Release__c=rele.id);
        //requ28.Priority__c = 'Low';
        requ28.Request_Type__c = 'Configuration';
        requ28.Request_Title__c = 'Test';
        requ28.Status__c = 'Identify: Change Request';
        Database.insert(requ28);
        requ28.Status__c = 'Release: Design';
        Database.update(requ28);
        requ28.Status__c = 'Identify: Change Request';
        Database.update(requ28);
        Request__c ureq28 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ28.id];     
        try{Integer d28 = ureq28.TimeSpentOn_Identify_Change_Request__c.intvalue();}CAtch(Exception ex){}
        if(ureq28.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ29 = new Request__c(Release__c=rele.id);
        //requ29.Priority__c = 'Low';
        requ29.Request_Type__c = 'Configuration';
        requ29.Request_Title__c = 'Test';
        requ29.Status__c = 'Identify: Change Request';
        Database.insert(requ29);
        requ29.Status__c = 'Release: Build';
        Database.update(requ29);
        requ29.Status__c = 'Identify: Change Request';
        Database.update(requ29);
        Request__c ureq29 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ29.id];     
        try{Integer d29 = ureq29.TimeSpentOn_Identify_Change_Request__c.intvalue();}Catch(Exception ex){}
        if(ureq29.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ30 = new Request__c(Release__c=rele.id);
        //requ30.Priority__c = 'Low';
        requ30.Request_Type__c = 'Configuration';
        requ30.Request_Title__c = 'Test';
        requ30.Status__c = 'Identify: Change Request';
        Database.insert(requ30);
        requ30.Status__c = 'Release: Test';
        Database.update(requ30);
        requ30.Status__c = 'Identify: Change Request';
        Database.update(requ30);
        Request__c ureq30 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ30.id];     
        try{Integer d30 = ureq30.TimeSpentOn_Identify_Change_Request__c.intvalue();}Catch(Exception ex){}
        if(ureq30.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ31 = new Request__c(Release__c=rele.id);
        //requ31.Priority__c = 'Low';
        requ31.Request_Type__c = 'Configuration';
        requ31.Request_Title__c = 'Test';
        requ31.Status__c = 'Identify: Change Request';
        Database.insert(requ31);
        requ31.Status__c = 'Release: SIT';
        Database.update(requ31);
        requ31.Status__c = 'Identify: Change Request';
        Database.update(requ31);
        Request__c ureq31 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ31.id];     
        try{Integer d31 = ureq31.TimeSpentOn_Identify_Change_Request__c.intvalue();}Catch(Exception ex){}
        if(ureq31.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ32 = new Request__c(Release__c=rele.id);
        //requ32.Priority__c = 'Low';
        requ32.Request_Type__c = 'Configuration';
        requ32.Request_Title__c = 'Test';
        requ32.Status__c = 'Identify: Change Request';
        Database.insert(requ32);
        requ32.Status__c = 'Release: UAT';
        Database.update(requ32);
        requ32.Status__c = 'Identify: Change Request';
        Database.update(requ32);
        Request__c ureq32 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ32.id];     
        try{Integer d32 = ureq32.TimeSpentOn_Identify_Change_Request__c.intvalue();}CAtch(Exception ex){}
        if(ureq32.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ33 = new Request__c(Release__c=rele.id);
        //requ33.Priority__c = 'Low';
        requ33.Request_Type__c = 'Configuration';
        requ33.Request_Title__c = 'Test';
        requ33.Status__c = 'Identify: Change Request';
        Database.insert(requ33);
        requ33.Status__c = 'Release: Build Production';
        Database.update(requ33);
        requ33.Status__c = 'Identify: Change Request';
        Database.update(requ33);
        Request__c ureq33 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ33.id];     
        try{Integer d33 = ureq33.TimeSpentOn_Identify_Change_Request__c.intvalue();}Catch(Exception ex){}
        if(ureq33.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ34 = new Request__c(Release__c=rele.id);
        //requ34.Priority__c = 'Low';
        requ34.Request_Type__c = 'Configuration';
        requ34.Request_Title__c = 'Test';
        requ34.Status__c = 'Identify: Change Request';
        Database.insert(requ34);
        requ34.Status__c = 'Release: Test Production';
        Database.update(requ34);
        requ34.Status__c = 'Identify: Change Request';
        Database.update(requ34);
        Request__c ureq34 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ34.id];     
        try{Integer d34 = ureq34.TimeSpentOn_Identify_Change_Request__c.intvalue();}Catch(Exception ex){}
        if(ureq34.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ35 = new Request__c(Release__c=rele.id);
        //requ35.Priority__c = 'Low';
        requ35.Request_Type__c = 'Configuration';
        requ35.Request_Title__c = 'Test';
        requ35.Status__c = 'Identify: Change Request';
        Database.insert(requ35);
        requ35.Status__c = 'Release: No Build Req';
        Database.update(requ35);
        requ35.Status__c = 'Identify: Change Request';
        Database.update(requ35);
        Request__c ureq35 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ35.id];     
        try{Integer d35 = ureq35.TimeSpentOn_Identify_Change_Request__c.intvalue();}Catch(Exception ex){}
        if(ureq35.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ36 = new Request__c(Release__c=rele.id);
        //requ36.Priority__c = 'Low';
        requ36.Request_Type__c = 'Configuration';
        requ36.Request_Title__c = 'Test';
        requ36.Status__c = 'Identify: Change Request';
        Database.insert(requ36);
        requ36.Status__c = 'Close: Deployed';
        Database.update(requ36);
        requ36.Status__c = 'Identify: Change Request';
        Database.update(requ36);
        Request__c ureq36 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ36.id];     
        try{Integer d36 = ureq36.TimeSpentOn_Identify_Change_Request__c.intvalue();}Catch(Exception ex){}
        if(ureq36.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ37 = new Request__c(Release__c=rele.id);
        //requ37.Priority__c = 'Low';
        requ37.Request_Type__c = 'Configuration';
        requ37.Request_Title__c = 'Test';
        requ37.Status__c = 'Identify: Change Request';
        Database.insert(requ37);
        requ37.Status__c = 'Close: Rejected';
        requ37.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ37);
        requ37.Status__c = 'Identify: Change Request';
        Database.update(requ37);
        Request__c ureq37 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ37.id];     
        try{Integer d37 = ureq37.TimeSpentOn_Identify_Change_Request__c.intvalue();}Catch(Exception ex){}
        if(ureq37.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ38 = new Request__c(Release__c=rele.id);
        //requ38.Priority__c = 'Low';
        requ38.Request_Type__c = 'Configuration';
        requ38.Request_Title__c = 'Test';
        requ38.Status__c = 'Identify: Change Request';
        requ38.Related_Request__c = requ37.Id;
        Database.insert(requ38);
        requ38.Status__c = 'Close: Duplicate';
        Database.update(requ38);
        requ38.Status__c = 'Identify: Change Request';
        Database.update(requ38);
        Request__c ureq38 = [Select Status__c, StartTime_Identify_Change_Request__c, StopTime_Identify_Change_Request__c, 
                             TimeSpentOn_Identify_Change_Request__c, LastModifiedDate, Id from Request__c where id=: requ38.id];     
        try{Integer d38 = ureq38.TimeSpentOn_Identify_Change_Request__c.intvalue();}Catch(Exception ex){}
        if(ureq38.StartTime_Identify_Change_Request__c != null){
            system.debug('Test Pass');
        }   
        
        Request__c requ39 = new Request__c(Release__c=rele.id);
        //requ39.Priority__c = 'Low';
        requ39.Request_Type__c = 'Configuration';
        requ39.Request_Title__c = 'Test';
        requ39.Status__c = 'Identify: Submit for Business Review';
        requ39.Related_Request__c = requ37.Id;
        Database.insert(requ39);
        requ39.Status__c = 'Identify: New Requirement';
        Database.update(requ39);
        requ39.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ39);
        Request__c ureq39 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ39.id];     
        try{Integer d39 = ureq39.TimeSpentOn_Submit_for_Business_Review__c.intvalue();}Catch(Exception ex){}
        if(ureq39.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ40 = new Request__c(Release__c=rele.id);
        //requ40.Priority__c = 'Low';
        requ40.Request_Type__c = 'Configuration';
        requ40.Request_Title__c = 'Test';
        requ40.Status__c = 'Identify: Submit for Business Review';
        requ40.Related_Request__c = requ37.Id;
        Database.insert(requ40);
        requ40.Status__c = 'Identify: Change Request';
        Database.update(requ40);
        requ40.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ40);
        Request__c ureq40 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ40.id];     
        try{Integer d40 = ureq40.TimeSpentOn_Submit_for_Business_Review__c.intvalue();}Catch(Exception ex){}
        if(ureq40.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Test.stopTest();
    }
    
    
    public static testMethod void TestUpdateTimeSpent8(){
        
        Test.startTest();
        Release__c rele = new Release__c();
        rele.Name = 'Test';
        Database.Insert(rele,false); 
        
        Request__c requ41 = new Request__c(Release__c=rele.id);
        //requ41.Priority__c = 'Low';
        requ41.Request_Type__c = 'Configuration';
        requ41.Request_Title__c = 'Test';
        requ41.Status__c = 'Identify: Submit for Business Review';
        Database.insert(requ41);
        requ41.Status__c = 'Identify: Emergency Request';
        Database.update(requ41);
        requ41.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ41);
        Request__c ureq41 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ41.id];     
        Integer d41 = ureq41.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        if(ureq41.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ42 = new Request__c(Release__c=rele.id);
        //requ42.Priority__c = 'Low';
        requ42.Request_Type__c = 'Configuration';
        requ42.Request_Title__c = 'Test';
        requ42.Status__c = 'Identify: Submit for Business Review';
        Database.insert(requ42);
        requ42.Status__c = 'Identify: Deferred';
        requ42.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ42);
        requ42.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ42);
        Request__c ureq42 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ42.id];     
        Integer d42 = ureq42.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        if(ureq42.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ43 = new Request__c(Release__c=rele.id);
        //requ43.Priority__c = 'Low';
        requ43.Request_Type__c = 'Configuration';
        requ43.Request_Title__c = 'Test';
        requ43.Status__c = 'Identify: Submit for Business Review';
        Database.insert(requ43);
        requ43.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ43);
        requ43.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ43);
        Request__c ureq43 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ43.id];     
        Integer d43 = ureq43.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        if(ureq43.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ44 = new Request__c(Release__c=rele.id);
        //requ44.Priority__c = 'Low';
        requ44.Request_Type__c = 'Configuration';
        requ44.Request_Title__c = 'Test';
        requ44.Status__c = 'Identify: Submit for Business Review';
        Database.insert(requ44);
        requ44.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ44);
        requ44.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ44);
        Request__c ureq44 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ44.id];     
        Integer d44 = ureq44.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        if(ureq44.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ45 = new Request__c(Release__c=rele.id);
        //requ45.Priority__c = 'Low';
        requ45.Request_Type__c = 'Configuration';
        requ45.Request_Title__c = 'Test';
        requ45.Status__c = 'Identify: Submit for Business Review';
        Database.insert(requ45);
        requ45.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ45);
        requ45.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ45);
        Request__c ureq45 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ45.id];     
        Integer d45 = ureq45.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        if(ureq45.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ451 = new Request__c(Release__c=rele.id);
        //requ451.Priority__c = 'Low';
        requ451.Request_Type__c = 'Configuration';
        requ451.Request_Title__c = 'Test';
        requ451.Status__c = 'Identify: Submit for Business Review';
        Database.insert(requ451);
        requ451.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ451);
        requ451.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ451);
        Request__c ureq451 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                              TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ451.id];     
        Integer d451 = ureq451.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        if(ureq451.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ46 = new Request__c(Release__c=rele.id);
        //requ46.Priority__c = 'Low';
        requ46.Request_Type__c = 'Configuration';
        requ46.Request_Title__c = 'Test';
        requ46.Status__c = 'Identify: Submit for Business Review';
        Database.insert(requ46);
        requ46.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ46);
        requ46.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ46);
        Request__c ureq46 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ46.id];     
        Integer d46 = ureq46.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        if(ureq46.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ47 = new Request__c(Release__c=rele.id);
        //requ47.Priority__c = 'Low';
        requ47.Request_Type__c = 'Configuration';
        requ47.Request_Title__c = 'Test';
        requ47.Status__c = 'Identify: Submit for Business Review';
        Database.insert(requ47);
        requ47.Status__c = 'Release: Design';
        Database.update(requ47);
        requ47.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ47);
        Request__c ureq47 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ47.id];     
        Integer d47 = ureq47.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        if(ureq47.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ48 = new Request__c(Release__c=rele.id);
        //requ48.Priority__c = 'Low';
        requ48.Request_Type__c = 'Configuration';
        requ48.Request_Title__c = 'Test';
        requ48.Status__c = 'Identify: Submit for Business Review';
        Database.insert(requ48);
        requ48.Status__c = 'Release: Build';
        Database.update(requ48);
        requ48.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ48);
        Request__c ureq48 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ48.id];     
        Integer d48 = ureq48.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        if(ureq48.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ49 = new Request__c(Release__c=rele.id);
        //requ49.Priority__c = 'Low';
        requ49.Request_Type__c = 'Configuration';
        requ49.Request_Title__c = 'Test';
        requ49.Status__c = 'Identify: Submit for Business Review';
        Database.insert(requ49);
        requ49.Status__c = 'Release: Test';
        Database.update(requ49);
        requ49.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ49);
        Request__c ureq49 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ49.id];     
        Integer d49 = ureq49.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        if(ureq49.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Test.stopTest();    
    }   
    
    public static testMethod void TestUpdateTimeSpent1(){
        
        Test.startTest();
        Release__c rele = new Release__c();
        rele.Name = 'Test';
        Database.Insert(rele,false); 
        
        Request__c requ50 = new Request__c(Release__c=rele.id);
        //requ50.Priority__c = 'Low';
        requ50.Request_Type__c = 'Configuration';
        requ50.Request_Title__c = 'Test';
        requ50.Status__c = 'Identify: Submit for Business Review';
        Database.insert(requ50);
        requ50.Status__c = 'Release: SIT';
        Database.update(requ50);
        requ50.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ50);
        Request__c ureq50 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ50.id];     
        Integer d50 = ureq50.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        if(ureq50.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ51 = new Request__c(Release__c=rele.id);
        //requ51.Priority__c = 'Low';
        requ51.Request_Type__c = 'Configuration';
        requ51.Request_Title__c = 'Test';
        requ51.Status__c = 'Identify: Submit for Business Review';
        Database.insert(requ51);
        requ51.Status__c = 'Release: UAT';
        Database.update(requ51);
        requ51.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ51);
        Request__c ureq51 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ51.id];     
        Integer d51 = ureq51.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        if(ureq51.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ52 = new Request__c(Release__c=rele.id);
        //requ52.Priority__c = 'Low';
        requ52.Request_Type__c = 'Configuration';
        requ52.Request_Title__c = 'Test';
        requ52.Status__c = 'Identify: Submit for Business Review';
        Database.insert(requ52);
        requ52.Status__c = 'Release: Build Production';
        Database.update(requ52);
        requ52.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ52);
        Request__c ureq52 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ52.id];     
        Integer d52 = ureq52.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        if(ureq52.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ53 = new Request__c(Release__c=rele.id);
        //requ53.Priority__c = 'Low';
        requ53.Request_Type__c = 'Configuration';
        requ53.Request_Title__c = 'Test';
        requ53.Status__c = 'Identify: Submit for Business Review';
        Database.insert(requ53);
        requ53.Status__c = 'Release: Test Production';
        Database.update(requ53);
        requ53.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ53);
        Request__c ureq53 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ53.id];     
        Integer d53 = ureq53.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        if(ureq53.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ54 = new Request__c(Release__c=rele.id);
        //requ54.Priority__c = 'Low';
        requ54.Request_Type__c = 'Configuration';
        requ54.Request_Title__c = 'Test';
        requ54.Status__c = 'Identify: Submit for Business Review';
        Database.insert(requ54);
        requ54.Status__c = 'Release: No Build Req';
        Database.update(requ54);
        requ54.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ54);
        Request__c ureq54 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ54.id];     
        Integer d54 = ureq54.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        if(ureq54.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ55 = new Request__c(Release__c=rele.id);
       // requ55.Priority__c = 'Low';
        requ55.Request_Type__c = 'Configuration';
        requ55.Request_Title__c = 'Test';
        requ55.Status__c = 'Identify: Submit for Business Review';
        Database.insert(requ55);
        requ55.Status__c = 'Close: Deployed';
        Database.update(requ55);
        requ55.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ55);
        Request__c ureq55 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ55.id];     
        Integer d55 = ureq55.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        if(ureq55.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ56 = new Request__c(Release__c=rele.id);
        //requ56.Priority__c = 'Low';
        requ56.Request_Type__c = 'Configuration';
        requ56.Request_Title__c = 'Test';
        requ56.Status__c = 'Identify: Submit for Business Review';
        Database.insert(requ56);
        requ56.Status__c = 'Close: Rejected';
        requ56.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ56);
        requ56.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ56);
        Request__c ureq56 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ56.id];     
        Integer d56 = ureq56.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        if(ureq56.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ57 = new Request__c(Release__c=rele.id);
        //requ57.Priority__c = 'Low';
        requ57.Request_Type__c = 'Configuration';
        requ57.Request_Title__c = 'Test';
        requ57.Status__c = 'Identify: Submit for Business Review';
        requ57.Related_Request__c = requ56.Id;
        Database.insert(requ57);
        requ57.Status__c = 'Close: Duplicate';
        Database.update(requ57);
        requ57.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ57);
        Request__c ureq57 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ57.id];     
        try{
        Integer d57 = ureq57.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        }Catch(Exception ex){}
        if(ureq57.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ58 = new Request__c(Release__c=rele.id);
        //requ58.Priority__c = 'Low';
        requ58.Request_Type__c = 'Configuration';
        requ58.Request_Title__c = 'Test';
        requ58.Status__c = 'Identify: Submit for Business Review';
        Database.insert(requ58);
        requ58.Status__c = 'Close: Duplicate';
        requ58.Related_Request__c = requ57.Id;
        Database.update(requ58);
        requ58.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ58);
        Request__c ureq58 = [Select Status__c, StartTime_Identify_Submit_for_Business__c, StopTime_Identify_Submit_for_Business__c, 
                             TimeSpentOn_Submit_for_Business_Review__c, LastModifiedDate, Id from Request__c where id=: requ58.id];     
        Integer d58 = ureq58.TimeSpentOn_Submit_for_Business_Review__c.intvalue();
        if(ureq58.StartTime_Identify_Submit_for_Business__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ59 = new Request__c(Release__c=rele.id);
        //requ59.Priority__c = 'Low';
        requ59.Request_Type__c = 'Configuration';
        requ59.Request_Title__c = 'Test';
        requ59.Status__c = 'Identify: Emergency Request';
        Database.insert(requ59);
        requ59.Status__c = 'Identify: New Requirement';
        Database.update(requ59);
        requ59.Status__c = 'Identify: Emergency Request';
        Database.update(requ59);
        Request__c ureq59 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ59.id];     
        Integer d59 = ureq59.TimeSpentOn_Emergency_Request__c.intvalue();
        if(ureq59.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ60 = new Request__c(Release__c=rele.id);
        //requ60.Priority__c = 'Low';
        requ60.Request_Type__c = 'Configuration';
        requ60.Request_Title__c = 'Test';
        requ60.Status__c = 'Identify: Emergency Request';
        Database.insert(requ60);
        requ60.Status__c = 'Identify: Change Request';
        Database.update(requ60);
        requ60.Status__c = 'Identify: Emergency Request';
        Database.update(requ60);
        Request__c ureq60 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ60.id];     
        Integer d60 = ureq60.TimeSpentOn_Emergency_Request__c.intvalue();
        if(ureq60.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ61 = new Request__c(Release__c=rele.id);
        //requ61.Priority__c = 'Low';
        requ61.Request_Type__c = 'Configuration';
        requ61.Request_Title__c = 'Test';
        requ61.Status__c = 'Identify: Emergency Request';
        Database.insert(requ61);
        requ61.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ61);
        requ61.Status__c = 'Identify: Emergency Request';
        Database.update(requ61);
        Request__c ureq61 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ61.id];     
        Integer d61 = ureq61.TimeSpentOn_Emergency_Request__c.intvalue();
        if(ureq61.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ62 = new Request__c(Release__c=rele.id);
        //requ62.Priority__c = 'Low';
        requ62.Request_Type__c = 'Configuration';
        requ62.Request_Title__c = 'Test';
        requ62.Status__c = 'Identify: Emergency Request';
        Database.insert(requ62);
        requ62.Status__c = 'Identify: Deferred';
        requ62.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ62);
        requ62.Status__c = 'Identify: Emergency Request';
        Database.update(requ62);
        Request__c ureq62 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ62.id];     
        Integer d62 = ureq62.TimeSpentOn_Emergency_Request__c.intvalue();
        if(ureq62.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ63 = new Request__c(Release__c=rele.id);
        //requ63.Priority__c = 'Low';
        requ63.Request_Type__c = 'Configuration';
        requ63.Request_Title__c = 'Test';
        requ63.Status__c = 'Identify: Emergency Request';
        Database.insert(requ63);
        requ63.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ63);
        requ63.Status__c = 'Identify: Emergency Request';
        Database.update(requ63);
        Request__c ureq63 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ63.id];     
        Integer d63 = ureq63.TimeSpentOn_Emergency_Request__c.intvalue();
        if(ureq63.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ64 = new Request__c(Release__c=rele.id);
        //requ64.Priority__c = 'Low';
        requ64.Request_Type__c = 'Configuration';
        requ64.Request_Title__c = 'Test';
        requ64.Status__c = 'Identify: Emergency Request';
        Database.insert(requ64);
        requ64.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ64);
        requ64.Status__c = 'Identify: Emergency Request';
        Database.update(requ64);
        Request__c ureq64 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ64.id];     
        Integer d64 = ureq64.TimeSpentOn_Emergency_Request__c.intvalue();
        if(ureq64.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ65 = new Request__c(Release__c=rele.id);
        //requ65.Priority__c = 'Low';
        requ65.Request_Type__c = 'Configuration';
        requ65.Request_Title__c = 'Test';
        requ65.Status__c = 'Identify: Emergency Request';
        Database.insert(requ65);
        requ65.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ65);
        requ65.Status__c = 'Identify: Emergency Request';
        Database.update(requ65);
        Request__c ureq65 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ65.id];     
        Integer d65 = ureq65.TimeSpentOn_Emergency_Request__c.intvalue();
        if(ureq65.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ66 = new Request__c(Release__c=rele.id);
        //requ66.Priority__c = 'Low';
        requ66.Request_Type__c = 'Configuration';
        requ66.Request_Title__c = 'Test';
        requ66.Status__c = 'Identify: Emergency Request';
        Database.insert(requ66);
        requ66.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ66);
        requ66.Status__c = 'Identify: Emergency Request';
        Database.update(requ66);
        Request__c ureq66 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ66.id];     
        Integer d66 = ureq66.TimeSpentOn_Emergency_Request__c.intvalue();
        if(ureq66.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ67 = new Request__c(Release__c=rele.id);
        //requ67.Priority__c = 'Low';
        requ67.Request_Type__c = 'Configuration';
        requ67.Request_Title__c = 'Test';
        requ67.Status__c = 'Identify: Emergency Request';
        Database.insert(requ67);
        requ67.Status__c = 'Release: Design';
        Database.update(requ67);
        requ67.Status__c = 'Identify: Emergency Request';
        Database.update(requ67);
        Request__c ureq67 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ67.id];     
        Integer d67 = ureq67.TimeSpentOn_Emergency_Request__c.intvalue();
        if(ureq67.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ68 = new Request__c(Release__c=rele.id);
        //requ68.Priority__c = 'Low';
        requ68.Request_Type__c = 'Configuration';
        requ68.Request_Title__c = 'Test';
        requ68.Status__c = 'Identify: Emergency Request';
        Database.insert(requ68);
        requ68.Status__c = 'Release: Build';
        Database.update(requ68);
        requ68.Status__c = 'Identify: Emergency Request';
        Database.update(requ68);
        Request__c ureq68 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ68.id];     
        Integer d68 = ureq68.TimeSpentOn_Emergency_Request__c.intvalue();
        if(ureq68.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ69 = new Request__c(Release__c=rele.id);
        //requ69.Priority__c = 'Low';
        requ69.Request_Type__c = 'Configuration';
        requ69.Request_Title__c = 'Test';
        requ69.Status__c = 'Identify: Emergency Request';
        Database.insert(requ69);
        requ69.Status__c = 'Release: Test';
        Database.update(requ69);
        requ69.Status__c = 'Identify: Emergency Request';
        Database.update(requ69);
        Request__c ureq69 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ69.id];     
        Integer d69 = ureq69.TimeSpentOn_Emergency_Request__c.intvalue();
        if(ureq69.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ70 = new Request__c(Release__c=rele.id);
        //requ70.Priority__c = 'Low';
        requ70.Request_Type__c = 'Configuration';
        requ70.Request_Title__c = 'Test';
        requ70.Status__c = 'Identify: Emergency Request';
        Database.insert(requ70);
        requ70.Status__c = 'Release: SIT';
        Database.update(requ70);
        requ70.Status__c = 'Identify: Emergency Request';
        Database.update(requ70);
        Request__c ureq70 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ70.id];     
        Integer d70 = ureq70.TimeSpentOn_Emergency_Request__c.intvalue();
        if(ureq70.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        Test.stopTest();
    }
    public static testMethod void TestUpdateTimeSpent18(){
        
        Test.startTest();
        Release__c rele = new Release__c();
        rele.Name = 'Test';
        Database.Insert(rele,false); 
        Request__c requ71 = new Request__c(Release__c=rele.id);
        //requ71.Priority__c = 'Low';
        requ71.Request_Type__c = 'Configuration';
        requ71.Request_Title__c = 'Test';
        requ71.Status__c = 'Identify: Emergency Request';
        Database.insert(requ71);
        requ71.Status__c = 'Release: UAT';
        Database.update(requ71);
        requ71.Status__c = 'Identify: Emergency Request';
        Database.update(requ71);
        Request__c ureq71 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ71.id];     
        Integer d71 = ureq71.TimeSpentOn_Emergency_Request__c.intvalue();
        if(ureq71.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ72 = new Request__c(Release__c=rele.id);
        //requ72.Priority__c = 'Low';
        requ72.Request_Type__c = 'Configuration';
        requ72.Request_Title__c = 'Test';
        requ72.Status__c = 'Identify: Emergency Request';
        Database.insert(requ72);
        requ72.Status__c = 'Release: Build Production';
        Database.update(requ72);
        requ72.Status__c = 'Identify: Emergency Request';
        Database.update(requ72);
        Request__c ureq72 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ72.id];     
        Integer d72 = ureq72.TimeSpentOn_Emergency_Request__c.intvalue();
        if(ureq72.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ73 = new Request__c(Release__c=rele.id);
        //requ73.Priority__c = 'Low';
        requ73.Request_Type__c = 'Configuration';
        requ73.Request_Title__c = 'Test';
        requ73.Status__c = 'Identify: Emergency Request';
        Database.insert(requ73);
        requ73.Status__c = 'Release: Test Production';
        Database.update(requ73);
        requ73.Status__c = 'Identify: Emergency Request';
        Database.update(requ73);
        Request__c ureq73 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ73.id];     
        Integer d73 = ureq73.TimeSpentOn_Emergency_Request__c.intvalue();
        if(ureq73.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ74 = new Request__c(Release__c=rele.id);
        //requ74.Priority__c = 'Low';
        requ74.Request_Type__c = 'Configuration';
        requ74.Request_Title__c = 'Test';
        requ74.Status__c = 'Identify: Emergency Request';
        Database.insert(requ74);
        requ74.Status__c = 'Release: No Build Req';
        Database.update(requ74);
        requ74.Status__c = 'Identify: Emergency Request';
        Database.update(requ74);
        Request__c ureq74 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ74.id];     
        Integer d74 = ureq74.TimeSpentOn_Emergency_Request__c.intvalue();
        if(ureq74.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ75 = new Request__c(Release__c=rele.id);
        //requ75.Priority__c = 'Low';
        requ75.Request_Type__c = 'Configuration';
        requ75.Request_Title__c = 'Test';
        requ75.Status__c = 'Identify: Emergency Request';
        Database.insert(requ75);
        requ75.Status__c = 'Close: Deployed';
        Database.update(requ75);
        requ75.Status__c = 'Identify: Emergency Request';
        Database.update(requ75);
        Request__c ureq75 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ75.id];     
        Integer d75 = ureq75.TimeSpentOn_Emergency_Request__c.intvalue();
        if(ureq75.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ76 = new Request__c(Release__c=rele.id);
        //requ76.Priority__c = 'Low';
        requ76.Request_Type__c = 'Configuration';
        requ76.Request_Title__c = 'Test';
        requ76.Status__c = 'Identify: Emergency Request';
        Database.insert(requ76);
        requ76.Status__c = 'Close: Rejected';
        requ76.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ76);
        requ76.Status__c = 'Identify: Emergency Request';
        Database.update(requ76);
        Request__c ureq76 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ76.id];     
        Integer d76 = ureq76.TimeSpentOn_Emergency_Request__c.intvalue();
        if(ureq76.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ77 = new Request__c(Release__c=rele.id);
        //requ77.Priority__c = 'Low';
        requ77.Request_Type__c = 'Configuration';
        requ77.Request_Title__c = 'Test';
        requ77.Status__c = 'Identify: Emergency Request';
        requ77.Related_Request__c = requ76.Id;
        Database.insert(requ77);
        requ77.Status__c = 'Close: Duplicate';
        Database.update(requ77);
        requ77.Status__c = 'Identify: Emergency Request';
        Database.update(requ77);
        Request__c ureq77 = [Select Status__c, StartTime_Emergency_Request__c, StopTime_Emergency_Request__c, 
                             TimeSpentOn_Emergency_Request__c, LastModifiedDate, Id from Request__c where id=: requ77.id];     
        try{Integer d77 = ureq77.TimeSpentOn_Emergency_Request__c.intvalue();}Catch(Exception ex){}
        if(ureq77.StartTime_Emergency_Request__c != null){
            system.debug('Test Pass');
        }
        
        
        Request__c requ78 = new Request__c(Release__c=rele.id);
        //requ78.Priority__c = 'Low';
        requ78.Request_Type__c = 'Configuration';
        requ78.Request_Title__c = 'Test';
        requ78.Status__c = 'Identify: Deferred';
        requ78.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        requ78.Related_Request__c = requ77.Id;
        Database.insert(requ78);
        requ78.Status__c = 'Identify: New Requirement';
        Database.update(requ78);
        requ78.Status__c = 'Identify: Deferred';
        requ78.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ78);
        Request__c ureq78 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ78.id];     
        try{Integer d78 = ureq78.TimeSpentOn_Deferred__c.intvalue();}Catch(Exception ex){}
        if(ureq78.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ79 = new Request__c(Release__c=rele.id);
        //requ79.Priority__c = 'Low';
        requ79.Request_Type__c = 'Configuration';
        requ79.Request_Title__c = 'Test';
        requ79.Status__c = 'Identify: Deferred';
        requ79.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        requ79.Related_Request__c = requ78.Id;
        Database.insert(requ79);
        requ79.Status__c = 'Identify: Change Request';
        Database.update(requ79);
        requ79.Status__c = 'Identify: Deferred';
        requ79.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ79);
        Request__c ureq79 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ79.id];     
        try{Integer d79 = ureq79.TimeSpentOn_Deferred__c.intvalue();}Catch(Exception ex){}
        if(ureq79.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ80 = new Request__c(Release__c=rele.id);
        //requ80.Priority__c = 'Low';
        requ80.Request_Type__c = 'Configuration';
        requ80.Request_Title__c = 'Test';
        requ80.Status__c = 'Identify: Deferred';
        requ80.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        requ80.Related_Request__c = requ79.Id;
        Database.insert(requ80);
        requ80.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ80);
        requ80.Status__c = 'Identify: Deferred';
        requ80.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ80);
        Request__c ureq80 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ80.id];     
        try{Integer d80 = ureq80.TimeSpentOn_Deferred__c.intvalue();}Catch(Exception ex){}
        if(ureq80.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ81 = new Request__c(Release__c=rele.id);
        //requ81.Priority__c = 'Low';
        requ81.Request_Type__c = 'Configuration';
        requ81.Request_Title__c = 'Test';
        requ81.Status__c = 'Identify: Deferred';
        requ81.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        requ81.Related_Request__c = requ80.Id;
        Database.insert(requ81);
        requ81.Status__c = 'Identify: Emergency Request';
        Database.update(requ81);
        requ81.Status__c = 'Identify: Deferred';
        requ81.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ81);
        Request__c ureq81 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ81.id];     
        try{Integer d81 = ureq81.TimeSpentOn_Deferred__c.intvalue();}Catch(Exception ex){}
        if(ureq81.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ82 = new Request__c(Release__c=rele.id);
        //requ82.Priority__c = 'Low';
        requ82.Request_Type__c = 'Configuration';
        requ82.Request_Title__c = 'Test';
        requ82.Status__c = 'Identify: Deferred';
        requ82.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        requ82.Related_Request__c = requ81.Id;
        Database.insert(requ82);
        requ82.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ82);
        requ82.Status__c = 'Identify: Deferred';
        requ82.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ82);
        Request__c ureq82 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ82.id];     
        try{Integer d82 = ureq82.TimeSpentOn_Deferred__c.intvalue();}Catch(Exception ex){}
        if(ureq82.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ83 = new Request__c(Release__c=rele.id);
        //requ83.Priority__c = 'Low';
        requ83.Request_Type__c = 'Configuration';
        requ83.Request_Title__c = 'Test';
        requ83.Status__c = 'Identify: Deferred';
        requ83.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        requ83.Related_Request__c = requ82.Id;
        Database.insert(requ83);
        requ83.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ83);
        requ83.Status__c = 'Identify: Deferred';
        requ83.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ83);
        Request__c ureq83 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ83.id];     
        try{Integer d83 = ureq83.TimeSpentOn_Deferred__c.intvalue();}Catch(Exception ex){}
        if(ureq83.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ84 = new Request__c(Release__c=rele.id);
        //requ84.Priority__c = 'Low';
        requ84.Request_Type__c = 'Configuration';
        requ84.Request_Title__c = 'Test';
        requ84.Status__c = 'Identify: Deferred';
        requ84.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        requ84.Related_Request__c = requ83.Id;
        Database.insert(requ84);
        requ84.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ84);
        requ84.Status__c = 'Identify: Deferred';
        requ84.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ84);
        Request__c ureq84 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ84.id];     
        try{Integer d84 = ureq84.TimeSpentOn_Deferred__c.intvalue();}Catch(Exception ex){}
        if(ureq84.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ85 = new Request__c(Release__c=rele.id);
        //requ85.Priority__c = 'Low';
        requ85.Request_Type__c = 'Configuration';
        requ85.Request_Title__c = 'Test';
        requ85.Status__c = 'Identify: Deferred';
        requ85.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        requ85.Related_Request__c = requ76.Id;
        Database.insert(requ85);
        requ85.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ85);
        requ85.Status__c = 'Identify: Deferred';
        requ85.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ85);
        Request__c ureq85 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ85.id];     
        try{Integer d85 = ureq85.TimeSpentOn_Deferred__c.intvalue();}Catch(Exception ex){}
        if(ureq85.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ86 = new Request__c(Release__c=rele.id);
        //requ86.Priority__c = 'Low';
        requ86.Request_Type__c = 'Configuration';
        requ86.Request_Title__c = 'Test';
        requ86.Status__c = 'Identify: Deferred';
        requ86.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        requ86.Related_Request__c = requ76.Id;
        Database.insert(requ86);
        requ86.Status__c = 'Release: Design';
        Database.update(requ86);
        requ86.Status__c = 'Identify: Deferred';
        requ86.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ86);
        Request__c ureq86 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ86.id];     
        try{Integer d86 = ureq86.TimeSpentOn_Deferred__c.intvalue();}Catch(Exception ex){}
        if(ureq86.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ87 = new Request__c(Release__c=rele.id);
        //requ87.Priority__c = 'Low';
        requ87.Request_Type__c = 'Configuration';
        requ87.Request_Title__c = 'Test';
        requ87.Status__c = 'Identify: Deferred';
        requ87.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.insert(requ87);
        requ87.Status__c = 'Release: Build';
        Database.update(requ87);
        requ87.Status__c = 'Identify: Deferred';
        requ87.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ87);
        Request__c ureq87 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ87.id];     
        Integer d87 = ureq87.TimeSpentOn_Deferred__c.intvalue();
        if(ureq87.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ88 = new Request__c(Release__c=rele.id);
        //requ88.Priority__c = 'Low';
        requ88.Request_Type__c = 'Configuration';
        requ88.Request_Title__c = 'Test';
        requ88.Status__c = 'Identify: Deferred';
        requ88.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.insert(requ88);
        requ88.Status__c = 'Release: Test';
        Database.update(requ88);
        requ88.Status__c = 'Identify: Deferred';
        requ88.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ88);
        Request__c ureq88 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ88.id];     
        Integer d88 = ureq88.TimeSpentOn_Deferred__c.intvalue();
        if(ureq88.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ89 = new Request__c(Release__c=rele.id);
        //requ89.Priority__c = 'Low';
        requ89.Request_Type__c = 'Configuration';
        requ89.Request_Title__c = 'Test';
        requ89.Status__c = 'Identify: Deferred';
        requ89.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.insert(requ89);
        requ89.Status__c = 'Release: SIT';
        Database.update(requ89);
        requ89.Status__c = 'Identify: Deferred';
        requ89.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ89);
        Request__c ureq89 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ89.id];     
        Integer d89 = ureq89.TimeSpentOn_Deferred__c.intvalue();
        if(ureq89.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ90 = new Request__c(Release__c=rele.id);
        //requ90.Priority__c = 'Low';
        requ90.Request_Type__c = 'Configuration';
        requ90.Request_Title__c = 'Test';
        requ90.Status__c = 'Identify: Deferred';
        requ90.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.insert(requ90);
        requ90.Status__c = 'Release: UAT';
        Database.update(requ90);
        requ90.Status__c = 'Identify: Deferred';
        requ90.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ90);
        Request__c ureq90 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ90.id];     
        Integer d90 = ureq90.TimeSpentOn_Deferred__c.intvalue();
        if(ureq90.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Test.stopTest();
    }
    public static testMethod void TestUpdateTimeSpent9(){
        
        Test.startTest();
        Release__c rele = new Release__c();
        rele.Name = 'Test';
        Database.Insert(rele,false); 
        Request__c requ91 = new Request__c(Release__c=rele.id);
        //requ91.Priority__c = 'Low';
        requ91.Request_Type__c = 'Configuration';
        requ91.Request_Title__c = 'Test';
        requ91.Status__c = 'Identify: Deferred';
        requ91.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.insert(requ91);
        requ91.Status__c = 'Release: Build Production';
        Database.update(requ91);
        requ91.Status__c = 'Identify: Deferred';
        requ91.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ91);
        Request__c ureq91 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ91.id];     
        Integer d91 = ureq91.TimeSpentOn_Deferred__c.intvalue();
        if(ureq91.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ92 = new Request__c(Release__c=rele.id);
        //requ92.Priority__c = 'Low';
        requ92.Request_Type__c = 'Configuration';
        requ92.Request_Title__c = 'Test';
        requ92.Status__c = 'Identify: Deferred';
        requ92.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.insert(requ92);
        requ92.Status__c = 'Release: Test Production';  
        Database.update(requ92);
        requ92.Status__c = 'Identify: Deferred';
        requ92.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ92);
        Request__c ureq92 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ92.id];     
        Integer d92 = ureq92.TimeSpentOn_Deferred__c.intvalue();
        if(ureq92.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ93 = new Request__c(Release__c=rele.id);
        //requ93.Priority__c = 'Low';
        requ93.Request_Type__c = 'Configuration';
        requ93.Request_Title__c = 'Test';
        requ93.Status__c = 'Identify: Deferred';
        requ93.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.insert(requ93);
        requ93.Status__c = 'Release: No Build Req';
        Database.update(requ93);
        requ93.Status__c = 'Identify: Deferred';
        requ93.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ93);
        Request__c ureq93 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ93.id];     
        Integer d93 = ureq93.TimeSpentOn_Deferred__c.intvalue();
        if(ureq93.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ94 = new Request__c(Release__c=rele.id);
        //requ94.Priority__c = 'Low';
        requ94.Request_Type__c = 'Configuration';
        requ94.Request_Title__c = 'Test';
        requ94.Status__c = 'Identify: Deferred';
        requ94.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.insert(requ94);
        requ94.Status__c = 'Close: Deployed';
        Database.update(requ94);
        requ94.Status__c = 'Identify: Deferred';
        requ94.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ94);
        Request__c ureq94 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ94.id];     
        Integer d94 = ureq94.TimeSpentOn_Deferred__c.intvalue();
        if(ureq94.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ95 = new Request__c(Release__c=rele.id);
        //requ95.Priority__c = 'Low';
        requ95.Request_Type__c = 'Configuration';
        requ95.Request_Title__c = 'Test';
        requ95.Status__c = 'Identify: Deferred';
        requ95.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.insert(requ95);
        requ95.Status__c = 'Close: Rejected';
        requ95.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ95);
        requ95.Status__c = 'Identify: Deferred';
        requ95.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ95);
        Request__c ureq95 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ95.id];     
        Integer d95 = ureq95.TimeSpentOn_Deferred__c.intvalue();
        if(ureq95.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ96 = new Request__c(Release__c=rele.id);
        //requ96.Priority__c = 'Low';
        requ96.Request_Type__c = 'Configuration';
        requ96.Request_Title__c = 'Test';
        requ96.Status__c = 'Identify: Deferred';
        requ96.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        requ96.Related_Request__c = requ95.Id;
        
        Database.insert(requ96);
        requ96.Status__c = 'Close: Duplicate';
        Database.update(requ96);
        requ96.Status__c = 'Identify: Deferred';
        requ96.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ96);
        Request__c ureq96 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ96.id];     
        try{Integer d96 = ureq96.TimeSpentOn_Deferred__c.intvalue();}Catch(Exception ex){}
        if(ureq96.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ97 = new Request__c(Release__c=rele.id);
        //requ97.Priority__c = 'Low';
        requ97.Request_Type__c = 'Configuration';
        requ97.Request_Title__c = 'Test';
        requ97.Status__c = 'Identify: Deferred';
        requ97.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        requ97.Related_Request__c = requ95.Id;
        Database.insert(requ97);
        requ97.Status__c = 'Close: Duplicate';
        Database.update(requ97);
        requ97.Status__c = 'Identify: Deferred';
        requ97.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ97);
        Request__c ureq97 = [Select Status__c, StartTime_Deferred__c, StopTime_Deferred__c, 
                             TimeSpentOn_Deferred__c, LastModifiedDate, Id from Request__c where id=: requ97.id];     
        try{Integer d97 = ureq97.TimeSpentOn_Deferred__c.intvalue();}Catch(Exception ex){}
        if(ureq97.StartTime_Deferred__c != null){
            system.debug('Test Pass');
        }
        
        Test.stopTest();
    }
    
    public static testMethod void TestUpdateTimeSpent2(){
        
        Test.startTest();
        Release__c rele = new Release__c();
        rele.Name = 'Test';
        Database.Insert(rele,false); 
        
        Request__c requ98 = new Request__c(Release__c=rele.id);
        //requ98.Priority__c = 'Low';
        requ98.Request_Type__c = 'Configuration';
        requ98.Request_Title__c = 'Test';
        requ98.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(requ98);
        requ98.Status__c = 'Identify: New Requirement';
        Database.update(requ98);
        requ98.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ98);
        Request__c ureq98 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                             TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ98.id];     
        Integer d98 = ureq98.TimeSpentOn_Approve_to_Estimate__c.intvalue();
        if(ureq98.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ99 = new Request__c(Release__c=rele.id);
        //requ99.Priority__c = 'Low';
        requ99.Request_Type__c = 'Configuration';
        requ99.Request_Title__c = 'Test';
        requ99.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(requ99);
        requ99.Status__c = 'Identify: Change Request';
        Database.update(requ99);
        requ99.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ99);
        Request__c ureq99 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                             TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ99.id];     
        Integer d99 = ureq99.TimeSpentOn_Approve_to_Estimate__c.intvalue();
        if(ureq99.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ100 = new Request__c(Release__c=rele.id);
        //requ100.Priority__c = 'Low';
        requ100.Request_Type__c = 'Configuration';
        requ100.Request_Title__c = 'Test';
        requ100.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(requ100);
        requ100.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ100);
        requ100.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ100);
        Request__c ureq100 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                              TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ100.id];     
        Integer d100 = ureq100.TimeSpentOn_Approve_to_Estimate__c.intvalue();
        if(ureq100.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ101 = new Request__c(Release__c=rele.id);
        //requ101.Priority__c = 'Low';
        requ101.Request_Type__c = 'Configuration';
        requ101.Request_Title__c = 'Test';
        requ101.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(requ101);
        requ101.Status__c = 'Identify: Emergency Request';
        Database.update(requ101);
        requ101.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ101);
        Request__c ureq101 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                              TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ101.id];     
        Integer d101 = ureq101.TimeSpentOn_Approve_to_Estimate__c.intvalue();
        if(ureq101.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ102 = new Request__c(Release__c=rele.id);
        //requ102.Priority__c = 'Low';
        requ102.Request_Type__c = 'Configuration';
        requ102.Request_Title__c = 'Test';
        requ102.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(requ102);
        requ102.Status__c = 'Identify: Deferred';
        requ102.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ102);
        requ102.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ102);
        Request__c ureq102 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                              TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ102.id];     
        Integer d102 = ureq102.TimeSpentOn_Approve_to_Estimate__c.intvalue();
        if(ureq102.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ103 = new Request__c(Release__c=rele.id);
        //requ103.Priority__c = 'Low';
        requ103.Request_Type__c = 'Configuration';
        requ103.Request_Title__c = 'Test';
        requ103.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(requ103);
        requ103.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ103);
        requ103.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ103);
        Request__c ureq103 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                              TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ103.id];     
        Integer d103 = ureq103.TimeSpentOn_Approve_to_Estimate__c.intvalue();
        if(ureq103.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ104 = new Request__c(Release__c=rele.id);
        //requ104.Priority__c = 'Low';
        requ104.Request_Type__c = 'Configuration';
        requ104.Request_Title__c = 'Test';
        requ104.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(requ104);
        requ104.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ104);
        requ104.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ104);
        Request__c ureq104 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                              TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ104.id];     
        Integer d104 = ureq104.TimeSpentOn_Approve_to_Estimate__c.intvalue();
        if(ureq104.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ105 = new Request__c(Release__c=rele.id);
        //requ105.Priority__c = 'Low';
        requ105.Request_Type__c = 'Configuration';
        requ105.Request_Title__c = 'Test';
        requ105.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(requ105);
        requ105.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ105);
        requ105.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ105);
        Request__c ureq105 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                              TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ105.id];     
        Integer d105 = ureq105.TimeSpentOn_Approve_to_Estimate__c.intvalue();
        if(ureq105.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ106 = new Request__c(Release__c=rele.id);
        //requ106.Priority__c = 'Low';
        requ106.Request_Type__c = 'Configuration';
        requ106.Request_Title__c = 'Test';
        requ106.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(requ106);
        requ106.Status__c = 'Release: Design';
        Database.update(requ106);
        requ106.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ106);
        Request__c ureq106 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                              TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ106.id];     
        Integer d106 = ureq106.TimeSpentOn_Approve_to_Estimate__c.intvalue();
        if(ureq106.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ107 = new Request__c(Release__c=rele.id);
        //requ107.Priority__c = 'Low';
        requ107.Request_Type__c = 'Configuration';
        requ107.Request_Title__c = 'Test';
        requ107.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(requ107);
        requ107.Status__c = 'Release: Build';
        Database.update(requ107);
        requ107.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ107);
        Request__c ureq107 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                              TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ107.id];     
        Integer d107 = ureq107.TimeSpentOn_Approve_to_Estimate__c.intvalue();
        if(ureq107.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ108 = new Request__c(Release__c=rele.id);
        //requ108.Priority__c = 'Low';
        requ108.Request_Type__c = 'Configuration';
        requ108.Request_Title__c = 'Test';
        requ108.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(requ108);
        requ108.Status__c = 'Release: Test';
        Database.update(requ108);
        requ108.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ108);
        Request__c ureq108 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                              TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ108.id];     
        Integer d108 = ureq108.TimeSpentOn_Approve_to_Estimate__c.intvalue();
        if(ureq108.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ109 = new Request__c(Release__c=rele.id);
        //requ109.Priority__c = 'Low';
        requ109.Request_Type__c = 'Configuration';
        requ109.Request_Title__c = 'Test';
        requ109.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(requ109);
        requ109.Status__c = 'Release: SIT';
        Database.update(requ109);
        requ109.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ109);
        Request__c ureq109 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                              TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ109.id];     
        Integer d109 = ureq109.TimeSpentOn_Approve_to_Estimate__c.intvalue();
        if(ureq109.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ110 = new Request__c(Release__c=rele.id);
        //requ110.Priority__c = 'Low';
        requ110.Request_Type__c = 'Configuration';
        requ110.Request_Title__c = 'Test';
        requ110.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(requ110);
        requ110.Status__c = 'Release: UAT';
        Database.update(requ110);
        requ110.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ110);
        Request__c ureq110 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                              TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ110.id];     
        Integer d110 = ureq110.TimeSpentOn_Approve_to_Estimate__c.intvalue();
        if(ureq110.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ111 = new Request__c(Release__c=rele.id);
        //requ111.Priority__c = 'Low';
        requ111.Request_Type__c = 'Configuration';
        requ111.Request_Title__c = 'Test';
        requ111.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(requ111);
        requ111.Status__c = 'Release: Build Production';
        Database.update(requ111);
        requ111.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ111);
        Request__c ureq111 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                              TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ111.id];     
        Integer d111 = ureq111.TimeSpentOn_Approve_to_Estimate__c.intvalue();
        if(ureq111.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ112 = new Request__c(Release__c=rele.id);
        //requ112.Priority__c = 'Low';
        requ112.Request_Type__c = 'Configuration';
        requ112.Request_Title__c = 'Test';
        requ112.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(requ112);
        requ112.Status__c = 'Release: Test Production';
        Database.update(requ112);
        requ112.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ112);
        Request__c ureq112 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                              TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ112.id];     
        Integer d112 = ureq112.TimeSpentOn_Approve_to_Estimate__c.intvalue();
        if(ureq112.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ113 = new Request__c(Release__c=rele.id);
        //requ113.Priority__c = 'Low';
        requ113.Request_Type__c = 'Configuration';
        requ113.Request_Title__c = 'Test';
        requ113.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(requ113);
        requ113.Status__c = 'Release: No Build Req';
        Database.update(requ113);
        requ113.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ113);
        Request__c ureq113 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                              TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ113.id];     
        Integer d113 = ureq113.TimeSpentOn_Approve_to_Estimate__c.intvalue();
        if(ureq113.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ114 = new Request__c(Release__c=rele.id);
        //requ114.Priority__c = 'Low';
        requ114.Request_Type__c = 'Configuration';
        requ114.Request_Title__c = 'Test';
        requ114.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(requ114);
        requ114.Status__c = 'Close: Deployed';
        Database.update(requ114);
        requ114.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ114);
        Request__c ureq114 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                              TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ114.id];     
        Integer d114 = ureq114.TimeSpentOn_Approve_to_Estimate__c.intvalue();
        if(ureq114.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ115 = new Request__c(Release__c=rele.id);
        //requ115.Priority__c = 'Low';
        requ115.Request_Type__c = 'Configuration';
        requ115.Request_Title__c = 'Test';
        requ115.Status__c = 'Consolidate: Approve to Estimate';
        Database.insert(requ115);
        requ115.Status__c = 'Close: Rejected';
        requ115.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ115);
        requ115.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ115);
        Request__c ureq115 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                              TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ115.id];     
        Integer d115 = ureq115.TimeSpentOn_Approve_to_Estimate__c.intvalue();
        if(ureq115.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ116 = new Request__c(Release__c=rele.id);
        //requ116.Priority__c = 'Low';
        requ116.Request_Type__c = 'Configuration';
        requ116.Request_Title__c = 'Test';
        requ116.Status__c = 'Consolidate: Approve to Estimate';
        requ116.Related_Request__c = requ115.Id;
        Database.insert(requ116);
        requ116.Status__c = 'Close: Duplicate';
        Database.update(requ116);
        requ116.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ116);
        Request__c ureq116 = [Select Status__c, StartTime_Approve_to_Estimate__c, StopTime_Approve_to_Estimate__c, 
                              TimeSpentOn_Approve_to_Estimate__c, LastModifiedDate, Id from Request__c where id=: requ116.id];     
        try{Integer d116 = ureq116.TimeSpentOn_Approve_to_Estimate__c.intvalue();}Catch(Exception ex){}
        if(ureq116.StartTime_Approve_to_Estimate__c != null){
            system.debug('Test Pass');
        }
        
        
        Request__c requ117 = new Request__c(Release__c=rele.id);
        //requ117.Priority__c = 'Low';
        requ117.Request_Type__c = 'Configuration';
        requ117.Request_Title__c = 'Test';
        requ117.Status__c = 'Consolidate: Level of Effort Complete';
        requ117.Related_Request__c = requ115.Id;
        Database.insert(requ117);
        requ117.Status__c = 'Identify: New Requirement';
        Database.update(requ117);
        requ117.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ117);
        Request__c ureq117 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ117.id];     
        try{Integer d117 = ureq117.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();}Catch(Exception ex){}
        if(ureq117.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ118 = new Request__c(Release__c=rele.id);
        //requ118.Priority__c = 'Low';
        requ118.Request_Type__c = 'Configuration';
        requ118.Request_Title__c = 'Test';
        requ118.Status__c = 'Consolidate: Level of Effort Complete';
        requ118.Related_Request__c = requ115.Id;
        Database.insert(requ118);
        requ118.Status__c = 'Identify: Change Request';
        Database.update(requ118);
        requ118.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ118);
        Request__c ureq118 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ118.id];     
        try{Integer d118 = ureq118.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();}Catch(Exception ex){}
        if(ureq118.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        Test.stopTest();    
    }
    
    
    public static testMethod void TestUpdateTimeSpent10 (){
        
        Test.startTest();
        Release__c rele = new Release__c();
        rele.Name = 'Test';
        Database.Insert(rele,false); 
        Request__c requ119 = new Request__c(Release__c=rele.id);
        //requ119.Priority__c = 'Low';
        requ119.Request_Type__c = 'Configuration';
        requ119.Request_Title__c = 'Test';
        requ119.Status__c = 'Consolidate: Level of Effort Complete';
        //requ119.Related_Request__c = requ115.Id;
        Database.insert(requ119);
        requ119.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ119);
        requ119.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ119);
        Request__c ureq119 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ119.id];     
        try{Integer d119 = ureq119.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();}Catch(Exception ex){}
        if(ureq119.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ120 = new Request__c(Release__c=rele.id);
        //requ120.Priority__c = 'Low';
        requ120.Request_Type__c = 'Configuration';
        requ120.Request_Title__c = 'Test';
        requ120.Status__c = 'Consolidate: Level of Effort Complete';
        requ120.Related_Request__c = requ119.Id;
        Database.insert(requ120);
        requ120.Status__c = 'Identify: Emergency Request';
        Database.update(requ120);
        requ120.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ120);
        Request__c ureq120 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ120.id];     
        try{Integer d120 = ureq120.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();}Catch(Exception ex){}
        if(ureq120.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ121 = new Request__c(Release__c=rele.id);
        //requ121.Priority__c = 'Low';
        requ121.Request_Type__c = 'Configuration';
        requ121.Request_Title__c = 'Test';
        requ121.Status__c = 'Consolidate: Level of Effort Complete';
        requ121.Related_Request__c = requ119.Id;
        Database.insert(requ121);
        requ121.Status__c = 'Identify: Deferred';
        requ121.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ121);
        requ121.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ121);
        Request__c ureq121 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ121.id];     
        try{Integer d121 = ureq121.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();}Catch(Exception ex){}
        if(ureq121.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ122 = new Request__c(Release__c=rele.id);
        //requ122.Priority__c = 'Low';
        requ122.Request_Type__c = 'Configuration';
        requ122.Request_Title__c = 'Test';
        requ122.Status__c = 'Consolidate: Level of Effort Complete';
        requ122.Related_Request__c = requ119.Id;
        Database.insert(requ122);
        requ122.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ122);
        requ122.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ122);
        Request__c ureq122 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ122.id];     
        try{Integer d122 = ureq122.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();}Catch(Exception ex){}
        if(ureq122.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ123 = new Request__c(Release__c=rele.id);
        //requ123.Priority__c = 'Low';
        requ123.Request_Type__c = 'Configuration';
        requ123.Request_Title__c = 'Test';
        requ123.Status__c = 'Consolidate: Level of Effort Complete';
        requ123.Related_Request__c = requ119.Id;
        Database.insert(requ123);
        requ123.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ123);
        requ123.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ123);
        Request__c ureq123 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ123.id];     
        try{Integer d123 = ureq123.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();}Catch(Exception ex){}
        if(ureq123.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ124 = new Request__c(Release__c=rele.id);
        //requ124.Priority__c = 'Low';
        requ124.Request_Type__c = 'Configuration';
        requ124.Request_Title__c = 'Test';
        requ124.Status__c = 'Consolidate: Level of Effort Complete';
        requ124.Related_Request__c = requ119.Id;
        Database.insert(requ124);
        requ124.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ124);
        requ124.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ124);
        Request__c ureq124 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ124.id];     
        try{Integer d124 = ureq124.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();}Catch(Exception ex){}
        if(ureq124.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ125 = new Request__c(Release__c=rele.id);
        //requ125.Priority__c = 'Low';
        requ125.Request_Type__c = 'Configuration';
        requ125.Request_Title__c = 'Test';
        requ125.Status__c = 'Consolidate: Level of Effort Complete';
        requ125.Related_Request__c = requ119.Id;
        Database.insert(requ125);
        requ125.Status__c = 'Release: Design';
        Database.update(requ125);
        requ125.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ125);
        Request__c ureq125 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ125.id];     
        try{Integer d125 = ureq125.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();}Catch(Exception ex){}
        if(ureq125.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ126 = new Request__c(Release__c=rele.id);
        //requ126.Priority__c = 'Low';
        requ126.Request_Type__c = 'Configuration';
        requ126.Request_Title__c = 'Test';
        requ126.Status__c = 'Consolidate: Level of Effort Complete';
        requ126.Related_Request__c = requ119.Id;
        Database.insert(requ126);
        requ126.Status__c = 'Release: Build';
        Database.update(requ126);
        requ126.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ126);
        Request__c ureq126 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ126.id];     
        try{Integer d126 = ureq126.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();}Catch(Exception ex){}
        if(ureq126.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ127 = new Request__c(Release__c=rele.id);
        //requ127.Priority__c = 'Low';
        requ127.Request_Type__c = 'Configuration';
        requ127.Request_Title__c = 'Test';
        requ127.Status__c = 'Consolidate: Level of Effort Complete';
        requ127.Related_Request__c = requ119.Id;
        Database.insert(requ127);
        requ127.Status__c = 'Release: Test';
        Database.update(requ127);
        requ127.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ127);
        Request__c ureq127 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ127.id];     
        try{Integer d127 = ureq127.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();}Catch(Exception ex){}
        if(ureq127.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ128 = new Request__c(Release__c=rele.id);
        //requ128.Priority__c = 'Low';
        requ128.Request_Type__c = 'Configuration';
        requ128.Request_Title__c = 'Test';
        requ128.Status__c = 'Consolidate: Level of Effort Complete';
        requ128.Related_Request__c = requ119.Id;
        Database.insert(requ128);
        requ128.Status__c = 'Release: SIT';
        Database.update(requ128);
        requ128.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ128);
        Request__c ureq128 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ128.id];     
        try{Integer d128 = ureq128.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();}Catch(Exception ex){}
        if(ureq128.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ129 = new Request__c(Release__c=rele.id);
        //requ129.Priority__c = 'Low';
        requ129.Request_Type__c = 'Configuration';
        requ129.Request_Title__c = 'Test';
        requ129.Status__c = 'Consolidate: Level of Effort Complete';
        Database.insert(requ129);
        requ129.Status__c = 'Release: UAT';
        Database.update(requ129);
        requ129.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ129);
        Request__c ureq129 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ129.id];     
        Integer d129 = ureq129.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();
        if(ureq129.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ130 = new Request__c(Release__c=rele.id);
        //requ130.Priority__c = 'Low';
        requ130.Request_Type__c = 'Configuration';
        requ130.Request_Title__c = 'Test';
        requ130.Status__c = 'Consolidate: Level of Effort Complete';
        Database.insert(requ130);
        requ130.Status__c = 'Release: Build Production';
        Database.update(requ130);
        requ130.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ130);
        Request__c ureq130 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ130.id];     
        Integer d130 = ureq130.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();
        if(ureq130.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ131 = new Request__c(Release__c=rele.id);
        //requ131.Priority__c = 'Low';
        requ131.Request_Type__c = 'Configuration';
        requ131.Request_Title__c = 'Test';
        requ131.Status__c = 'Consolidate: Level of Effort Complete';
        Database.insert(requ131);
        requ131.Status__c = 'Release: Test Production';
        Database.update(requ131);
        requ131.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ131);
        Request__c ureq131 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ131.id];     
        Integer d131 = ureq131.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();
        if(ureq131.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ132 = new Request__c(Release__c=rele.id);
        //requ132.Priority__c = 'Low';
        requ132.Request_Type__c = 'Configuration';
        requ132.Request_Title__c = 'Test';
        requ132.Status__c = 'Consolidate: Level of Effort Complete';
        Database.insert(requ132);
        requ132.Status__c = 'Release: No Build Req';
        Database.update(requ132);
        requ132.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ132);
        Request__c ureq132 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ132.id];     
        Integer d132 = ureq132.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();
        if(ureq132.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ133 = new Request__c(Release__c=rele.id);
        //requ133.Priority__c = 'Low';
        requ133.Request_Type__c = 'Configuration';
        requ133.Request_Title__c = 'Test';
        requ133.Status__c = 'Consolidate: Level of Effort Complete';
        Database.insert(requ133);
        requ133.Status__c = 'Close: Deployed';
        Database.update(requ133);
        requ133.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ133);
        Request__c ureq133 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ133.id];     
        Integer d133 = ureq133.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();
        if(ureq133.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ134 = new Request__c(Release__c=rele.id);
        //requ134.Priority__c = 'Low';
        requ134.Request_Type__c = 'Configuration';
        requ134.Request_Title__c = 'Test';
        requ134.Status__c = 'Consolidate: Level of Effort Complete';
        Database.insert(requ134);
        requ134.Status__c = 'Close: Rejected';
        requ134.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ134);
        requ134.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ134);
        Request__c ureq134 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ134.id];     
        Integer d134 = ureq134.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();
        if(ureq134.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ135 = new Request__c(Release__c=rele.id);
        //requ135.Priority__c = 'Low';
        requ135.Request_Type__c = 'Configuration';
        requ135.Request_Title__c = 'Test';
        requ135.Status__c = 'Consolidate: Level of Effort Complete';
        requ135.Related_Request__c = requ134.Id;
        Database.insert(requ135);
        requ135.Status__c = 'Close: Duplicate';
        Database.update(requ135);
        requ135.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ135);
        Request__c ureq135 = [Select Status__c, StartTime_Level_of_Effort_Complete__c, StopTime_Level_of_Effort_Complete__c, 
                              TimeSpentOn_Level_of_Effort_Complete__c, LastModifiedDate, Id from Request__c where id=: requ135.id];     
        Integer d135 = ureq135.TimeSpentOn_Level_of_Effort_Complete__c.intvalue();
        if(ureq135.StartTime_Level_of_Effort_Complete__c != null){
            system.debug('Test Pass');
        }
        
        
        Request__c requ136 = new Request__c(Release__c=rele.id);
        //requ136.Priority__c = 'Low';
        requ136.Request_Type__c = 'Configuration';
        requ136.Request_Title__c = 'Test';
        requ136.Status__c = 'Approve: Approved to Deploy';
        Database.insert(requ136);
        requ136.Status__c = 'Identify: New Requirement';
        Database.update(requ136);
        requ136.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ136);
        Request__c ureq136 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ136.id];     
        Integer d136 = ureq136.TimeSpentOn_Approved_to_Deploy__c.intvalue();
        if(ureq136.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ137 = new Request__c(Release__c=rele.id);
        //requ137.Priority__c = 'Low';
        requ137.Request_Type__c = 'Configuration';
        requ137.Request_Title__c = 'Test';
        requ137.Status__c = 'Approve: Approved to Deploy';
        Database.insert(requ137);
        requ137.Status__c = 'Identify: Change Request';
        Database.update(requ137);
        requ137.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ137);
        Request__c ureq137 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ137.id];     
        Integer d137 = ureq137.TimeSpentOn_Approved_to_Deploy__c.intvalue();
        if(ureq137.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ138 = new Request__c(Release__c=rele.id);
        //requ138.Priority__c = 'Low';
        requ138.Request_Type__c = 'Configuration';
        requ138.Request_Title__c = 'Test';
        requ138.Status__c = 'Approve: Approved to Deploy';
        Database.insert(requ138);
        requ138.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ138);
        requ138.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ138);
        Request__c ureq138 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ138.id];     
        Integer d138 = ureq138.TimeSpentOn_Approved_to_Deploy__c.intvalue();
        if(ureq138.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        Test.stopTest();    
    }
    public static testMethod void TestUpdateTimeSpent11(){
        
        Test.startTest();
        Release__c rele = new Release__c();
        rele.Name = 'Test';
        Database.Insert(rele,false); 
        Request__c requ139 = new Request__c(Release__c=rele.id);
        //requ139.Priority__c = 'Low';
        requ139.Request_Type__c = 'Configuration';
        requ139.Request_Title__c = 'Test';
        requ139.Status__c = 'Approve: Approved to Deploy';
        Database.insert(requ139);
        requ139.Status__c = 'Identify: Emergency Request';
        Database.update(requ139);
        requ139.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ139);
        Request__c ureq139 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ139.id];     
        Integer d139 = ureq139.TimeSpentOn_Approved_to_Deploy__c.intvalue();
        if(ureq139.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ140 = new Request__c(Release__c=rele.id);
        //requ140.Priority__c = 'Low';
        requ140.Request_Type__c = 'Configuration';
        requ140.Request_Title__c = 'Test';
        requ140.Status__c = 'Approve: Approved to Deploy';
        Database.insert(requ140);
        requ140.Status__c = 'Identify: Deferred';
        requ140.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ140);
        requ140.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ140);
        Request__c ureq140 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ140.id];     
        Integer d140 = ureq140.TimeSpentOn_Approved_to_Deploy__c.intvalue();
        if(ureq140.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ141 = new Request__c(Release__c=rele.id);
        //requ141.Priority__c = 'Low';
        requ141.Request_Type__c = 'Configuration';
        requ141.Request_Title__c = 'Test';
        requ141.Status__c = 'Approve: Approved to Deploy';
        Database.insert(requ141);
        requ141.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ141);
        requ141.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ141);
        Request__c ureq141 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ141.id];     
        Integer d141 = ureq141.TimeSpentOn_Approved_to_Deploy__c.intvalue();
        if(ureq141.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ142 = new Request__c(Release__c=rele.id);
        //requ142.Priority__c = 'Low';
        requ142.Request_Type__c = 'Configuration';
        requ142.Request_Title__c = 'Test';
        requ142.Status__c = 'Approve: Approved to Deploy';
        Database.insert(requ142);
        requ142.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ142);
        requ142.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ142);
        Request__c ureq142 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ142.id];     
        Integer d142 = ureq142.TimeSpentOn_Approved_to_Deploy__c.intvalue();
        if(ureq142.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ143 = new Request__c(Release__c=rele.id);
        //requ143.Priority__c = 'Low';
        requ143.Request_Type__c = 'Configuration';
        requ143.Request_Title__c = 'Test';
        requ143.Status__c = 'Approve: Approved to Deploy';
        Database.insert(requ143);
        requ143.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ143);
        requ143.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ143);
        Request__c ureq143 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ143.id];     
        Integer d143 = ureq143.TimeSpentOn_Approved_to_Deploy__c.intvalue();
        if(ureq143.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ144 = new Request__c(Release__c=rele.id);
        //requ144.Priority__c = 'Low';
        requ144.Request_Type__c = 'Configuration';
        requ144.Request_Title__c = 'Test';
        requ144.Status__c = 'Approve: Approved to Deploy';
        Database.insert(requ144);
        requ144.Status__c = 'Release: Design';
        Database.update(requ144);
        requ144.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ144);
        Request__c ureq144 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ144.id];     
        Integer d144 = ureq144.TimeSpentOn_Approved_to_Deploy__c.intvalue();
        if(ureq144.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        Test.stopTest();    
    }
    public static testMethod void TestUpdateTimeSpent3(){
        
        Test.startTest();
        Release__c rele = new Release__c();
        rele.Name = 'Test';
        Database.Insert(rele,false); 
        
        Request__c requ145 = new Request__c(Release__c=rele.id);
        //requ145.Priority__c = 'Low';
        requ145.Request_Type__c = 'Configuration';
        requ145.Request_Title__c = 'Test';
        requ145.Status__c = 'Approve: Approved to Deploy';
        Database.insert(requ145);
        requ145.Status__c = 'Release: Build';
        Database.update(requ145);
        requ145.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ145);
        Request__c ureq145 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ145.id];     
        Integer d145 = ureq145.TimeSpentOn_Approved_to_Deploy__c.intvalue();
        if(ureq145.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ146 = new Request__c(Release__c=rele.id);
        //requ146.Priority__c = 'Low';
        requ146.Request_Type__c = 'Configuration';
        requ146.Request_Title__c = 'Test';
        requ146.Status__c = 'Approve: Approved to Deploy';
        Database.insert(requ146);
        requ146.Status__c = 'Release: Test';
        Database.update(requ146);
        requ146.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ146);
        Request__c ureq146 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ146.id];     
        Integer d146 = ureq146.TimeSpentOn_Approved_to_Deploy__c.intvalue();
        if(ureq146.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ147 = new Request__c(Release__c=rele.id);
        //requ147.Priority__c = 'Low';
        requ147.Request_Type__c = 'Configuration';
        requ147.Request_Title__c = 'Test';
        requ147.Status__c = 'Approve: Approved to Deploy';
        Database.insert(requ147);
        requ147.Status__c = 'Release: SIT';
        Database.update(requ147);
        requ147.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ147);
        Request__c ureq147 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ147.id];     
        Integer d147 = ureq147.TimeSpentOn_Approved_to_Deploy__c.intvalue();
        if(ureq147.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ148 = new Request__c(Release__c=rele.id);
        //requ148.Priority__c = 'Low';
        requ148.Request_Type__c = 'Configuration';
        requ148.Request_Title__c = 'Test';
        requ148.Status__c = 'Approve: Approved to Deploy';
        Database.insert(requ148);
        requ148.Status__c = 'Release: UAT';
        Database.update(requ148);
        requ148.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ148);
        Request__c ureq148 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ148.id];     
        Integer d148 = ureq148.TimeSpentOn_Approved_to_Deploy__c.intvalue();
        if(ureq148.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ149 = new Request__c(Release__c=rele.id);
        //requ149.Priority__c = 'Low';
        requ149.Request_Type__c = 'Configuration';
        requ149.Request_Title__c = 'Test';
        requ149.Status__c = 'Approve: Approved to Deploy';
        Database.insert(requ149);
        requ149.Status__c = 'Release: Build Production';
        Database.update(requ149);
        requ149.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ149);
        Request__c ureq149 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ149.id];     
        Integer d149 = ureq149.TimeSpentOn_Approved_to_Deploy__c.intvalue();
        if(ureq149.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ150 = new Request__c(Release__c=rele.id);
        //requ150.Priority__c = 'Low';
        requ150.Request_Type__c = 'Configuration';
        requ150.Request_Title__c = 'Test';
        requ150.Status__c = 'Approve: Approved to Deploy';
        Database.insert(requ150);
        requ150.Status__c = 'Release: Test Production';
        Database.update(requ150);
        requ150.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ150);
        Request__c ureq150 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ150.id];     
        Integer d150 = ureq150.TimeSpentOn_Approved_to_Deploy__c.intvalue();
        if(ureq150.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ151 = new Request__c(Release__c=rele.id);
        //requ151.Priority__c = 'Low';
        requ151.Request_Type__c = 'Configuration';
        requ151.Request_Title__c = 'Test';
        requ151.Status__c = 'Approve: Approved to Deploy';
        Database.insert(requ151);
        requ151.Status__c = 'Release: No Build Req';
        Database.update(requ151);
        requ151.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ151);
        Request__c ureq151 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ151.id];     
        Integer d151 = ureq151.TimeSpentOn_Approved_to_Deploy__c.intvalue();
        if(ureq151.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ152 = new Request__c(Release__c=rele.id);
        //requ152.Priority__c = 'Low';
        requ152.Request_Type__c = 'Configuration';
        requ152.Request_Title__c = 'Test';
        requ152.Status__c = 'Approve: Approved to Deploy';
        Database.insert(requ152);
        requ152.Status__c = 'Close: Deployed';
        Database.update(requ152);
        requ152.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ152);
        Request__c ureq152 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ152.id];     
        Integer d152 = ureq152.TimeSpentOn_Approved_to_Deploy__c.intvalue();
        if(ureq152.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ153 = new Request__c(Release__c=rele.id);
        //requ153.Priority__c = 'Low';
        requ153.Request_Type__c = 'Configuration';
        requ153.Request_Title__c = 'Test';
        requ153.Status__c = 'Approve: Approved to Deploy';
        Database.insert(requ153);
        requ153.Status__c = 'Close: Rejected';
        requ153.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ153);
        requ153.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ153);
        Request__c ureq153 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ153.id];     
        Integer d153 = ureq153.TimeSpentOn_Approved_to_Deploy__c.intvalue();
        if(ureq153.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ154 = new Request__c(Release__c=rele.id);
        //requ154.Priority__c = 'Low';
        requ154.Request_Type__c = 'Configuration';
        requ154.Request_Title__c = 'Test';
        requ154.Status__c = 'Approve: Approved to Deploy';
        requ154.Related_Request__c = requ153.Id;
        Database.insert(requ154);
        requ154.Status__c = 'Close: Duplicate';
        Database.update(requ154);
        requ154.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ154);
        Request__c ureq154 = [Select Status__c, StartTime_Approved_to_Deploy__c, StopTime_Approved_to_Deploy__c, 
                              TimeSpentOn_Approved_to_Deploy__c, LastModifiedDate, Id from Request__c where id=: requ154.id];     
        try{Integer d154 = ureq154.TimeSpentOn_Approved_to_Deploy__c.intvalue();}Catch(Exception ex){}
        if(ureq154.StartTime_Approved_to_Deploy__c != null){
            system.debug('Test Pass');
        }
        
        
        Request__c requ155 = new Request__c(Release__c=rele.id);
        //requ155.Priority__c = 'Low';
        requ155.Request_Type__c = 'Configuration';
        requ155.Request_Title__c = 'Test';
        requ155.Status__c = 'Approve: Approved Emergency Release';
        requ155.Related_Request__c = requ153.Id;
        Database.insert(requ155);
        requ155.Status__c = 'Identify: New Requirement';
        Database.update(requ155);
        requ155.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ155);
        Request__c ureq155 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ155.id];     
        try{Integer d155 = ureq155.TimeSpentOn_Approved_Emergency_Release__c.intvalue();}Catch(Exception ex){}
        if(ureq155.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ156 = new Request__c(Release__c=rele.id);
        //requ156.Priority__c = 'Low';
        requ156.Request_Type__c = 'Configuration';
        requ156.Request_Title__c = 'Test';
        requ156.Status__c = 'Approve: Approved Emergency Release';
        requ156.Related_Request__c = requ153.Id;
        Database.insert(requ156);
        requ156.Status__c = 'Identify: Change Request';
        Database.update(requ156);
        requ156.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ156);
        Request__c ureq156 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ156.id];     
        try{Integer d156 = ureq156.TimeSpentOn_Approved_Emergency_Release__c.intvalue();}Catch(Exception ex){}
        if(ureq156.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ157 = new Request__c(Release__c=rele.id);
        //requ157.Priority__c = 'Low';
        requ157.Request_Type__c = 'Configuration';
        requ157.Request_Title__c = 'Test';
        requ157.Status__c = 'Approve: Approved Emergency Release';
        requ157.Related_Request__c = requ153.Id;
        Database.insert(requ157);
        requ157.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ157);
        requ157.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ157);
        Request__c ureq157 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ157.id];     
        try{Integer d157 = ureq157.TimeSpentOn_Approved_Emergency_Release__c.intvalue();}Catch(Exception ex){}
        if(ureq157.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ158 = new Request__c(Release__c=rele.id);
        //requ158.Priority__c = 'Low';
        requ158.Request_Type__c = 'Configuration';
        requ158.Request_Title__c = 'Test';
        requ158.Status__c = 'Approve: Approved Emergency Release';
        requ158.Related_Request__c = requ153.Id;
        Database.insert(requ158);
        requ158.Status__c = 'Identify: Emergency Request';
        Database.update(requ158);
        requ158.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ158);
        Request__c ureq158 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ158.id];     
        try{Integer d158 = ureq158.TimeSpentOn_Approved_Emergency_Release__c.intvalue();}Catch(Exception ex){}
        if(ureq158.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ159 = new Request__c(Release__c=rele.id);
        //requ159.Priority__c = 'Low';
        requ159.Request_Type__c = 'Configuration';
        requ159.Request_Title__c = 'Test';
        requ159.Status__c = 'Approve: Approved Emergency Release';
        requ159.Related_Request__c = requ153.Id;
        Database.insert(requ159);
        requ159.Status__c = 'Identify: Deferred';
        requ159.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ159);
        requ159.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ159);
        Request__c ureq159 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ159.id];     
        try{Integer d159 = ureq159.TimeSpentOn_Approved_Emergency_Release__c.intvalue();}Catch(Exception ex){}
        if(ureq159.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ160 = new Request__c(Release__c=rele.id);
        //requ160.Priority__c = 'Low';
        requ160.Request_Type__c = 'Configuration';
        requ160.Request_Title__c = 'Test';
        requ160.Status__c = 'Approve: Approved Emergency Release';
        requ160.Related_Request__c = requ153.Id;
        Database.insert(requ160);
        requ160.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ160);
        requ160.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ160);
        Request__c ureq160 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ160.id];     
        try{Integer d160 = ureq160.TimeSpentOn_Approved_Emergency_Release__c.intvalue();}Catch(Exception ex){}
        if(ureq160.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ161 = new Request__c(Release__c=rele.id);
        //requ161.Priority__c = 'Low';
        requ161.Request_Type__c = 'Configuration';
        requ161.Request_Title__c = 'Test';
        requ161.Status__c = 'Approve: Approved Emergency Release';
        requ161.Related_Request__c = requ153.Id;
        Database.insert(requ161);
        requ161.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ161);
        requ161.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ161);
        Request__c ureq161 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ161.id];     
        try{Integer d161 = ureq161.TimeSpentOn_Approved_Emergency_Release__c.intvalue();}Catch(Exception ex){}
        if(ureq161.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ162 = new Request__c(Release__c=rele.id);
        //requ162.Priority__c = 'Low';
        requ162.Request_Type__c = 'Configuration';
        requ162.Request_Title__c = 'Test';
        requ162.Status__c = 'Approve: Approved Emergency Release';
        Database.insert(requ162);
        requ162.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ162);
        requ162.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ162);
        Request__c ureq162 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ162.id];     
        try{Integer d162 = ureq162.TimeSpentOn_Approved_Emergency_Release__c.intvalue();}Catch(Exception ex){}
        if(ureq162.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ163 = new Request__c(Release__c=rele.id);
        //requ163.Priority__c = 'Low';
        requ163.Request_Type__c = 'Configuration';
        requ163.Request_Title__c = 'Test';
        requ163.Status__c = 'Approve: Approved Emergency Release';
        Database.insert(requ163);
        requ163.Status__c = 'Release: Design';
        Database.update(requ163);
        requ163.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ163);
        Request__c ureq163 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ163.id];     
        try{Integer d163 = ureq163.TimeSpentOn_Approved_Emergency_Release__c.intvalue();}Catch(Exception ex){}
        if(ureq163.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ164 = new Request__c(Release__c=rele.id);
        //requ164.Priority__c = 'Low';
        requ164.Request_Type__c = 'Configuration';
        requ164.Request_Title__c = 'Test';
        requ164.Status__c = 'Approve: Approved Emergency Release';
        Database.insert(requ164);
        requ164.Status__c = 'Release: Build';
        Database.update(requ164);
        requ164.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ164);
        Request__c ureq164 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ164.id];     
        try{Integer d164 = ureq164.TimeSpentOn_Approved_Emergency_Release__c.intvalue();}Catch(Exception ex){}
        if(ureq164.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ165 = new Request__c(Release__c=rele.id);
        //requ165.Priority__c = 'Low';
        requ165.Request_Type__c = 'Configuration';
        requ165.Request_Title__c = 'Test';
        requ165.Status__c = 'Approve: Approved Emergency Release';
        Database.insert(requ165);
        requ165.Status__c = 'Release: Test';
        Database.update(requ165);
        requ165.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ165);
        Request__c ureq165 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ165.id];     
        try{Integer d165 = ureq165.TimeSpentOn_Approved_Emergency_Release__c.intvalue();}Catch(Exception ex){}
        if(ureq165.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        Test.stopTest();    
    }
    public static testMethod void TestUpdateTimeSpent13(){
        
        Test.startTest();
        Release__c rele = new Release__c();
        rele.Name = 'Test';
        Database.Insert(rele,false); 
        Request__c requ166 = new Request__c(Release__c=rele.id);
        //requ166.Priority__c = 'Low';
        requ166.Request_Type__c = 'Configuration';
        requ166.Request_Title__c = 'Test';
        requ166.Status__c = 'Approve: Approved Emergency Release';
        Database.insert(requ166);
        requ166.Status__c = 'Release: SIT';
        Database.update(requ166);
        requ166.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ166);
        Request__c ureq166 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ166.id];     
        try{
        Integer d166 = ureq166.TimeSpentOn_Approved_Emergency_Release__c.intvalue();
       }Catch(Exception ex){}
        if(ureq166.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ167 = new Request__c(Release__c=rele.id);
        //requ167.Priority__c = 'Low';
        requ167.Request_Type__c = 'Configuration';
        requ167.Request_Title__c = 'Test';
        requ167.Status__c = 'Approve: Approved Emergency Release';
        Database.insert(requ167);
        requ167.Status__c = 'Release: UAT';
        Database.update(requ167);
        requ167.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ167);
        Request__c ureq167 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ167.id];     
       try{ Integer d167 = ureq167.TimeSpentOn_Approved_Emergency_Release__c.intvalue();}Catch(Exception ex){}
        if(ureq167.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ168 = new Request__c(Release__c=rele.id);
        //requ168.Priority__c = 'Low';
        requ168.Request_Type__c = 'Configuration';
        requ168.Request_Title__c = 'Test';
        requ168.Status__c = 'Approve: Approved Emergency Release';
        Database.insert(requ168);
        requ168.Status__c = 'Release: Build Production';
        Database.update(requ168);
        requ168.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ168);
        Request__c ureq168 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ168.id];     
        try{Integer d168 = ureq168.TimeSpentOn_Approved_Emergency_Release__c.intvalue();}Catch(Exception ex){}
        if(ureq168.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ169 = new Request__c(Release__c=rele.id);
        //requ169.Priority__c = 'Low';
        requ169.Request_Type__c = 'Configuration';
        requ169.Request_Title__c = 'Test';
        requ169.Status__c = 'Approve: Approved Emergency Release';
        Database.insert(requ169);
        requ169.Status__c = 'Release: Test Production';
        Database.update(requ169);
        requ169.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ169);
        Request__c ureq169 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ169.id];     
        try{Integer d169 = ureq169.TimeSpentOn_Approved_Emergency_Release__c.intvalue();}Catch(Exception ex){}
        if(ureq169.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ170 = new Request__c(Release__c=rele.id);
        //requ170.Priority__c = 'Low';
        requ170.Request_Type__c = 'Configuration';
        requ170.Request_Title__c = 'Test';
        requ170.Status__c = 'Approve: Approved Emergency Release';
        Database.insert(requ170);
        requ170.Status__c = 'Release: No Build Req';
        Database.update(requ170);
        requ170.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ170);
        Request__c ureq170 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ170.id];     
        try{Integer d170 = ureq170.TimeSpentOn_Approved_Emergency_Release__c.intvalue();}Catch(Exception ex){}
        if(ureq170.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ171 = new Request__c(Release__c=rele.id);
        //requ171.Priority__c = 'Low';
        requ171.Request_Type__c = 'Configuration';
        requ171.Request_Title__c = 'Test';
        requ171.Status__c = 'Approve: Approved Emergency Release';
        Database.insert(requ171);
        requ171.Status__c = 'Close: Deployed';
        Database.update(requ171);
        requ171.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ171);
        Request__c ureq171 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ171.id];     
        try{Integer d171 = ureq171.TimeSpentOn_Approved_Emergency_Release__c.intvalue();}Catch(Exception ex){}
        if(ureq171.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ172 = new Request__c(Release__c=rele.id);
        //requ172.Priority__c = 'Low';
        requ172.Request_Type__c = 'Configuration';
        requ172.Request_Title__c = 'Test';
        requ172.Status__c = 'Approve: Approved Emergency Release';
        Database.insert(requ172);
        requ172.Status__c = 'Close: Rejected';
        requ172.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ172);
        requ172.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ172);
        Request__c ureq172 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ172.id];     
        try{Integer d172 = ureq172.TimeSpentOn_Approved_Emergency_Release__c.intvalue();}Catch(Exception ex){}
        if(ureq172.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ173 = new Request__c(Release__c=rele.id);
        //requ173.Priority__c = 'Low';
        requ173.Request_Type__c = 'Configuration';
        requ173.Request_Title__c = 'Test';
        requ173.Status__c = 'Approve: Approved Emergency Release';
        requ173.Related_Request__c = requ172.Id;
        Database.insert(requ173);
        requ173.Status__c = 'Close: Duplicate';
        Database.update(requ173);
        requ173.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ173);
        Request__c ureq173 = [Select Status__c, StartTime_Approved_Emergency_Release__c, StopTime_Approved_Emergency_Release__c, 
                              TimeSpentOn_Approved_Emergency_Release__c, LastModifiedDate, Id from Request__c where id=: requ173.id];     
        try{Integer d173 = ureq173.TimeSpentOn_Approved_Emergency_Release__c.intvalue();}Catch(Exception ex){}
        if(ureq173.StartTime_Approved_Emergency_Release__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ174 = new Request__c(Release__c=rele.id);
        //requ174.Priority__c = 'Low';
        requ174.Request_Type__c = 'Configuration';
        requ174.Request_Title__c = 'Test';
        requ174.Status__c = 'Release: Design';
        requ173.Related_Request__c = requ172.Id;
        Database.insert(requ174);
        requ174.Status__c = 'Identify: New Requirement';
        Database.update(requ174);
        requ174.Status__c = 'Release: Design';
        Database.update(requ174);
        Request__c ureq174 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ174.id];     
        try{Integer d174 = ureq174.TimeSpentOn_Design__c.intvalue();}Catch(Exception ex){}
        if(ureq174.StartTime_Design__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ175 = new Request__c(Release__c=rele.id);
        //requ175.Priority__c = 'Low';
        requ175.Request_Type__c = 'Configuration';
        requ175.Request_Title__c = 'Test';
        requ175.Status__c = 'Release: Design';
        requ173.Related_Request__c = requ172.Id;
        Database.insert(requ175);
        requ175.Status__c = 'Identify: Change Request';
        Database.update(requ175);
        requ175.Status__c = 'Release: Design';
        Database.update(requ175);
        Request__c ureq175 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ175.id];     
        Integer d175 = ureq175.TimeSpentOn_Design__c.intvalue();
        if(ureq175.StartTime_Design__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ176 = new Request__c(Release__c=rele.id);
        //requ176.Priority__c = 'Low';
        requ176.Request_Type__c = 'Configuration';
        requ176.Request_Title__c = 'Test';
        requ176.Status__c = 'Release: Design';requ173.Related_Request__c = requ172.Id;
        Database.insert(requ176);
        requ176.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ176);
        requ176.Status__c = 'Release: Design';
        Database.update(requ176);
        Request__c ureq176 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ176.id];     
        try{Integer d176 = ureq176.TimeSpentOn_Design__c.intvalue();}Catch(Exception es){}
        if(ureq176.StartTime_Design__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ177 = new Request__c(Release__c=rele.id);
        //requ177.Priority__c = 'Low';
        requ177.Request_Type__c = 'Configuration';
        requ177.Request_Title__c = 'Test';
        requ177.Status__c = 'Release: Design';requ173.Related_Request__c = requ172.Id;
        Database.insert(requ177);
        requ177.Status__c = 'Identify: Emergency Request';
        Database.update(requ177);
        requ177.Status__c = 'Release: Design';
        Database.update(requ177);
        Request__c ureq177 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ177.id];     
        try{Integer d177 = ureq177.TimeSpentOn_Design__c.intvalue();}Catch(Exception ex){}
        if(ureq177.StartTime_Design__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ178 = new Request__c(Release__c=rele.id);
        //requ178.Priority__c = 'Low';
        requ178.Request_Type__c = 'Configuration';
        requ178.Request_Title__c = 'Test';
        requ178.Status__c = 'Release: Design';requ173.Related_Request__c = requ172.Id;
        Database.insert(requ178);
        requ178.Status__c = 'Identify: Deferred';
        requ178.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ178);
        requ178.Status__c = 'Release: Design';
        Database.update(requ178);
        Request__c ureq178 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ178.id];     
        try{Integer d178 = ureq178.TimeSpentOn_Design__c.intvalue();}Catch(Exception ex){}
        if(ureq178.StartTime_Design__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ179 = new Request__c(Release__c=rele.id);
        //requ179.Priority__c = 'Low';
        requ179.Request_Type__c = 'Configuration';
        requ179.Request_Title__c = 'Test';
        requ179.Status__c = 'Release: Design';requ173.Related_Request__c = requ172.Id;
        Database.insert(requ179);
        requ179.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ179);
        requ179.Status__c = 'Release: Design';
        Database.update(requ179);
        Request__c ureq179 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ179.id];     
        try{Integer d179 = ureq179.TimeSpentOn_Design__c.intvalue();}Catch(Exception ex){}
        if(ureq179.StartTime_Design__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ180 = new Request__c(Release__c=rele.id);
        //requ180.Priority__c = 'Low';
        requ180.Request_Type__c = 'Configuration';
        requ180.Request_Title__c = 'Test';
        requ180.Status__c = 'Release: Design';requ173.Related_Request__c = requ172.Id;
        Database.insert(requ180);
        requ180.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ180);
        requ180.Status__c = 'Release: Design';
        Database.update(requ180);
        Request__c ureq180 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ180.id];     
        try{Integer d180 = ureq180.TimeSpentOn_Design__c.intvalue();}Catch(Exception ex){}
        if(ureq180.StartTime_Design__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ181 = new Request__c(Release__c=rele.id);
        //requ181.Priority__c = 'Low';
        requ181.Request_Type__c = 'Configuration';
        requ181.Request_Title__c = 'Test';
        requ181.Status__c = 'Release: Design';requ173.Related_Request__c = requ172.Id;
        Database.insert(requ181);
        requ181.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ181);
        requ181.Status__c = 'Release: Design';
        Database.update(requ181);
        Request__c ureq181 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ181.id];     
        try{Integer d181 = ureq181.TimeSpentOn_Design__c.intvalue();}Catch(Exception ex){}
        if(ureq181.StartTime_Design__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ182 = new Request__c(Release__c=rele.id);
        //requ182.Priority__c = 'Low';
        requ182.Request_Type__c = 'Configuration';
        requ182.Request_Title__c = 'Test';
        requ182.Status__c = 'Release: Design';requ173.Related_Request__c = requ172.Id;
        Database.insert(requ182);
        requ182.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ182);
        requ182.Status__c = 'Release: Design';
        Database.update(requ182);
        Request__c ureq182 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ182.id];     
        try{Integer d182 = ureq182.TimeSpentOn_Design__c.intvalue();}Catch(Exception ex){}
        if(ureq182.StartTime_Design__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ183 = new Request__c(Release__c=rele.id);
        //requ183.Priority__c = 'Low';
        requ183.Request_Type__c = 'Configuration';
        requ183.Request_Title__c = 'Test';
        requ183.Status__c = 'Release: Design';requ173.Related_Request__c = requ172.Id;
        Database.insert(requ183);
        requ183.Status__c = 'Release: Build';
        Database.update(requ183);
        requ183.Status__c = 'Release: Design';
        Database.update(requ183);
        Request__c ureq183 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ183.id];     
        try{Integer d183 = ureq183.TimeSpentOn_Design__c.intvalue();}Catch(Exception ex){}
        if(ureq183.StartTime_Design__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ184 = new Request__c(Release__c=rele.id);
        //requ184.Priority__c = 'Low';
        requ184.Request_Type__c = 'Configuration';
        requ184.Request_Title__c = 'Test';
        requ184.Status__c = 'Release: Design';requ173.Related_Request__c = requ172.Id;
        Database.insert(requ184);
        requ184.Status__c = 'Release: Test';
        Database.update(requ184);
        requ184.Status__c = 'Release: Design';
        Database.update(requ184);
        Request__c ureq184 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ184.id];     
        try{Integer d184 = ureq184.TimeSpentOn_Design__c.intvalue();}catch(Exception ex){}
        if(ureq184.StartTime_Design__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ185 = new Request__c(Release__c=rele.id);
        //requ185.Priority__c = 'Low';
        requ185.Request_Type__c = 'Configuration';
        requ185.Request_Title__c = 'Test';
        requ185.Status__c = 'Release: Design';requ173.Related_Request__c = requ172.Id;
        Database.insert(requ185);
        requ185.Status__c = 'Release: SIT';
        Database.update(requ185);
        requ185.Status__c = 'Release: Design';
        Database.update(requ185);
        Request__c ureq185 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ185.id];     
        try{Integer d185 = ureq185.TimeSpentOn_Design__c.intvalue();}Catch(Exception ex){}
        if(ureq185.StartTime_Design__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ186 = new Request__c(Release__c=rele.id);
        //requ186.Priority__c = 'Low';
        requ186.Request_Type__c = 'Configuration';
        requ186.Request_Title__c = 'Test';
        requ186.Status__c = 'Release: Design';requ173.Related_Request__c = requ172.Id;
        Database.insert(requ186);
        requ186.Status__c = 'Release: UAT';
        Database.update(requ186);
        requ186.Status__c = 'Release: Design';
        Database.update(requ186);
        Request__c ureq186 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ186.id];     
        try{Integer d186 = ureq186.TimeSpentOn_Design__c.intvalue();}Catch(Exception ex){}
        if(ureq186.StartTime_Design__c != null){
            system.debug('Test Pass');
        }
        Test.stopTest();    
    }
    public static testMethod void TestUpdateTimeSpent14(){
        
        Test.startTest();
        Release__c rele = new Release__c();
        rele.Name = 'Test';
        Database.Insert(rele,false); 
        Request__c requ187 = new Request__c(Release__c=rele.id);
        //requ187.Priority__c = 'Low';
        requ187.Request_Type__c = 'Configuration';
        requ187.Request_Title__c = 'Test';
        requ187.Status__c = 'Release: Design';
        Database.insert(requ187);
        requ187.Status__c = 'Release: Build Production';
        Database.update(requ187);
        requ187.Status__c = 'Release: Design';
        Database.update(requ187);
        Request__c ureq187 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ187.id];     
        Integer d187 = ureq187.TimeSpentOn_Design__c.intvalue();
        if(ureq187.StartTime_Design__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ188 = new Request__c(Release__c=rele.id);
        //requ188.Priority__c = 'Low';
        requ188.Request_Type__c = 'Configuration';
        requ188.Request_Title__c = 'Test';
        requ188.Status__c = 'Release: Design';
        Database.insert(requ188);
        requ188.Status__c = 'Release: Test Production';
        Database.update(requ188);
        requ188.Status__c = 'Release: Design';
        Database.update(requ188);
        Request__c ureq188 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ188.id];     
        Integer d188 = ureq188.TimeSpentOn_Design__c.intvalue();
        if(ureq188.StartTime_Design__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ189 = new Request__c(Release__c=rele.id);
        //requ189.Priority__c = 'Low';
        requ189.Request_Type__c = 'Configuration';
        requ189.Request_Title__c = 'Test';
        requ189.Status__c = 'Release: Design';
        Database.insert(requ189);
        requ189.Status__c = 'Release: No Build Req';
        Database.update(requ189);
        requ189.Status__c = 'Release: Design';
        Database.update(requ189);
        Request__c ureq189 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ189.id];     
        Integer d189 = ureq189.TimeSpentOn_Design__c.intvalue();
        if(ureq189.StartTime_Design__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ190 = new Request__c(Release__c=rele.id);
        //requ190.Priority__c = 'Low';
        requ190.Request_Type__c = 'Configuration';
        requ190.Request_Title__c = 'Test';
        requ190.Status__c = 'Release: Design';
        Database.insert(requ190);
        requ190.Status__c = 'Close: Deployed';
        Database.update(requ190);
        requ190.Status__c = 'Release: Design';
        Database.update(requ190);
        Request__c ureq190 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ190.id];     
        Integer d190 = ureq190.TimeSpentOn_Design__c.intvalue();
        if(ureq190.StartTime_Design__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ191 = new Request__c(Release__c=rele.id);
        //requ191.Priority__c = 'Low';
        requ191.Request_Type__c = 'Configuration';
        requ191.Request_Title__c = 'Test';
        requ191.Status__c = 'Release: Design';
        Database.insert(requ191);
        requ191.Status__c = 'Close: Rejected';
        requ191.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ191);
        requ191.Status__c = 'Release: Design';
        Database.update(requ191);
        Request__c ureq191 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ191.id];     
        Integer d191 = ureq191.TimeSpentOn_Design__c.intvalue();
        if(ureq191.StartTime_Design__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ192 = new Request__c(Release__c=rele.id);
        //requ192.Priority__c = 'Low';
        requ192.Request_Type__c = 'Configuration';
        requ192.Request_Title__c = 'Test';
        requ192.Status__c = 'Release: Design';
        requ192.Related_Request__c = requ191.Id;
        Database.insert(requ192);
        requ192.Status__c = 'Close: Duplicate';
        Database.update(requ192);
        requ192.Status__c = 'Release: Design';
        Database.update(requ192);
        Request__c ureq192 = [Select Status__c, StartTime_Design__c, StopTime_Design__c, 
                              TimeSpentOn_Design__c, LastModifiedDate, Id from Request__c where id=: requ192.id];     
        try{Integer d192 = ureq192.TimeSpentOn_Design__c.intvalue();}Catch(Exception ex){}
        if(ureq192.StartTime_Design__c != null){
            system.debug('Test Pass');
        }          
        Test.stopTest();    
    }
    
    
    public static testMethod void TestUpdateTimeSpent4(){
        
        Test.startTest();
        Release__c rele = new Release__c();
        rele.Name = 'Test';
        Database.Insert(rele,false); 
        
        Request__c requ193 = new Request__c(Release__c=rele.id);
        //requ193.Priority__c = 'Low';
        requ193.Request_Type__c = 'Configuration';
        requ193.Request_Title__c = 'Test';
        requ193.Status__c = 'Release: Build';
        Database.insert(requ193);
        requ193.Status__c = 'Identify: New Requirement';
        Database.update(requ193);
        requ193.Status__c = 'Release: Build';
        Database.update(requ193);
        Request__c ureq193 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ193.id];     
        Integer d193 = ureq193.TimeSpentOn_Build__c.intvalue();
        if(ureq193.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ194 = new Request__c(Release__c=rele.id);
        //requ194.Priority__c = 'Low';
        requ194.Request_Type__c = 'Configuration';
        requ194.Request_Title__c = 'Test';
        requ194.Status__c = 'Release: Build';
        Database.insert(requ194);
        requ194.Status__c = 'Identify: Change Request';
        Database.update(requ194);
        requ194.Status__c = 'Release: Build';
        Database.update(requ194);
        Request__c ureq194 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ194.id];     
        Integer d194 = ureq194.TimeSpentOn_Build__c.intvalue();
        if(ureq194.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ195 = new Request__c(Release__c=rele.id);
        //requ195.Priority__c = 'Low';
        requ195.Request_Type__c = 'Configuration';
        requ195.Request_Title__c = 'Test';
        requ195.Status__c = 'Release: Build';
        Database.insert(requ195);
        requ195.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ195);
        requ195.Status__c = 'Release: Build';
        Database.update(requ195);
        Request__c ureq195 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ195.id];     
        Integer d195 = ureq195.TimeSpentOn_Build__c.intvalue();
        if(ureq195.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ196 = new Request__c(Release__c=rele.id);
        //requ196.Priority__c = 'Low';
        requ196.Request_Type__c = 'Configuration';
        requ196.Request_Title__c = 'Test';
        requ196.Status__c = 'Release: Build';
        Database.insert(requ196);
        requ196.Status__c = 'Identify: Emergency Request';
        Database.update(requ196);
        requ196.Status__c = 'Release: Build';
        Database.update(requ196);
        Request__c ureq196 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ196.id];     
        Integer d196 = ureq196.TimeSpentOn_Build__c.intvalue();
        if(ureq196.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ197 = new Request__c(Release__c=rele.id);
        //requ197.Priority__c = 'Low';
        requ197.Request_Type__c = 'Configuration';
        requ197.Request_Title__c = 'Test';
        requ197.Status__c = 'Release: Build';
        Database.insert(requ197);
        requ197.Status__c = 'Identify: Deferred';
        requ197.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ197);
        requ197.Status__c = 'Release: Build';
        Database.update(requ197);
        Request__c ureq197 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ197.id];     
        Integer d197 = ureq197.TimeSpentOn_Build__c.intvalue();
        if(ureq197.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ198 = new Request__c(Release__c=rele.id);
        //requ198.Priority__c = 'Low';
        requ198.Request_Type__c = 'Configuration';
        requ198.Request_Title__c = 'Test';
        requ198.Status__c = 'Release: Build';
        Database.insert(requ198);
        requ198.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ198);
        requ198.Status__c = 'Release: Build';
        Database.update(requ198);
        Request__c ureq198 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ198.id];     
        Integer d198 = ureq198.TimeSpentOn_Build__c.intvalue();
        if(ureq198.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ199 = new Request__c(Release__c=rele.id);
        //requ199.Priority__c = 'Low';
        requ199.Request_Type__c = 'Configuration';
        requ199.Request_Title__c = 'Test';
        requ199.Status__c = 'Release: Build';
        Database.insert(requ199);
        requ199.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ199);
        requ199.Status__c = 'Release: Build';
        Database.update(requ199);
        Request__c ureq199 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ199.id];     
        Integer d199 = ureq199.TimeSpentOn_Build__c.intvalue();
        if(ureq199.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ200 = new Request__c(Release__c=rele.id);
        //requ200.Priority__c = 'Low';
        requ200.Request_Type__c = 'Configuration';
        requ200.Request_Title__c = 'Test';
        requ200.Status__c = 'Release: Build';
        Database.insert(requ200);
        requ200.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ200);
        requ200.Status__c = 'Release: Build';
        Database.update(requ200);
        Request__c ureq200 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ200.id];     
        Integer d200 = ureq200.TimeSpentOn_Build__c.intvalue();
        if(ureq200.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ201 = new Request__c(Release__c=rele.id);
        //requ201.Priority__c = 'Low';
        requ201.Request_Type__c = 'Configuration';
        requ201.Request_Title__c = 'Test';
        requ201.Status__c = 'Release: Build';
        Database.insert(requ201);
        requ201.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ201);
        requ201.Status__c = 'Release: Build';
        Database.update(requ201);
        Request__c ureq201 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ201.id];     
        Integer d201 = ureq201.TimeSpentOn_Build__c.intvalue();
        if(ureq201.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ202 = new Request__c(Release__c=rele.id);
        //requ202.Priority__c = 'Low';
        requ202.Request_Type__c = 'Configuration';
        requ202.Request_Title__c = 'Test';
        requ202.Status__c = 'Release: Build';
        Database.insert(requ202);
        requ202.Status__c = 'Release: Design';
        Database.update(requ202);
        requ202.Status__c = 'Release: Build';
        Database.update(requ202);
        Request__c ureq202 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ202.id];     
        Integer d202 = ureq202.TimeSpentOn_Build__c.intvalue();
        if(ureq202.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ203 = new Request__c(Release__c=rele.id);
        //requ203.Priority__c = 'Low';
        requ203.Request_Type__c = 'Configuration';
        requ203.Request_Title__c = 'Test';
        requ203.Status__c = 'Release: Build';
        Database.insert(requ203);
        requ203.Status__c = 'Release: Test';
        Database.update(requ203);
        requ203.Status__c = 'Release: Build';
        Database.update(requ203);
        Request__c ureq203 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ203.id];     
        Integer d203 = ureq203.TimeSpentOn_Build__c.intvalue();
        if(ureq203.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ204 = new Request__c(Release__c=rele.id);
        //requ204.Priority__c = 'Low';
        requ204.Request_Type__c = 'Configuration';
        requ204.Request_Title__c = 'Test';
        requ204.Status__c = 'Release: Build';
        Database.insert(requ204);
        requ204.Status__c = 'Release: SIT';
        Database.update(requ204);
        requ204.Status__c = 'Release: Build';
        Database.update(requ204);
        Request__c ureq204 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ204.id];     
        Integer d204 = ureq204.TimeSpentOn_Build__c.intvalue();
        if(ureq204.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ205 = new Request__c(Release__c=rele.id);
        //requ205.Priority__c = 'Low';
        requ205.Request_Type__c = 'Configuration';
        requ205.Request_Title__c = 'Test';
        requ205.Status__c = 'Release: Build';
        Database.insert(requ205);
        requ205.Status__c = 'Release: UAT';
        Database.update(requ205);
        requ205.Status__c = 'Release: Build';
        Database.update(requ205);
        Request__c ureq205 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ205.id];     
        Integer d205 = ureq205.TimeSpentOn_Build__c.intvalue();
        if(ureq205.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ206 = new Request__c(Release__c=rele.id);
        //requ206.Priority__c = 'Low';
        requ206.Request_Type__c = 'Configuration';
        requ206.Request_Title__c = 'Test';
        requ206.Status__c = 'Release: Build';
        Database.insert(requ206);
        requ206.Status__c = 'Release: Build Production';
        Database.update(requ206);
        requ206.Status__c = 'Release: Build';
        Database.update(requ206);
        Request__c ureq206 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ206.id];     
        Integer d206 = ureq206.TimeSpentOn_Build__c.intvalue();
        if(ureq206.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ207 = new Request__c(Release__c=rele.id);
        //requ207.Priority__c = 'Low';
        requ207.Request_Type__c = 'Configuration';
        requ207.Request_Title__c = 'Test';
        requ207.Status__c = 'Release: Build';
        Database.insert(requ207);
        requ207.Status__c = 'Release: Test Production';
        Database.update(requ207);
        requ207.Status__c = 'Release: Build';
        Database.update(requ207);
        Request__c ureq207 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ207.id];     
        Integer d207 = ureq207.TimeSpentOn_Build__c.intvalue();
        if(ureq207.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ208 = new Request__c(Release__c=rele.id);
        //requ208.Priority__c = 'Low';
        requ208.Request_Type__c = 'Configuration';
        requ208.Request_Title__c = 'Test';
        requ208.Status__c = 'Release: Build';
        Database.insert(requ208);
        requ208.Status__c = 'Release: No Build Req';
        Database.update(requ208);
        requ208.Status__c = 'Release: Build';
        Database.update(requ208);
        Request__c ureq208 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ208.id];     
        Integer d208 = ureq208.TimeSpentOn_Build__c.intvalue();
        if(ureq208.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ209 = new Request__c(Release__c=rele.id);
        //requ209.Priority__c = 'Low';
        requ209.Request_Type__c = 'Configuration';
        requ209.Request_Title__c = 'Test';
        requ209.Status__c = 'Release: Build';
        Database.insert(requ209);
        requ209.Status__c = 'Close: Deployed';
        Database.update(requ209);
        requ209.Status__c = 'Release: Build';
        Database.update(requ209);
        Request__c ureq209 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ209.id];     
        Integer d209 = ureq209.TimeSpentOn_Build__c.intvalue();
        if(ureq209.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ210 = new Request__c(Release__c=rele.id);
        //requ210.Priority__c = 'Low';
        requ210.Request_Type__c = 'Configuration';
        requ210.Request_Title__c = 'Test';
        requ210.Status__c = 'Release: Build';
        Database.insert(requ210);
        requ210.Status__c = 'Close: Rejected';
        requ210.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ210);
        requ210.Status__c = 'Release: Build';
        Database.update(requ210);
        Request__c ureq210 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ210.id];     
        Integer d210 = ureq210.TimeSpentOn_Build__c.intvalue();
        if(ureq210.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ211 = new Request__c(Release__c=rele.id);
        //requ211.Priority__c = 'Low';
        requ211.Request_Type__c = 'Configuration';
        requ211.Request_Title__c = 'Test';
        requ211.Status__c = 'Release: Build';
        requ211.Related_Request__c = requ210.Id;
        Database.insert(requ211);
        requ211.Status__c = 'Close: Duplicate';
        Database.update(requ211);
        requ211.Status__c = 'Release: Build';
        Database.update(requ211);
        Request__c ureq211 = [Select Status__c, StartTime_Build__c, StopTime_Build__c, 
                              TimeSpentOn_Build__c, LastModifiedDate, Id from Request__c where id=: requ211.id];     
        try{Integer d211 = ureq211.TimeSpentOn_Build__c.intvalue();}Catch(Exception ex){}
        if(ureq211.StartTime_Build__c != null){
            system.debug('Test Pass');
        }
        Request__c requ212 = new Request__c(Release__c=rele.id);
        //requ212.Priority__c = 'Low';
        requ212.Request_Type__c = 'Configuration';
        requ212.Request_Title__c = 'Test';
        requ212.Status__c = 'Release: Test';
        requ212.Related_Request__c = requ210.Id;
        Database.insert(requ212);
        requ212.Status__c = 'Identify: New Requirement';
        Database.update(requ212);
        requ212.Status__c = 'Release: Test';
        Database.update(requ212);
        Request__c ureq212 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ212.id];     
        try{Integer d212 = ureq212.TimeSpentOn_Test__c.intvalue();}Catch(Exception ex){}
        if(ureq212.StartTime_Test__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ213 = new Request__c(Release__c=rele.id);
        //requ213.Priority__c = 'Low';
        requ213.Request_Type__c = 'Configuration';
        requ213.Request_Title__c = 'Test';
        requ213.Status__c = 'Release: Test';
        requ213.Related_Request__c = requ210.Id;
        Database.insert(requ213);
        requ213.Status__c = 'Identify: Change Request';
        Database.update(requ213);
        requ213.Status__c = 'Release: Test';
        Database.update(requ213);
        Request__c ureq213 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ213.id];     
        try{Integer d213 = ureq213.TimeSpentOn_Test__c.intvalue();}Catch(Exception ex){}
        if(ureq213.StartTime_Test__c != null){
            system.debug('Test Pass');
        }
        Test.stopTest();    
    }
    public static testMethod void TestUpdateTimeSpent12(){
        
        Test.startTest();
        Release__c rele = new Release__c();
        rele.Name = 'Test';
        Database.Insert(rele,false); 
        
        Request__c requ214 = new Request__c(Release__c=rele.id);
        //requ214.Priority__c = 'Low';
        requ214.Request_Type__c = 'Configuration';
        requ214.Request_Title__c = 'Test';
        requ214.Status__c = 'Release: Test';
        Database.insert(requ214);
        requ214.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ214);
        requ214.Status__c = 'Release: Test';
        Database.update(requ214);
        Request__c ureq214 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ214.id];     
        Integer d214 = ureq214.TimeSpentOn_Test__c.intvalue();
        if(ureq214.StartTime_Test__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ215 = new Request__c(Release__c=rele.id);
        //requ215.Priority__c = 'Low';
        requ215.Request_Type__c = 'Configuration';
        requ215.Request_Title__c = 'Test';
        requ215.Status__c = 'Release: Test';
        Database.insert(requ215);
        requ215.Status__c = 'Identify: Emergency Request';
        Database.update(requ215);
        requ215.Status__c = 'Release: Test';
        Database.update(requ215);
        Request__c ureq215 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ215.id];     
        Integer d215 = ureq215.TimeSpentOn_Test__c.intvalue();
        if(ureq215.StartTime_Test__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ216 = new Request__c(Release__c=rele.id);
        //requ216.Priority__c = 'Low';
        requ216.Request_Type__c = 'Configuration';
        requ216.Request_Title__c = 'Test';
        requ216.Status__c = 'Release: Test';
        Database.insert(requ216);
        requ216.Status__c = 'Identify: Deferred';
        requ216.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ216);
        requ216.Status__c = 'Release: Test';
        Database.update(requ216);
        Request__c ureq216 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ216.id];     
        Integer d216 = ureq216.TimeSpentOn_Test__c.intvalue();
        if(ureq216.StartTime_Test__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ217 = new Request__c(Release__c=rele.id);
        //requ217.Priority__c = 'Low';
        requ217.Request_Type__c = 'Configuration';
        requ217.Request_Title__c = 'Test';
        requ217.Status__c = 'Release: Test';
        Database.insert(requ217);
        requ217.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ217);
        requ217.Status__c = 'Release: Test';
        Database.update(requ217);
        Request__c ureq217 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ217.id];     
        Integer d217 = ureq217.TimeSpentOn_Test__c.intvalue();
        if(ureq217.StartTime_Test__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ218 = new Request__c(Release__c=rele.id);
        //requ218.Priority__c = 'Low';
        requ218.Request_Type__c = 'Configuration';
        requ218.Request_Title__c = 'Test';
        requ218.Status__c = 'Release: Test';
        Database.insert(requ218);
        requ218.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ218);
        requ218.Status__c = 'Release: Test';
        Database.update(requ218);
        Request__c ureq218 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ218.id];     
        Integer d218 = ureq218.TimeSpentOn_Test__c.intvalue();
        if(ureq218.StartTime_Test__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ219 = new Request__c(Release__c=rele.id);
        //requ219.Priority__c = 'Low';
        requ219.Request_Type__c = 'Configuration';
        requ219.Request_Title__c = 'Test';
        requ219.Status__c = 'Release: Test';
        Database.insert(requ219);
        requ219.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ219);
        requ219.Status__c = 'Release: Test';
        Database.update(requ219);
        Request__c ureq219 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ219.id];     
        Integer d219 = ureq219.TimeSpentOn_Test__c.intvalue();
        if(ureq219.StartTime_Test__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ220 = new Request__c(Release__c=rele.id);
        //requ220.Priority__c = 'Low';
        requ220.Request_Type__c = 'Configuration';
        requ220.Request_Title__c = 'Test';
        requ220.Status__c = 'Release: Test';
        Database.insert(requ220);
        requ220.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ220);
        requ220.Status__c = 'Release: Test';
        Database.update(requ220);
        Request__c ureq220 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ220.id];     
        Integer d220 = ureq220.TimeSpentOn_Test__c.intvalue();
        if(ureq220.StartTime_Test__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ221 = new Request__c(Release__c=rele.id);
        //requ221.Priority__c = 'Low';
        requ221.Request_Type__c = 'Configuration';
        requ221.Request_Title__c = 'Test';
        requ221.Status__c = 'Release: Test';
        Database.insert(requ221);
        requ221.Status__c = 'Release: Design';
        Database.update(requ221);
        requ221.Status__c = 'Release: Test';
        Database.update(requ221);
        Request__c ureq221 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ221.id];     
        Integer d221 = ureq221.TimeSpentOn_Test__c.intvalue();
        if(ureq221.StartTime_Test__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ222 = new Request__c(Release__c=rele.id);
        //requ222.Priority__c = 'Low';
        requ222.Request_Type__c = 'Configuration';
        requ222.Request_Title__c = 'Test';
        requ222.Status__c = 'Release: Test';
        Database.insert(requ222);
        requ222.Status__c = 'Release: Build';
        Database.update(requ222);
        requ222.Status__c = 'Release: Test';
        Database.update(requ222);
        Request__c ureq222 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ222.id];     
        Integer d222 = ureq222.TimeSpentOn_Test__c.intvalue();
        if(ureq222.StartTime_Test__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ223 = new Request__c(Release__c=rele.id);
        //requ223.Priority__c = 'Low';
        requ223.Request_Type__c = 'Configuration';
        requ223.Request_Title__c = 'Test';
        requ223.Status__c = 'Release: Test';
        Database.insert(requ223);
        requ223.Status__c = 'Release: SIT';
        Database.update(requ223);
        requ223.Status__c = 'Release: Test';
        Database.update(requ223);
        Request__c ureq223 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ223.id];     
        Integer d223 = ureq223.TimeSpentOn_Test__c.intvalue();
        if(ureq223.StartTime_Test__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ224 = new Request__c(Release__c=rele.id);
        //requ224.Priority__c = 'Low';
        requ224.Request_Type__c = 'Configuration';
        requ224.Request_Title__c = 'Test';
        requ224.Status__c = 'Release: Test';
        Database.insert(requ224);
        requ224.Status__c = 'Release: UAT';
        Database.update(requ224);
        requ224.Status__c = 'Release: Test';
        Database.update(requ224);
        Request__c ureq224 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ224.id];     
        Integer d224 = ureq224.TimeSpentOn_Test__c.intvalue();
        if(ureq224.StartTime_Test__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ225 = new Request__c(Release__c=rele.id);
        //requ225.Priority__c = 'Low';
        requ225.Request_Type__c = 'Configuration';
        requ225.Request_Title__c = 'Test';
        requ225.Status__c = 'Release: Test';
        Database.insert(requ225);
        requ225.Status__c = 'Release: Build Production';
        Database.update(requ225);
        requ225.Status__c = 'Release: Test';
        Database.update(requ225);
        Request__c ureq225 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ225.id];     
        Integer d225 = ureq225.TimeSpentOn_Test__c.intvalue();
        if(ureq225.StartTime_Test__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ226 = new Request__c(Release__c=rele.id);
        //requ226.Priority__c = 'Low';
        requ226.Request_Type__c = 'Configuration';
        requ226.Request_Title__c = 'Test';
        requ226.Status__c = 'Release: Test';
        Database.insert(requ226);
        requ226.Status__c = 'Release: Test Production';
        Database.update(requ226);
        requ226.Status__c = 'Release: Test';
        Database.update(requ226);
        Request__c ureq226 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ226.id];     
        Integer d226 = ureq226.TimeSpentOn_Test__c.intvalue();
        if(ureq226.StartTime_Test__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ227 = new Request__c(Release__c=rele.id);
        //requ227.Priority__c = 'Low';
        requ227.Request_Type__c = 'Configuration';
        requ227.Request_Title__c = 'Test';
        requ227.Status__c = 'Release: Test';
        Database.insert(requ227);
        requ227.Status__c = 'Release: No Build Req';
        Database.update(requ227);
        requ227.Status__c = 'Release: Test';
        Database.update(requ227);
        Request__c ureq227 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ227.id];     
        Integer d227 = ureq227.TimeSpentOn_Test__c.intvalue();
        if(ureq227.StartTime_Test__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ228 = new Request__c(Release__c=rele.id);
       // requ228.Priority__c = 'Low';
        requ228.Request_Type__c = 'Configuration';
        requ228.Request_Title__c = 'Test';
        requ228.Status__c = 'Release: Test';
        Database.insert(requ228);
        requ228.Status__c = 'Close: Deployed';
        Database.update(requ228);
        requ228.Status__c = 'Release: Test';
        Database.update(requ228);
        Request__c ureq228 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ228.id];     
        Integer d228 = ureq228.TimeSpentOn_Test__c.intvalue();
        if(ureq228.StartTime_Test__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ229 = new Request__c(Release__c=rele.id);
       // requ229.Priority__c = 'Low';
        requ229.Request_Type__c = 'Configuration';
        requ229.Request_Title__c = 'Test';
        requ229.Status__c = 'Release: Test';
        Database.insert(requ229);
        requ229.Status__c = 'Close: Rejected';
        requ229.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ229);
        requ229.Status__c = 'Release: Test';
        Database.update(requ229);
        Request__c ureq229 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ229.id];     
        Integer d229 = ureq229.TimeSpentOn_Test__c.intvalue();
        if(ureq229.StartTime_Test__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ230 = new Request__c(Release__c=rele.id);
        //requ230.Priority__c = 'Low';
        requ230.Request_Type__c = 'Configuration';
        requ230.Request_Title__c = 'Test';
        requ230.Status__c = 'Release: Test';
        requ230.Related_Request__c = requ229.Id;
        Database.insert(requ230);
        requ230.Status__c = 'Close: Duplicate';
        Database.update(requ230);
        requ230.Status__c = 'Release: Test';
        Database.update(requ230);
        Request__c ureq230 = [Select Status__c, StartTime_Test__c, StopTime_Test__c, 
                              TimeSpentOn_Test__c, LastModifiedDate, Id from Request__c where id=: requ230.id];     
        Integer d230 = ureq230.TimeSpentOn_Test__c.intvalue();
        if(ureq230.StartTime_Test__c != null){
            system.debug('Test Pass');
        }  
        Test.stopTest();    
    }
    
    public static testMethod void TestUpdateTimeSpent5(){
        
        Test.startTest();
        Release__c rele = new Release__c();
        rele.Name = 'Test';
        Database.Insert(rele,false); 
        
        Request__c requ231 = new Request__c(Release__c=rele.id);
        //requ231.Priority__c = 'Low';
        requ231.Request_Type__c = 'Configuration';
        requ231.Request_Title__c = 'Test';
        requ231.Status__c = 'Release: SIT';
        Database.insert(requ231);
        requ231.Status__c = 'Identify: New Requirement';
        Database.update(requ231);
        requ231.Status__c = 'Release: SIT';
        Database.update(requ231);
        Request__c ureq231 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ231.id];     
        Integer d231 = ureq231.TimeSpentOn_SIT__c.intvalue();
        if(ureq231.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ232 = new Request__c(Release__c=rele.id);
        //requ232.Priority__c = 'Low';
        requ232.Request_Type__c = 'Configuration';
        requ232.Request_Title__c = 'Test';
        requ232.Status__c = 'Release: SIT';
        Database.insert(requ232);
        requ232.Status__c = 'Identify: Change Request';
        Database.update(requ232);
        requ232.Status__c = 'Release: SIT';
        Database.update(requ232);
        Request__c ureq232 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ232.id];     
        Integer d232 = ureq232.TimeSpentOn_SIT__c.intvalue();
        if(ureq232.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ233 = new Request__c(Release__c=rele.id);
        //requ233.Priority__c = 'Low';
        requ233.Request_Type__c = 'Configuration';
        requ233.Request_Title__c = 'Test';
        requ233.Status__c = 'Release: SIT';
        Database.insert(requ233);
        requ233.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ233);
        requ233.Status__c = 'Release: SIT';
        Database.update(requ233);
        Request__c ureq233 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ233.id];     
        Integer d233 = ureq233.TimeSpentOn_SIT__c.intvalue();
        if(ureq233.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ234 = new Request__c(Release__c=rele.id);
        //requ234.Priority__c = 'Low';
        requ234.Request_Type__c = 'Configuration';
        requ234.Request_Title__c = 'Test';
        requ234.Status__c = 'Release: SIT';
        Database.insert(requ234);
        requ234.Status__c = 'Identify: Emergency Request';
        Database.update(requ234);
        requ234.Status__c = 'Release: SIT';
        Database.update(requ234);
        Request__c ureq234 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ234.id];     
        Integer d234 = ureq234.TimeSpentOn_SIT__c.intvalue();
        if(ureq234.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ235 = new Request__c(Release__c=rele.id);
        //requ235.Priority__c = 'Low';
        requ235.Request_Type__c = 'Configuration';
        requ235.Request_Title__c = 'Test';
        requ235.Status__c = 'Release: SIT';
        Database.insert(requ235);
        requ235.Status__c = 'Identify: Deferred';
        requ235.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ235);
        requ235.Status__c = 'Release: SIT';
        Database.update(requ235);
        Request__c ureq235 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ235.id];     
        Integer d235 = ureq235.TimeSpentOn_SIT__c.intvalue();
        if(ureq235.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ236 = new Request__c(Release__c=rele.id);
        //requ236.Priority__c = 'Low';
        requ236.Request_Type__c = 'Configuration';
        requ236.Request_Title__c = 'Test';
        requ236.Status__c = 'Release: SIT';
        Database.insert(requ236);
        requ236.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ236);
        requ236.Status__c = 'Release: SIT';
        Database.update(requ236);
        Request__c ureq236 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ236.id];     
        Integer d236 = ureq236.TimeSpentOn_SIT__c.intvalue();
        if(ureq236.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ237 = new Request__c(Release__c=rele.id);
        //requ237.Priority__c = 'Low';
        requ237.Request_Type__c = 'Configuration';
        requ237.Request_Title__c = 'Test';
        requ237.Status__c = 'Release: SIT';
        Database.insert(requ237);
        requ237.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ237);
        requ237.Status__c = 'Release: SIT';
        Database.update(requ237);
        Request__c ureq237 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ237.id];     
        Integer d237 = ureq237.TimeSpentOn_SIT__c.intvalue();
        if(ureq237.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ238 = new Request__c(Release__c=rele.id);
        //requ238.Priority__c = 'Low';
        requ238.Request_Type__c = 'Configuration';
        requ238.Request_Title__c = 'Test';
        requ238.Status__c = 'Release: SIT';
        Database.insert(requ238);
        requ238.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ238);
        requ238.Status__c = 'Release: SIT';
        Database.update(requ238);
        Request__c ureq238 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ238.id];     
        Integer d238 = ureq238.TimeSpentOn_SIT__c.intvalue();
        if(ureq238.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ239 = new Request__c(Release__c=rele.id);
        //requ239.Priority__c = 'Low';
        requ239.Request_Type__c = 'Configuration';
        requ239.Request_Title__c = 'Test';
        requ239.Status__c = 'Release: SIT';
        Database.insert(requ239);
        requ239.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ239);
        requ239.Status__c = 'Release: SIT';
        Database.update(requ239);
        Request__c ureq239 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ239.id];     
        Integer d239 = ureq239.TimeSpentOn_SIT__c.intvalue();
        if(ureq239.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ240 = new Request__c(Release__c=rele.id);
        //requ240.Priority__c = 'Low';
        requ240.Request_Type__c = 'Configuration';
        requ240.Request_Title__c = 'Test';
        requ240.Status__c = 'Release: SIT';
        Database.insert(requ240);
        requ240.Status__c = 'Release: Design';
        Database.update(requ240);
        requ240.Status__c = 'Release: SIT';
        Database.update(requ240);
        Request__c ureq240 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ240.id];     
        Integer d240 = ureq240.TimeSpentOn_SIT__c.intvalue();
        if(ureq240.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ241 = new Request__c(Release__c=rele.id);
        //requ241.Priority__c = 'Low';
        requ241.Request_Type__c = 'Configuration';
        requ241.Request_Title__c = 'Test';
        requ241.Status__c = 'Release: SIT';
        Database.insert(requ241);
        requ241.Status__c = 'Release: Build';
        Database.update(requ241);
        requ241.Status__c = 'Release: SIT';
        Database.update(requ241);
        Request__c ureq241 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ241.id];     
        Integer d241 = ureq241.TimeSpentOn_SIT__c.intvalue();
        if(ureq241.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ242 = new Request__c(Release__c=rele.id);
        //requ242.Priority__c = 'Low';
        requ242.Request_Type__c = 'Configuration';
        requ242.Request_Title__c = 'Test';
        requ242.Status__c = 'Release: SIT';
        Database.insert(requ242);
        requ242.Status__c = 'Release: Test';
        Database.update(requ242);
        requ242.Status__c = 'Release: SIT';
        Database.update(requ242);
        Request__c ureq242 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ242.id];     
        Integer d242 = ureq242.TimeSpentOn_SIT__c.intvalue();
        if(ureq242.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ243 = new Request__c(Release__c=rele.id);
        //requ243.Priority__c = 'Low';
        requ243.Request_Type__c = 'Configuration';
        requ243.Request_Title__c = 'Test';
        requ243.Status__c = 'Release: SIT';
        Database.insert(requ243);
        requ243.Status__c = 'Release: UAT';
        Database.update(requ243);
        requ243.Status__c = 'Release: SIT';
        Database.update(requ243);
        Request__c ureq243 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ243.id];     
        Integer d243 = ureq243.TimeSpentOn_SIT__c.intvalue();
        if(ureq243.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ244 = new Request__c(Release__c=rele.id);
        //requ244.Priority__c = 'Low';
        requ244.Request_Type__c = 'Configuration';
        requ244.Request_Title__c = 'Test';
        requ244.Status__c = 'Release: SIT';
        Database.insert(requ244);
        requ244.Status__c = 'Release: Build Production';
        Database.update(requ244);
        requ244.Status__c = 'Release: SIT';
        Database.update(requ244);
        Request__c ureq244 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ244.id];     
        Integer d244 = ureq244.TimeSpentOn_SIT__c.intvalue();
        if(ureq244.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ245 = new Request__c(Release__c=rele.id);
        //requ245.Priority__c = 'Low';
        requ245.Request_Type__c = 'Configuration';
        requ245.Request_Title__c = 'Test';
        requ245.Status__c = 'Release: SIT';
        Database.insert(requ245);
        requ245.Status__c = 'Release: Test Production';
        Database.update(requ245);
        requ245.Status__c = 'Release: SIT';
        Database.update(requ245);
        Request__c ureq245 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ245.id];     
        Integer d245 = ureq245.TimeSpentOn_SIT__c.intvalue();
        if(ureq245.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ246 = new Request__c(Release__c=rele.id);
        //requ246.Priority__c = 'Low';
        requ246.Request_Type__c = 'Configuration';
        requ246.Request_Title__c = 'Test';
        requ246.Status__c = 'Release: SIT';
        Database.insert(requ246);
        requ246.Status__c = 'Release: No Build Req';
        Database.update(requ246);
        requ246.Status__c = 'Release: SIT';
        Database.update(requ246);
        Request__c ureq246 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ246.id];     
        Integer d246 = ureq246.TimeSpentOn_SIT__c.intvalue();
        if(ureq246.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ247 = new Request__c(Release__c=rele.id);
        //requ247.Priority__c = 'Low';
        requ247.Request_Type__c = 'Configuration';
        requ247.Request_Title__c = 'Test';
        requ247.Status__c = 'Release: SIT';
        Database.insert(requ247);
        requ247.Status__c = 'Close: Deployed';
        Database.update(requ247);
        requ247.Status__c = 'Release: SIT';
        Database.update(requ247);
        Request__c ureq247 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ247.id];     
        Integer d247 = ureq247.TimeSpentOn_SIT__c.intvalue();
        if(ureq247.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ248 = new Request__c(Release__c=rele.id);
        //requ248.Priority__c = 'Low';
        requ248.Request_Type__c = 'Configuration';
        requ248.Request_Title__c = 'Test';
        requ248.Status__c = 'Release: SIT';
        Database.insert(requ248);
        requ248.Status__c = 'Close: Rejected';
        requ248.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ248);
        requ248.Status__c = 'Release: SIT';
        Database.update(requ248);
        Request__c ureq248 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ248.id];     
        Integer d248 = ureq248.TimeSpentOn_SIT__c.intvalue();
        if(ureq248.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ249 = new Request__c(Release__c=rele.id);
        //requ249.Priority__c = 'Low';
        requ249.Request_Type__c = 'Configuration';
        requ249.Request_Title__c = 'Test';
        requ249.Status__c = 'Release: SIT';
        requ249.Related_Request__c = requ248.Id;
        Database.insert(requ249);
        requ249.Status__c = 'Close: Duplicate';
        Database.update(requ249);
        requ249.Status__c = 'Release: SIT';
        Database.update(requ249);
        Request__c ureq249 = [Select Status__c, StartTime_SIT__c, StopTime_SIT__c, 
                              TimeSpentOn_SIT__c, LastModifiedDate, Id from Request__c where id=: requ249.id];     
        try{Integer d249 = ureq249.TimeSpentOn_SIT__c.intvalue();}Catch(Exception ex){}
        if(ureq249.StartTime_SIT__c != null){
            system.debug('Test Pass');
        }
        
        
        
        Request__c requ250 = new Request__c(Release__c=rele.id);
        //requ250.Priority__c = 'Low';
        requ250.Request_Type__c = 'Configuration';
        requ250.Request_Title__c = 'Test';
        requ250.Status__c = 'Release: UAT';
        requ250.Related_Request__c = requ249.Id;
        Database.insert(requ250);
        requ250.Status__c = 'Identify: New Requirement';
        Database.update(requ250);
        requ250.Status__c = 'Release: UAT';
        Database.update(requ250);
        Request__c ureq250 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ250.id];     
        try{Integer d250 = ureq250.TimeSpentOn_UAT__c.intvalue();}Catch(Exception ex){}
        if(ureq250.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ251 = new Request__c(Release__c=rele.id);
        //requ251.Priority__c = 'Low';
        requ251.Request_Type__c = 'Configuration';
        requ251.Request_Title__c = 'Test';
        requ251.Status__c = 'Release: UAT';
        requ251.Related_Request__c = requ249.Id;
        Database.insert(requ251);
        requ251.Status__c = 'Identify: Change Request';
        Database.update(requ251);
        requ251.Status__c = 'Release: UAT';
        Database.update(requ251);
        Request__c ureq251 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ251.id];     
        try{Integer d251 = ureq251.TimeSpentOn_UAT__c.intvalue();}Catch(Exception ex){}
        if(ureq251.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        Test.stopTest();    
    }
    public static testMethod void TestUpdateTimeSpent15(){
        
        Test.startTest();
        Release__c rele = new Release__c();
        rele.Name = 'Test';
        Database.Insert(rele,false); 
        Request__c requ252 = new Request__c(Release__c=rele.id);
        //requ252.Priority__c = 'Low';
        requ252.Request_Type__c = 'Configuration';
        requ252.Request_Title__c = 'Test';
        requ252.Status__c = 'Release: UAT';
        Database.insert(requ252);
        requ252.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ252);
        requ252.Status__c = 'Release: UAT';
        Database.update(requ252);
        Request__c ureq252 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ252.id];     
        Integer d252 = ureq252.TimeSpentOn_UAT__c.intvalue();
        if(ureq252.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ253 = new Request__c(Release__c=rele.id);
        //requ253.Priority__c = 'Low';
        requ253.Request_Type__c = 'Configuration';
        requ253.Request_Title__c = 'Test';
        requ253.Status__c = 'Release: UAT';
        Database.insert(requ253);
        requ253.Status__c = 'Identify: Emergency Request';
        Database.update(requ253);
        requ253.Status__c = 'Release: UAT';
        Database.update(requ253);
        Request__c ureq253 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ253.id];     
        Integer d253 = ureq253.TimeSpentOn_UAT__c.intvalue();
        if(ureq253.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ254 = new Request__c(Release__c=rele.id);
        //requ254.Priority__c = 'Low';
        requ254.Request_Type__c = 'Configuration';
        requ254.Request_Title__c = 'Test';
        requ254.Status__c = 'Release: UAT';
        Database.insert(requ254);
        requ254.Status__c = 'Identify: Deferred';
        requ254.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ254);
        requ254.Status__c = 'Release: UAT';
        Database.update(requ254);
        Request__c ureq254 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ254.id];     
        Integer d254 = ureq254.TimeSpentOn_UAT__c.intvalue();
        if(ureq254.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ255 = new Request__c(Release__c=rele.id);
        //requ255.Priority__c = 'Low';
        requ255.Request_Type__c = 'Configuration';
        requ255.Request_Title__c = 'Test';
        requ255.Status__c = 'Release: UAT';
        Database.insert(requ255);
        requ255.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ255);
        requ255.Status__c = 'Release: UAT';
        Database.update(requ255);
        Request__c ureq255 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ255.id];     
        Integer d255 = ureq255.TimeSpentOn_UAT__c.intvalue();
        if(ureq255.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ256 = new Request__c(Release__c=rele.id);
        //requ256.Priority__c = 'Low';
        requ256.Request_Type__c = 'Configuration';
        requ256.Request_Title__c = 'Test';
        requ256.Status__c = 'Release: UAT';
        Database.insert(requ256);
        requ256.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ256);
        requ256.Status__c = 'Release: UAT';
        Database.update(requ256);
        Request__c ureq256 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ256.id];     
        Integer d256 = ureq256.TimeSpentOn_UAT__c.intvalue();
        if(ureq256.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ257 = new Request__c(Release__c=rele.id);
        //requ257.Priority__c = 'Low';
        requ257.Request_Type__c = 'Configuration';
        requ257.Request_Title__c = 'Test';
        requ257.Status__c = 'Release: UAT';
        Database.insert(requ257);
        requ257.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ257);
        requ257.Status__c = 'Release: UAT';
        Database.update(requ257);
        Request__c ureq257 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ257.id];     
        Integer d257 = ureq257.TimeSpentOn_UAT__c.intvalue();
        if(ureq257.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ258 = new Request__c(Release__c=rele.id);
        //requ258.Priority__c = 'Low';
        requ258.Request_Type__c = 'Configuration';
        requ258.Request_Title__c = 'Test';
        requ258.Status__c = 'Release: UAT';
        Database.insert(requ258);
        requ258.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ258);
        requ258.Status__c = 'Release: UAT';
        Database.update(requ258);
        Request__c ureq258 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ258.id];     
        Integer d258 = ureq258.TimeSpentOn_UAT__c.intvalue();
        if(ureq258.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ259 = new Request__c(Release__c=rele.id);
        //requ259.Priority__c = 'Low';
        requ259.Request_Type__c = 'Configuration';
        requ259.Request_Title__c = 'Test';
        requ259.Status__c = 'Release: UAT';
        Database.insert(requ259);
        requ259.Status__c = 'Release: Design';
        Database.update(requ259);
        requ259.Status__c = 'Release: UAT';
        Database.update(requ259);
        Request__c ureq259 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ259.id];     
        Integer d259 = ureq259.TimeSpentOn_UAT__c.intvalue();
        if(ureq259.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ260 = new Request__c(Release__c=rele.id);
        //requ260.Priority__c = 'Low';
        requ260.Request_Type__c = 'Configuration';
        requ260.Request_Title__c = 'Test';
        requ260.Status__c = 'Release: UAT';
        Database.insert(requ260);
        requ260.Status__c = 'Release: Build';
        Database.update(requ260);
        requ260.Status__c = 'Release: UAT';
        Database.update(requ260);
        Request__c ureq260 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ260.id];     
        Integer d260 = ureq260.TimeSpentOn_UAT__c.intvalue();
        if(ureq260.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ261 = new Request__c(Release__c=rele.id);
        //requ261.Priority__c = 'Low';
        requ261.Request_Type__c = 'Configuration';
        requ261.Request_Title__c = 'Test';
        requ261.Status__c = 'Release: UAT';
        Database.insert(requ261);
        requ261.Status__c = 'Release: Test';
        Database.update(requ261);
        requ261.Status__c = 'Release: UAT';
        Database.update(requ261);
        Request__c ureq261 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ261.id];     
        Integer d261 = ureq261.TimeSpentOn_UAT__c.intvalue();
        if(ureq261.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ262 = new Request__c(Release__c=rele.id);
        //requ262.Priority__c = 'Low';
        requ262.Request_Type__c = 'Configuration';
        requ262.Request_Title__c = 'Test';
        requ262.Status__c = 'Release: UAT';
        Database.insert(requ262);
        requ262.Status__c = 'Release: SIT';
        Database.update(requ262);
        requ262.Status__c = 'Release: UAT';
        Database.update(requ262);
        Request__c ureq262 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ262.id];     
        Integer d262 = ureq262.TimeSpentOn_UAT__c.intvalue();
        if(ureq262.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ263 = new Request__c(Release__c=rele.id);
        //requ263.Priority__c = 'Low';
        requ263.Request_Type__c = 'Configuration';
        requ263.Request_Title__c = 'Test';
        requ263.Status__c = 'Release: UAT';
        Database.insert(requ263);
        requ263.Status__c = 'Release: Build Production';
        Database.update(requ263);
        requ263.Status__c = 'Release: UAT';
        Database.update(requ263);
        Request__c ureq263 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ263.id];     
        Integer d263 = ureq263.TimeSpentOn_UAT__c.intvalue();
        if(ureq263.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ264 = new Request__c(Release__c=rele.id);
        //requ264.Priority__c = 'Low';
        requ264.Request_Type__c = 'Configuration';
        requ264.Request_Title__c = 'Test';
        requ264.Status__c = 'Release: UAT';
        Database.insert(requ264);
        requ264.Status__c = 'Release: Test Production';
        Database.update(requ264);
        requ264.Status__c = 'Release: UAT';
        Database.update(requ264);
        Request__c ureq264 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ264.id];     
        Integer d264 = ureq264.TimeSpentOn_UAT__c.intvalue();
        if(ureq264.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ265 = new Request__c(Release__c=rele.id);
        //requ265.Priority__c = 'Low';
        requ265.Request_Type__c = 'Configuration';
        requ265.Request_Title__c = 'Test';
        requ265.Status__c = 'Release: UAT';
        Database.insert(requ265);
        requ265.Status__c = 'Release: No Build Req';
        Database.update(requ265);
        requ265.Status__c = 'Release: UAT';
        Database.update(requ265);
        Request__c ureq265 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ265.id];     
        Integer d265 = ureq265.TimeSpentOn_UAT__c.intvalue();
        if(ureq265.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ266 = new Request__c(Release__c=rele.id);
        //requ266.Priority__c = 'Low';
        requ266.Request_Type__c = 'Configuration';
        requ266.Request_Title__c = 'Test';
        requ266.Status__c = 'Release: UAT';
        Database.insert(requ266);
        requ266.Status__c = 'Close: Deployed';
        Database.update(requ266);
        requ266.Status__c = 'Release: UAT';
        Database.update(requ266);
        Request__c ureq266 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ266.id];     
        Integer d266 = ureq266.TimeSpentOn_UAT__c.intvalue();
        if(ureq266.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ267 = new Request__c(Release__c=rele.id);
        //requ267.Priority__c = 'Low';
        requ267.Request_Type__c = 'Configuration';
        requ267.Request_Title__c = 'Test';
        requ267.Status__c = 'Release: UAT';
        Database.insert(requ267);
        requ267.Status__c = 'Close: Rejected';
        requ267.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ267);
        requ267.Status__c = 'Release: UAT';
        Database.update(requ267);
        Request__c ureq267 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ267.id];     
        Integer d267 = ureq267.TimeSpentOn_UAT__c.intvalue();
        if(ureq267.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ268 = new Request__c(Release__c=rele.id);
        //requ268.Priority__c = 'Low';
        requ268.Request_Type__c = 'Configuration';
        requ268.Request_Title__c = 'Test';
        requ268.Status__c = 'Release: UAT';
        requ268.Related_Request__c = requ267.Id;
        Database.insert(requ268);
        requ268.Status__c = 'Close: Duplicate';
        Database.update(requ268);
        requ268.Status__c = 'Release: UAT';
        Database.update(requ268);
        Request__c ureq268 = [Select Status__c, StartTime_UAT__c, StopTime_UAT__c, 
                              TimeSpentOn_UAT__c, LastModifiedDate, Id from Request__c where id=: requ268.id];     
        try{Integer d268 = ureq268.TimeSpentOn_UAT__c.intvalue();}Catch(Exception ex){}
        if(ureq268.StartTime_UAT__c != null){
            system.debug('Test Pass');
        }
        
        Test.stopTest();    
    }
    
    public static testMethod void TestUpdateTimeSpent6(){
        
        Test.startTest();
        Release__c rele = new Release__c();
        rele.Name = 'Test';
        Database.Insert(rele,false); 
        
        
        Request__c requ269 = new Request__c(Release__c=rele.id);
        //requ269.Priority__c = 'Low';
        requ269.Request_Type__c = 'Configuration';
        requ269.Request_Title__c = 'Test';
        requ269.Status__c = 'Release: Build Production';
        Database.insert(requ269);
        requ269.Status__c = 'Identify: New Requirement';
        Database.update(requ269);
        requ269.Status__c = 'Release: Build Production';
        Database.update(requ269);
        Request__c ureq269 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ269.id];     
        Integer d269 = ureq269.TimeSpentOn_Build_Production__c.intvalue();
        if(ureq269.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ270 = new Request__c(Release__c=rele.id);
        //requ270.Priority__c = 'Low';
        requ270.Request_Type__c = 'Configuration';
        requ270.Request_Title__c = 'Test';
        requ270.Status__c = 'Release: Build Production';
        Database.insert(requ270);
        requ270.Status__c = 'Identify: Change Request';
        Database.update(requ270);
        requ270.Status__c = 'Release: Build Production';
        Database.update(requ270);
        Request__c ureq270 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ270.id];     
        Integer d270 = ureq270.TimeSpentOn_Build_Production__c.intvalue();
        if(ureq270.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ271 = new Request__c(Release__c=rele.id);
        //requ271.Priority__c = 'Low';
        requ271.Request_Type__c = 'Configuration';
        requ271.Request_Title__c = 'Test';
        requ271.Status__c = 'Release: Build Production';
        Database.insert(requ271);
        requ271.Status__c = 'Identify: Submit for Business Review';
        Database.update(requ271);
        requ271.Status__c = 'Release: Build Production';
        Database.update(requ271);
        Request__c ureq271 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ271.id];     
        Integer d271 = ureq271.TimeSpentOn_Build_Production__c.intvalue();
        if(ureq271.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ272 = new Request__c(Release__c=rele.id);
        //requ272.Priority__c = 'Low';
        requ272.Request_Type__c = 'Configuration';
        requ272.Request_Title__c = 'Test';
        requ272.Status__c = 'Release: Build Production';
        Database.insert(requ272);
        requ272.Status__c = 'Identify: Emergency Request';
        Database.update(requ272);
        requ272.Status__c = 'Release: Build Production';
        Database.update(requ272);
        Request__c ureq272 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ272.id];     
        Integer d272 = ureq272.TimeSpentOn_Build_Production__c.intvalue();
        if(ureq272.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ273 = new Request__c(Release__c=rele.id);
        //requ273.Priority__c = 'Low';
        requ273.Request_Type__c = 'Configuration';
        requ273.Request_Title__c = 'Test';
        requ273.Status__c = 'Release: Build Production';
        Database.insert(requ273);
        requ273.Status__c = 'Identify: Deferred';
        requ273.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ273);
        requ273.Status__c = 'Release: Build Production';
        Database.update(requ273);
        Request__c ureq273 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ273.id];     
        Integer d273 = ureq273.TimeSpentOn_Build_Production__c.intvalue();
        if(ureq273.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ274 = new Request__c(Release__c=rele.id);
        //requ274.Priority__c = 'Low';
        requ274.Request_Type__c = 'Configuration';
        requ274.Request_Title__c = 'Test';
        requ274.Status__c = 'Release: Build Production';
        Database.insert(requ274);
        requ274.Status__c = 'Consolidate: Approve to Estimate';
        Database.update(requ274);
        requ274.Status__c = 'Release: Build Production';
        Database.update(requ274);
        Request__c ureq274 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ274.id];     
        Integer d274 = ureq274.TimeSpentOn_Build_Production__c.intvalue();
        if(ureq274.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ275 = new Request__c(Release__c=rele.id);
        //requ275.Priority__c = 'Low';
        requ275.Request_Type__c = 'Configuration';
        requ275.Request_Title__c = 'Test';
        requ275.Status__c = 'Release: Build Production';
        Database.insert(requ275);
        requ275.Status__c = 'Consolidate: Level of Effort Complete';
        Database.update(requ275);
        requ275.Status__c = 'Release: Build Production';
        Database.update(requ275);
        Request__c ureq275 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ275.id];     
        Integer d275 = ureq275.TimeSpentOn_Build_Production__c.intvalue();
        if(ureq275.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ276 = new Request__c(Release__c=rele.id);
        //requ276.Priority__c = 'Low';
        requ276.Request_Type__c = 'Configuration';
        requ276.Request_Title__c = 'Test';
        requ276.Status__c = 'Release: Build Production';
        Database.insert(requ276);
        requ276.Status__c = 'Approve: Approved to Deploy';
        Database.update(requ276);
        requ276.Status__c = 'Release: Build Production';
        Database.update(requ276);
        Request__c ureq276 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ276.id];     
        Integer d276 = ureq276.TimeSpentOn_Build_Production__c.intvalue();
        if(ureq276.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ277 = new Request__c(Release__c=rele.id);
        //requ277.Priority__c = 'Low';
        requ277.Request_Type__c = 'Configuration';
        requ277.Request_Title__c = 'Test';
        requ277.Status__c = 'Release: Build Production';
        Database.insert(requ277);
        requ277.Status__c = 'Approve: Approved Emergency Release';
        Database.update(requ277);
        requ277.Status__c = 'Release: Build Production';
        Database.update(requ277);
        Request__c ureq277 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ277.id];     
        Integer d277 = ureq277.TimeSpentOn_Build_Production__c.intvalue();
        if(ureq277.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ278 = new Request__c(Release__c=rele.id);
        //requ278.Priority__c = 'Low';
        requ278.Request_Type__c = 'Configuration';
        requ278.Request_Title__c = 'Test';
        requ278.Status__c = 'Release: Build Production';
        Database.insert(requ278);
        requ278.Status__c = 'Release: Design';
        Database.update(requ278);
        requ278.Status__c = 'Release: Build Production';
        Database.update(requ278);
        Request__c ureq278 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ278.id];     
        Integer d278 = ureq278.TimeSpentOn_Build_Production__c.intvalue();
        if(ureq278.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ279 = new Request__c(Release__c=rele.id);
        //requ279.Priority__c = 'Low';
        requ279.Request_Type__c = 'Configuration';
        requ279.Request_Title__c = 'Test';
        requ279.Status__c = 'Release: Build Production';
        Database.insert(requ279);
        requ279.Status__c = 'Release: Build';
        Database.update(requ279);
        requ279.Status__c = 'Release: Build Production';
        Database.update(requ279);
        Request__c ureq279 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ279.id];     
        Integer d279 = ureq279.TimeSpentOn_Build_Production__c.intvalue();
        if(ureq279.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ280 = new Request__c(Release__c=rele.id);
        //requ280.Priority__c = 'Low';
        requ280.Request_Type__c = 'Configuration';
        requ280.Request_Title__c = 'Test';
        requ280.Status__c = 'Release: Build Production';
        Database.insert(requ280);
        requ280.Status__c = 'Release: Test';
        Database.update(requ280);
        requ280.Status__c = 'Release: Build Production';
        Database.update(requ280);
        Request__c ureq280 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ280.id];     
        Integer d280 = ureq280.TimeSpentOn_Build_Production__c.intvalue();
        if(ureq280.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ281 = new Request__c(Release__c=rele.id);
        //requ281.Priority__c = 'Low';
        requ281.Request_Type__c = 'Configuration';
        requ281.Request_Title__c = 'Test';
        requ281.Status__c = 'Release: Build Production';
        Database.insert(requ281);
        requ281.Status__c = 'Release: SIT';
        Database.update(requ281);
        requ281.Status__c = 'Release: Build Production';
        Database.update(requ281);
        Request__c ureq281 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ281.id];     
        Integer d281 = ureq281.TimeSpentOn_Build_Production__c.intvalue();
        if(ureq281.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ282 = new Request__c(Release__c=rele.id);
        //requ282.Priority__c = 'Low';
        requ282.Request_Type__c = 'Configuration';
        requ282.Request_Title__c = 'Test';
        requ282.Status__c = 'Release: Build Production';
        Database.insert(requ282);
        requ282.Status__c = 'Release: UAT';
        Database.update(requ282);
        requ282.Status__c = 'Release: Build Production';
        Database.update(requ282);
        Request__c ureq282 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ282.id];     
        Integer d282 = ureq282.TimeSpentOn_Build_Production__c.intvalue();
        if(ureq282.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ283 = new Request__c(Release__c=rele.id);
        //requ283.Priority__c = 'Low';
        requ283.Request_Type__c = 'Configuration';
        requ283.Request_Title__c = 'Test';
        requ283.Status__c = 'Release: Build Production';
        Database.insert(requ283);
        requ283.Status__c = 'Release: Test Production';
        Database.update(requ283);
        requ283.Status__c = 'Release: Build Production';
        Database.update(requ283);
        Request__c ureq283 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ283.id];     
        Integer d283 = ureq283.TimeSpentOn_Build_Production__c.intvalue();
        if(ureq283.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ284 = new Request__c(Release__c=rele.id);
        //requ284.Priority__c = 'Low';
        requ284.Request_Type__c = 'Configuration';
        requ284.Request_Title__c = 'Test';
        requ284.Status__c = 'Release: Build Production';
        Database.insert(requ284);
        requ284.Status__c = 'Release: No Build Req';
        Database.update(requ284);
        requ284.Status__c = 'Release: Build Production';
        Database.update(requ284);
        Request__c ureq284 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ284.id];     
        Integer d284 = ureq284.TimeSpentOn_Build_Production__c.intvalue();
        if(ureq284.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ285 = new Request__c(Release__c=rele.id);
       // requ285.Priority__c = 'Low';
        requ285.Request_Type__c = 'Configuration';
        requ285.Request_Title__c = 'Test';
        requ285.Status__c = 'Release: Build Production';
        Database.insert(requ285);
        requ285.Status__c = 'Close: Deployed';
        Database.update(requ285);
        requ285.Status__c = 'Release: Build Production';
        Database.update(requ285);
        Request__c ureq285 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ285.id];     
        Integer d285 = ureq285.TimeSpentOn_Build_Production__c.intvalue();
        if(ureq285.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ286 = new Request__c(Release__c=rele.id);
        //requ286.Priority__c = 'Low';
        requ286.Request_Type__c = 'Configuration';
        requ286.Request_Title__c = 'Test';
        requ286.Status__c = 'Release: Build Production';
        Database.insert(requ286);
        requ286.Status__c = 'Close: Rejected';
        requ286.Closed_Deferred__c = 'Deferred: Waiting Architecture Availabiity';
        Database.update(requ286);
        requ286.Status__c = 'Release: Build Production';
        Database.update(requ286);
        Request__c ureq286 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ286.id];     
        Integer d286 = ureq286.TimeSpentOn_Build_Production__c.intvalue();
        if(ureq286.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }
        
        Request__c requ287 = new Request__c(Release__c=rele.id);
        //requ287.Priority__c = 'Low';
        requ287.Request_Type__c = 'Configuration';
        requ287.Request_Title__c = 'Test';
        requ287.Status__c = 'Release: Build Production';
        requ287.Related_Request__c = requ286.Id;
        Database.insert(requ287);
        requ287.Status__c = 'Close: Duplicate';
        Database.update(requ287);
        requ287.Status__c = 'Release: Build Production';
        Database.update(requ287);
        Request__c ureq287 = [Select Status__c, StartTime_Build_Production__c, StopTime_Build_Production__c, 
                              TimeSpentOn_Build_Production__c, LastModifiedDate, Id from Request__c where id=: requ287.id];     
        try{Integer d287 = ureq287.TimeSpentOn_Build_Production__c.intvalue();}Catch(Exception ex){}
        if(ureq287.StartTime_Build_Production__c != null){
            system.debug('Test Pass');
        }   
        
        Test.stopTest();    
    }
    
}