@isTest
public class SaaSSessionOutcomeDetailCtrlTest 
{
   static testMethod void validateSaaSSessionOutcomeDetail() 
   {
        Release__c rel = new Release__c();
        rel.Name = 'Test Release Data';
        rel.Id = null;
        rel.Plan_Start_Date__c = System.today();
        rel.Release_Planned_End_Date__c= System.today() + 10;
        rel.Status__c = 'Red';
        rel.Description__c = 'Test description ';
        insert rel;
        
        Value_Delivery_Session__c vds = new Value_Delivery_Session__c();
        vds.Description__c = 'test delivery data';
        vds.End_Date__c = System.today() + 10; 
        vds.Start_Time__c=system.now();
        vds.Releases__c = rel.id;
        insert vds;        
                
        Value_Delivery_Session_Outcomes__c objVDSO = new Value_Delivery_Session_Outcomes__c();
        objVDSO.Name = 'Test outcome Data';
        objVDSO.Phase__c = 'Design';
        objVDSO.Start_Date__c = system.today();
        objVDSO.End_Date__c = system.today()+10;
        objVDSO.Session_Outcome__c = 'Test data preparation';
        objVDSO.Value_Delivery_Session__c = vds.id; 
        insert objVDSO;   
       
                

        Value_Delivery_Key_Participants__c  vdp = new Value_Delivery_Key_Participants__c(); 
        vdp.name = 'TestName';
        vdp.Role__c = 'TestRole';
        vdp.Participant_Type__c = 'Accenture Team';
        vdp.Comments__c ='Test Comment';
        vdp.Session_Outcomes__c = objVDSO.id;
        insert vdp;
       
        Value_Delivery_Key_Participants__c  vd = new Value_Delivery_Key_Participants__c(); 
        vd.name = 'TestNewName';
        vd.Role__c = 'TestNewRole';
        vd.Participant_Type__c = 'Accenture Team';
        vd.Comments__c ='TestNew Comment';
        vd.Session_Outcomes__c = objVDSO.id;
        insert vd;
          
        ApexPages.CurrentPage().getparameters().put('participantsId', vd.id);
        SaaSSessionOutcomeDetailCtrl ctrl = new SaaSSessionOutcomeDetailCtrl(new ApexPages.StandardController(objVDSO));
        ctrl.getParticipants();
        ctrl.newParticipantsObj = vdp;
        ctrl.isDetail = false;
        ctrl.sessionsOutcomeLst = new List<SelectOption>();
        ctrl.sessOutcomeID = objVDSO.id;
        ctrl.participantsObj = vd;        
        ctrl.saveSessionOutcome(); 
        objVDSO.Name = Null;
        try {
            ctrl.validateSessionOutcome();
        } catch(DMLException e) {
            system.assertEquals(e.getMessage(), e.getMessage());
        } 
        ctrl.addPartcipants();   
        
        ctrl.getAllKeyParticipants();        
        ctrl.updateParticipants();
        ctrl.deleteParticipants();
        User_Story__c userstory = new User_Story__c();
        userstory.name ='how to implement';
        userstory.Release__c = rel.Id;
        insert userstory;
        
        Value_Delivery_Session_User_Stories__c stories = new Value_Delivery_Session_User_Stories__c();
        stories.Value_Delivery_Session_Outcomes__c = objVDSO.Id;
        stories.User_Story__c =userstory.Id;
        insert stories;
       
        Value_Delivery_Session_User_Stories__c stories1 = new Value_Delivery_Session_User_Stories__c();
        boolean flag = true;
        stories1.Value_Delivery_Session_Outcomes__c = objVDSO.Id;
        stories1.User_Story__c =userstory.Id;
        insert stories1;
      
       User_Story_Options__c userStoryoption = new User_Story_Options__c ();
       integer i=1;
       string s ='test';
       userStoryoption.Value_Deliver_Session_User_Stories__c=stories.Id;
       insert userStoryoption;
       
       User_Story_Options__c userStoryoption1 = new User_Story_Options__c ();
       userStoryoption1.Value_Deliver_Session_User_Stories__c=stories.Id;
       insert userStoryoption1;
       
       List<User_Story_Options__c> userStoryoptionlist = [select id from User_Story_Options__c where id=:userStoryoption1.Id LIMIT 1]; 
       
       SaaSSessionOutcomeDetailCtrl.OptionsWrapper pwr = new SaaSSessionOutcomeDetailCtrl.OptionsWrapper (userStoryoption1); 
       SaaSSessionOutcomeDetailCtrl.OptionsWrapper pw = new SaaSSessionOutcomeDetailCtrl.OptionsWrapper(i,userStoryoption,s);        
       ctrl.newOptionsLst.add(pw);
       ctrl.getSessionUserStory();
       ctrl.getUserStoryOptions();
       ctrl.saveUserVote();
       ctrl.saveUserStory();
       list<Vote_User_Story__c>  userVoteLst = new List<Vote_User_Story__c>();
       SaaSSessionOutcomeDetailCtrl.VoteUserStoryWrapper  pwt = new SaaSSessionOutcomeDetailCtrl.VoteUserStoryWrapper ();  
        pwt.userVote = null;
        try {
           ctrl.validateUserVote(); 
       } catch(DMLException e) {
         system.assertEquals(e.getMessage(), e.getMessage());
       }
       

       userVoteLst.add(pwt.userVoteObj);   
       ctrl.add();
       ctrl.remove();
       //ctrl.validateSessionOutcome();
       ctrl.validateParticipant(vdp);
       boolean flag1 =ctrl.voteFlag;
      // ctrl.deleteSessionUserStory();
       SaaSSessionOutcomeDetailCtrl.SessionUserStoryWrapper session = new SaaSSessionOutcomeDetailCtrl.SessionUserStoryWrapper(stories);        

       Vote_User_Story__c voteUserStory = new Vote_User_Story__c();
       voteUserStory.User_Story_Option__c =userStoryoption1.Id;
       insert voteUserStory ;

       SaaSSessionOutcomeDetailCtrl.SessionUserStoryWrapper session1 = new SaaSSessionOutcomeDetailCtrl.SessionUserStoryWrapper(stories1,true);        
   }
    
   static testMethod void validateSaaSSessionOutcomeDetailNegative() 
   {
        Release__c rel = new Release__c();
        rel.Name = 'Test Release Data';
        rel.Id = null;
        rel.Plan_Start_Date__c = System.today();
        rel.Release_Planned_End_Date__c= System.today() + 10;
        rel.Status__c = 'Red';
        rel.Description__c = 'Test description ';
        insert rel;
        
        Value_Delivery_Session__c vds = new Value_Delivery_Session__c();
        vds.Description__c = 'test delivery data';
        vds.End_Date__c = System.today() + 10; 
        vds.Start_Time__c=system.now();
        vds.Releases__c = rel.id;
        insert vds;        
        
        Value_Delivery_Session_Outcomes__c objVDSO = new Value_Delivery_Session_Outcomes__c();
        objVDSO.Name = 'Test Data';
        objVDSO.Phase__c = Null;
        objVDSO.Start_Date__c = system.today();
        objVDSO.End_Date__c = system.today()+10;
        objVDSO.Session_Outcome__c = 'Test data preparation';
        objVDSO.Value_Delivery_Session__c = vds.id;         
        insert objVDSO;

        Value_Delivery_Key_Participants__c  vd = new Value_Delivery_Key_Participants__c(); 
        vd.name = 'TestNewName';
        vd.Role__c = 'TestNewRole';
        vd.Participant_Type__c = 'Accenture Team';
        vd.Comments__c ='TestNew Comment';
        vd.Session_Outcomes__c = objVDSO.id;
       
        SaaSSessionOutcomeDetailCtrl ctrl = new SaaSSessionOutcomeDetailCtrl(new ApexPages.StandardController(objVDSO));        
        
        ctrl.newParticipantsObj = vd;

        ctrl.addPartcipants();
        ctrl.saveSessionOutcome();
       
        ctrl.participantsObj = Null;
        ctrl.updateParticipants();
        ctrl.deleteParticipants();
              
        Value_Delivery_Session_Outcomes__c objVDSOs = new Value_Delivery_Session_Outcomes__c();
        objVDSOs.Name = '   ';
        objVDSOs.Phase__c = 'Design';
        objVDSOs.Start_Date__c = system.today();
        objVDSOs.End_Date__c = system.today()+10;
        objVDSOs.Session_Outcome__c = 'Test data preparation';
        objVDSOs.Value_Delivery_Session__c = vds.id;            
        insert objVDSOs;
               
        SaaSSessionOutcomeDetailCtrl ctrls = new SaaSSessionOutcomeDetailCtrl(new ApexPages.StandardController(objVDSOs));
        ctrls.saveSessionOutcome();
   }
   
    static testMethod void SaaSSessionOutcomeDetailNegativeTest() 
   {
        Release__c rel = new Release__c();
        rel.Name = 'Test Release Data';
        rel.Id = null;
        rel.Plan_Start_Date__c = System.today();
        rel.Release_Planned_End_Date__c= System.today() + 10;
        rel.Status__c = 'Red';
        rel.Description__c = 'Test description ';
        insert rel;
        
        Value_Delivery_Session__c vds = new Value_Delivery_Session__c();
        vds.Description__c = 'test delivery data';
        vds.End_Date__c = System.today() + 10; 
        vds.Start_Time__c=system.now();
        vds.Releases__c = rel.id;
        insert vds;        
        
        Value_Delivery_Session_Outcomes__c objVDSO = new Value_Delivery_Session_Outcomes__c();
        objVDSO.Name = 'Test Data';
        objVDSO.Phase__c = Null;
        objVDSO.Start_Date__c = system.today();
        objVDSO.End_Date__c = system.today()+10;
        objVDSO.Session_Outcome__c = 'Test data preparation';
        objVDSO.Value_Delivery_Session__c = vds.id;         
        insert objVDSO;
        
        
        Value_Delivery_Key_Participants__c  vd = new Value_Delivery_Key_Participants__c(); 
        vd.name = Null;
        vd.Role__c = 'Test Roll';
        vd.Participant_Type__c = 'Accenture Team';
        vd.Comments__c ='TestNew Comment';
        vd.Session_Outcomes__c = Null;
        
         Value_Delivery_Key_Participants__c  vdp = new Value_Delivery_Key_Participants__c(); 
        vdp.name = 'Rahul';
        vdp.Role__c = Null;
        vdp.Participant_Type__c = 'Accenture Team';
        vdp.Comments__c ='TestNew Comment';
        vdp.Session_Outcomes__c = objVDSO.ID;
  
        Value_Delivery_Session_User_Stories__c stories = new Value_Delivery_Session_User_Stories__c();
        stories.Value_Delivery_Session_Outcomes__c = objVDSO.Id;
        stories.User_Story__c =null;
       
        
        SaaSSessionOutcomeDetailCtrl ctrl = new SaaSSessionOutcomeDetailCtrl(new ApexPages.StandardController(objVDSO));        
        
        ctrl.participantsObj = vd;
        ctrl.deleteSessionUsrStory = stories;
        ctrl.deleteSessionUserStory();
        ctrl.deleteParticipants();
        //ctrl.newSessionUserStoriesObj = stories;
        //ctrl.saveUserStory();
        ctrl.updateParticipants();
        
   }      
}