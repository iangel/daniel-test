public with sharing class Cls_MilestoneGanttChart {

    public string ganttJson {get;set;}
    public string color{get;set;}
    public date startdate{get;set;}
    public date enddate{get;set;}
    public List<SelectOption> myList{get; set;}
    //public string selectedcheckboxstatusvalues{get;set;}
    public string selectedmilestoneValues{get;set;}
    //public string strStatus;
    public boolean noflag{get;set;}
    public boolean searchflag{get;set;}
    
    public List<Milestone__c> taskList{get;set;}
    //public String query{get;set;}
    
    set<string> setstring = new set<string>();
    string recordid = ApexPages.currentPage().getParameters().get('ReleaseId');
    // String selectedmilestonevalue = ApexPages.currentPage().getParameters().get('selectedmilestone');
        // String selectedstatusvalue = ApexPages.currentPage().getParameters().get('selectedstatus');
    
    //public string theSite{get;set;}


    
    public List<Key_Action_Decision__c> keydecisionList{get;set;}
    //List<sObject> milestoneandkeydecisionlist {get;set;} 
    
    
    String[] selectedcheckboxvalues = new String[]{};
    
    //public string recordid{get;set;}

    
    public String[] getselectedcheckboxvalues() {
         
        return selectedcheckboxvalues;
    }
    
    public void setselectedcheckboxvalues(String[] selectedcheckboxvalues) {
        this.selectedcheckboxvalues= selectedcheckboxvalues;
    }
    
    public Cls_MilestoneGanttChart(ApexPages.StandardController controller) {
         noflag = false;
         searchflag = false;
         //recordid = controller.getRecord().Id;
         recordid = ApexPages.currentPage().getParameters().get('ReleaseId');
         String selectedmilestonevalue = ApexPages.currentPage().getParameters().get('selectedmilestone');
         String selectedstatusvalue = ApexPages.currentPage().getParameters().get('selectedstatus');
         
        //string theSite = ApexPages.CurrentPage().getParameters().get('site');
            
        //system.debug('selectedstatusvalue123456 --> '+ theSite);
        if(ApexPages.CurrentPage().getParameters().get('ReleaseId') == null) {
            taskList = [Select Id, Name, Actual_Start_Date__c, Actual_End_Date__c,Planned_Start_Date__c,Planned_End_Date__c,Milestone_Name__c,
                        Asset_Initiative_Milestone__c,Comments__c,Milestones__c,Milestone_Id__c,On_Target__c,Owner__c,
                        Progress__c,Release__c,Release__r.Name,Status__c,Complete2__c,Color__c,Owner.Name
                        From Milestone__c Where Release__c =: controller.getRecord().Id order by Actual_Start_Date__c,Planned_Start_Date__c ASC ]; 
           
           keydecisionList  = [select Id,Name,RecordTypeId,Completed_Date__c,Days_Open__c,Decision_Outcome__c,Description__c,Due_Date__c,Key_Action_Decision__c,Options__c,
                               Priority__c,Related_Capability__c,Related_Issue_Risk__c,Related_Key_Action_Decision__c,Related_Question_Log__c,Related_Release__c,Owner.Name,
                               Related_Request__c,SOURCE_ID__c,Status__c,Use_Case__c from Key_Action_Decision__c where Display_on_Timeline__c = true and Related_Release__c =: controller.getRecord().Id order by Completed_Date__c ASC];               

       } else {
          
                taskList = [Select Id, Name, Actual_Start_Date__c, Actual_End_Date__c,Planned_Start_Date__c,Planned_End_Date__c,Milestone_Name__c,
                            Asset_Initiative_Milestone__c,Comments__c,Milestones__c,Milestone_Id__c,On_Target__c,Owner__c,
                            Progress__c,Release__c,Release__r.Name,Status__c,Complete2__c,Color__c,Owner.Name
                            From Milestone__c Where Release__c =: ApexPages.CurrentPage().getParameters().get('ReleaseId') 
                            order by Actual_Start_Date__c,Planned_Start_Date__c ASC];

             keydecisionList  = [select Id,Name,RecordTypeId,Completed_Date__c,Days_Open__c,Decision_Outcome__c,Description__c,Due_Date__c,Key_Action_Decision__c,Options__c,
                               Priority__c,Related_Capability__c,Related_Issue_Risk__c,Related_Key_Action_Decision__c,Related_Question_Log__c,Related_Release__c,Owner.Name,
                               Related_Request__c,SOURCE_ID__c,Status__c,Use_Case__c from Key_Action_Decision__c where Display_on_Timeline__c = true and Related_Release__c =: ApexPages.CurrentPage().getParameters().get('ReleaseId') order by Completed_Date__c ASC];             
            
        } 
        
            List<sObject> milestoneandkeydecisionlist = new List<sObject>();
            
            milestoneandkeydecisionlist.addAll((List<sObject>)(taskList));
            milestoneandkeydecisionlist.addAll((List<sObject>)(keydecisionList));
        
       
    
        for(Milestone__c taskRec : taskList) {
           
            color = taskRec.Color__c;
            system.debug('color-->' + color );
            
            if(taskRec.Actual_Start_Date__c != null){
                startdate = taskRec.Actual_Start_Date__c;
                } else{
                startdate = taskRec.Planned_Start_Date__c;
                }
                
             if(taskRec.Actual_End_Date__c!= null){
                enddate= taskRec.Actual_End_Date__c;
                } else{
                enddate= taskRec.Planned_End_Date__c;
                }
            
            if(taskRec.Milestone_Name__c== taskRec.Milestone_Name__c) {
                if(string.isBlank(ganttJson)) {
                    ganttJson = '[{"values":[{"customClass":"Milestone: '+taskRec.Milestone_Name__c+'<br/>Planned Start Date: '+startdate.format()+'<br/>Planned End Date: '+enddate.format()+'<br/>Progress: '+taskRec.Progress__c+'<br/>Owner: '+taskRec.Owner.Name+'","from":"'+startdate.format()+'","label":"'+taskRec.Id+'","color":"'+taskRec.Color__c+'","to":"'+enddate.format()+'","id":"'+taskRec.Id+
                                '"}],"scale":"hours","itemsPerPage":"11","navigate":"scroll","name":"'+taskRec.Milestone_Name__c+'","startDate":"'+startdate.format()+'","endDate":"'+enddate.format()+'","fullScreen":"'+(ApexPages.CurrentPage().getParameters().get('ReleaseId')!=null ? 'true' : 'false')+'"}';
                }
                else {
                    ganttJson = ganttJson+',{"values":[{"customClass":"Milestone: '+taskRec.Milestone_Name__c+'<br/>Planned Start Date: '+startdate.format()+'<br/>Planned End Date: '+enddate.format()+'<br/>Progress: '+taskRec.Progress__c+'<br/>Owner: '+taskRec.Owner.Name+'","from":"'+startdate.format()+'","label":"'+taskRec.Id+'","color":"'+taskRec.Color__c+'","to":"'+enddate.format()+'","id":"'+taskRec.Id+
                                '"}],"scale":"hours","itemsPerPage":"11","navigate":"scroll","name":"'+taskRec.Milestone_Name__c+'","startDate":"'+startdate.format()+'","endDate":"'+enddate.format()+'","fullScreen":"'+(ApexPages.CurrentPage().getParameters().get('ReleaseId')!=null ? 'true' : 'false')+'"}';
                }
            }
            /*else {
                if(string.isBlank(ganttJson)) {
                    ganttJson = '[{"values":[{"customClass":"Milestone: '+taskRec.Milestone_Name__c+'<br/>Planned Start Date: '+startdate.format()+'<br/>Planned End Date: '+enddate.format()+'<br/>Progress: '+taskRec.Progress__c+'<br/>Owner: '+taskRec.Owner.Name+'","from":"'+startdate.format()+'","label":"'+taskRec.Id+'","color":"'+taskRec.Color__c+'","to":"'+enddate.format()+'","id":"'+taskRec.Id+
                                 '"}],"scale":"hours","itemsPerPage":"11","navigate":"scroll","name":"'+taskRec.Milestone_Name__c+'","startDate":"'+startdate.format()+'","endDate":"'+enddate.format()+'","fullScreen":"'+(ApexPages.CurrentPage().getParameters().get('ReleaseId')!=null ? 'true' : 'false')+'"}';       
                }
                else {
                    ganttJson = ganttJson+',{"values":[{"customClass":"Milestone: '+taskRec.Milestone_Name__c+'<br/>Planned Start Date: '+startdate.format()+'<br/>Planned End Date: '+enddate.format()+'<br/>Progress: '+taskRec.Progress__c+'<br/>Owner: '+taskRec.Owner.Name+'","from":"'+startdate.format()+'","label":"'+taskRec.Id+'","color":"'+taskRec.Color__c+'","to":"'+enddate.format()+'","id":"'+taskRec.Id+
                                  '"}],"scale":"hours","itemsPerPage":"11","navigate":"scroll","name":"'+taskRec.Milestone_Name__c+'","startDate":"'+startdate.format()+'","endDate":"'+enddate.format()+'","fullScreen":"'+(ApexPages.CurrentPage().getParameters().get('ReleaseId')!=null ? 'true' : 'false')+'"}';      
                }
                
            } */
        }
        
        
        // for key decision 
            
            for(Key_Action_Decision__c taskRec1 : keydecisionList) {

            if(taskRec1.Due_Date__c!= null){
                    startdate = taskRec1.Due_Date__c;
                } else {
                    startdate = taskRec1.Completed_Date__c;
                 }   
                
              
             
            if(taskRec1.Name== taskRec1.Name) {
                if(string.isBlank(ganttJson)) {
                    ganttJson = '[{"values":[{"customClass":"KeyDecision: '+taskRec1.Name+'<br/>Description: '+taskRec1.Description__c+'<br/>Status: '+taskRec1.Status__c+'<br/>Due Date: '+startdate.format()+'<br/>Owner: '+taskRec1.Owner.Name+'","from":"'+startdate.format()+'","label":"'+taskRec1.Id+'","to":"'+startdate.format()+'","id":"'+taskRec1.Id+
                                '"}],"scale":"hours","itemsPerPage":"11","navigate":"scroll","name":"'+taskRec1.Name+'","startDate":"'+startdate.format()+'","fullScreen":"'+(ApexPages.CurrentPage().getParameters().get('ReleaseId')!=null ? 'true' : 'false')+'"}';
                }
                else {
                    ganttJson = ganttJson+',{"values":[{"customClass":"KeyDecision: '+taskRec1.Name+'<br/>Description: '+taskRec1.Description__c+'<br/>Status: '+taskRec1.Status__c+'<br/>Due Date: '+startdate.format()+'<br/>Owner: '+taskRec1.Owner.Name+'","from":"'+startdate.format()+'","label":"'+taskRec1.Id+'","to":"'+startdate.format()+'","id":"'+taskRec1.Id+
                                '"}],"scale":"hours","itemsPerPage":"11","navigate":"scroll","name":"'+taskRec1.Name+'","startDate":"'+startdate.format()+'","fullScreen":"'+(ApexPages.CurrentPage().getParameters().get('ReleaseId')!=null ? 'true' : 'false')+'"}';
                }
            }
           /* else {
                if(string.isBlank(ganttJson)) {
                    ganttJson = '[{"values":[{"customClass":"KeyDecision: '+taskRec1.Name+'<br/>Description: '+taskRec1.Description__c+'<br/>Status: '+taskRec1.Status__c+'<br/>Due Date: '+startdate.format()+'<br/>Owner: '+taskRec1.Owner.Name+'","label":"'+taskRec1.Id+'","id":"'+taskRec1.Id+
                                '"}],"scale":"hours","itemsPerPage":"11","navigate":"scroll","name":"'+taskRec1.Name+'","startDate":"'+startdate.format()+'","fullScreen":"'+(ApexPages.CurrentPage().getParameters().get('ReleaseId')!=null ? 'true' : 'false')+'"}';      
                }
                else {
                    ganttJson = ganttJson+',{"values":[{"customClass":"KeyDecision: '+taskRec1.Name+'<br/>Description: '+taskRec1.Description__c+'<br/>Status: '+taskRec1.Status__c+'<br/>Due Date: '+startdate.format()+'<br/>Owner: '+taskRec1.Owner.Name+'","label":"'+taskRec1.Id+'","id":"'+taskRec1.Id+
                                '"}],"scale":"hours","itemsPerPage":"11","navigate":"scroll","name":"'+taskRec1.Name+'","startDate":"'+startdate.format()+'","fullScreen":"'+(ApexPages.CurrentPage().getParameters().get('ReleaseId')!=null ? 'true' : 'false')+'"}';      
                }
                
            } */
        }
        
        system.debug('ganttJson 123  -->' + ganttJson);
        
         if(ganttJson == null || ganttJson == ']'){
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'No Milestones and keydecision records are for this search Criteria.'));
           noflag = true;
        } 
       
        //ganttJson.sort();        
        ganttJson = ganttJson + ']';
        system.debug('ganttJson -->' + ganttJson);

    }
    
    public PageReference searchresults(){
          
         noflag = false;
         searchflag = false;
        ganttJson = '';
        system.debug('ganttJson123-->' + ganttJson);
        //string theSite = ApexPages.CurrentPage().getParameters().get('site');
        
        //system.debug('helloo...21 >' + theSite);
        recordid = ApexPages.currentPage().getParameters().get('ReleaseId');
      
        integer count = selectedcheckboxvalues.size();
        system.debug('helloo...count' + count);
             
        system.debug('helloo...'+selectedcheckboxvalues);
        //strStatus='(\'';
        setstring.clear();
        for(integer i=0;i<count;i++){
        system.debug('helloo...inside');
        setstring.add(selectedcheckboxvalues[i]);
        }
        system.debug('helloo...');
        system.debug('selectedmilestoneValues --> ' + selectedmilestoneValues);
        system.debug('selectedcheckboxvalues--> ' + setstring);
            if(selectedmilestoneValues !=null && count > 0) {
                    taskList = [Select Id, Name, Actual_Start_Date__c, Actual_End_Date__c,Planned_Start_Date__c,Planned_End_Date__c,Milestone_Name__c,
                                    Asset_Initiative_Milestone__c,Comments__c,Milestones__c,Milestone_Id__c,On_Target__c,Owner__c,
                                    Progress__c,Release__c,Release__r.Name,Status__c,Complete2__c,Color__c,Owner.Name
                                    From Milestone__c Where Release__c =:recordid 
                                    and Milestones__c=:selectedmilestoneValues 
                                    and Progress__c  In :setstring
                                    order by Actual_Start_Date__c,Planned_Start_Date__c ASC];
               } else if(selectedmilestoneValues == null && count == 0) {
                    taskList = [Select Id, Name, Actual_Start_Date__c, Actual_End_Date__c,Planned_Start_Date__c,Planned_End_Date__c,Milestone_Name__c,
                            Asset_Initiative_Milestone__c,Comments__c,Milestones__c,Milestone_Id__c,On_Target__c,Owner__c,
                            Progress__c,Release__c,Release__r.Name,Status__c,Complete2__c,Color__c,Owner.Name
                            From Milestone__c Where Release__c =:recordid];
                           
                       // order by Actual_Start_Date__c,Planned_Start_Date__c ASC];
             }  else if(selectedmilestoneValues != null && count == 0) {
                    taskList = [Select Id, Name, Actual_Start_Date__c, Actual_End_Date__c,Planned_Start_Date__c,Planned_End_Date__c,Milestone_Name__c,
                            Asset_Initiative_Milestone__c,Comments__c,Milestones__c,Milestone_Id__c,On_Target__c,Owner__c,
                            Progress__c,Release__c,Release__r.Name,Status__c,Complete2__c,Color__c,Owner.Name
                            From Milestone__c Where Release__c =:recordid and Milestones__c=:selectedmilestoneValues];
             }  else if(selectedmilestoneValues == null && count > 0) {
                    taskList = [Select Id, Name, Actual_Start_Date__c, Actual_End_Date__c,Planned_Start_Date__c,Planned_End_Date__c,Milestone_Name__c,
                            Asset_Initiative_Milestone__c,Comments__c,Milestones__c,Milestone_Id__c,On_Target__c,Owner__c,
                            Progress__c,Release__c,Release__r.Name,Status__c,Complete2__c,Color__c,Owner.Name
                            From Milestone__c Where Release__c =:recordid and Progress__c  IN :setstring];
             }  
             
             
                       
  
         keydecisionList  = [select Id,Name,RecordTypeId,Completed_Date__c,Days_Open__c,Decision_Outcome__c,Description__c,Due_Date__c,Key_Action_Decision__c,Options__c,
                               Priority__c,Related_Capability__c,Related_Issue_Risk__c,Related_Key_Action_Decision__c,Related_Question_Log__c,Related_Release__c,Owner.Name,
                               Related_Request__c,SOURCE_ID__c,Status__c,Use_Case__c from Key_Action_Decision__c where Display_on_Timeline__c = true and Related_Release__c =:recordid order by Completed_Date__c ASC];               
                     
          
       system.debug('recordid-->' + recordid); 
       system.debug('taskList-->' + taskList);
       system.debug('keydecisionList -->' + keydecisionList );
        
            List<sObject> milestoneandkeydecisionlist = new List<sObject>();
            
            milestoneandkeydecisionlist.addAll((List<sObject>)(taskList));
            milestoneandkeydecisionlist.addAll((List<sObject>)(keydecisionList));
        
       
    
        for(Milestone__c taskRec : taskList) {
            
            color = taskRec.Color__c;
            system.debug('color-->' + color );
            
            if(taskRec.Actual_Start_Date__c != null){
                startdate = taskRec.Actual_Start_Date__c;
                } else{
                startdate = taskRec.Planned_Start_Date__c;
                }
                
             if(taskRec.Actual_End_Date__c!= null){
                enddate= taskRec.Actual_End_Date__c;
                } else{
                enddate= taskRec.Planned_End_Date__c;
                }
            
            if(taskRec.Milestone_Name__c== taskRec.Milestone_Name__c) {
                if(string.isBlank(ganttJson)) {
                    ganttJson = '[{"values":[{"customClass":"Milestone: '+taskRec.Milestone_Name__c+'<br/>Planned Start Date: '+startdate.format()+'<br/>Planned End Date: '+enddate.format()+'<br/>Progress: '+taskRec.Progress__c+'<br/>Owner: '+taskRec.Owner.Name+'","from":"'+startdate.format()+'","label":"'+taskRec.Id+'","color":"'+taskRec.Color__c+'","to":"'+enddate.format()+'","id":"'+taskRec.Id+
                                '"}],"scale":"hours","itemsPerPage":"11","navigate":"scroll","name":"'+taskRec.Milestone_Name__c+'","startDate":"'+startdate.format()+'","endDate":"'+enddate.format()+'","fullScreen":"'+(ApexPages.CurrentPage().getParameters().get('ReleaseId')!=null ? 'true' : 'false')+'"}';
                }
                else {
                    ganttJson = ganttJson+',{"values":[{"customClass":"Milestone: '+taskRec.Milestone_Name__c+'<br/>Planned Start Date: '+startdate.format()+'<br/>Planned End Date: '+enddate.format()+'<br/>Progress: '+taskRec.Progress__c+'<br/>Owner: '+taskRec.Owner.Name+'","from":"'+startdate.format()+'","label":"'+taskRec.Id+'","color":"'+taskRec.Color__c+'","to":"'+enddate.format()+'","id":"'+taskRec.Id+
                                '"}],"scale":"hours","itemsPerPage":"11","navigate":"scroll","name":"'+taskRec.Milestone_Name__c+'","startDate":"'+startdate.format()+'","endDate":"'+enddate.format()+'","fullScreen":"'+(ApexPages.CurrentPage().getParameters().get('ReleaseId')!=null ? 'true' : 'false')+'"}';
                }
            }
           /* else {
                if(string.isBlank(ganttJson)) {
                    ganttJson = '[{"values":[{"customClass":"Milestone: '+taskRec.Milestone_Name__c+'<br/>Planned Start Date: '+startdate.format()+'<br/>Planned End Date: '+enddate.format()+'<br/>Progress: '+taskRec.Progress__c+'<br/>Owner: '+taskRec.Owner.Name+'","from":"'+startdate.format()+'","label":"'+taskRec.Id+'","color":"'+taskRec.Color__c+'","to":"'+enddate.format()+'","id":"'+taskRec.Id+
                                 '"}],"scale":"hours","itemsPerPage":"11","navigate":"scroll","name":"'+taskRec.Milestone_Name__c+'","startDate":"'+startdate.format()+'","endDate":"'+enddate.format()+'","fullScreen":"'+(ApexPages.CurrentPage().getParameters().get('ReleaseId')!=null ? 'true' : 'false')+'"}';       
                }
                else {
                    ganttJson = ganttJson+',{"values":[{"customClass":"Milestone: '+taskRec.Milestone_Name__c+'<br/>Planned Start Date: '+startdate.format()+'<br/>Planned End Date: '+enddate.format()+'<br/>Progress: '+taskRec.Progress__c+'<br/>Owner: '+taskRec.Owner.Name+'","from":"'+startdate.format()+'","label":"'+taskRec.Id+'","color":"'+taskRec.Color__c+'","to":"'+enddate.format()+'","id":"'+taskRec.Id+
                                  '"}],"scale":"hours","itemsPerPage":"11","navigate":"scroll","name":"'+taskRec.Milestone_Name__c+'","startDate":"'+startdate.format()+'","endDate":"'+enddate.format()+'","fullScreen":"'+(ApexPages.CurrentPage().getParameters().get('ReleaseId')!=null ? 'true' : 'false')+'"}';      
                }
                
            } */
        }
        
        
        // for key decision 
            
            for(Key_Action_Decision__c taskRec1 : keydecisionList) {

            if(taskRec1.Due_Date__c!= null){
                    startdate = taskRec1.Due_Date__c;
                } else {
                    startdate = taskRec1.Completed_Date__c;
                 }   
                
              
             
            if(taskRec1.Name== taskRec1.Name) {
                if(string.isBlank(ganttJson)) {
                    ganttJson = '[{"values":[{"customClass":"KeyDecision: '+taskRec1.Name+'<br/>Description: '+taskRec1.Description__c+'<br/>Status: '+taskRec1.Status__c+'<br/>Due Date: '+startdate.format()+'<br/>Owner: '+taskRec1.Owner.Name+'","from":"'+startdate.format()+'","label":"'+taskRec1.Id+'","to":"'+startdate.format()+'","id":"'+taskRec1.Id+
                                '"}],"scale":"hours","itemsPerPage":"11","navigate":"scroll","name":"'+taskRec1.Name+'","startDate":"'+startdate.format()+'","fullScreen":"'+(ApexPages.CurrentPage().getParameters().get('ReleaseId')!=null ? 'true' : 'false')+'"}';
                }
                else {
                    ganttJson = ganttJson+',{"values":[{"customClass":"KeyDecision: '+taskRec1.Name+'<br/>Description: '+taskRec1.Description__c+'<br/>Status: '+taskRec1.Status__c+'<br/>Due Date: '+startdate.format()+'<br/>Owner: '+taskRec1.Owner.Name+'","from":"'+startdate.format()+'","label":"'+taskRec1.Id+'","to":"'+startdate.format()+'","id":"'+taskRec1.Id+
                                '"}],"scale":"hours","itemsPerPage":"11","navigate":"scroll","name":"'+taskRec1.Name+'","startDate":"'+startdate.format()+'","fullScreen":"'+(ApexPages.CurrentPage().getParameters().get('ReleaseId')!=null ? 'true' : 'false')+'"}';
                }
            }
          /*  else {
                if(string.isBlank(ganttJson)) {
                    ganttJson = '[{"values":[{"customClass":"KeyDecision: '+taskRec1.Name+'<br/>Description: '+taskRec1.Description__c+'<br/>Status: '+taskRec1.Status__c+'<br/>Due Date: '+startdate.format()+'<br/>Owner: '+taskRec1.Owner.Name+'","label":"'+taskRec1.Id+'","id":"'+taskRec1.Id+
                                '"}],"scale":"hours","itemsPerPage":"11","navigate":"scroll","name":"'+taskRec1.Name+'","startDate":"'+startdate.format()+'","fullScreen":"'+(ApexPages.CurrentPage().getParameters().get('ReleaseId')!=null ? 'true' : 'false')+'"}';      
                }
                else {
                    ganttJson = ganttJson+',{"values":[{"customClass":"KeyDecision: '+taskRec1.Name+'<br/>Description: '+taskRec1.Description__c+'<br/>Status: '+taskRec1.Status__c+'<br/>Due Date: '+startdate.format()+'<br/>Owner: '+taskRec1.Owner.Name+'","label":"'+taskRec1.Id+'","id":"'+taskRec1.Id+
                                '"}],"scale":"hours","itemsPerPage":"11","navigate":"scroll","name":"'+taskRec1.Name+'","startDate":"'+startdate.format()+'","fullScreen":"'+(ApexPages.CurrentPage().getParameters().get('ReleaseId')!=null ? 'true' : 'false')+'"}';      
                }
                
            } */
        }
        
        
        ganttJson = ganttJson + ']';
        
          
         if(ganttJson == null || ganttJson == ']'){
           //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'No Milestones and keydecision records are for this search Criteria.'));
           searchflag = true;
        } 
        system.debug('ganttJson -->' + ganttJson);
    return null;
    }
    
    
    public List<SelectOption> getStatusValues(){
        myList =new List<SelectOption>();
      
        Schema.DescribeFieldResult f = Milestone__c.Progress__c.getDescribe();
            List<Schema.PicklistEntry> p = f.getPicklistValues();
               for(Schema.PicklistEntry e:p){
                    myList.add(new SelectOption(e.getLabel(),e.getValue()));
                                       
            }
            return myList;
    }
    
     public List<SelectOption> getmilestoneValues(){
        myList =new List<SelectOption>();
        myList.add(new selectOption('', '--- None ---')); 
        Schema.DescribeFieldResult f = Milestone__c.Milestones__c.getDescribe();
            List<Schema.PicklistEntry> p = f.getPicklistValues();
               for(Schema.PicklistEntry e:p){
                    myList.add(new SelectOption(e.getLabel(),e.getValue()));
                                       
            }
            return myList;
    }
}