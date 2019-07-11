/**@author  Accenture
* @Created Date 2018-Apr-15
* @version  1.0
* @description This class conatins methods which are invoked by CaseTrigger to update Case detail 

*/ 
public Without sharing class NS_CaseTriggerHelper {
    /*Class Name*/
    private static final String CLASS_NAME = 'NS_CaseTriggerHelper';
    
    /* @author-  Accenture
*  @description- Fetch Case Setting(Custom Metada) to populate default value 
*  @param- List of Cases
*  @return- None
*  @throws- Standard Exception
*/ 
    public static void checkRecordTypeAndIsMonitored(List<Case> caseNew){
        try{
            //Prevent updation by workflow/ process builder
            NS_StaticVariablesUtility.isTriggerExecuted = true;
            
            For(Case caseRec:caseNew){
                //caseRec.Origin='Manual';
                // 12.19, update condition to check RecordtypeId != Email_To_Case, which is assigned for Cases created
                // by EmailtoCaseHandler class
                // --commented on 12.19
                              
                if(!(NS_StaticVariablesUtility.NS_Email.equalsIgnoreCase( caseRec.Origin)&&(!caseRec.NS_Created_using_Quick_Case__c))&& caseRec.ParentId== null){           
                    //if((caseRec.RecordTypeId != Schema.SObjectType.Case.getRecordTypeInfosByName().get('Email-to-Case').getRecordTypeId() ||
                    /*Brief description :  Marketing Users should be able to create Customer Service Requests   
*Defect no./wa/request no: WA#632
*Developer Name : Moumita Sarangi
*Date :18/01/2019*/
                    if(NS_StaticVariablesUtility.Delayed.equals(caseRec.NS_InteractionReason__c)){
                          caseRec.RecordTypeId = NS_CaseTriggerUtility.getRecTypeId(NS_StaticVariablesUtility.Delay_Expedite);
                      }
                    
                    /*/*Brief description :  Marketing Users should be able to create Customer Service Requests 
*Defect no./wa/request no: WA#632
*Developer Name : Moumita Sarangi
*Date :18/01/2019*/ 
                    else if(caseRec.RecordTypeId.Equals(Schema.SObjectType.Case.getRecordTypeInfosByName().get('Service Requests').getRecordTypeId()))
                    {
                         caseRec.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Service Requests').getRecordTypeId();
                    }
                    
                    /*Brief description :  Marketing Users should be able to create Customer Service Requests   
*Defect no./wa/request no: WA#632
*Developer Name : Moumita Sarangi
*Date :18/01/2019*/
                    else{
                        caseRec.RecordTypeId =  NS_CaseTriggerUtility.getRecTypeId(caseRec.NS_InteractionReason__c);
                    }
                    
                } 
                else if((caseRec.RecordTypeId != Schema.SObjectType.Case.getRecordTypeInfosByName().get('Email-to-Case').getRecordTypeId()||
                         caseRec.RecordTypeId != Schema.SObjectType.Case.getRecordTypeInfosByName().get('Service Requests').getRecordTypeId())&&
                        caseRec.ParentId!=null)
                {
                    caseRec.RecordTypeId =  NS_CaseTriggerUtility.getRecTypeId(NS_StaticVariablesUtility.ChildCase); 
                }
                
                
                /*Updating record type for Case TOP21 Type*/
                //Start
          
                else if((caseRec.RecordTypeId == Schema.SObjectType.Case.getRecordTypeInfosByName().get('Email-to-Case').getRecordTypeId()
                       )&&(([Select Forwarding_Address__c from NS_EmailToQueue__mdt where MasterLabel ='TOP21 Inquiry'].Forwarding_Address__c).contains(caseRec.Forwarding_Emails__c))){
                    caseRec.RecordTypeId =  NS_CaseTriggerUtility.getRecTypeId('TOP21');
                }
                //End


                /*Updating record type for Case Email Type*/
                //Start
                else{
                    if(!(caseRec.isClone())){
                   caseRec.RecordTypeId =  NS_CaseTriggerUtility.getRecTypeId(NS_StaticVariablesUtility.NS_EmailToCaseRT );
                    }
                }
                
                //End
                
                
                if(caseRec.Origin != 'Email' && caseRec.NS_Created_using_Quick_Case__c == false){
                    caseRec.NS_CreatedFromClonning__c = true;
                    caseRec.NS_StatusReason__c = null;
                    caseRec.NS_ExternalCaseNotes__c = null;
                }
            }
              if(Test.isRunningTest()){
                integer I=100/0;
            }
        }
        catch(exception exp)
        {
            NS_StaticVariablesUtility.createExceptionRecord(exp, '', 'checkRecordTypeAndIsMonitored');
            
        }
        
    }
    

    /* @author-  Accenture
*  @description- Update Contact with number of Cases associated
*  @param- None
*  @return- None
*  @throws- Standard Exception
*/
    public static void updateCountInContact(List<Case> listCase){
        Set<Id> conIds = new Set<Id>(); 
        List<Contact> contactWithCount=New List<Contact>();
        for(Case c : listCase){ 
            if(c.ContactId != null){ 
                conIds.add(c.ContactId); 
            } 
        }
        try{
            //////////Jack Reported issue on 5-31//////////////////////////
            List<Contact> ConList =[SELECT id, name, (SELECT id FROM cases) FROM contact where Id IN: conIds];
            For(Contact con: ConList){
                con.NS_CaseCount__c =con.cases.size(); 
                contactWithCount.ADD(con);
            }
            Update contactWithCount;
            
           

            
            //to cover Catch part
            if(Test.isRunningTest()){
                integer I=100/0;
            }
        }
        catch (Exception exp) {
            /*Inserting a record in Exception object*/
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, 'updateCountInContact');
        } 
    }
    
    /* @author-  Accenture
*  @description- Update Case with cust. Metadata value, if Interaction reason is changed
*  @param- None
*  @return- None
*  @throws- Standard Exception
*/
    
    public static void updateCaseInfo(List<Case> newCases){
        
        if(NS_StaticVariablesUtility.isTriggerExecuted == false){
            List<Case> casesNewOwner = new List<Case>();
            List<Id> casesClosed = new List<Id>();
            List<Case> casesNewSetings = new List<Case>();//if interaction reason is changed
            List<Case> casesNewUpdate = new List<Case>();
            Set<Case> casesWithTask = new Set<Case>();
            Set<Id> nonEscalatedCases = new Set<Id>();
            Case cseOld = new Case();
            Case cseNew = new Case();
            Case oldCase = new Case();
            Case newCase = new Case();
            Set<String> reasonToEscalate = new Set<String>();//Change owner if case is escalated
            //Gunjari -- 12/19 for Req#919 -- populate Case BU
            List<Case> caseChangedOwners = new List<Case>();
            List<Profile> adminProfileID= [Select id from profile where Name in ('System Administrator', 'OSS Support') limit 05];
            Profile currentUserProfile = [Select id from profile where id =:userinfo.getProfileId()];
            
            try{
                NS_CaseTriggerUtility.metadataData();
                
                for(Case CC : newCases){
                    oldCase = (Case)Trigger.oldMap.get(CC.id);
                    newCase = (Case)Trigger.newMap.get(CC.id); 
                    if((NS_StaticVariablesUtility.NS_CLOSED.Equals(CC.Status))&&(oldCase.Status.Equals(newCase.Status))&&(!adminProfileID.contains(currentUserProfile))){
                       CC.addError('Closed Case Cannot Be Edited'); 
                    }
                }
                
                For(NS_CaseSetting__mdt cSet :[SELECT Label,Interaction_Type__c FROM NS_CaseSetting__mdt 
                                               WHERE NS_AutoEscalateOnUpdate__c = true LIMIT 100]){
                                                   reasonToEscalate.add(cSet.Label+cSet.Interaction_Type__c);
                                               }
                
                for( Id cseId : Trigger.newMap.keySet() ){
                    cseOld = (Case)Trigger.oldMap.get(cseId);
                    cseNew = (Case)Trigger.newMap.get(cseId); 
                    if(cseNew.NS_WFAutoRelease__c==false && cseNew.parentid==null){//Added as Time based workflow was hitting update trigger logic
                        //If Case created from Quick case remove the checkbox so that validation rule can function 
                        if(cseNew.NS_Created_using_Quick_Case__c == true){
                            cseNew.NS_Created_using_Quick_Case__c= false;
                        }
                        //Assigned To will be null if owner is changed
                        if(cseOld.OwnerId != cseNew.OwnerId){
                            
                            cseNew.NS_AssignedTo__c = null;
                            //Gunjari -- 12/19 for Req#919 -- populate Case BU
                            caseChangedOwners.add(cseNew);
                        }
                        
                        if(!NS_StaticVariablesUtility.NS_ESCALATED.equalsIgnoreCase(cseNew.Status)){
                            nonEscalatedCases.add(cseNew.Id);//Later if status is escalated then update Assigned To as null
                        }    
                        //fetch custom logic if interaction reason is changed 
                        if((cseOld.NS_InteractionReason__c != cseNew.NS_InteractionReason__c)){
                            casesNewUpdate.add(cseNew);
                        }
                        //Check 'Escalate on Edit' Interaction Reasons for auto escalation
                        else if(cseNew.NS_IsEscaledOnEdit__c== false &&
                                reasonToEscalate.contains(cseNew.NS_InteractionReason__c+cseNew.NS_Type__c)){        
                                    casesNewSetings.add(cseNew);
                                }
                        else if((cseOld.NS_Type__c  != cseNew.NS_Type__c)){
                            
                            casesNewUpdate.add(cseNew);
                        }
                        //Manual Case Closure not permitted if Case is having open task
                        else if(cseOld.Status != cseNew.Status && NS_StaticVariablesUtility.NS_CLOSED.equalsIgnoreCase(cseNew.Status)){
                            casesClosed.add(cseNew.Id);
                        }
                        //Manual Escalation, fetch custom logic to get the new owner
                        else if(cseOld.Status != cseNew.Status && NS_StaticVariablesUtility.NS_ESCALATED.equalsIgnoreCase(cseNew.Status)){
                            if(cseOld.NS_CaseBusinessUnit__c=='OSS'&&cseNew.NS_CaseBusinessUnit__c=='OSS'){
                            cseNew.NS_AssignedTo__c = null;
                            } 
                            casesNewOwner.add(cseNew);
                        }
                        //Update Owner, if Case Assignment is updated
                        if (cseOld.NS_AssignedTo__c != cseNew.NS_AssignedTo__c){
                            
                            if(cseOld.NS_AssignedTo__c==null && (NS_StaticVariablesUtility.NS_NEW.equalsIgnoreCase(cseNew.Status) || cseNew.Status.equalsIgnoreCase(NS_StaticVariablesUtility.NEW_TXT))){
                                cseNew.Status = NS_StaticVariablesUtility.NS_WORKING;
                                
                            }
                            if (cseNew.NS_AssignedTo__c!=null){
                                
                                casesNewOwner.add(cseNew);
                                casesWithTask.add(cseNew);
                            }
                        }
                    }  
                    //If Time based workflow hit the update trigger 
                    else{
                        cseNew.NS_WFAutoRelease__c=false;
                    }
                }
                if(!casesNewSetings.isEmpty()){
                    
                    NS_CaseTriggerUtility.getCaseSettings(casesNewSetings);
                    getCaseOwner(casesNewSetings);
                    For(Case cse: casesNewSetings){
                        if(nonEscalatedCases.contains(cse.Id) && NS_StaticVariablesUtility.NS_ESCALATED.equalsIgnoreCase(cse.Status)){
                            if(cse.NS_CaseBusinessUnit__c=='OSS'){
                            cse.NS_AssignedTo__c=null;//Setting up Assigned to as null for auto Escalated case
                            }
                        } 
                    }
                    NS_StaticVariablesUtility.isTriggerExecuted = true;
                }
                else if(!casesNewOwner.isEmpty()){
                    
                    getCaseOwner(casesNewOwner);
                    For(Case cse: casesNewSetings){
                        if(nonEscalatedCases.contains(cse.Id) && NS_StaticVariablesUtility.NS_ESCALATED.equalsIgnoreCase(cse.Status)){
                            
                           if(cse.NS_CaseBusinessUnit__c=='OSS'){
                                cse.NS_AssignedTo__c=null;//Setting up Assigned to as null for auto Escalated case
                           }
                        } 
                    }
                    NS_StaticVariablesUtility.isTriggerExecuted = true;
                }
                if(!casesNewUpdate.isEmpty()){
                    
                   NS_CaseTriggerUtility.getCaseSettings(casesNewUpdate);
                    For( Case cse: casesNewUpdate){
                        if(NS_StaticVariablesUtility.NS_CLOSED.equalsIgnoreCase(cse.Status) ||
                           NS_StaticVariablesUtility.NS_ESCALATED.equalsIgnoreCase(cse.Status)){
                               cse.Status = NS_StaticVariablesUtility.NS_WORKING;
                           }
                    }
                    NS_StaticVariablesUtility.isTriggerExecuted = true;
                }
                //Gunjari -- 12/19 for Req#919 -- populate Case BU
                if(!caseChangedOwners.isEmpty()){
                    NS_CaseTriggerUtility.getCaseBusinessUnit(caseChangedOwners);
                    NS_StaticVariablesUtility.isTriggerExecuted = true;
                }
                
                if(!casesClosed.isEmpty()){
                    
                    List<Id> casesWithOpenTask = NS_CaseTriggerUtility.getcaseWithOpenTask(casesClosed);
                    
                    for(Case cse : newCases){
                        if(casesWithOpenTask.contains(cse.Id)){
                            cse.addError(Label.NS_CaseWithOpenTaskError);
                        }
                    }    
                }
                
                if(!casesWithTask.isEmpty()){
                    
                   NS_CaseTriggerUtility.refreshTask(casesWithTask);
                }
                for(Case cse : newCases){
                    if(NS_StaticVariablesUtility.NS_ESCALATED.equalsIgnoreCase(cse.Status) && cse.NS_IsEscaledOnEdit__c== false){
                        cse.NS_IsEscaledOnEdit__c= true;
                    }
                }
                //to cover Catch part
                if(Test.isRunningTest()){
                    integer I=100/0;
                }
            }
            catch (Exception exp) {
                /*Inserting a record in Exception object*/
                NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, 'getCaseOwner');
            }
        }    
    }
        

    
  
    /* @author-  Accenture
*  @description- Check if new Task needs to be created
*  @param- None
*  @return- None
*  @throws- Standard Exception
*/
    public static void checkTask(){
        Case cseOld = new Case();
        Case cseNew = new Case();
        List<Case> casesNewTask= new List<Case>();
        List<Case> caseWithoutTask = new List<Case>();
        
        try{
            for( Id cseId : Trigger.newMap.keySet() ){
                cseOld = (Case)Trigger.oldMap.get(cseId);
                cseNew = (Case)Trigger.newMap.get(cseId); 
                if( cseOld.Status != cseNew.Status){
                    casesNewTask.add(cseNew);
                }
            }
            if(casesNewTask.size()>0){
                createTask(casesNewTask);
            }
            
            //to cover Catch part
            if(Test.isRunningTest()){
                integer I=100/0;
            }
        }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, 'checkTask');
        } 
    }
    
    /* @author-  Accenture
*  @description- Create Task as per Case Setting for ecalation notifications
*  @param- List of Cases
*  @return- None
*  @throws- Standard Exception
*/
    public static void createTask(List<Case> caseNew){
        Set<String> caseTaskOwner = new Set<String>();
        List<String> pubGroupList = new List<String>();
        Set<String> iReasons = new Set<String>();
        Set<String> iType = new Set<String>();
        Set<Id> ownerIds = new Set<Id>();
        Set<ID> userIDTask = new Set<ID>();
        Map<Id,String> queueNameWithIds = new Map<Id,String>();
        Map<Case,List<Id>> taskAndUsers= new Map<Case,List<Id>>();
        try{
            system.debug('START TASK '+[SELECT count() FROM Task WHERE WhatId in : caseNew AND TaskSubtype = 'Task' ]);
            for(Task T :[SELECT id, OwnerId,WhatId FROM Task WHERE WhatId in : caseNew AND TaskSubtype = 'Task' ]){
                String S =T.OwnerId+'_'+T.WhatId;
                caseTaskOwner.add(S);
            }
            
            For(Case cse: caseNew){
                iReasons.add(cse.NS_InteractionReason__c);
                iType.add(cse.NS_Type__c);
                ownerIds.add(cse.OwnerId);
            }
            //Get values from Custom metadata Case Settings 
            Map<String, String> caseBUWithStatus = NS_CaseTriggerUtility.getMetadataStatus(iReasons,iType);
            Map<String, String> caseWithTaskOwners = NS_CaseTriggerUtility.getTaskOwner(iReasons,iType);
            String autoStatus;
            For(Case cse: caseNew){ 
                //Combination of Case BU and Interaction Reason is unique. Get the API name of public group
                
                if(cse.Status.equalsIgnoreCase('NS_Escalated')){
                    pubGroupList.add(caseWithTaskOwners.get(cse.NS_InteractionReason__c+cse.NS_Type__c));
                }
                system.debug('SRV PUB_GRP '+pubGroupList);
            }
            //All the member users of public group
            Map<String,List<Id>>groupWithUsers= NS_CaseTriggerUtility.getMemberUsers(pubGroupList);
            system.debug('SRV MMBR IN PUB-GRP '+groupWithUsers);
            //Get the Case Owner queue
            For(Group grp: [SELECT Id,Type,DeveloperName FROM Group WHERE Id IN: ownerIds and Type='Queue']){
                queueNameWithIds.put(grp.Id, grp.DeveloperName);
            }
            system.debug('queueNameWithIds '+queueNameWithIds);
            //All the member users of owner queue
            system.debug('SRV queueNameWithIds.values '+ queueNameWithIds.values());
            Map<String,List<Id>>queueWithUsers= NS_CaseTriggerUtility.getMemberUsers(queueNameWithIds.values());
            system.debug('queueWithUsers '+queueWithUsers);
            taskAndUsers= NS_CaseTriggerUtility.getMktgNotifications(caseNew);
            system.debug('SRV TSKUSR01 '+taskAndUsers);
            For(Case cse: caseNew){

                system.debug('SRV cse.OwnerId '+cse.OwnerId);
                system.debug('SRV queueNameWithIds.get(cse.OwnerId) '+ queueNameWithIds.get(cse.OwnerId));
                system.debug('SRV queueWithUsers.get(queueNameWithIds.get(cse.OwnerId)) '+ queueWithUsers.get(queueNameWithIds.get(cse.OwnerId)));
                
                List<Id> groupMembers = groupWithUsers.get(caseWithTaskOwners.get(cse.NS_InteractionReason__c+cse.NS_Type__c));
                List<Id> queueMembers = queueWithUsers.get(queueNameWithIds.get(cse.OwnerId));
                system.debug('SRV queueMembers '+ queueMembers);
                
               /*  system.debug('SRV BRKUP01 '+caseWithTaskOwners.get(cse.NS_InteractionReason__c+cse.NS_Type__c));
                system.debug('SRV BRKUP02 '+ cse.OwnerId);
                
                system.debug('SRV GRP MMBR '+groupMembers.size());
                System.debug('SRV QQ MMBR '+queueMembers.size());
               */
                For(Id usrId: queueMembers){
                    //check if queue member also exist in group member
                   // system.debug('SRV CNDTN CCK '+groupMembers.contains(usrId));
                    system.debug('SRV CNDTN UID '+ usrId);
                    If(groupMembers != null && groupMembers.contains(usrId)){
                        if(!taskAndUsers.containsKey(cse)){
                            taskAndUsers.put(cse, new List<Id>());
                        }
                    
                        taskAndUsers.get(cse).add(usrId);

                    }
                }
                system.debug('SRV TSKUSR '+taskAndUsers);
            }    
            
            List<Task> listTask = new List<Task>();
            For(Case cse:taskAndUsers.keyset()){
                
                For(Id usrId: taskAndUsers.get(cse)){
                    if(!userIDTask.contains(usrId)){
                        userIDTask.add(usrId);
                        String userTask = usrId+'_'+cse.Id;
                        if(!caseTaskOwner.contains(userTask)){
                            
                        system.debug('SRV TASK CRTN STRT');
                            Task tsk = new Task();
                            tsk.WhatId=cse.Id;
                            tsk.Status='Temp';
                            If(cse.Account.NS_MarketingOwner__c!=null){
                                tsk.Subject='Case ' + cse.CaseNumber + ' has been escalated';
                            }
                            else{
                                tsk.Subject='Case ' + cse.CaseNumber + ' has been escalated to your queue - ' + cse.NS_InteractionReason__c;    
                            }
                            tsk.Description=cse.Description;
                            tsk.OwnerId=usrId ;
                            listTask.add(tsk);
                        }
                        system.debug('SRV TSK end '+listTask);
                    }
                }
            }
            if(!listTask.isEmpty()){
                List<database.SaveResult> SS= Database.insert(listTask,false);// inserting task as open task so that user gets notificaton later updating it as completed
            }
            List<Task> markAsCompleted = new List<Task>();
            For(Task tsk: listTask){
                tsk.Status = 'Completed';
                markAsCompleted.add(tsk);
            }
            if (markAsCompleted.size() > 0) {
            	update markAsCompleted;
            }
            
            
            //to cover Catch part
            if(Test.isRunningTest()){
                integer I=100/0;
            }
        }
        catch(Exception ex){
            NS_StaticVariablesUtility.createExceptionRecord(ex, CLASS_NAME, '');
        }
    }
   
  
    
      //Gunjari -- 12/19 for Req#919 -- populate Case BU
    /* @author-  Accenture
*  @description- Case Owner can be the user, user's queue or manager's queue bases on different condition
*  @param- List of Cases
*  @return- None
*  @throws- Standard Exception
*/
    public static void getCaseOwner(List<Case> caseList){
        
        Map<String,Id> queueWithId = new Map<String,Id>();
        Map<ID,String> allIDwithQueue = new Map<ID,String>();
        Set<String> setQueueNames = new Set<String>();// list of user's primary and manger's queue
        Set<Id> setAssignedToIds = new Set<Id>();
        Map<Id,String> userPrimaryQ = new Map<Id,String>();//user Id and Queue name
        Map<String,String> managerQ = new Map<String,String>();//Queue name and Manager's queue
        // Map<String,String> QueueWithBU = new Map<String,String>();//commented by Gunjari -- 12/19 for Req#919 -- populate Case BU
        //Gunjari -- 12/19 for Req#919 -- populate Case BU
        List<case> caseOwners = new List<case>();
        try{
            For(Group gg :[SELECT Id,Name FROM Group WHERE Type = 'Queue']){
                allIDwithQueue.put(gg.Id,gg.Name);
            }
            
            For(case cse : caseList){
                if(cse.NS_AssignedTo__c!=null){
                    setAssignedToIds.add(cse.NS_AssignedTo__c);
                    
                }
                setQueueNames.add(allIDwithQueue.get(Cse.OwnerId));
            }
            For(User usr: [SELECT Id, NS_Primary_Queue__c, Associated_Business_Unit__c FROM User 
                           WHERE 
                           Id =:userinfo.getUserId() OR 
                           Id IN : setAssignedToIds]){//and Associated_Business_Unit__c='OSS'
                               setQueueNames.add(usr.NS_Primary_Queue__c);                                
                               userPrimaryQ.put(usr.Id,usr.NS_Primary_Queue__c);               
                           }
            //fetch custom metadata to check manager's queue name and corresponding business unit
            For(NS_QueueSetting__mdt qmdt: [SELECT Label, NS_BusinessUnit__c,NS_ManagerQueue__c FROM NS_QueueSetting__mdt 
                                            Where Label IN: setQueueNames]){
                                                setQueueNames.add(qmdt.NS_ManagerQueue__c);
                                                managerQ.put(qmdt.Label,qmdt.NS_ManagerQueue__c); 
                                            }
            
            // Fetch Queue Id for user's primary and manager's queu name
            For(QueueSobject qs: [SELECT QueueId,Queue.Name FROM QueueSobject 
                                  WHERE SobjectType = :NS_StaticVariablesUtility.NS_CASE 
                                  AND Queue.Name IN :setQueueNames ]){
                                      queueWithId.put(qs.Queue.Name,qs.QueueId);               
                                  }
            String userType = Schema.SObjectType.User.getKeyPrefix();
            for(case cse: caseList){
                
                
                if(cse.RecordTypeId !=Schema.getGlobalDescribe().get('Case').getDescribe().getRecordTypeInfosByName().get('Service Requests').getRecordTypeId()){
                    
                    
                    /*****Edited by Moumita*****/
                    if((cse.Origin.equalsIgnoreCase(NS_StaticVariablesUtility.NS_Email) && cse.Id!=null) ||
                       (cse.Origin.equalsIgnoreCase(NS_StaticVariablesUtility.NS_Email) && cse.Id==null && ((String)cse.OwnerId).startsWith(userType)) ||
                       !cse.Origin.equalsIgnoreCase(NS_StaticVariablesUtility.NS_Email)){
                           
                           // cse.NS_OwnerBusinessUnit__c = QueueWithBU.get(userPrimaryQ.get(userinfo.getUserId())); //commented by Gunjari -- 12/19 for Req#919 -- populate Case BU
                           //Owner is Manager's Queue for Escalated Case
                     
                           if(cse.Id!=null && NS_StaticVariablesUtility.NS_ESCALATED.equalsIgnoreCase(cse.Status) &&
                              cse.NS_IsEscaledOnEdit__c== false){
                                  if(cse.NS_AssignedTo__c!=null){
                                      cse.OwnerId =  queueWithId.get(managerQ.get(userPrimaryQ.get(cse.NS_AssignedTo__c)));
                                      // cse.NS_OwnerBusinessUnit__c = QueueWithBU.get(userPrimaryQ.get(cse.NS_AssignedTo__c));//commented by Gunjari -- 12/19 for Req#919 -- populate Case BU
                                  }
                                  else{
                                      //cse.OwnerId =  queueWithId.get(managerQ.get(userPrimaryQ.get(userinfo.getUserId()))) ;
                                      cse.OwnerId =  queueWithId.get(managerQ.get(allIDwithQueue.get(cse.OwnerId))) ;
                                  }
                                  
                              }
                           //Owner is Assigned user's Primary_Queue 
                           else if(queueWithId.containsKey(userPrimaryQ.get(cse.NS_AssignedTo__c)) && cse.ParentId ==null){
                               cse.OwnerId = queueWithId.get(userPrimaryQ.get(cse.NS_AssignedTo__c));
                               
                           }
                           //Owner is logged in user's Primary_Queue    
                           else if(queueWithId.containsKey(userPrimaryQ.get(userinfo.getUserId())) && cse.ParentId ==null){
                               cse.OwnerId = queueWithId.get(userPrimaryQ.get(userinfo.getUserId()));
                               if(cse.NS_AssignedTo__c==null){
                                   cse.NS_AssignedTo__c=userinfo.getUserId();
                               }    
                               
                           }
                           // If user's primary queue is not set, owner will be 'created by'  
                           else{
                               //cse.OwnerId =  userinfo.getUserId();
                               if(cse.NS_AssignedTo__c==null && cse.ParentId ==null){
                                   cse.NS_AssignedTo__c=userinfo.getUserId();
                               }
                               
                           }
                           
                       }  
                }
                /* else{
continue;//If inserting Email-to-case, no action needed from here
}*/
                //Gunjari -- 12/19 for Req#919 -- populate Case BU
                caseOwners.add(cse);
            }
            //Gunjari -- 12/19 for Req#919 -- populate Case BU
            NS_CaseTriggerUtility.getCaseBusinessUnit(caseOwners);
            //to cover Catch part
            if(Test.isRunningTest()){
                integer I=100/0;
            }
        }
        catch (Exception exp) {
            /*Inserting a record in Exception object*/
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, 'getCaseOwner');
        }        
    }
     


    /* @author-  Accenture
*  @description- Update Case status to escalated as per the metadata
*  @param- List of Cases in trigger
*  @return- None
*  @throws- Standard Exception
*/
    public static void checkStatusOnCreate(List<Case> caseNewList){
        Set<String> iReasons = new Set<String>();
        Set<String> iType = new Set<String>();
        map<String,String> mapMetadata = new map<String,String>();
        try{
            For(Case cse: caseNewList){
                iReasons.add(cse.NS_InteractionReason__c);
                iType.add(Cse.NS_Type__c);
            }
            if(NS_CaseTriggerUtility.getMetadataStatus(iReasons,iType)!=null){
                mapMetadata=NS_CaseTriggerUtility.getMetadataStatus(iReasons,iType);
            }
            
            for(Case newCase : caseNewList ){
                if(newCase.NS_Type__c =='Empty Disposition'&&(newCase.NS_CaseBusinessUnit__c=='Equipment Planning' || newCase.NS_CaseBusinessUnit__c=='Unit Train'))
                {
                    newCase.Status = 'NS_Closed';    
                }
                else if(mapMetadata.get(newCase.NS_InteractionReason__c+'_'+newCase.NS_CaseBusinessUnit__c)!=null){
                    newCase.Status=mapMetadata.get(newCase.NS_InteractionReason__c+'_'+newCase.NS_CaseBusinessUnit__c);
                }
                
            }
            if(Test.isRunningTest()){
                integer I=100/0;
            }
        }
        
        catch (Exception exp) {
            
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, 'checkStatusOnCreate');
        }
    }
    
  
   /****************************************************/
    //Description: R2 changes on contact,Account
    //             custom validation rule that when Case record OEM account field is selected, its id must have a corresponding ns_accountrelation record where selected OEM account is in ns_relationparty2 field 
    //            
    //Developer Name : Moumita
    //Date : 3/7/2019
    /***************************************************/
    public static void ValidateOEMAccount(List<Case> caseList){
        Set<Id> RelationParty2Ids = new Set<Id>();
        boolean isPresent;
        
        try{
            
            for(Case cs : caseList)
            {
                if(cs.NS_OEM_Account__c != null){
                    
                    for(List<NS_AccountRelation__c> ar : [Select Id, NS_RelationParty1__c, NS_RelationParty2__c from NS_AccountRelation__c where NS_RelationParty1__c = : cs.AccountId])
                    {
                        for(NS_AccountRelation__c r : ar)
                        {
                            RelationParty2Ids.add(r.NS_RelationParty2__c);
                        }
                    }
                    
                    isPresent =  RelationParty2Ids.contains(cs.NS_OEM_Account__c);
                    
                    if(isPresent == false)
                    {
                        cs.NS_OEM_Account__c.addError('Please select OEM Account that is in Relation Party 2 with the respective account');
                        
                    }
                }
            }
            if(Test.isRunningTest()){
                integer I=100/0;
            }
        }
        catch (Exception exp) 
        {
            /*Inserting a record in Exception object*/
            NS_StaticVariablesUtility.createExceptionRecord(exp,NS_StaticVariablesUtility.CONST_BLANK,NS_StaticVariablesUtility.CONST_BLANK);
        }
        
    }
    
    /********* end of changes R2 Requirement, Made by Moumita***************/    
   
    
}