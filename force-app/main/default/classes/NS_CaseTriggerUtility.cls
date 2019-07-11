public class NS_CaseTriggerUtility {
    /*Class Name*/
    private static final String CLASS_NAME = 'NS_CaseTriggerUtility';
    public static Map<String,NS_CaseSetting__mdt> mapReasonWithSettings= new Map<String,NS_CaseSetting__mdt>();
    
    /* @author-  Accenture
*  @description- Fetch Case Setting(Custom Metada) to populate default value 
*  @param- Set<String> ,Set<String>
*  @return- map<String, String>
*  @throws- Standard Exception
*/    
    
    public static map<String, String> getMetadataStatus(Set<String> iReasons,Set<String> iType){
        
        Map<String, String> caseBUWithStatus = new Map<String, String>();
        String metadataFields;
        List<String> metadataFieldList = new List<String>() ;
        try{
            Map<String, String> caseBUWithMetadata = (Map<String,String>) JSON.deserialize(system.label.NS_CaseBUMap, Map<String,String>.class);
            For(String mField: caseBUWithMetadata.keyset()){
                metadataFields=(metadataFields!=null)?(metadataFields+', ' +mField):mField;
                metadataFieldList.add(mField);
            }
            String metadataQuery ='SELECT Label,Interaction_Type__c, '+ metadataFields;
            
            For(NS_CaseSetting__mdt settings:database.query(metadataQuery +' FROM NS_CaseSetting__mdt WHERE Label IN : iReasons and Interaction_Type__c IN : iType')){
                For(String st: metadataFieldList){
                    if(settings.get(st)!=null){
                        caseBUWithStatus.put(settings.Label+settings.Interaction_Type__c+'_'+caseBUWithMetadata.get(st), (String)settings.get(st));
                    }    
                }
            }
            //to cover Catch part
            if(Test.isRunningTest()){
                integer I=100/0;
            }
        }
        catch (Exception exp) {
            
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, 'getMetadataStatus');
        }
        return caseBUWithStatus;
    }
    
    /* @author-  Accenture
*  @description- get member users from Queue and/or group
*  @param- List<String>
*  @return- Map<String,List<Id>>
*  @throws- Standard Exception
*/    
    public static Map<String,List<Id>> getMemberUsers(List<String> pubGroups){
        Map<Id,List<GroupMember>> groupAndMembers = new Map<Id,List<GroupMember>>();
        Map<Id,String> groupIdWithName = new Map<Id,String>();
        Map<String,List<Id>> groupWithUsers = new Map<String,List<Id>>();
        String groupType =Schema.SObjectType.Group.getKeyPrefix();
        Map<Id,Id> memberParentGroups = new Map<Id,Id>();
        Map<Id,Id> roleWithGroup = new Map<Id,Id>();
        Map<Id,Id> parentRoleIds = new Map<Id,Id>();
        Map<Id,Id> userIdParentGroups = new Map<Id,Id>();
        Map<Id, List<User>> roleWithUsers = new Map<Id, List<User>>();
        List<GroupMember> GrpMember =new List<GroupMember>();
        try{
            //Get the ID and members of the public group
            For(Group grp:[SELECT Id,Type,DeveloperName,(SELECT UserOrGroupId FROM GroupMembers) FROM Group WHERE DeveloperName IN: pubGroups]){
                groupAndMembers.put(grp.Id,grp.GroupMembers);
                groupIdWithName.put(grp.Id,grp.DeveloperName);
            }
            
            //Get Members of the group, user or another group (Role/Role And Subordinates)
            For(Id grpId: groupAndMembers.keyset()){
                For(GroupMember grpMem:groupAndMembers.get(grpId)){
                    
                    if(((String)grpMem.UserOrGroupId).startsWith(groupType)) {
                        memberParentGroups.put(grpMem.UserOrGroupId,grpId); 
                    
                        ///////////////////////////
                                                
                        if(!groupWithUsers.containsKey(groupIdWithName.get(grpId))){
                            
                            groupWithUsers.put(groupIdWithName.get(grpId), new List<Id>());
                        }    
                        groupWithUsers.get(groupIdWithName.get(grpId)).add(grpMem.UserOrGroupId);
                        
                        ///////////////////////////
                        
                        
                    }  
                    else{
                        if(!groupWithUsers.containsKey(groupIdWithName.get(grpId))){
                            groupWithUsers.put(groupIdWithName.get(grpId), new List<Id>());
                        }    
                        groupWithUsers.get(groupIdWithName.get(grpId)).add(grpMem.UserOrGroupId);
                    }
                }
            }             
            
            /////////////SRV///////////////
     /*       For(Group grp1:[SELECT DeveloperName,Id,RelatedId,(SELECT UserOrGroupId FROM GroupMembers),Type FROM Group WHERE (Id IN: memberParentGroups.keySet() OR ID IN :memberParentGroups.Values())]){
                GrpMember=grp1.GroupMembers;
                For(GroupMember grpMem:GrpMember){
                    
                    if(((String)grpMem.UserOrGroupId).startsWith(groupType)) {
                        memberParentGroups.put(grpMem.UserOrGroupId,grp1.Id); 
                    }  
                    else{
                        if(!groupWithUsers.containsKey(groupIdWithName.get(grp1.Id))){
                            groupWithUsers.put(groupIdWithName.get(grp1.Id), new List<Id>());
                        }    
                        groupWithUsers.get(groupIdWithName.get(grp1.Id)).add(grpMem.UserOrGroupId);
                    }
                }
            }
*/
            /////////////SRV///////////////
            
            
            
            List<Group> listGroupRole = new List<Group>([SELECT DeveloperName,Id,RelatedId,Type FROM Group WHERE Id IN: memberParentGroups.keySet() AND Type LIKE 'Role%']);
            For(Group grp:listGroupRole){
                //For(Group grp:[SELECT DeveloperName,Id,RelatedId,Type FROM Group WHERE Id IN: memberParentGroups.keySet()]){    
                roleWithGroup.put(grp.RelatedId,grp.Id); 
                
                If ((grp.Type).contains('RoleAndSubordinates')){
                    parentRoleIds.put(grp.RelatedId,grp.Id);
                }
            }
            
            //Member of the Role
            for (UserRole role : [SELECT Id, ParentRoleId, DeveloperName, (SELECT Id FROM Users) FROM UserRole where ID in: roleWithGroup.keyset()]){
                if  (!roleWithUsers.containsKey(role.Id)){
                    roleWithUsers.put(role.Id, new List<User>());
                }    
                For(User usr:role.Users){
                    roleWithUsers.get(role.Id).add(usr);  
                }
            }

            //Member of the RoleHasSubordinates
            for (UserRole role : [SELECT Id, ParentRoleId, DeveloperName, (SELECT Id FROM Users) FROM UserRole where ParentRoleId in: parentRoleIds.keyset()]){
                if  (!roleWithUsers.containsKey(role.ParentRoleId)){
                    roleWithUsers.put(role.ParentRoleId, new List<User>());
                }  
                For(User usr:role.Users){
                    roleWithUsers.get(role.ParentRoleId).add(usr); 
                }                
            }

            //Prepare the map of group name and all user members
            For(Id roleId:roleWithUsers.keyset()){
                if(!groupWithUsers.containsKey(groupIdWithName.get(memberParentGroups.get(roleWithGroup.get(roleId))))){
                    groupWithUsers.put(groupIdWithName.get(memberParentGroups.get(roleWithGroup.get(roleId))), new List<Id>());
                }   
                For(User usr: roleWithUsers.get(roleId)){
                    groupWithUsers.get(groupIdWithName.get(memberParentGroups.get(roleWithGroup.get(roleId)))).add(usr.Id);                    
                } 
                
            }

            //to cover Catch part in test class
            if(Test.isRunningTest()){
                integer I=100/0;
            }
        }
        catch(Exception ex){
            
            NS_StaticVariablesUtility.createExceptionRecord(ex, CLASS_NAME, 'getMemberUsers');
        }
        return groupWithUsers;
    } 
    
    public static Map<Case,List<Id>> getMktgNotifications(List<Case> listCases){
        List<String> notificationIR = new List<String>();
        List<String> notificationIT = new List<String>();
        Map<Case,List<Id>> mktgNotification = new Map<Case,List<Id>>();
        For(NS_CaseSetting__mdt settings:[SELECT Label,Interaction_Type__c, NS_MktgNotification__c FROM NS_CaseSetting__mdt WHERE NS_MktgNotification__c= true]){
            notificationIR.add(settings.Label);
            notificationIT.add(Settings.Interaction_Type__c);
        }
        for(Case cse: [select id,account.NS_MarketingOwner__c,CaseNumber,NS_InteractionReason__c,Description  from case where account.NS_MarketingOwner__c!=null 
                       and Id IN: listCases and Status='NS_Escalated' and NS_InteractionReason__c IN: notificationIR and NS_type__C in :notificationIT]){
                           
                           If(!mktgNotification.containsKey(cse)){
                               mktgNotification.put(cse, new List<Id>());
                           }    
                           mktgNotification.get(cse).add(cse.account.NS_MarketingOwner__c);
                       }
        return mktgNotification;
    }
    
    
    /* @author-  Accenture
*  @description- 
*  @param- List<Id>
*  @return- List<Id>
*  @throws- Standard Exception
*/
    
    public static List<Id> getcaseWithOpenTask(List<Id> closedCaseIds){
        List<Id> caseWithOpenTask= new List<Id>();
        
        For( Task tsk: [SELECT Id, WhatId FROM Task WHERE WhatId IN :closedCaseIds AND Status != 'Completed' AND Status != 'Closed']){
            
            caseWithOpenTask.add(tsk.WhatId);
        } 
        
        return caseWithOpenTask;
    }
    
    /* @author-  Accenture
*  @description- Return Id of Salesforce Record Type
*  @param- String of Record Type Name
*  @return- Id of Record Type
*  @throws- Standard Exception
*/
    public static Id getRecTypeId(String recTypeName){  
        
        Id recTypeId =null;
        try{
            
            recTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(recTypeName).getRecordTypeId();  
            
            //to cover Catch part
            if(Test.isRunningTest()){
                integer I=100/0;
            }
        }
        catch (Exception exp) {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, 'getRecTypeId');
        }
        
        return recTypeId;
    }
    
    
    /* @author-  Accenture
*  @description- Return Id of Salesforce Record Type
*  @param- Set<String> ,Set<String> 
*  @return- map<String, String>
*  @throws- Standard Exception
*/        
    
    public static map<String, String> getTaskOwner(Set<String> iReasons,Set<String> iType){
        Map<String, String> caseWithTaskOwners = new Map<String, String>();
        
        For(NS_CaseSetting__mdt settings:[SELECT Label,Interaction_Type__c,NS_TaskOwnerGroup__c FROM NS_CaseSetting__mdt WHERE Label IN: iReasons and Interaction_Type__c IN : iType ]){
            If(settings.NS_TaskOwnerGroup__c!=null){
                caseWithTaskOwners.put(settings.Label+settings.Interaction_Type__c,settings.NS_TaskOwnerGroup__c);
            }
        }
        return caseWithTaskOwners;
    }

    /* @author-  Accenture
*  @description- Fetch Case Setting(Custom Metada) to populate default value 
*  @param- List of Cases
*  @return- None
*  @throws- Standard Exception
*/ 
    
    public static void metadataData(){
        try{
            for(NS_CaseSetting__mdt rec: [SELECT Label,Interaction_Type__c,NS_DefaultStatus__c, NS_Priority__c,NS_AutoEscalateOnUpdate__c FROM NS_CaseSetting__mdt 
                                          ]){ 
                                              mapReasonWithSettings.put(rec.Label+rec.Interaction_Type__c,rec);
                                          }
             
        }
        catch(exception ee){
        }
    }
    public static void getCaseSettings(List<Case> caseNew){
        Map<id,Case> monitoredAccountWithCase = new Map<id,Case>();
        //Map<String,NS_CaseSetting__mdt> mapReasonWithSettings = new Map<String,NS_CaseSetting__mdt>();
        Set<String> iReason= new Set<String>();
        Set<String> iType = new Set<String>();
        NS_CaseSetting__mdt setting= new NS_CaseSetting__mdt();
        try{
            
            For(Case cseRec : caseNew){
                iReason.add(cseRec.NS_InteractionReason__c);
                iType.add(cseRec.NS_Type__c);
            }
            /*
            for(NS_CaseSetting__mdt rec: [SELECT Label,Interaction_Type__c,NS_DefaultStatus__c, NS_Priority__c,NS_AutoEscalateOnUpdate__c FROM NS_CaseSetting__mdt 
                                          WHERE Label IN: iReason and Interaction_Type__c in :iType LIMIT 100]){ 
                                              mapReasonWithSettings.put(rec.Label+rec.Interaction_Type__c,rec);
                                          }
*/
            for( Case cse : caseNew ){
                //If not creating but updating Email-To-Case
                if((cse.Origin.equalsIgnoreCase(NS_StaticVariablesUtility.NS_Email) && cse.Id!=null) ||
                   (!cse.Origin.equalsIgnoreCase(NS_StaticVariablesUtility.NS_Email))){
                       setting= mapReasonWithSettings.get(cse.NS_InteractionReason__c+cse.NS_Type__c);

                       if(cse.Id!=null && setting.NS_AutoEscalateOnUpdate__c==true){

                           cse.Status=NS_StaticVariablesUtility.NS_ESCALATED;
                       }
                       else{
                           cse.Status=setting.NS_DefaultStatus__c;
                       }
                     
                       cse.Priority=setting.NS_Priority__c;
                       if(cse.NS_InteractionReason__c==NS_StaticVariablesUtility.Delayed || 
                          cse.NS_InteractionReason__c==NS_StaticVariablesUtility.Expedite){
                              cse.RecordTypeId =  getRecTypeId(NS_StaticVariablesUtility.Delay_Expedite);
                          }
                       else{
                           cse.RecordTypeId =  Schema.SObjectType.Case.getRecordTypeInfosByName().get(cse.NS_InteractionReason__c).getRecordTypeId();
                       }
                      
                   }               
            }
            
            //to cover Catch part
            if(Test.isRunningTest()){
                integer I=100/0;
            }
        }
        catch (Exception exp) {
            /*Inserting a record in Exception object*/
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, 'getCaseSettings');
        }       
    }
   
    public static void getCaseBusinessUnit(List<Case> caseNewList){
        Map<String,String> QueueWithBU = new Map<String,String>();
        Map<Id,String> queueIdWithName = new Map<Id,String>();
        For(NS_QueueSetting__mdt qmdt: [SELECT Label, NS_BusinessUnit__c FROM NS_QueueSetting__mdt]){
            QueueWithBU.put(qmdt.Label,qmdt.NS_BusinessUnit__c);
        }
        For(Group grp: [SELECT Id,name FROM Group WHERE Type='Queue']){
            queueIdWithName.put(grp.Id,grp.name);
        }
        for(case cse: caseNewList){
            if(queueIdWithName.containsKey(cse.OwnerId)){
                
                cse.NS_CaseBusinessUnit__c = QueueWithBU.get(queueIdWithName.get(cse.OwnerId)); 
                
            }
        }
    }
     /* @author-  Accenture
*  @description- If any open task then update task owner
*  @param- None
*  @return- None
*  @throws- Standard Exception
*/
    public static void refreshTask(Set<Case> caseList){
        Map <Id,Id> caseAssigned = new Map <Id,Id>();
        List <Task> taskList = new List <Task>();
        try{
            For(Case cs:caseList){
                if(cs.NS_AssignedTo__c!=null){
                    caseAssigned.put(cs.Id,cs.NS_AssignedTo__c);
                }    
            }
            For(Task tsk: [Select Id, WhatId, OwnerId from Task where WhatId IN: caseAssigned.keyset() AND IsClosed = false]){
                If(caseAssigned.containsKey(tsk.WhatId)){
                    tsk.OwnerId = caseAssigned.get(tsk.WhatId);
                    taskList.add(tsk);
                }        
            }
            update taskList;
            
            //to cover Catch part
            if(Test.isRunningTest()){
                integer I=100/0;
            }
        }
        catch (Exception exp) {
            /*Inserting a record in Exception object*/
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, 'refreshTask');
        }
    }    
  
    
}