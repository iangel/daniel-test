public class clsTimeSpentOnStatus{

    public static Boolean IsBefore=false;
    public static Boolean IsUpdate=false;
    public static Boolean IsInsert=false;
   // public static map<Id, Request__c> RequestOldMap=new map<Id, Request__c>();
   // public static map<Id, Request__c> RequestNewMap=new map<Id, Request__c>();
    //public static Request__c[] RequestNew=new list<Request__c>();
              
    public static void fnBeforeInsertTimeSpentOnStatus(List<Request__c> RequestNew){
    try{system.debug('>>>>Hi<<<<');
        for(Request__c req : RequestNew){ 
            system.debug('>>>>Hi2=<<<<');
            if(req.Status__c == 'Identify: New Requirement'){
                system.debug('>>>>Hi2<<<<');
                req.StartTime_Identify_New_Requirement__c = System.Now();
                system.debug('>>>>Hi3<<<<'+ req.StartTime_Identify_New_Requirement__c);
                
                
            } 
            if(req.Status__c == 'Identify: On-Hold Waiting on Client'){
                req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();   
            } 
            if(req.Status__c == 'Identify: Submit for Business Review'){
                req.StartTime_Identify_Submit_for_Business__c = System.Now();   
            } 
            if(req.Status__c == 'Identify: Emergency Request'){
                req.StartTime_Emergency_Request__c = System.Now();   
            }
            if(req.Status__c == 'Identify: Deferred'){
                req.StartTime_Deferred__c = System.Now();   
            } 
            if(req.Status__c == 'Consolidate: Approve to Estimate'){
                req.StartTime_Approve_to_Estimate__c = System.Now();   
            } 
            if(req.Status__c == 'Consolidate: Level of Effort Complete'){
                req.StartTime_Level_of_Effort_Complete__c = System.Now();   
            } 
            if(req.Status__c == 'Approve: Approved to Deploy'){
                req.StartTime_Approved_to_Deploy__c = System.Now();   
            } 
            if(req.Status__c == 'Release: Design'){
                req.StartTime_Design__c = System.Now();   
            } 
            if(req.Status__c == 'Release: Build'){
                req.StartTime_Build__c = System.Now();   
            } 
            if(req.Status__c == 'Release: Test'){
                req.StartTime_Test__c = System.Now();   
            }
            if(req.Status__c == 'Release: SIT'){
                req.StartTime_SIT__c = System.Now();   
            } 
            if(req.Status__c == 'Release: UAT'){
                req.StartTime_UAT__c = System.Now();   
            } 
            if(req.Status__c == 'Release: Build Production'){
                req.StartTime_Build_Production__c = System.Now();   
            } 
            if(req.Status__c == 'Release: Test Production'){
                req.StartTime_Test_Production__c = System.Now();   
            } 
            if(req.Status__c == 'Close: Deployed'){
                req.StartTime_Deployed__c = System.Now();   
            } 
            if(req.Status__c == 'Close: Rejected'){
                req.StartTime_Rejected__c = System.Now();   
            }
                    if(req.Status__c == 'Identify: On-Hold Waiting on Client'){
                req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();   
            }
            if(req.Status__c == 'Close: Duplicate'){
                req.StartTime_Duplicate__c = System.Now(); 
                system.debug('>>>>Hello<<<<');                
            }          
        } 
    }catch (Exception e){
        system.debug('The following error has occurred:'+e.getMessage());
       
        
        
        
        }
    }

    public static void fnBeforeUpdateTimeSpentOnStatus(List<Request__c> RequestNew,List<Request__c> Requestold , map<Id, Request__c> RequestNewMap, map<Id, Request__c> RequestOldMap){ 
            
    try{ 
        system.debug('>>>>Hell<<<<');   
        for(Request__c req:RequestNew){
            system.debug('>>>>Hell<<<<');  
            if(RequestOldMap.get(req.Id).Status__c == 'Identify: New Requirement'){
                system.debug('>>>>Hell<<<<');
                if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c == null){
                    req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();            
                    req.StopTime_Identify_New_Requirement__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ICR_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_OnHoldWaitingonClie__c;
                    Integer diff_ICR = diff_ICR_D.intvalue();
                    DateTime dT2 = dT.addMinutes(-diff_ICR);
                    req.StartTime_Identify_OnHoldWaitingonClient__c = dT2;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = null;
                    req.StopTime_Identify_New_Requirement__c = System.Now();                    
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c == null){
                    req.StartTime_Identify_Submit_for_Business__c = System.Now();
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SBR_D = RequestOldMap.get(req.Id).TimeSpentOn_Submit_for_Business_Review__c;
                    Integer diff_SBR = diff_SBR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_SBR);
                    req.StartTime_Identify_Submit_for_Business__c = dT3;
                    req.StopTime_Identify_Submit_for_Business__c = null;
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c == null){
                    req.StartTime_Emergency_Request__c = System.Now();
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ER_D = RequestOldMap.get(req.Id).TimeSpentOn_Emergency_Request__c;
                    Integer diff_ER = diff_ER_D.intvalue();
                    DateTime dT4 = dT.addMinutes(-diff_ER);
                    req.StartTime_Emergency_Request__c = dT4;
                    req.StopTime_Emergency_Request__c = null;
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c == null){
                    req.StartTime_Deferred__c = System.Now();
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c != null){
                    DateTime dT = System.now();
                    Decimal diff_D_D = RequestOldMap.get(req.Id).TimeSpentOn_Deferred__c;
                    Integer diff_D = diff_D_D.intvalue();
                    DateTime dT5 = dT.addMinutes(-diff_D);
                    req.StartTime_Deferred__c = dT5;
                    req.StopTime_Deferred__c = null;
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c == null){
                    req.StartTime_Approve_to_Estimate__c = System.Now();
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AE_D = RequestOldMap.get(req.Id).TimeSpentOn_Approve_to_Estimate__c;
                    Integer diff_AE = diff_AE_D.intvalue();
                    DateTime dT6 = dT.addMinutes(-diff_AE);
                    req.StartTime_Approve_to_Estimate__c = dT6;
                    req.StopTime_Approve_to_Estimate__c = null;
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c == null){
                    req.StartTime_Level_of_Effort_Complete__c = System.Now();
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c != null){
                    DateTime dT = System.now();
                    Decimal diff_LEC_D = RequestOldMap.get(req.Id).TimeSpentOn_Level_of_Effort_Complete__c;
                    Integer diff_LEC = diff_LEC_D.intvalue();
                    DateTime dT7 = dT.addMinutes(-diff_LEC);
                    req.StartTime_Level_of_Effort_Complete__c = dT7;
                    req.StopTime_Level_of_Effort_Complete__c = null;
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c == null){
                    req.StartTime_Approved_to_Deploy__c = System.Now();
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AD_D = RequestOldMap.get(req.Id).TimeSpentOn_Approved_to_Deploy__c;
                    Integer diff_AD = diff_AD_D.intvalue();
                    DateTime dT8 = dT.addMinutes(-diff_AD);
                    req.StartTime_Approved_to_Deploy__c = dT8;
                    req.StopTime_Approved_to_Deploy__c = null;
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c == null){
                    req.StartTime_Design__c = System.Now();
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DE_D = RequestOldMap.get(req.Id).TimeSpentOn_Design__c;
                    Integer diff_DE = diff_DE_D.intvalue();
                    DateTime dT10 = dT.addMinutes(-diff_DE);
                    req.StartTime_Design__c = dT10;
                    req.StopTime_Design__c = null;
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c == null){
                    req.StartTime_Build__c = System.Now();
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Build__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Build__c = dT11;
                    req.StopTime_Build__c = null;
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c == null){
                    req.StartTime_Test__c = System.Now();
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c != null){
                    DateTime dT = System.now();
                    Decimal diff_T_D = RequestOldMap.get(req.Id).TimeSpentOn_Test__c;
                    Integer diff_T = diff_T_D.intvalue();
                    DateTime dT12 = dT.addMinutes(-diff_T);
                    req.StartTime_Test__c = dT12;
                    req.StopTime_Test__c = null;
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c == null){
                    req.StartTime_SIT__c = System.Now();
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SIT_D = RequestOldMap.get(req.Id).TimeSpentOn_SIT__c;
                    Integer diff_SIT = diff_SIT_D.intvalue();
                    DateTime dT13 = dT.addMinutes(-diff_SIT);
                    req.StartTime_SIT__c = dT13;
                    req.StopTime_SIT__c = null;
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c == null){
                    req.StartTime_UAT__c = System.Now();
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_UAT_D = RequestOldMap.get(req.Id).TimeSpentOn_UAT__c;
                    Integer diff_UAT = diff_UAT_D.intvalue();
                    DateTime dT14 = dT.addMinutes(-diff_UAT);
                    req.StartTime_UAT__c = dT14;
                    req.StopTime_UAT__c = null;
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c == null){
                    req.StartTime_Build_Production__c = System.Now();
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_BP_D = RequestOldMap.get(req.Id).TimeSpentOn_Build_Production__c;
                    Integer diff_BP = diff_BP_D.intvalue();
                    DateTime dT15 = dT.addMinutes(-diff_BP);
                    req.StartTime_Build_Production__c = dT15;
                    req.StopTime_Build_Production__c = null;
                    req.StopTime_Identify_New_Requirement__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c == null){
                    req.StartTime_Test_Production__c = System.Now();
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_TP_D = RequestOldMap.get(req.Id).TimeSpentOn_Test_Production__c;
                    Integer diff_TP = diff_TP_D.intvalue();
                    DateTime dT16 = dT.addMinutes(-diff_TP);
                    req.StartTime_Test_Production__c = dT16;
                    req.StopTime_Test_Production__c = null;
                    req.StopTime_Identify_New_Requirement__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c == null){
                    req.StartTime_Deployed__c = System.Now();
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DP_D = RequestOldMap.get(req.Id).TimeSpentOn_Deployed__c;
                    Integer diff_DP = diff_DP_D.intvalue();
                    DateTime dT18 = dT.addMinutes(-diff_DP);
                    req.StartTime_Deployed__c = dT18;
                    req.StopTime_Deployed__c = null;
                    req.StopTime_Identify_New_Requirement__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c == null){
                    req.StartTime_Rejected__c = System.Now();
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c != null){
                    DateTime dT = System.now();
                    Decimal diff_RE_D = RequestOldMap.get(req.Id).TimeSpentOn_Rejected__c;
                    Integer diff_RE = diff_RE_D.intvalue();
                    DateTime dT19 = dT.addMinutes(-diff_RE);
                    req.StartTime_Rejected__c = dT19;
                    req.StopTime_Rejected__c = null;
                    req.StopTime_Identify_New_Requirement__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c == null){
                    req.StartTime_Duplicate__c = System.Now();
                    req.StopTime_Identify_New_Requirement__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c != null){      
                    DateTime dT = System.now();
                    Decimal diff_DU_D = RequestOldMap.get(req.Id).TimeSpentOn_Duplicate__c;
                    Integer diff_DU = diff_DU_D.intvalue();
                    DateTime dT20 = dT.addMinutes(-diff_DU);
                    req.StartTime_Duplicate__c = dT20;
                    req.StopTime_Duplicate__c = null;
                    req.StopTime_Identify_New_Requirement__c = System.Now();
                }
            }
            

            if(RequestOldMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client'){
                if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement' && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c == null){
                    req.StartTime_Identify_New_Requirement__c = System.Now();
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement'  && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_New_Requirement__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Identify_New_Requirement__c = dT11;
                    req.StopTime_Identify_New_Requirement__c = null;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c == null){
                    req.StartTime_Identify_Submit_for_Business__c = System.Now();
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SBR_D = RequestOldMap.get(req.Id).TimeSpentOn_Submit_for_Business_Review__c;
                    Integer diff_SBR = diff_SBR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_SBR);
                    req.StartTime_Identify_Submit_for_Business__c = dT3;
                    req.StopTime_Identify_Submit_for_Business__c = null;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c == null){
                    req.StartTime_Emergency_Request__c = System.Now();
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ER_D = RequestOldMap.get(req.Id).TimeSpentOn_Emergency_Request__c;
                    Integer diff_ER = diff_ER_D.intvalue();
                    DateTime dT4 = dT.addMinutes(-diff_ER);
                    req.StartTime_Emergency_Request__c = dT4;
                    req.StopTime_Emergency_Request__c = null;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c == null){
                    req.StartTime_Deferred__c = System.Now();
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c != null){
                    DateTime dT = System.now();
                    Decimal diff_D_D = RequestOldMap.get(req.Id).TimeSpentOn_Deferred__c;
                    Integer diff_D = diff_D_D.intvalue();
                    DateTime dT5 = dT.addMinutes(-diff_D);
                    req.StartTime_Deferred__c = dT5;
                    req.StopTime_Deferred__c = null;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c == null){
                    req.StartTime_Approve_to_Estimate__c = System.Now();
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AE_D = RequestOldMap.get(req.Id).TimeSpentOn_Approve_to_Estimate__c;
                    Integer diff_AE = diff_AE_D.intvalue();
                    DateTime dT6 = dT.addMinutes(-diff_AE);
                    req.StartTime_Approve_to_Estimate__c = dT6;
                    req.StopTime_Approve_to_Estimate__c = null;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c == null){
                    req.StartTime_Level_of_Effort_Complete__c = System.Now();
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c != null){
                    DateTime dT = System.now();
                    Decimal diff_LEC_D = RequestOldMap.get(req.Id).TimeSpentOn_Level_of_Effort_Complete__c;
                    Integer diff_LEC = diff_LEC_D.intvalue();
                    DateTime dT7 = dT.addMinutes(-diff_LEC);
                    req.StartTime_Level_of_Effort_Complete__c = dT7;
                    req.StopTime_Level_of_Effort_Complete__c = null;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c == null){
                    req.StartTime_Approved_to_Deploy__c = System.Now();
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AD_D = RequestOldMap.get(req.Id).TimeSpentOn_Approved_to_Deploy__c;
                    Integer diff_AD = diff_AD_D.intvalue();
                    DateTime dT8 = dT.addMinutes(-diff_AD);
                    req.StartTime_Approved_to_Deploy__c = dT8;
                    req.StopTime_Approved_to_Deploy__c = null;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c == null){
                    req.StartTime_Design__c = System.Now();
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DE_D = RequestOldMap.get(req.Id).TimeSpentOn_Design__c;
                    Integer diff_DE = diff_DE_D.intvalue();
                    DateTime dT10 = dT.addMinutes(-diff_DE);
                    req.StartTime_Design__c = dT10;
                    req.StopTime_Design__c = null;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c == null){
                    req.StartTime_Build__c = System.Now();
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Build__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Build__c = dT11;
                    req.StopTime_Build__c = null;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c == null){
                    req.StartTime_Test__c = System.Now();
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c != null){
                    DateTime dT = System.now();
                    Decimal diff_T_D = RequestOldMap.get(req.Id).TimeSpentOn_Test__c;
                    Integer diff_T = diff_T_D.intvalue();
                    DateTime dT12 = dT.addMinutes(-diff_T);
                    req.StartTime_Test__c = dT12;
                    req.StopTime_Test__c = null;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c == null){
                    req.StartTime_SIT__c = System.Now();
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SIT_D = RequestOldMap.get(req.Id).TimeSpentOn_SIT__c;
                    Integer diff_SIT = diff_SIT_D.intvalue();
                    DateTime dT13 = dT.addMinutes(-diff_SIT);
                    req.StartTime_SIT__c = dT13;
                    req.StopTime_SIT__c = null;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c == null){
                    req.StartTime_UAT__c = System.Now();
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_UAT_D = RequestOldMap.get(req.Id).TimeSpentOn_UAT__c;
                    Integer diff_UAT = diff_UAT_D.intvalue();
                    DateTime dT14 = dT.addMinutes(-diff_UAT);
                    req.StartTime_UAT__c = dT14;
                    req.StopTime_UAT__c = null;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c == null){
                    req.StartTime_Build_Production__c = System.Now();
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_BP_D = RequestOldMap.get(req.Id).TimeSpentOn_Build_Production__c;
                    Integer diff_BP = diff_BP_D.intvalue();
                    DateTime dT15 = dT.addMinutes(-diff_BP);
                    req.StartTime_Build_Production__c = dT15;
                    req.StopTime_Build_Production__c = null;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c == null){
                    req.StartTime_Test_Production__c = System.Now();
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_TP_D = RequestOldMap.get(req.Id).TimeSpentOn_Test_Production__c;
                    Integer diff_TP = diff_TP_D.intvalue();
                    DateTime dT16 = dT.addMinutes(-diff_TP);
                    req.StartTime_Test_Production__c = dT16;
                    req.StopTime_Test_Production__c = null;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c == null){
                    req.StartTime_Deployed__c = System.Now();
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DP_D = RequestOldMap.get(req.Id).TimeSpentOn_Deployed__c;
                    Integer diff_DP = diff_DP_D.intvalue();
                    DateTime dT18 = dT.addMinutes(-diff_DP);
                    req.StartTime_Deployed__c = dT18;
                    req.StopTime_Deployed__c = null;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c == null){
                    req.StartTime_Rejected__c = System.Now();
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c != null){
                    DateTime dT = System.now();
                    Decimal diff_RE_D = RequestOldMap.get(req.Id).TimeSpentOn_Rejected__c;
                    Integer diff_RE = diff_RE_D.intvalue();
                    DateTime dT19 = dT.addMinutes(-diff_RE);
                    req.StartTime_Rejected__c = dT19;
                    req.StopTime_Rejected__c = null;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c == null){
                    req.StartTime_Duplicate__c = System.Now();
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c != null){      
                    DateTime dT = System.now();
                    Decimal diff_DU_D = RequestOldMap.get(req.Id).TimeSpentOn_Duplicate__c;
                    Integer diff_DU = diff_DU_D.intvalue();
                    DateTime dT20 = dT.addMinutes(-diff_DU);
                    req.StartTime_Duplicate__c = dT20;
                    req.StopTime_Duplicate__c = null;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = System.Now();
                }
            }
            
            if(RequestOldMap.get(req.Id).Status__c == 'Identify: Submit for Business Review'){
                if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement' && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c == null){
                    req.StartTime_Identify_New_Requirement__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement'  && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_New_Requirement__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Identify_New_Requirement__c = dT11;
                    req.StopTime_Identify_New_Requirement__c = null;
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c == null){
                    req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ICR_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_OnHoldWaitingonClie__c;
                    Integer diff_ICR = diff_ICR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_ICR);
                    req.StartTime_Identify_OnHoldWaitingonClient__c = dT3;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = null;
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c == null){
                    req.StartTime_Emergency_Request__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ER_D = RequestOldMap.get(req.Id).TimeSpentOn_Emergency_Request__c;
                    Integer diff_ER = diff_ER_D.intvalue();
                    DateTime dT4 = dT.addMinutes(-diff_ER);
                    req.StartTime_Emergency_Request__c = dT4;
                    req.StopTime_Emergency_Request__c = null;
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c == null){
                    req.StartTime_Deferred__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c != null){
                    DateTime dT = System.now();
                    Decimal diff_D_D = RequestOldMap.get(req.Id).TimeSpentOn_Deferred__c;
                    Integer diff_D = diff_D_D.intvalue();
                    DateTime dT5 = dT.addMinutes(-diff_D);
                    req.StartTime_Deferred__c = dT5;
                    req.StopTime_Deferred__c = null;
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c == null){
                    req.StartTime_Approve_to_Estimate__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AE_D = RequestOldMap.get(req.Id).TimeSpentOn_Approve_to_Estimate__c;
                    Integer diff_AE = diff_AE_D.intvalue();
                    DateTime dT6 = dT.addMinutes(-diff_AE);
                    req.StartTime_Approve_to_Estimate__c = dT6;
                    req.StopTime_Approve_to_Estimate__c = null;
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c == null){
                    req.StartTime_Level_of_Effort_Complete__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c != null){
                    DateTime dT = System.now();
                    Decimal diff_LEC_D = RequestOldMap.get(req.Id).TimeSpentOn_Level_of_Effort_Complete__c;
                    Integer diff_LEC = diff_LEC_D.intvalue();
                    DateTime dT7 = dT.addMinutes(-diff_LEC);
                    req.StartTime_Level_of_Effort_Complete__c = dT7;
                    req.StopTime_Level_of_Effort_Complete__c = null;
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c == null){
                    req.StartTime_Approved_to_Deploy__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AD_D = RequestOldMap.get(req.Id).TimeSpentOn_Approved_to_Deploy__c;
                    Integer diff_AD = diff_AD_D.intvalue();
                    DateTime dT8 = dT.addMinutes(-diff_AD);
                    req.StartTime_Approved_to_Deploy__c = dT8;
                    req.StopTime_Approved_to_Deploy__c = null;
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c == null){
                    req.StartTime_Design__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DE_D = RequestOldMap.get(req.Id).TimeSpentOn_Design__c;
                    Integer diff_DE = diff_DE_D.intvalue();
                    DateTime dT10 = dT.addMinutes(-diff_DE);
                    req.StartTime_Design__c = dT10;
                    req.StopTime_Design__c = null;
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c == null){
                    req.StartTime_Build__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Build__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Build__c = dT11;
                    req.StopTime_Build__c = null;
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c == null){
                    req.StartTime_Test__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c != null){
                    DateTime dT = System.now();
                    Decimal diff_T_D = RequestOldMap.get(req.Id).TimeSpentOn_Test__c;
                    Integer diff_T = diff_T_D.intvalue();
                    DateTime dT12 = dT.addMinutes(-diff_T);
                    req.StartTime_Test__c = dT12;
                    req.StopTime_Test__c = null;
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c == null){
                    req.StartTime_SIT__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SIT_D = RequestOldMap.get(req.Id).TimeSpentOn_SIT__c;
                    Integer diff_SIT = diff_SIT_D.intvalue();
                    DateTime dT13 = dT.addMinutes(-diff_SIT);
                    req.StartTime_SIT__c = dT13;
                    req.StopTime_SIT__c = null;
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c == null){
                    req.StartTime_UAT__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_UAT_D = RequestOldMap.get(req.Id).TimeSpentOn_UAT__c;
                    Integer diff_UAT = diff_UAT_D.intvalue();
                    DateTime dT14 = dT.addMinutes(-diff_UAT);
                    req.StartTime_UAT__c = dT14;
                    req.StopTime_UAT__c = null;
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c == null){
                    req.StartTime_Build_Production__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_BP_D = RequestOldMap.get(req.Id).TimeSpentOn_Build_Production__c;
                    Integer diff_BP = diff_BP_D.intvalue();
                    DateTime dT15 = dT.addMinutes(-diff_BP);
                    req.StartTime_Build_Production__c = dT15;
                    req.StopTime_Build_Production__c = null;
                    req.StopTime_Identify_Submit_for_Business__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c == null){
                    req.StartTime_Test_Production__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_TP_D = RequestOldMap.get(req.Id).TimeSpentOn_Test_Production__c;
                    Integer diff_TP = diff_TP_D.intvalue();
                    DateTime dT16 = dT.addMinutes(-diff_TP);
                    req.StartTime_Test_Production__c = dT16;
                    req.StopTime_Test_Production__c = null;
                    req.StopTime_Identify_Submit_for_Business__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c == null){
                    req.StartTime_Deployed__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DP_D = RequestOldMap.get(req.Id).TimeSpentOn_Deployed__c;
                    Integer diff_DP = diff_DP_D.intvalue();
                    DateTime dT18 = dT.addMinutes(-diff_DP);
                    req.StartTime_Deployed__c = dT18;
                    req.StopTime_Deployed__c = null;
                    req.StopTime_Identify_Submit_for_Business__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c == null){
                    req.StartTime_Rejected__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c != null){
                    DateTime dT = System.now();
                    Decimal diff_RE_D = RequestOldMap.get(req.Id).TimeSpentOn_Rejected__c;
                    Integer diff_RE = diff_RE_D.intvalue();
                    DateTime dT19 = dT.addMinutes(-diff_RE);
                    req.StartTime_Rejected__c = dT19;
                    req.StopTime_Rejected__c = null;
                    req.StopTime_Identify_Submit_for_Business__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c == null){
                    req.StartTime_Duplicate__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c != null){      
                    DateTime dT = System.now();
                    Decimal diff_DU_D = RequestOldMap.get(req.Id).TimeSpentOn_Duplicate__c;
                    Integer diff_DU = diff_DU_D.intvalue();
                    DateTime dT20 = dT.addMinutes(-diff_DU);
                    req.StartTime_Duplicate__c = dT20;
                    req.StopTime_Duplicate__c = null;
                    req.StopTime_Identify_Submit_for_Business__c = System.Now();
                }
            }
            
            if(RequestOldMap.get(req.Id).Status__c == 'Identify: Emergency Request'){
                if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement' && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c == null){
                    req.StartTime_Identify_New_Requirement__c = System.Now();
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement'  && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_New_Requirement__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Identify_New_Requirement__c = dT11;
                    req.StopTime_Identify_New_Requirement__c = null;
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c == null){
                    req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ICR_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_OnHoldWaitingonClie__c;
                    Integer diff_ICR = diff_ICR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_ICR);
                    req.StartTime_Identify_OnHoldWaitingonClient__c = dT3;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = null;
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c == null){
                    req.StartTime_Identify_Submit_for_Business__c = System.Now();
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SBR_D = RequestOldMap.get(req.Id).TimeSpentOn_Submit_for_Business_Review__c;
                    Integer diff_SBR = diff_SBR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_SBR);
                    req.StartTime_Identify_Submit_for_Business__c = dT3;
                    req.StopTime_Identify_Submit_for_Business__c = null;
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c == null){
                    req.StartTime_Deferred__c = System.Now();
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c != null){
                    DateTime dT = System.now();
                    Decimal diff_D_D = RequestOldMap.get(req.Id).TimeSpentOn_Deferred__c;
                    Integer diff_D = diff_D_D.intvalue();
                    DateTime dT5 = dT.addMinutes(-diff_D);
                    req.StartTime_Deferred__c = dT5;
                    req.StopTime_Deferred__c = null;
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c == null){
                    req.StartTime_Approve_to_Estimate__c = System.Now();
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AE_D = RequestOldMap.get(req.Id).TimeSpentOn_Approve_to_Estimate__c;
                    Integer diff_AE = diff_AE_D.intvalue();
                    DateTime dT6 = dT.addMinutes(-diff_AE);
                    req.StartTime_Approve_to_Estimate__c = dT6;
                    req.StopTime_Approve_to_Estimate__c = null;
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c == null){
                    req.StartTime_Level_of_Effort_Complete__c = System.Now();
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c != null){
                    DateTime dT = System.now();
                    Decimal diff_LEC_D = RequestOldMap.get(req.Id).TimeSpentOn_Level_of_Effort_Complete__c;
                    Integer diff_LEC = diff_LEC_D.intvalue();
                    DateTime dT7 = dT.addMinutes(-diff_LEC);
                    req.StartTime_Level_of_Effort_Complete__c = dT7;
                    req.StopTime_Level_of_Effort_Complete__c = null;
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c == null){
                    req.StartTime_Approved_to_Deploy__c = System.Now();
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AD_D = RequestOldMap.get(req.Id).TimeSpentOn_Approved_to_Deploy__c;
                    Integer diff_AD = diff_AD_D.intvalue();
                    DateTime dT8 = dT.addMinutes(-diff_AD);
                    req.StartTime_Approved_to_Deploy__c = dT8;
                    req.StopTime_Approved_to_Deploy__c = null;
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c == null){
                    req.StartTime_Design__c = System.Now();
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DE_D = RequestOldMap.get(req.Id).TimeSpentOn_Design__c;
                    Integer diff_DE = diff_DE_D.intvalue();
                    DateTime dT10 = dT.addMinutes(-diff_DE);
                    req.StartTime_Design__c = dT10;
                    req.StopTime_Design__c = null;
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c == null){
                    req.StartTime_Build__c = System.Now();
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Build__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Build__c = dT11;
                    req.StopTime_Build__c = null;
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c == null){
                    req.StartTime_Test__c = System.Now();
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c != null){
                    DateTime dT = System.now();
                    Decimal diff_T_D = RequestOldMap.get(req.Id).TimeSpentOn_Test__c;
                    Integer diff_T = diff_T_D.intvalue();
                    DateTime dT12 = dT.addMinutes(-diff_T);
                    req.StartTime_Test__c = dT12;
                    req.StopTime_Test__c = null;
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c == null){
                    req.StartTime_SIT__c = System.Now();
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SIT_D = RequestOldMap.get(req.Id).TimeSpentOn_SIT__c;
                    Integer diff_SIT = diff_SIT_D.intvalue();
                    DateTime dT13 = dT.addMinutes(-diff_SIT);
                    req.StartTime_SIT__c = dT13;
                    req.StopTime_SIT__c = null;
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c == null){
                    req.StartTime_UAT__c = System.Now();
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_UAT_D = RequestOldMap.get(req.Id).TimeSpentOn_UAT__c;
                    Integer diff_UAT = diff_UAT_D.intvalue();
                    DateTime dT14 = dT.addMinutes(-diff_UAT);
                    req.StartTime_UAT__c = dT14;
                    req.StopTime_UAT__c = null;
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c == null){
                    req.StartTime_Build_Production__c = System.Now();
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_BP_D = RequestOldMap.get(req.Id).TimeSpentOn_Build_Production__c;
                    Integer diff_BP = diff_BP_D.intvalue();
                    DateTime dT15 = dT.addMinutes(-diff_BP);
                    req.StartTime_Build_Production__c = dT15;
                    req.StopTime_Build_Production__c = null;
                    req.StopTime_Emergency_Request__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c == null){
                    req.StartTime_Test_Production__c = System.Now();
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_TP_D = RequestOldMap.get(req.Id).TimeSpentOn_Test_Production__c;
                    Integer diff_TP = diff_TP_D.intvalue();
                    DateTime dT16 = dT.addMinutes(-diff_TP);
                    req.StartTime_Test_Production__c = dT16;
                    req.StopTime_Test_Production__c = null;
                    req.StopTime_Emergency_Request__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c == null){
                    req.StartTime_Deployed__c = System.Now();
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DP_D = RequestOldMap.get(req.Id).TimeSpentOn_Deployed__c;
                    Integer diff_DP = diff_DP_D.intvalue();
                    DateTime dT18 = dT.addMinutes(-diff_DP);
                    req.StartTime_Deployed__c = dT18;
                    req.StopTime_Deployed__c = null;
                    req.StopTime_Emergency_Request__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c == null){
                    req.StartTime_Rejected__c = System.Now();
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c != null){
                    DateTime dT = System.now();
                    Decimal diff_RE_D = RequestOldMap.get(req.Id).TimeSpentOn_Rejected__c;
                    Integer diff_RE = diff_RE_D.intvalue();
                    DateTime dT19 = dT.addMinutes(-diff_RE);
                    req.StartTime_Rejected__c = dT19;
                    req.StopTime_Rejected__c = null;
                    req.StopTime_Emergency_Request__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c == null){
                    req.StartTime_Duplicate__c = System.Now();
                    req.StopTime_Emergency_Request__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c != null){      
                    DateTime dT = System.now();
                    Decimal diff_DU_D = RequestOldMap.get(req.Id).TimeSpentOn_Duplicate__c;
                    Integer diff_DU = diff_DU_D.intvalue();
                    DateTime dT20 = dT.addMinutes(-diff_DU);
                    req.StartTime_Duplicate__c = dT20;
                    req.StopTime_Duplicate__c = null;
                    req.StopTime_Emergency_Request__c = System.Now();
                }
            }
                        
            if(RequestOldMap.get(req.Id).Status__c == 'Identify: Deferred'){
                if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement' && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c == null){
                    req.StartTime_Identify_New_Requirement__c = System.Now();
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement'  && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_New_Requirement__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Identify_New_Requirement__c = dT11;
                    req.StopTime_Identify_New_Requirement__c = null;
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c == null){
                    req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ICR_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_OnHoldWaitingonClie__c;
                    Integer diff_ICR = diff_ICR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_ICR);
                    req.StartTime_Identify_OnHoldWaitingonClient__c = dT3;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = null;
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c == null){
                    req.StartTime_Identify_Submit_for_Business__c = System.Now();
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SBR_D = RequestOldMap.get(req.Id).TimeSpentOn_Submit_for_Business_Review__c;
                    Integer diff_SBR = diff_SBR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_SBR);
                    req.StartTime_Identify_Submit_for_Business__c = dT3;
                    req.StopTime_Identify_Submit_for_Business__c = null;
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c == null){
                    req.StartTime_Emergency_Request__c = System.Now();
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ER_D = RequestOldMap.get(req.Id).TimeSpentOn_Emergency_Request__c;
                    Integer diff_ER = diff_ER_D.intvalue();
                    DateTime dT4 = dT.addMinutes(-diff_ER);
                    req.StartTime_Emergency_Request__c = dT4;
                    req.StopTime_Emergency_Request__c = null;
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c == null){
                    req.StartTime_Approve_to_Estimate__c = System.Now();
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AE_D = RequestOldMap.get(req.Id).TimeSpentOn_Approve_to_Estimate__c;
                    Integer diff_AE = diff_AE_D.intvalue();
                    DateTime dT6 = dT.addMinutes(-diff_AE);
                    req.StartTime_Approve_to_Estimate__c = dT6;
                    req.StopTime_Approve_to_Estimate__c = null;
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c == null){
                    req.StartTime_Level_of_Effort_Complete__c = System.Now();
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c != null){
                    DateTime dT = System.now();
                    Decimal diff_LEC_D = RequestOldMap.get(req.Id).TimeSpentOn_Level_of_Effort_Complete__c;
                    Integer diff_LEC = diff_LEC_D.intvalue();
                    DateTime dT7 = dT.addMinutes(-diff_LEC);
                    req.StartTime_Level_of_Effort_Complete__c = dT7;
                    req.StopTime_Level_of_Effort_Complete__c = null;
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c == null){
                    req.StartTime_Approved_to_Deploy__c = System.Now();
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AD_D = RequestOldMap.get(req.Id).TimeSpentOn_Approved_to_Deploy__c;
                    Integer diff_AD = diff_AD_D.intvalue();
                    DateTime dT8 = dT.addMinutes(-diff_AD);
                    req.StartTime_Approved_to_Deploy__c = dT8;
                    req.StopTime_Approved_to_Deploy__c = null;
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c == null){
                    req.StartTime_Design__c = System.Now();
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DE_D = RequestOldMap.get(req.Id).TimeSpentOn_Design__c;
                    Integer diff_DE = diff_DE_D.intvalue();
                    DateTime dT10 = dT.addMinutes(-diff_DE);
                    req.StartTime_Design__c = dT10;
                    req.StopTime_Design__c = null;
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c == null){
                    req.StartTime_Build__c = System.Now();
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Build__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Build__c = dT11;
                    req.StopTime_Build__c = null;
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c == null){
                    req.StartTime_Test__c = System.Now();
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c != null){
                    DateTime dT = System.now();
                    Decimal diff_T_D = RequestOldMap.get(req.Id).TimeSpentOn_Test__c;
                    Integer diff_T = diff_T_D.intvalue();
                    DateTime dT12 = dT.addMinutes(-diff_T);
                    req.StartTime_Test__c = dT12;
                    req.StopTime_Test__c = null;
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c == null){
                    req.StartTime_SIT__c = System.Now();
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SIT_D = RequestOldMap.get(req.Id).TimeSpentOn_SIT__c;
                    Integer diff_SIT = diff_SIT_D.intvalue();
                    DateTime dT13 = dT.addMinutes(-diff_SIT);
                    req.StartTime_SIT__c = dT13;
                    req.StopTime_SIT__c = null;
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c == null){
                    req.StartTime_UAT__c = System.Now();
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_UAT_D = RequestOldMap.get(req.Id).TimeSpentOn_UAT__c;
                    Integer diff_UAT = diff_UAT_D.intvalue();
                    DateTime dT14 = dT.addMinutes(-diff_UAT);
                    req.StartTime_UAT__c = dT14;
                    req.StopTime_UAT__c = null;
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c == null){
                    req.StartTime_Build_Production__c = System.Now();
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_BP_D = RequestOldMap.get(req.Id).TimeSpentOn_Build_Production__c;
                    Integer diff_BP = diff_BP_D.intvalue();
                    DateTime dT15 = dT.addMinutes(-diff_BP);
                    req.StartTime_Build_Production__c = dT15;
                    req.StopTime_Build_Production__c = null;
                    req.StopTime_Deferred__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c == null){
                    req.StartTime_Test_Production__c = System.Now();
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_TP_D = RequestOldMap.get(req.Id).TimeSpentOn_Test_Production__c;
                    Integer diff_TP = diff_TP_D.intvalue();
                    DateTime dT16 = dT.addMinutes(-diff_TP);
                    req.StartTime_Test_Production__c = dT16;
                    req.StopTime_Test_Production__c = null;
                    req.StopTime_Deferred__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c == null){
                    req.StartTime_Deployed__c = System.Now();
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DP_D = RequestOldMap.get(req.Id).TimeSpentOn_Deployed__c;
                    Integer diff_DP = diff_DP_D.intvalue();
                    DateTime dT18 = dT.addMinutes(-diff_DP);
                    req.StartTime_Deployed__c = dT18;
                    req.StopTime_Deployed__c = null;
                    req.StopTime_Deferred__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c == null){
                    req.StartTime_Rejected__c = System.Now();
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c != null){
                    DateTime dT = System.now();
                    Decimal diff_RE_D = RequestOldMap.get(req.Id).TimeSpentOn_Rejected__c;
                    Integer diff_RE = diff_RE_D.intvalue();
                    DateTime dT19 = dT.addMinutes(-diff_RE);
                    req.StartTime_Rejected__c = dT19;
                    req.StopTime_Rejected__c = null;
                    req.StopTime_Deferred__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c == null){
                    req.StartTime_Duplicate__c = System.Now();
                    req.StopTime_Deferred__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c != null){      
                    DateTime dT = System.now();
                    Decimal diff_DU_D = RequestOldMap.get(req.Id).TimeSpentOn_Duplicate__c;
                    Integer diff_DU = diff_DU_D.intvalue();
                    DateTime dT20 = dT.addMinutes(-diff_DU);
                    req.StartTime_Duplicate__c = dT20;
                    req.StopTime_Duplicate__c = null;
                    req.StopTime_Deferred__c = System.Now();
                }
            }
        }       
    }
    catch (Exception e){
        system.debug('The following error has occurred:'+e.getMessage());
    }
    }
    
    
    public static void fnBeforeUpdateTimeSpentOnStatus1(List<Request__c> RequestNew,List<Request__c> Requestold , map<Id, Request__c> RequestNewMap, map<Id, Request__c> RequestOldMap){ 
    try{        
        for(Request__c req:RequestNew){
            if(RequestOldMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate'){
                if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement' && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c == null){
                    req.StartTime_Identify_New_Requirement__c = System.Now();
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement'  && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_New_Requirement__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Identify_New_Requirement__c = dT11;
                    req.StopTime_Identify_New_Requirement__c = null;
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c == null){
                    req.StartTime_Identify_Submit_for_Business__c = System.Now();
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c == null){
                    req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ICR_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_OnHoldWaitingonClie__c;
                    Integer diff_ICR = diff_ICR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_ICR);
                    req.StartTime_Identify_OnHoldWaitingonClient__c = dT3;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = null;
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SBR_D = RequestOldMap.get(req.Id).TimeSpentOn_Submit_for_Business_Review__c;
                    Integer diff_SBR = diff_SBR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_SBR);
                    req.StartTime_Identify_Submit_for_Business__c = dT3;
                    req.StopTime_Identify_Submit_for_Business__c = null;
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c == null){
                    req.StartTime_Emergency_Request__c = System.Now();
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ER_D = RequestOldMap.get(req.Id).TimeSpentOn_Emergency_Request__c;
                    Integer diff_ER = diff_ER_D.intvalue();
                    DateTime dT4 = dT.addMinutes(-diff_ER);
                    req.StartTime_Emergency_Request__c = dT4;
                    req.StopTime_Emergency_Request__c = null;
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c == null){
                    req.StartTime_Deferred__c = System.Now();
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c != null){
                    DateTime dT = System.now();
                    Decimal diff_D_D = RequestOldMap.get(req.Id).TimeSpentOn_Deferred__c;
                    Integer diff_D = diff_D_D.intvalue();
                    DateTime dT5 = dT.addMinutes(-diff_D);
                    req.StartTime_Deferred__c = dT5;
                    req.StopTime_Deferred__c = null;
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c == null){
                    req.StartTime_Level_of_Effort_Complete__c = System.Now();
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c != null){
                    DateTime dT = System.now();
                    Decimal diff_LEC_D = RequestOldMap.get(req.Id).TimeSpentOn_Level_of_Effort_Complete__c;
                    Integer diff_LEC = diff_LEC_D.intvalue();
                    DateTime dT7 = dT.addMinutes(-diff_LEC);
                    req.StartTime_Level_of_Effort_Complete__c = dT7;
                    req.StopTime_Level_of_Effort_Complete__c = null;
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c == null){
                    req.StartTime_Approved_to_Deploy__c = System.Now();
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AD_D = RequestOldMap.get(req.Id).TimeSpentOn_Approved_to_Deploy__c;
                    Integer diff_AD = diff_AD_D.intvalue();
                    DateTime dT8 = dT.addMinutes(-diff_AD);
                    req.StartTime_Approved_to_Deploy__c = dT8;
                    req.StopTime_Approved_to_Deploy__c = null;
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c == null){
                    req.StartTime_Design__c = System.Now();
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DE_D = RequestOldMap.get(req.Id).TimeSpentOn_Design__c;
                    Integer diff_DE = diff_DE_D.intvalue();
                    DateTime dT10 = dT.addMinutes(-diff_DE);
                    req.StartTime_Design__c = dT10;
                    req.StopTime_Design__c = null;
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c == null){
                    req.StartTime_Build__c = System.Now();
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Build__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Build__c = dT11;
                    req.StopTime_Build__c = null;
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c == null){
                    req.StartTime_Test__c = System.Now();
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c != null){
                    DateTime dT = System.now();
                    Decimal diff_T_D = RequestOldMap.get(req.Id).TimeSpentOn_Test__c;
                    Integer diff_T = diff_T_D.intvalue();
                    DateTime dT12 = dT.addMinutes(-diff_T);
                    req.StartTime_Test__c = dT12;
                    req.StopTime_Test__c = null;
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c == null){
                    req.StartTime_SIT__c = System.Now();
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SIT_D = RequestOldMap.get(req.Id).TimeSpentOn_SIT__c;
                    Integer diff_SIT = diff_SIT_D.intvalue();
                    DateTime dT13 = dT.addMinutes(-diff_SIT);
                    req.StartTime_SIT__c = dT13;
                    req.StopTime_SIT__c = null;
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c == null){
                    req.StartTime_UAT__c = System.Now();
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_UAT_D = RequestOldMap.get(req.Id).TimeSpentOn_UAT__c;
                    Integer diff_UAT = diff_UAT_D.intvalue();
                    DateTime dT14 = dT.addMinutes(-diff_UAT);
                    req.StartTime_UAT__c = dT14;
                    req.StopTime_UAT__c = null;
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c == null){
                    req.StartTime_Build_Production__c = System.Now();
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_BP_D = RequestOldMap.get(req.Id).TimeSpentOn_Build_Production__c;
                    Integer diff_BP = diff_BP_D.intvalue();
                    DateTime dT15 = dT.addMinutes(-diff_BP);
                    req.StartTime_Build_Production__c = dT15;
                    req.StopTime_Build_Production__c = null;
                    req.StopTime_Approve_to_Estimate__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c == null){
                    req.StartTime_Test_Production__c = System.Now();
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_TP_D = RequestOldMap.get(req.Id).TimeSpentOn_Test_Production__c;
                    Integer diff_TP = diff_TP_D.intvalue();
                    DateTime dT16 = dT.addMinutes(-diff_TP);
                    req.StartTime_Test_Production__c = dT16;
                    req.StopTime_Test_Production__c = null;
                    req.StopTime_Approve_to_Estimate__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c == null){
                    req.StartTime_Deployed__c = System.Now();
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DP_D = RequestOldMap.get(req.Id).TimeSpentOn_Deployed__c;
                    Integer diff_DP = diff_DP_D.intvalue();
                    DateTime dT18 = dT.addMinutes(-diff_DP);
                    req.StartTime_Deployed__c = dT18;
                    req.StopTime_Deployed__c = null;
                    req.StopTime_Approve_to_Estimate__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c == null){
                    req.StartTime_Rejected__c = System.Now();
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c != null){
                    DateTime dT = System.now();
                    Decimal diff_RE_D = RequestOldMap.get(req.Id).TimeSpentOn_Rejected__c;
                    Integer diff_RE = diff_RE_D.intvalue();
                    DateTime dT19 = dT.addMinutes(-diff_RE);
                    req.StartTime_Rejected__c = dT19;
                    req.StopTime_Rejected__c = null;
                    req.StopTime_Approve_to_Estimate__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c == null){
                    req.StartTime_Duplicate__c = System.Now();
                    req.StopTime_Approve_to_Estimate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c != null){      
                    DateTime dT = System.now();
                    Decimal diff_DU_D = RequestOldMap.get(req.Id).TimeSpentOn_Duplicate__c;
                    Integer diff_DU = diff_DU_D.intvalue();
                    DateTime dT20 = dT.addMinutes(-diff_DU);
                    req.StartTime_Duplicate__c = dT20;
                    req.StopTime_Duplicate__c = null;
                    req.StopTime_Approve_to_Estimate__c = System.Now();
                }
            }
             
            if(RequestOldMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete'){
                if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement' && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c == null){
                    req.StartTime_Identify_New_Requirement__c = System.Now();
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement'  && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_New_Requirement__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Identify_New_Requirement__c = dT11;
                    req.StopTime_Identify_New_Requirement__c = null;
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c == null){
                    req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ICR_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_OnHoldWaitingonClie__c;
                    Integer diff_ICR = diff_ICR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_ICR);
                    req.StartTime_Identify_OnHoldWaitingonClient__c = dT3;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = null;
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c == null){
                    req.StartTime_Identify_Submit_for_Business__c = System.Now();
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SBR_D = RequestOldMap.get(req.Id).TimeSpentOn_Submit_for_Business_Review__c;
                    Integer diff_SBR = diff_SBR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_SBR);
                    req.StartTime_Identify_Submit_for_Business__c = dT3;
                    req.StopTime_Identify_Submit_for_Business__c = null;
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c == null){
                    req.StartTime_Emergency_Request__c = System.Now();
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ER_D = RequestOldMap.get(req.Id).TimeSpentOn_Emergency_Request__c;
                    Integer diff_ER = diff_ER_D.intvalue();
                    DateTime dT4 = dT.addMinutes(-diff_ER);
                    req.StartTime_Emergency_Request__c = dT4;
                    req.StopTime_Emergency_Request__c = null;
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c == null){
                    req.StartTime_Deferred__c = System.Now();
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c != null){
                    DateTime dT = System.now();
                    Decimal diff_D_D = RequestOldMap.get(req.Id).TimeSpentOn_Deferred__c;
                    Integer diff_D = diff_D_D.intvalue();
                    DateTime dT5 = dT.addMinutes(-diff_D);
                    req.StartTime_Deferred__c = dT5;
                    req.StopTime_Deferred__c = null;
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c == null){
                    req.StartTime_Approve_to_Estimate__c = System.Now();
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AE_D = RequestOldMap.get(req.Id).TimeSpentOn_Approve_to_Estimate__c;
                    Integer diff_AE = diff_AE_D.intvalue();
                    DateTime dT6 = dT.addMinutes(-diff_AE);
                    req.StartTime_Approve_to_Estimate__c = dT6;
                    req.StopTime_Approve_to_Estimate__c = null;
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c == null){
                    req.StartTime_Approved_to_Deploy__c = System.Now();
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AD_D = RequestOldMap.get(req.Id).TimeSpentOn_Approved_to_Deploy__c;
                    Integer diff_AD = diff_AD_D.intvalue();
                    DateTime dT8 = dT.addMinutes(-diff_AD);
                    req.StartTime_Approved_to_Deploy__c = dT8;
                    req.StopTime_Approved_to_Deploy__c = null;
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c == null){
                    req.StartTime_Design__c = System.Now();
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DE_D = RequestOldMap.get(req.Id).TimeSpentOn_Design__c;
                    Integer diff_DE = diff_DE_D.intvalue();
                    DateTime dT10 = dT.addMinutes(-diff_DE);
                    req.StartTime_Design__c = dT10;
                    req.StopTime_Design__c = null;
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c == null){
                    req.StartTime_Build__c = System.Now();
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Build__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Build__c = dT11;
                    req.StopTime_Build__c = null;
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c == null){
                    req.StartTime_Test__c = System.Now();
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c != null){
                    DateTime dT = System.now();
                    Decimal diff_T_D = RequestOldMap.get(req.Id).TimeSpentOn_Test__c;
                    Integer diff_T = diff_T_D.intvalue();
                    DateTime dT12 = dT.addMinutes(-diff_T);
                    req.StartTime_Test__c = dT12;
                    req.StopTime_Test__c = null;
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c == null){
                    req.StartTime_SIT__c = System.Now();
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SIT_D = RequestOldMap.get(req.Id).TimeSpentOn_SIT__c;
                    Integer diff_SIT = diff_SIT_D.intvalue();
                    DateTime dT13 = dT.addMinutes(-diff_SIT);
                    req.StartTime_SIT__c = dT13;
                    req.StopTime_SIT__c = null;
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c == null){
                    req.StartTime_UAT__c = System.Now();
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_UAT_D = RequestOldMap.get(req.Id).TimeSpentOn_UAT__c;
                    Integer diff_UAT = diff_UAT_D.intvalue();
                    DateTime dT14 = dT.addMinutes(-diff_UAT);
                    req.StartTime_UAT__c = dT14;
                    req.StopTime_UAT__c = null;
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c == null){
                    req.StartTime_Build_Production__c = System.Now();
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_BP_D = RequestOldMap.get(req.Id).TimeSpentOn_Build_Production__c;
                    Integer diff_BP = diff_BP_D.intvalue();
                    DateTime dT15 = dT.addMinutes(-diff_BP);
                    req.StartTime_Build_Production__c = dT15;
                    req.StopTime_Build_Production__c = null;
                    req.StopTime_Level_of_Effort_Complete__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c == null){
                    req.StartTime_Test_Production__c = System.Now();
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_TP_D = RequestOldMap.get(req.Id).TimeSpentOn_Test_Production__c;
                    Integer diff_TP = diff_TP_D.intvalue();
                    DateTime dT16 = dT.addMinutes(-diff_TP);
                    req.StartTime_Test_Production__c = dT16;
                    req.StopTime_Test_Production__c = null;
                    req.StopTime_Level_of_Effort_Complete__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c == null){
                    req.StartTime_Deployed__c = System.Now();
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DP_D = RequestOldMap.get(req.Id).TimeSpentOn_Deployed__c;
                    Integer diff_DP = diff_DP_D.intvalue();
                    DateTime dT18 = dT.addMinutes(-diff_DP);
                    req.StartTime_Deployed__c = dT18;
                    req.StopTime_Deployed__c = null;
                    req.StopTime_Level_of_Effort_Complete__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c == null){
                    req.StartTime_Rejected__c = System.Now();
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c != null){
                    DateTime dT = System.now();
                    Decimal diff_RE_D = RequestOldMap.get(req.Id).TimeSpentOn_Rejected__c;
                    Integer diff_RE = diff_RE_D.intvalue();
                    DateTime dT19 = dT.addMinutes(-diff_RE);
                    req.StartTime_Rejected__c = dT19;
                    req.StopTime_Rejected__c = null;
                    req.StopTime_Level_of_Effort_Complete__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c == null){
                    req.StartTime_Duplicate__c = System.Now();
                    req.StopTime_Level_of_Effort_Complete__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c != null){      
                    DateTime dT = System.now();
                    Decimal diff_DU_D = RequestOldMap.get(req.Id).TimeSpentOn_Duplicate__c;
                    Integer diff_DU = diff_DU_D.intvalue();
                    DateTime dT20 = dT.addMinutes(-diff_DU);
                    req.StartTime_Duplicate__c = dT20;
                    req.StopTime_Duplicate__c = null;
                    req.StopTime_Level_of_Effort_Complete__c = System.Now();
                }
            }
             
                        if(RequestOldMap.get(req.Id).Status__c == 'Approve: Approved to Deploy'){
                if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement' && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c == null){
                    req.StartTime_Identify_New_Requirement__c = System.Now();
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement'  && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_New_Requirement__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Identify_New_Requirement__c = dT11;
                    req.StopTime_Identify_New_Requirement__c = null;
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c == null){
                    req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();
                    req.StopTime_Identify_Submit_for_Business__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ICR_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_OnHoldWaitingonClie__c;
                    Integer diff_ICR = diff_ICR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_ICR);
                    req.StartTime_Identify_OnHoldWaitingonClient__c = dT3;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = null;
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c == null){
                    req.StartTime_Identify_Submit_for_Business__c = System.Now();
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SBR_D = RequestOldMap.get(req.Id).TimeSpentOn_Submit_for_Business_Review__c;
                    Integer diff_SBR = diff_SBR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_SBR);
                    req.StartTime_Identify_Submit_for_Business__c = dT3;
                    req.StopTime_Identify_Submit_for_Business__c = null;
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c == null){
                    req.StartTime_Emergency_Request__c = System.Now();
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ER_D = RequestOldMap.get(req.Id).TimeSpentOn_Emergency_Request__c;
                    Integer diff_ER = diff_ER_D.intvalue();
                    DateTime dT4 = dT.addMinutes(-diff_ER);
                    req.StartTime_Emergency_Request__c = dT4;
                    req.StopTime_Emergency_Request__c = null;
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c == null){
                    req.StartTime_Deferred__c = System.Now();
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c != null){
                    DateTime dT = System.now();
                    Decimal diff_D_D = RequestOldMap.get(req.Id).TimeSpentOn_Deferred__c;
                    Integer diff_D = diff_D_D.intvalue();
                    DateTime dT5 = dT.addMinutes(-diff_D);
                    req.StartTime_Deferred__c = dT5;
                    req.StopTime_Deferred__c = null;
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c == null){
                    req.StartTime_Approve_to_Estimate__c = System.Now();
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AE_D = RequestOldMap.get(req.Id).TimeSpentOn_Approve_to_Estimate__c;
                    Integer diff_AE = diff_AE_D.intvalue();
                    DateTime dT6 = dT.addMinutes(-diff_AE);
                    req.StartTime_Approve_to_Estimate__c = dT6;
                    req.StopTime_Approve_to_Estimate__c = null;
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c == null){
                    req.StartTime_Level_of_Effort_Complete__c = System.Now();
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c != null){
                    DateTime dT = System.now();
                    Decimal diff_LEC_D = RequestOldMap.get(req.Id).TimeSpentOn_Level_of_Effort_Complete__c;
                    Integer diff_LEC = diff_LEC_D.intvalue();
                    DateTime dT7 = dT.addMinutes(-diff_LEC);
                    req.StartTime_Level_of_Effort_Complete__c = dT7;
                    req.StopTime_Level_of_Effort_Complete__c = null;
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c == null){
                    req.StartTime_Design__c = System.Now();
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DE_D = RequestOldMap.get(req.Id).TimeSpentOn_Design__c;
                    Integer diff_DE = diff_DE_D.intvalue();
                    DateTime dT10 = dT.addMinutes(-diff_DE);
                    req.StartTime_Design__c = dT10;
                    req.StopTime_Design__c = null;
                    req.StopTime_Approved_to_Deploy__c= System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c == null){
                    req.StartTime_Build__c = System.Now();
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Build__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Build__c = dT11;
                    req.StopTime_Build__c = null;
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c == null){
                    req.StartTime_Test__c = System.Now();
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c != null){
                    DateTime dT = System.now();
                    Decimal diff_T_D = RequestOldMap.get(req.Id).TimeSpentOn_Test__c;
                    Integer diff_T = diff_T_D.intvalue();
                    DateTime dT12 = dT.addMinutes(-diff_T);
                    req.StartTime_Test__c = dT12;
                    req.StopTime_Test__c = null;
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c == null){
                    req.StartTime_SIT__c = System.Now();
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SIT_D = RequestOldMap.get(req.Id).TimeSpentOn_SIT__c;
                    Integer diff_SIT = diff_SIT_D.intvalue();
                    DateTime dT13 = dT.addMinutes(-diff_SIT);
                    req.StartTime_SIT__c = dT13;
                    req.StopTime_SIT__c = null;
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c == null){
                    req.StartTime_UAT__c = System.Now();
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_UAT_D = RequestOldMap.get(req.Id).TimeSpentOn_UAT__c;
                    Integer diff_UAT = diff_UAT_D.intvalue();
                    DateTime dT14 = dT.addMinutes(-diff_UAT);
                    req.StartTime_UAT__c = dT14;
                    req.StopTime_UAT__c = null;
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c == null){
                    req.StartTime_Build_Production__c = System.Now();
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_BP_D = RequestOldMap.get(req.Id).TimeSpentOn_Build_Production__c;
                    Integer diff_BP = diff_BP_D.intvalue();
                    DateTime dT15 = dT.addMinutes(-diff_BP);
                    req.StartTime_Build_Production__c = dT15;
                    req.StopTime_Build_Production__c = null;
                    req.StopTime_Approved_to_Deploy__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c == null){
                    req.StartTime_Test_Production__c = System.Now();
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_TP_D = RequestOldMap.get(req.Id).TimeSpentOn_Test_Production__c;
                    Integer diff_TP = diff_TP_D.intvalue();
                    DateTime dT16 = dT.addMinutes(-diff_TP);
                    req.StartTime_Test_Production__c = dT16;
                    req.StopTime_Test_Production__c = null;
                    req.StopTime_Approved_to_Deploy__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c == null){
                    req.StartTime_Deployed__c = System.Now();
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DP_D = RequestOldMap.get(req.Id).TimeSpentOn_Deployed__c;
                    Integer diff_DP = diff_DP_D.intvalue();
                    DateTime dT18 = dT.addMinutes(-diff_DP);
                    req.StartTime_Deployed__c = dT18;
                    req.StopTime_Deployed__c = null;
                    req.StopTime_Approved_to_Deploy__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c == null){
                    req.StartTime_Rejected__c = System.Now();
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c != null){
                    DateTime dT = System.now();
                    Decimal diff_RE_D = RequestOldMap.get(req.Id).TimeSpentOn_Rejected__c;
                    Integer diff_RE = diff_RE_D.intvalue();
                    DateTime dT19 = dT.addMinutes(-diff_RE);
                    req.StartTime_Rejected__c = dT19;
                    req.StopTime_Rejected__c = null;
                    req.StopTime_Approved_to_Deploy__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c == null){
                    req.StartTime_Duplicate__c = System.Now();
                    req.StopTime_Approved_to_Deploy__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c != null){      
                    DateTime dT = System.now();
                    Decimal diff_DU_D = RequestOldMap.get(req.Id).TimeSpentOn_Duplicate__c;
                    Integer diff_DU = diff_DU_D.intvalue();
                    DateTime dT20 = dT.addMinutes(-diff_DU);
                    req.StartTime_Duplicate__c = dT20;
                    req.StopTime_Duplicate__c = null;
                    req.StopTime_Approved_to_Deploy__c = System.Now();
                }
            }           
            
            if(RequestOldMap.get(req.Id).Status__c == 'Release: Design'){
                if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement' && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c == null){
                    req.StartTime_Identify_New_Requirement__c = System.Now();
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement'  && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_New_Requirement__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Identify_New_Requirement__c = dT11;
                    req.StopTime_Identify_New_Requirement__c = null;
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c == null){
                    req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SBR_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_OnHoldWaitingonClie__c;
                    Integer diff_SBR = diff_SBR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_SBR);
                    req.StartTime_Identify_OnHoldWaitingonClient__c = dT3;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = null;
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c == null){
                    req.StartTime_Identify_Submit_for_Business__c = System.Now();
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SBR_D = RequestOldMap.get(req.Id).TimeSpentOn_Submit_for_Business_Review__c;
                    Integer diff_SBR = diff_SBR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_SBR);
                    req.StartTime_Identify_Submit_for_Business__c = dT3;
                    req.StopTime_Identify_Submit_for_Business__c = null;
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c == null){
                    req.StartTime_Emergency_Request__c = System.Now();
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ER_D = RequestOldMap.get(req.Id).TimeSpentOn_Emergency_Request__c;
                    Integer diff_ER = diff_ER_D.intvalue();
                    DateTime dT4 = dT.addMinutes(-diff_ER);
                    req.StartTime_Emergency_Request__c = dT4;
                    req.StopTime_Emergency_Request__c = null;
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c == null){
                    req.StartTime_Deferred__c = System.Now();
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c != null){
                    DateTime dT = System.now();
                    Decimal diff_D_D = RequestOldMap.get(req.Id).TimeSpentOn_Deferred__c;
                    Integer diff_D = diff_D_D.intvalue();
                    DateTime dT5 = dT.addMinutes(-diff_D);
                    req.StartTime_Deferred__c = dT5;
                    req.StopTime_Deferred__c = null;
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c == null){
                    req.StartTime_Approve_to_Estimate__c = System.Now();
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AE_D = RequestOldMap.get(req.Id).TimeSpentOn_Approve_to_Estimate__c;
                    Integer diff_AE = diff_AE_D.intvalue();
                    DateTime dT6 = dT.addMinutes(-diff_AE);
                    req.StartTime_Approve_to_Estimate__c = dT6;
                    req.StopTime_Approve_to_Estimate__c = null;
                    req.StopTime_Design__c= System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c == null){
                    req.StartTime_Level_of_Effort_Complete__c = System.Now();
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c != null){
                    DateTime dT = System.now();
                    Decimal diff_LEC_D = RequestOldMap.get(req.Id).TimeSpentOn_Level_of_Effort_Complete__c;
                    Integer diff_LEC = diff_LEC_D.intvalue();
                    DateTime dT7 = dT.addMinutes(-diff_LEC);
                    req.StartTime_Level_of_Effort_Complete__c = dT7;
                    req.StopTime_Level_of_Effort_Complete__c = null;
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c == null){
                    req.StartTime_Approved_to_Deploy__c = System.Now();
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AD_D = RequestOldMap.get(req.Id).TimeSpentOn_Approved_to_Deploy__c;
                    Integer diff_AD = diff_AD_D.intvalue();
                    DateTime dT8 = dT.addMinutes(-diff_AD);
                    req.StartTime_Approved_to_Deploy__c = dT8;
                    req.StopTime_Approved_to_Deploy__c = null;
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c == null){
                    req.StartTime_Build__c = System.Now();
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Build__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Build__c = dT11;
                    req.StopTime_Build__c = null;
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c == null){
                    req.StartTime_Test__c = System.Now();
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c != null){
                    DateTime dT = System.now();
                    Decimal diff_T_D = RequestOldMap.get(req.Id).TimeSpentOn_Test__c;
                    Integer diff_T = diff_T_D.intvalue();
                    DateTime dT12 = dT.addMinutes(-diff_T);
                    req.StartTime_Test__c = dT12;
                    req.StopTime_Test__c = null;
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c == null){
                    req.StartTime_SIT__c = System.Now();
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SIT_D = RequestOldMap.get(req.Id).TimeSpentOn_SIT__c;
                    Integer diff_SIT = diff_SIT_D.intvalue();
                    DateTime dT13 = dT.addMinutes(-diff_SIT);
                    req.StartTime_SIT__c = dT13;
                    req.StopTime_SIT__c = null;
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c == null){
                    req.StartTime_UAT__c = System.Now();
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_UAT_D = RequestOldMap.get(req.Id).TimeSpentOn_UAT__c;
                    Integer diff_UAT = diff_UAT_D.intvalue();
                    DateTime dT14 = dT.addMinutes(-diff_UAT);
                    req.StartTime_UAT__c = dT14;
                    req.StopTime_UAT__c = null;
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c == null){
                    req.StartTime_Build_Production__c = System.Now();
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_BP_D = RequestOldMap.get(req.Id).TimeSpentOn_Build_Production__c;
                    Integer diff_BP = diff_BP_D.intvalue();
                    DateTime dT15 = dT.addMinutes(-diff_BP);
                    req.StartTime_Build_Production__c = dT15;
                    req.StopTime_Build_Production__c = null;
                    req.StopTime_Design__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c == null){
                    req.StartTime_Test_Production__c = System.Now();
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_TP_D = RequestOldMap.get(req.Id).TimeSpentOn_Test_Production__c;
                    Integer diff_TP = diff_TP_D.intvalue();
                    DateTime dT16 = dT.addMinutes(-diff_TP);
                    req.StartTime_Test_Production__c = dT16;
                    req.StopTime_Test_Production__c = null;
                    req.StopTime_Design__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c == null){
                    req.StartTime_Deployed__c = System.Now();
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DP_D = RequestOldMap.get(req.Id).TimeSpentOn_Deployed__c;
                    Integer diff_DP = diff_DP_D.intvalue();
                    DateTime dT18 = dT.addMinutes(-diff_DP);
                    req.StartTime_Deployed__c = dT18;
                    req.StopTime_Deployed__c = null;
                    req.StopTime_Design__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c == null){
                    req.StartTime_Rejected__c = System.Now();
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c != null){
                    DateTime dT = System.now();
                    Decimal diff_RE_D = RequestOldMap.get(req.Id).TimeSpentOn_Rejected__c;
                    Integer diff_RE = diff_RE_D.intvalue();
                    DateTime dT19 = dT.addMinutes(-diff_RE);
                    req.StartTime_Rejected__c = dT19;
                    req.StopTime_Rejected__c = null;
                    req.StopTime_Design__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c == null){
                    req.StartTime_Duplicate__c = System.Now();
                    req.StopTime_Design__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c != null){      
                    DateTime dT = System.now();
                    Decimal diff_DU_D = RequestOldMap.get(req.Id).TimeSpentOn_Duplicate__c;
                    Integer diff_DU = diff_DU_D.intvalue();
                    DateTime dT20 = dT.addMinutes(-diff_DU);
                    req.StartTime_Duplicate__c = dT20;
                    req.StopTime_Duplicate__c = null;
                    req.StopTime_Design__c= System.Now();
                }
            }             
        }
    }
    catch (Exception e){
        system.debug('The following error has occurred:'+e.getMessage());
    }
    }

    public static void fnBeforeUpdateTimeSpentOnStatus2(List<Request__c> RequestNew,List<Request__c> Requestold , map<Id, Request__c> RequestNewMap, map<Id, Request__c> RequestOldMap){ 
    try{        
        for(Request__c req:RequestNew){
            
            if(RequestOldMap.get(req.Id).Status__c == 'Release: Build'){
                if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement' && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c == null){
                    req.StartTime_Identify_New_Requirement__c = System.Now();
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement'  && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_New_Requirement__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Identify_New_Requirement__c = dT11;
                    req.StopTime_Identify_New_Requirement__c = null;
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c == null){
                    req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();            
                    req.StopTime_Build__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ICR_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_OnHoldWaitingonClie__c;
                    Integer diff_ICR = diff_ICR_D.intvalue();
                    DateTime dT2 = dT.addMinutes(-diff_ICR);
                    req.StartTime_Identify_OnHoldWaitingonClient__c = dT2;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = null;
                    req.StopTime_Build__c = System.Now();                    
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c == null){
                    req.StartTime_Identify_Submit_for_Business__c = System.Now();
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SBR_D = RequestOldMap.get(req.Id).TimeSpentOn_Submit_for_Business_Review__c;
                    Integer diff_SBR = diff_SBR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_SBR);
                    req.StartTime_Identify_Submit_for_Business__c = dT3;
                    req.StopTime_Identify_Submit_for_Business__c = null;
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c == null){
                    req.StartTime_Emergency_Request__c = System.Now();
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ER_D = RequestOldMap.get(req.Id).TimeSpentOn_Emergency_Request__c;
                    Integer diff_ER = diff_ER_D.intvalue();
                    DateTime dT4 = dT.addMinutes(-diff_ER);
                    req.StartTime_Emergency_Request__c = dT4;
                    req.StopTime_Emergency_Request__c = null;
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c == null){
                    req.StartTime_Deferred__c = System.Now();
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c != null){
                    DateTime dT = System.now();
                    Decimal diff_D_D = RequestOldMap.get(req.Id).TimeSpentOn_Deferred__c;
                    Integer diff_D = diff_D_D.intvalue();
                    DateTime dT5 = dT.addMinutes(-diff_D);
                    req.StartTime_Deferred__c = dT5;
                    req.StopTime_Deferred__c = null;
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c == null){
                    req.StartTime_Approve_to_Estimate__c = System.Now();
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AE_D = RequestOldMap.get(req.Id).TimeSpentOn_Approve_to_Estimate__c;
                    Integer diff_AE = diff_AE_D.intvalue();
                    DateTime dT6 = dT.addMinutes(-diff_AE);
                    req.StartTime_Approve_to_Estimate__c = dT6;
                    req.StopTime_Approve_to_Estimate__c = null;
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c == null){
                    req.StartTime_Level_of_Effort_Complete__c = System.Now();
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c != null){
                    DateTime dT = System.now();
                    Decimal diff_LEC_D = RequestOldMap.get(req.Id).TimeSpentOn_Level_of_Effort_Complete__c;
                    Integer diff_LEC = diff_LEC_D.intvalue();
                    DateTime dT7 = dT.addMinutes(-diff_LEC);
                    req.StartTime_Level_of_Effort_Complete__c = dT7;
                    req.StopTime_Level_of_Effort_Complete__c = null;
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c == null){
                    req.StartTime_Approved_to_Deploy__c = System.Now();
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AD_D = RequestOldMap.get(req.Id).TimeSpentOn_Approved_to_Deploy__c;
                    Integer diff_AD = diff_AD_D.intvalue();
                    DateTime dT8 = dT.addMinutes(-diff_AD);
                    req.StartTime_Approved_to_Deploy__c = dT8;
                    req.StopTime_Approved_to_Deploy__c = null;
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c == null){
                    req.StartTime_Design__c = System.Now();
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DE_D = RequestOldMap.get(req.Id).TimeSpentOn_Design__c;
                    Integer diff_DE = diff_DE_D.intvalue();
                    DateTime dT10 = dT.addMinutes(-diff_DE);
                    req.StartTime_Design__c = dT10;
                    req.StopTime_Design__c = null;
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c == null){
                    req.StartTime_Test__c = System.Now();
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c != null){
                    DateTime dT = System.now();
                    Decimal diff_T_D = RequestOldMap.get(req.Id).TimeSpentOn_Test__c;
                    Integer diff_T = diff_T_D.intvalue();
                    DateTime dT12 = dT.addMinutes(-diff_T);
                    req.StartTime_Test__c = dT12;
                    req.StopTime_Test__c = null;
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c == null){
                    req.StartTime_SIT__c = System.Now();
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SIT_D = RequestOldMap.get(req.Id).TimeSpentOn_SIT__c;
                    Integer diff_SIT = diff_SIT_D.intvalue();
                    DateTime dT13 = dT.addMinutes(-diff_SIT);
                    req.StartTime_SIT__c = dT13;
                    req.StopTime_SIT__c = null;
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c == null){
                    req.StartTime_UAT__c = System.Now();
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_UAT_D = RequestOldMap.get(req.Id).TimeSpentOn_UAT__c;
                    Integer diff_UAT = diff_UAT_D.intvalue();
                    DateTime dT14 = dT.addMinutes(-diff_UAT);
                    req.StartTime_UAT__c = dT14;
                    req.StopTime_UAT__c = null;
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c == null){
                    req.StartTime_Build_Production__c = System.Now();
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_BP_D = RequestOldMap.get(req.Id).TimeSpentOn_Build_Production__c;
                    Integer diff_BP = diff_BP_D.intvalue();
                    DateTime dT15 = dT.addMinutes(-diff_BP);
                    req.StartTime_Build_Production__c = dT15;
                    req.StopTime_Build_Production__c = null;
                    req.StopTime_Build__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c == null){
                    req.StartTime_Test_Production__c = System.Now();
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_TP_D = RequestOldMap.get(req.Id).TimeSpentOn_Test_Production__c;
                    Integer diff_TP = diff_TP_D.intvalue();
                    DateTime dT16 = dT.addMinutes(-diff_TP);
                    req.StartTime_Test_Production__c = dT16;
                    req.StopTime_Test_Production__c = null;
                    req.StopTime_Build__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c == null){
                    req.StartTime_Deployed__c = System.Now();
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DP_D = RequestOldMap.get(req.Id).TimeSpentOn_Deployed__c;
                    Integer diff_DP = diff_DP_D.intvalue();
                    DateTime dT18 = dT.addMinutes(-diff_DP);
                    req.StartTime_Deployed__c = dT18;
                    req.StopTime_Deployed__c = null;
                    req.StopTime_Build__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c == null){
                    req.StartTime_Rejected__c = System.Now();
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c != null){
                    DateTime dT = System.now();
                    Decimal diff_RE_D = RequestOldMap.get(req.Id).TimeSpentOn_Rejected__c;
                    Integer diff_RE = diff_RE_D.intvalue();
                    DateTime dT19 = dT.addMinutes(-diff_RE);
                    req.StartTime_Rejected__c = dT19;
                    req.StopTime_Rejected__c = null;
                    req.StopTime_Build__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c == null){
                    req.StartTime_Duplicate__c = System.Now();
                    req.StopTime_Build__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c != null){      
                    DateTime dT = System.now();
                    Decimal diff_DU_D = RequestOldMap.get(req.Id).TimeSpentOn_Duplicate__c;
                    Integer diff_DU = diff_DU_D.intvalue();
                    DateTime dT20 = dT.addMinutes(-diff_DU);
                    req.StartTime_Duplicate__c = dT20;
                    req.StopTime_Duplicate__c = null;
                    req.StopTime_Build__c = System.Now();
                }
            }
            
            if(RequestOldMap.get(req.Id).Status__c == 'Release: Test'){
                if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement' && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c == null){
                    req.StartTime_Identify_New_Requirement__c = System.Now();
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement'  && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_New_Requirement__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Identify_New_Requirement__c = dT11;
                    req.StopTime_Identify_New_Requirement__c = null;
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c == null){
                    req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();            
                    req.StopTime_Test__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ICR_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_OnHoldWaitingonClie__c;
                    Integer diff_ICR = diff_ICR_D.intvalue();
                    DateTime dT2 = dT.addMinutes(-diff_ICR);
                    req.StartTime_Identify_OnHoldWaitingonClient__c = dT2;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = null;
                    req.StopTime_Test__c = System.Now();                    
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c == null){
                    req.StartTime_Identify_Submit_for_Business__c = System.Now();
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SBR_D = RequestOldMap.get(req.Id).TimeSpentOn_Submit_for_Business_Review__c;
                    Integer diff_SBR = diff_SBR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_SBR);
                    req.StartTime_Identify_Submit_for_Business__c = dT3;
                    req.StopTime_Identify_Submit_for_Business__c = null;
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c == null){
                    req.StartTime_Emergency_Request__c = System.Now();
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ER_D = RequestOldMap.get(req.Id).TimeSpentOn_Emergency_Request__c;
                    Integer diff_ER = diff_ER_D.intvalue();
                    DateTime dT4 = dT.addMinutes(-diff_ER);
                    req.StartTime_Emergency_Request__c = dT4;
                    req.StopTime_Emergency_Request__c = null;
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c == null){
                    req.StartTime_Deferred__c = System.Now();
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c != null){
                    DateTime dT = System.now();
                    Decimal diff_D_D = RequestOldMap.get(req.Id).TimeSpentOn_Deferred__c;
                    Integer diff_D = diff_D_D.intvalue();
                    DateTime dT5 = dT.addMinutes(-diff_D);
                    req.StartTime_Deferred__c = dT5;
                    req.StopTime_Deferred__c = null;
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c == null){
                    req.StartTime_Approve_to_Estimate__c = System.Now();
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AE_D = RequestOldMap.get(req.Id).TimeSpentOn_Approve_to_Estimate__c;
                    Integer diff_AE = diff_AE_D.intvalue();
                    DateTime dT6 = dT.addMinutes(-diff_AE);
                    req.StartTime_Approve_to_Estimate__c = dT6;
                    req.StopTime_Approve_to_Estimate__c = null;
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c == null){
                    req.StartTime_Level_of_Effort_Complete__c = System.Now();
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c != null){
                    DateTime dT = System.now();
                    Decimal diff_LEC_D = RequestOldMap.get(req.Id).TimeSpentOn_Level_of_Effort_Complete__c;
                    Integer diff_LEC = diff_LEC_D.intvalue();
                    DateTime dT7 = dT.addMinutes(-diff_LEC);
                    req.StartTime_Level_of_Effort_Complete__c = dT7;
                    req.StopTime_Level_of_Effort_Complete__c = null;
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c == null){
                    req.StartTime_Approved_to_Deploy__c = System.Now();
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AD_D = RequestOldMap.get(req.Id).TimeSpentOn_Approved_to_Deploy__c;
                    Integer diff_AD = diff_AD_D.intvalue();
                    DateTime dT8 = dT.addMinutes(-diff_AD);
                    req.StartTime_Approved_to_Deploy__c = dT8;
                    req.StopTime_Approved_to_Deploy__c = null;
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c == null){
                    req.StartTime_Design__c = System.Now();
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DE_D = RequestOldMap.get(req.Id).TimeSpentOn_Design__c;
                    Integer diff_DE = diff_DE_D.intvalue();
                    DateTime dT10 = dT.addMinutes(-diff_DE);
                    req.StartTime_Design__c = dT10;
                    req.StopTime_Design__c = null;
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c == null){
                    req.StartTime_Build__c = System.Now();
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Build__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Build__c = dT11;
                    req.StopTime_Build__c = null;
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c == null){
                    req.StartTime_SIT__c = System.Now();
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SIT_D = RequestOldMap.get(req.Id).TimeSpentOn_SIT__c;
                    Integer diff_SIT = diff_SIT_D.intvalue();
                    DateTime dT13 = dT.addMinutes(-diff_SIT);
                    req.StartTime_SIT__c = dT13;
                    req.StopTime_SIT__c = null;
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c == null){
                    req.StartTime_UAT__c = System.Now();
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_UAT_D = RequestOldMap.get(req.Id).TimeSpentOn_UAT__c;
                    Integer diff_UAT = diff_UAT_D.intvalue();
                    DateTime dT14 = dT.addMinutes(-diff_UAT);
                    req.StartTime_UAT__c = dT14;
                    req.StopTime_UAT__c = null;
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c == null){
                    req.StartTime_Build_Production__c = System.Now();
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_BP_D = RequestOldMap.get(req.Id).TimeSpentOn_Build_Production__c;
                    Integer diff_BP = diff_BP_D.intvalue();
                    DateTime dT15 = dT.addMinutes(-diff_BP);
                    req.StartTime_Build_Production__c = dT15;
                    req.StopTime_Build_Production__c = null;
                    req.StopTime_Test__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c == null){
                    req.StartTime_Test_Production__c = System.Now();
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_TP_D = RequestOldMap.get(req.Id).TimeSpentOn_Test_Production__c;
                    Integer diff_TP = diff_TP_D.intvalue();
                    DateTime dT16 = dT.addMinutes(-diff_TP);
                    req.StartTime_Test_Production__c = dT16;
                    req.StopTime_Test_Production__c = null;
                    req.StopTime_Test__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c == null){
                    req.StartTime_Deployed__c = System.Now();
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DP_D = RequestOldMap.get(req.Id).TimeSpentOn_Deployed__c;
                    Integer diff_DP = diff_DP_D.intvalue();
                    DateTime dT18 = dT.addMinutes(-diff_DP);
                    req.StartTime_Deployed__c = dT18;
                    req.StopTime_Deployed__c = null;
                    req.StopTime_Test__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c == null){
                    req.StartTime_Rejected__c = System.Now();
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c != null){
                    DateTime dT = System.now();
                    Decimal diff_RE_D = RequestOldMap.get(req.Id).TimeSpentOn_Rejected__c;
                    Integer diff_RE = diff_RE_D.intvalue();
                    DateTime dT19 = dT.addMinutes(-diff_RE);
                    req.StartTime_Rejected__c = dT19;
                    req.StopTime_Rejected__c = null;
                    req.StopTime_Test__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c == null){
                    req.StartTime_Duplicate__c = System.Now();
                    req.StopTime_Test__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c != null){      
                    DateTime dT = System.now();
                    Decimal diff_DU_D = RequestOldMap.get(req.Id).TimeSpentOn_Duplicate__c;
                    Integer diff_DU = diff_DU_D.intvalue();
                    DateTime dT20 = dT.addMinutes(-diff_DU);
                    req.StartTime_Duplicate__c = dT20;
                    req.StopTime_Duplicate__c = null;
                    req.StopTime_Test__c = System.Now();
                }
            }
            
            
            if(RequestOldMap.get(req.Id).Status__c == 'Release: SIT'){
                if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement' && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c == null){
                    req.StartTime_Identify_New_Requirement__c = System.Now();
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement'  && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_New_Requirement__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Identify_New_Requirement__c = dT11;
                    req.StopTime_Identify_New_Requirement__c = null;
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c == null){
                    req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();            
                    req.StopTime_SIT__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ICR_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_OnHoldWaitingonClie__c;
                    Integer diff_ICR = diff_ICR_D.intvalue();
                    DateTime dT2 = dT.addMinutes(-diff_ICR);
                    req.StartTime_Identify_OnHoldWaitingonClient__c = dT2;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = null;
                    req.StopTime_SIT__c = System.Now();                    
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c == null){
                    req.StartTime_Identify_Submit_for_Business__c = System.Now();
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SBR_D = RequestOldMap.get(req.Id).TimeSpentOn_Submit_for_Business_Review__c;
                    Integer diff_SBR = diff_SBR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_SBR);
                    req.StartTime_Identify_Submit_for_Business__c = dT3;
                    req.StopTime_Identify_Submit_for_Business__c = null;
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c == null){
                    req.StartTime_Emergency_Request__c = System.Now();
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ER_D = RequestOldMap.get(req.Id).TimeSpentOn_Emergency_Request__c;
                    Integer diff_ER = diff_ER_D.intvalue();
                    DateTime dT4 = dT.addMinutes(-diff_ER);
                    req.StartTime_Emergency_Request__c = dT4;
                    req.StopTime_Emergency_Request__c = null;
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c == null){
                    req.StartTime_Deferred__c = System.Now();
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c != null){
                    DateTime dT = System.now();
                    Decimal diff_D_D = RequestOldMap.get(req.Id).TimeSpentOn_Deferred__c;
                    Integer diff_D = diff_D_D.intvalue();
                    DateTime dT5 = dT.addMinutes(-diff_D);
                    req.StartTime_Deferred__c = dT5;
                    req.StopTime_Deferred__c = null;
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c == null){
                    req.StartTime_Approve_to_Estimate__c = System.Now();
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AE_D = RequestOldMap.get(req.Id).TimeSpentOn_Approve_to_Estimate__c;
                    Integer diff_AE = diff_AE_D.intvalue();
                    DateTime dT6 = dT.addMinutes(-diff_AE);
                    req.StartTime_Approve_to_Estimate__c = dT6;
                    req.StopTime_Approve_to_Estimate__c = null;
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c == null){
                    req.StartTime_Level_of_Effort_Complete__c = System.Now();
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c != null){
                    DateTime dT = System.now();
                    Decimal diff_LEC_D = RequestOldMap.get(req.Id).TimeSpentOn_Level_of_Effort_Complete__c;
                    Integer diff_LEC = diff_LEC_D.intvalue();
                    DateTime dT7 = dT.addMinutes(-diff_LEC);
                    req.StartTime_Level_of_Effort_Complete__c = dT7;
                    req.StopTime_Level_of_Effort_Complete__c = null;
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c == null){
                    req.StartTime_Approved_to_Deploy__c = System.Now();
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AD_D = RequestOldMap.get(req.Id).TimeSpentOn_Approved_to_Deploy__c;
                    Integer diff_AD = diff_AD_D.intvalue();
                    DateTime dT8 = dT.addMinutes(-diff_AD);
                    req.StartTime_Approved_to_Deploy__c = dT8;
                    req.StopTime_Approved_to_Deploy__c = null;
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c == null){
                    req.StartTime_Design__c = System.Now();
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DE_D = RequestOldMap.get(req.Id).TimeSpentOn_Design__c;
                    Integer diff_DE = diff_DE_D.intvalue();
                    DateTime dT10 = dT.addMinutes(-diff_DE);
                    req.StartTime_Design__c = dT10;
                    req.StopTime_Design__c = null;
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c == null){
                    req.StartTime_Build__c = System.Now();
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Build__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Build__c = dT11;
                    req.StopTime_Build__c = null;
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c == null){
                    req.StartTime_Test__c = System.Now();
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c != null){
                    DateTime dT = System.now();
                    Decimal diff_T_D = RequestOldMap.get(req.Id).TimeSpentOn_Test__c;
                    Integer diff_T = diff_T_D.intvalue();
                    DateTime dT12 = dT.addMinutes(-diff_T);
                    req.StartTime_Test__c = dT12;
                    req.StopTime_Test__c = null;
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c == null){
                    req.StartTime_UAT__c = System.Now();
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_UAT_D = RequestOldMap.get(req.Id).TimeSpentOn_UAT__c;
                    Integer diff_UAT = diff_UAT_D.intvalue();
                    DateTime dT14 = dT.addMinutes(-diff_UAT);
                    req.StartTime_UAT__c = dT14;
                    req.StopTime_UAT__c = null;
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c == null){
                    req.StartTime_Build_Production__c = System.Now();
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_BP_D = RequestOldMap.get(req.Id).TimeSpentOn_Build_Production__c;
                    Integer diff_BP = diff_BP_D.intvalue();
                    DateTime dT15 = dT.addMinutes(-diff_BP);
                    req.StartTime_Build_Production__c = dT15;
                    req.StopTime_Build_Production__c = null;
                    req.StopTime_SIT__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c == null){
                    req.StartTime_Test_Production__c = System.Now();
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_TP_D = RequestOldMap.get(req.Id).TimeSpentOn_Test_Production__c;
                    Integer diff_TP = diff_TP_D.intvalue();
                    DateTime dT16 = dT.addMinutes(-diff_TP);
                    req.StartTime_Test_Production__c = dT16;
                    req.StopTime_Test_Production__c = null;
                    req.StopTime_SIT__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c == null){
                    req.StartTime_Deployed__c = System.Now();
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DP_D = RequestOldMap.get(req.Id).TimeSpentOn_Deployed__c;
                    Integer diff_DP = diff_DP_D.intvalue();
                    DateTime dT18 = dT.addMinutes(-diff_DP);
                    req.StartTime_Deployed__c = dT18;
                    req.StopTime_Deployed__c = null;
                    req.StopTime_SIT__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c == null){
                    req.StartTime_Rejected__c = System.Now();
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c != null){
                    DateTime dT = System.now();
                    Decimal diff_RE_D = RequestOldMap.get(req.Id).TimeSpentOn_Rejected__c;
                    Integer diff_RE = diff_RE_D.intvalue();
                    DateTime dT19 = dT.addMinutes(-diff_RE);
                    req.StartTime_Rejected__c = dT19;
                    req.StopTime_Rejected__c = null;
                    req.StopTime_SIT__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c == null){
                    req.StartTime_Duplicate__c = System.Now();
                    req.StopTime_SIT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c != null){      
                    DateTime dT = System.now();
                    Decimal diff_DU_D = RequestOldMap.get(req.Id).TimeSpentOn_Duplicate__c;
                    Integer diff_DU = diff_DU_D.intvalue();
                    DateTime dT20 = dT.addMinutes(-diff_DU);
                    req.StartTime_Duplicate__c = dT20;
                    req.StopTime_Duplicate__c = null;
                    req.StopTime_SIT__c = System.Now();
                }
            }
            
            
            if(RequestOldMap.get(req.Id).Status__c == 'Release: UAT'){
                if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement' && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c == null){
                    req.StartTime_Identify_New_Requirement__c = System.Now();
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement'  && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_New_Requirement__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Identify_New_Requirement__c = dT11;
                    req.StopTime_Identify_New_Requirement__c = null;
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c == null){
                    req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();            
                    req.StopTime_UAT__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ICR_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_OnHoldWaitingonClie__c;
                    Integer diff_ICR = diff_ICR_D.intvalue();
                    DateTime dT2 = dT.addMinutes(-diff_ICR);
                    req.StartTime_Identify_OnHoldWaitingonClient__c = dT2;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = null;
                    req.StopTime_UAT__c = System.Now();                    
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c == null){
                    req.StartTime_Identify_Submit_for_Business__c = System.Now();
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SBR_D = RequestOldMap.get(req.Id).TimeSpentOn_Submit_for_Business_Review__c;
                    Integer diff_SBR = diff_SBR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_SBR);
                    req.StartTime_Identify_Submit_for_Business__c = dT3;
                    req.StopTime_Identify_Submit_for_Business__c = null;
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c == null){
                    req.StartTime_Emergency_Request__c = System.Now();
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ER_D = RequestOldMap.get(req.Id).TimeSpentOn_Emergency_Request__c;
                    Integer diff_ER = diff_ER_D.intvalue();
                    DateTime dT4 = dT.addMinutes(-diff_ER);
                    req.StartTime_Emergency_Request__c = dT4;
                    req.StopTime_Emergency_Request__c = null;
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c == null){
                    req.StartTime_Deferred__c = System.Now();
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c != null){
                    DateTime dT = System.now();
                    Decimal diff_D_D = RequestOldMap.get(req.Id).TimeSpentOn_Deferred__c;
                    Integer diff_D = diff_D_D.intvalue();
                    DateTime dT5 = dT.addMinutes(-diff_D);
                    req.StartTime_Deferred__c = dT5;
                    req.StopTime_Deferred__c = null;
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c == null){
                    req.StartTime_Approve_to_Estimate__c = System.Now();
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AE_D = RequestOldMap.get(req.Id).TimeSpentOn_Approve_to_Estimate__c;
                    Integer diff_AE = diff_AE_D.intvalue();
                    DateTime dT6 = dT.addMinutes(-diff_AE);
                    req.StartTime_Approve_to_Estimate__c = dT6;
                    req.StopTime_Approve_to_Estimate__c = null;
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c == null){
                    req.StartTime_Level_of_Effort_Complete__c = System.Now();
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c != null){
                    DateTime dT = System.now();
                    Decimal diff_LEC_D = RequestOldMap.get(req.Id).TimeSpentOn_Level_of_Effort_Complete__c;
                    Integer diff_LEC = diff_LEC_D.intvalue();
                    DateTime dT7 = dT.addMinutes(-diff_LEC);
                    req.StartTime_Level_of_Effort_Complete__c = dT7;
                    req.StopTime_Level_of_Effort_Complete__c = null;
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c == null){
                    req.StartTime_Approved_to_Deploy__c = System.Now();
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AD_D = RequestOldMap.get(req.Id).TimeSpentOn_Approved_to_Deploy__c;
                    Integer diff_AD = diff_AD_D.intvalue();
                    DateTime dT8 = dT.addMinutes(-diff_AD);
                    req.StartTime_Approved_to_Deploy__c = dT8;
                    req.StopTime_Approved_to_Deploy__c = null;
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c == null){
                    req.StartTime_Design__c = System.Now();
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DE_D = RequestOldMap.get(req.Id).TimeSpentOn_Design__c;
                    Integer diff_DE = diff_DE_D.intvalue();
                    DateTime dT10 = dT.addMinutes(-diff_DE);
                    req.StartTime_Design__c = dT10;
                    req.StopTime_Design__c = null;
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c == null){
                    req.StartTime_Build__c = System.Now();
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Build__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Build__c = dT11;
                    req.StopTime_Build__c = null;
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c == null){
                    req.StartTime_Test__c = System.Now();
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c != null){
                    DateTime dT = System.now();
                    Decimal diff_T_D = RequestOldMap.get(req.Id).TimeSpentOn_Test__c;
                    Integer diff_T = diff_T_D.intvalue();
                    DateTime dT12 = dT.addMinutes(-diff_T);
                    req.StartTime_Test__c = dT12;
                    req.StopTime_Test__c = null;
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c == null){
                    req.StartTime_SIT__c = System.Now();
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SIT_D = RequestOldMap.get(req.Id).TimeSpentOn_SIT__c;
                    Integer diff_SIT = diff_SIT_D.intvalue();
                    DateTime dT13 = dT.addMinutes(-diff_SIT);
                    req.StartTime_SIT__c = dT13;
                    req.StopTime_SIT__c = null;
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c == null){
                    req.StartTime_Build_Production__c = System.Now();
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_BP_D = RequestOldMap.get(req.Id).TimeSpentOn_Build_Production__c;
                    Integer diff_BP = diff_BP_D.intvalue();
                    DateTime dT15 = dT.addMinutes(-diff_BP);
                    req.StartTime_Build_Production__c = dT15;
                    req.StopTime_Build_Production__c = null;
                    req.StopTime_UAT__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c == null){
                    req.StartTime_Test_Production__c = System.Now();
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_TP_D = RequestOldMap.get(req.Id).TimeSpentOn_Test_Production__c;
                    Integer diff_TP = diff_TP_D.intvalue();
                    DateTime dT16 = dT.addMinutes(-diff_TP);
                    req.StartTime_Test_Production__c = dT16;
                    req.StopTime_Test_Production__c = null;
                    req.StopTime_UAT__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c == null){
                    req.StartTime_Deployed__c = System.Now();
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DP_D = RequestOldMap.get(req.Id).TimeSpentOn_Deployed__c;
                    Integer diff_DP = diff_DP_D.intvalue();
                    DateTime dT18 = dT.addMinutes(-diff_DP);
                    req.StartTime_Deployed__c = dT18;
                    req.StopTime_Deployed__c = null;
                    req.StopTime_UAT__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c == null){
                    req.StartTime_Rejected__c = System.Now();
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c != null){
                    DateTime dT = System.now();
                    Decimal diff_RE_D = RequestOldMap.get(req.Id).TimeSpentOn_Rejected__c;
                    Integer diff_RE = diff_RE_D.intvalue();
                    DateTime dT19 = dT.addMinutes(-diff_RE);
                    req.StartTime_Rejected__c = dT19;
                    req.StopTime_Rejected__c = null;
                    req.StopTime_UAT__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c == null){
                    req.StartTime_Duplicate__c = System.Now();
                    req.StopTime_UAT__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c != null){      
                    DateTime dT = System.now();
                    Decimal diff_DU_D = RequestOldMap.get(req.Id).TimeSpentOn_Duplicate__c;
                    Integer diff_DU = diff_DU_D.intvalue();
                    DateTime dT20 = dT.addMinutes(-diff_DU);
                    req.StartTime_Duplicate__c = dT20;
                    req.StopTime_Duplicate__c = null;
                    req.StopTime_UAT__c = System.Now();
                }
            }
            
            
            if(RequestOldMap.get(req.Id).Status__c == 'Release: Build Production'){
                if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement' && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c == null){
                    req.StartTime_Identify_New_Requirement__c = System.Now();
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement'  && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_New_Requirement__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Identify_New_Requirement__c = dT11;
                    req.StopTime_Identify_New_Requirement__c = null;
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c == null){
                    req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();            
                    req.StopTime_Build_Production__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ICR_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_OnHoldWaitingonClie__c;
                    Integer diff_ICR = diff_ICR_D.intvalue();
                    DateTime dT2 = dT.addMinutes(-diff_ICR);
                    req.StartTime_Identify_OnHoldWaitingonClient__c = dT2;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = null;
                    req.StopTime_Build_Production__c = System.Now();                    
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c == null){
                    req.StartTime_Identify_Submit_for_Business__c = System.Now();
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SBR_D = RequestOldMap.get(req.Id).TimeSpentOn_Submit_for_Business_Review__c;
                    Integer diff_SBR = diff_SBR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_SBR);
                    req.StartTime_Identify_Submit_for_Business__c = dT3;
                    req.StopTime_Identify_Submit_for_Business__c = null;
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c == null){
                    req.StartTime_Emergency_Request__c = System.Now();
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ER_D = RequestOldMap.get(req.Id).TimeSpentOn_Emergency_Request__c;
                    Integer diff_ER = diff_ER_D.intvalue();
                    DateTime dT4 = dT.addMinutes(-diff_ER);
                    req.StartTime_Emergency_Request__c = dT4;
                    req.StopTime_Emergency_Request__c = null;
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c == null){
                    req.StartTime_Deferred__c = System.Now();
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c != null){
                    DateTime dT = System.now();
                    Decimal diff_D_D = RequestOldMap.get(req.Id).TimeSpentOn_Deferred__c;
                    Integer diff_D = diff_D_D.intvalue();
                    DateTime dT5 = dT.addMinutes(-diff_D);
                    req.StartTime_Deferred__c = dT5;
                    req.StopTime_Deferred__c = null;
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c == null){
                    req.StartTime_Approve_to_Estimate__c = System.Now();
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AE_D = RequestOldMap.get(req.Id).TimeSpentOn_Approve_to_Estimate__c;
                    Integer diff_AE = diff_AE_D.intvalue();
                    DateTime dT6 = dT.addMinutes(-diff_AE);
                    req.StartTime_Approve_to_Estimate__c = dT6;
                    req.StopTime_Approve_to_Estimate__c = null;
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c == null){
                    req.StartTime_Level_of_Effort_Complete__c = System.Now();
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c != null){
                    DateTime dT = System.now();
                    Decimal diff_LEC_D = RequestOldMap.get(req.Id).TimeSpentOn_Level_of_Effort_Complete__c;
                    Integer diff_LEC = diff_LEC_D.intvalue();
                    DateTime dT7 = dT.addMinutes(-diff_LEC);
                    req.StartTime_Level_of_Effort_Complete__c = dT7;
                    req.StopTime_Level_of_Effort_Complete__c = null;
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c == null){
                    req.StartTime_Approved_to_Deploy__c = System.Now();
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AD_D = RequestOldMap.get(req.Id).TimeSpentOn_Approved_to_Deploy__c;
                    Integer diff_AD = diff_AD_D.intvalue();
                    DateTime dT8 = dT.addMinutes(-diff_AD);
                    req.StartTime_Approved_to_Deploy__c = dT8;
                    req.StopTime_Approved_to_Deploy__c = null;
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c == null){
                    req.StartTime_Design__c = System.Now();
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DE_D = RequestOldMap.get(req.Id).TimeSpentOn_Design__c;
                    Integer diff_DE = diff_DE_D.intvalue();
                    DateTime dT10 = dT.addMinutes(-diff_DE);
                    req.StartTime_Design__c = dT10;
                    req.StopTime_Design__c = null;
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c == null){
                    req.StartTime_Build__c = System.Now();
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Build__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Build__c = dT11;
                    req.StopTime_Build__c = null;
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c == null){
                    req.StartTime_Test__c = System.Now();
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c != null){
                    DateTime dT = System.now();
                    Decimal diff_T_D = RequestOldMap.get(req.Id).TimeSpentOn_Test__c;
                    Integer diff_T = diff_T_D.intvalue();
                    DateTime dT12 = dT.addMinutes(-diff_T);
                    req.StartTime_Test__c = dT12;
                    req.StopTime_Test__c = null;
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c == null){
                    req.StartTime_SIT__c = System.Now();
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SIT_D = RequestOldMap.get(req.Id).TimeSpentOn_SIT__c;
                    Integer diff_SIT = diff_SIT_D.intvalue();
                    DateTime dT13 = dT.addMinutes(-diff_SIT);
                    req.StartTime_SIT__c = dT13;
                    req.StopTime_SIT__c = null;
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c == null){
                    req.StartTime_UAT__c = System.Now();
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_UAT_D = RequestOldMap.get(req.Id).TimeSpentOn_UAT__c;
                    Integer diff_UAT = diff_UAT_D.intvalue();
                    DateTime dT14 = dT.addMinutes(-diff_UAT);
                    req.StartTime_UAT__c = dT14;
                    req.StopTime_UAT__c = null;
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c == null){
                    req.StartTime_Test_Production__c = System.Now();
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_TP_D = RequestOldMap.get(req.Id).TimeSpentOn_Test_Production__c;
                    Integer diff_TP = diff_TP_D.intvalue();
                    DateTime dT16 = dT.addMinutes(-diff_TP);
                    req.StartTime_Test_Production__c = dT16;
                    req.StopTime_Test_Production__c = null;
                    req.StopTime_Build_Production__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c == null){
                    req.StartTime_Deployed__c = System.Now();
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DP_D = RequestOldMap.get(req.Id).TimeSpentOn_Deployed__c;
                    Integer diff_DP = diff_DP_D.intvalue();
                    DateTime dT18 = dT.addMinutes(-diff_DP);
                    req.StartTime_Deployed__c = dT18;
                    req.StopTime_Deployed__c = null;
                    req.StopTime_Build_Production__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c == null){
                    req.StartTime_Rejected__c = System.Now();
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c != null){
                    DateTime dT = System.now();
                    Decimal diff_RE_D = RequestOldMap.get(req.Id).TimeSpentOn_Rejected__c;
                    Integer diff_RE = diff_RE_D.intvalue();
                    DateTime dT19 = dT.addMinutes(-diff_RE);
                    req.StartTime_Rejected__c = dT19;
                    req.StopTime_Rejected__c = null;
                    req.StopTime_Build_Production__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c == null){
                    req.StartTime_Duplicate__c = System.Now();
                    req.StopTime_Build_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c != null){      
                    DateTime dT = System.now();
                    Decimal diff_DU_D = RequestOldMap.get(req.Id).TimeSpentOn_Duplicate__c;
                    Integer diff_DU = diff_DU_D.intvalue();
                    DateTime dT20 = dT.addMinutes(-diff_DU);
                    req.StartTime_Duplicate__c = dT20;
                    req.StopTime_Duplicate__c = null;
                    req.StopTime_Build_Production__c = System.Now();
                }
            }            
        }
    }catch(Exception e){
        system.debug('The following error has occurred:'+e.getMessage());
    }
    }   
            
    public static void fnBeforeUpdateTimeSpentOnStatus3(List<Request__c> RequestNew,List<Request__c> Requestold , map<Id, Request__c> RequestNewMap, map<Id, Request__c> RequestOldMap){
    try{            
        for(Request__c req:RequestNew){     
            if(RequestOldMap.get(req.Id).Status__c == 'Release: Test Production'){
                if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement' && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c == null){
                    req.StartTime_Identify_New_Requirement__c = System.Now();
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement'  && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_New_Requirement__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Identify_New_Requirement__c = dT11;
                    req.StopTime_Identify_New_Requirement__c = null;
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c == null){
                    req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();            
                    req.StopTime_Test_Production__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ICR_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_OnHoldWaitingonClie__c;
                    Integer diff_ICR = diff_ICR_D.intvalue();
                    DateTime dT2 = dT.addMinutes(-diff_ICR);
                    req.StartTime_Identify_OnHoldWaitingonClient__c = dT2;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = null;
                    req.StopTime_Test_Production__c = System.Now();                    
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c == null){
                    req.StartTime_Identify_Submit_for_Business__c = System.Now();
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SBR_D = RequestOldMap.get(req.Id).TimeSpentOn_Submit_for_Business_Review__c;
                    Integer diff_SBR = diff_SBR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_SBR);
                    req.StartTime_Identify_Submit_for_Business__c = dT3;
                    req.StopTime_Identify_Submit_for_Business__c = null;
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c == null){
                    req.StartTime_Emergency_Request__c = System.Now();
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ER_D = RequestOldMap.get(req.Id).TimeSpentOn_Emergency_Request__c;
                    Integer diff_ER = diff_ER_D.intvalue();
                    DateTime dT4 = dT.addMinutes(-diff_ER);
                    req.StartTime_Emergency_Request__c = dT4;
                    req.StopTime_Emergency_Request__c = null;
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c == null){
                    req.StartTime_Deferred__c = System.Now();
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c != null){
                    DateTime dT = System.now();
                    Decimal diff_D_D = RequestOldMap.get(req.Id).TimeSpentOn_Deferred__c;
                    Integer diff_D = diff_D_D.intvalue();
                    DateTime dT5 = dT.addMinutes(-diff_D);
                    req.StartTime_Deferred__c = dT5;
                    req.StopTime_Deferred__c = null;
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c == null){
                    req.StartTime_Approve_to_Estimate__c = System.Now();
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AE_D = RequestOldMap.get(req.Id).TimeSpentOn_Approve_to_Estimate__c;
                    Integer diff_AE = diff_AE_D.intvalue();
                    DateTime dT6 = dT.addMinutes(-diff_AE);
                    req.StartTime_Approve_to_Estimate__c = dT6;
                    req.StopTime_Approve_to_Estimate__c = null;
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c == null){
                    req.StartTime_Level_of_Effort_Complete__c = System.Now();
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c != null){
                    DateTime dT = System.now();
                    Decimal diff_LEC_D = RequestOldMap.get(req.Id).TimeSpentOn_Level_of_Effort_Complete__c;
                    Integer diff_LEC = diff_LEC_D.intvalue();
                    DateTime dT7 = dT.addMinutes(-diff_LEC);
                    req.StartTime_Level_of_Effort_Complete__c = dT7;
                    req.StopTime_Level_of_Effort_Complete__c = null;
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c == null){
                    req.StartTime_Approved_to_Deploy__c = System.Now();
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AD_D = RequestOldMap.get(req.Id).TimeSpentOn_Approved_to_Deploy__c;
                    Integer diff_AD = diff_AD_D.intvalue();
                    DateTime dT8 = dT.addMinutes(-diff_AD);
                    req.StartTime_Approved_to_Deploy__c = dT8;
                    req.StopTime_Approved_to_Deploy__c = null;
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c == null){
                    req.StartTime_Design__c = System.Now();
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DE_D = RequestOldMap.get(req.Id).TimeSpentOn_Design__c;
                    Integer diff_DE = diff_DE_D.intvalue();
                    DateTime dT10 = dT.addMinutes(-diff_DE);
                    req.StartTime_Design__c = dT10;
                    req.StopTime_Design__c = null;
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c == null){
                    req.StartTime_Build__c = System.Now();
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Build__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Build__c = dT11;
                    req.StopTime_Build__c = null;
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c == null){
                    req.StartTime_Test__c = System.Now();
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c != null){
                    DateTime dT = System.now();
                    Decimal diff_T_D = RequestOldMap.get(req.Id).TimeSpentOn_Test__c;
                    Integer diff_T = diff_T_D.intvalue();
                    DateTime dT12 = dT.addMinutes(-diff_T);
                    req.StartTime_Test__c = dT12;
                    req.StopTime_Test__c = null;
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c == null){
                    req.StartTime_SIT__c = System.Now();
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SIT_D = RequestOldMap.get(req.Id).TimeSpentOn_SIT__c;
                    Integer diff_SIT = diff_SIT_D.intvalue();
                    DateTime dT13 = dT.addMinutes(-diff_SIT);
                    req.StartTime_SIT__c = dT13;
                    req.StopTime_SIT__c = null;
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c == null){
                    req.StartTime_UAT__c = System.Now();
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_UAT_D = RequestOldMap.get(req.Id).TimeSpentOn_UAT__c;
                    Integer diff_UAT = diff_UAT_D.intvalue();
                    DateTime dT14 = dT.addMinutes(-diff_UAT);
                    req.StartTime_UAT__c = dT14;
                    req.StopTime_UAT__c = null;
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c == null){
                    req.StartTime_Build_Production__c = System.Now();
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_BP_D = RequestOldMap.get(req.Id).TimeSpentOn_Build_Production__c;
                    Integer diff_BP = diff_BP_D.intvalue();
                    DateTime dT15 = dT.addMinutes(-diff_BP);
                    req.StartTime_Build_Production__c = dT15;
                    req.StopTime_Build_Production__c = null;
                    req.StopTime_Test_Production__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c == null){
                    req.StartTime_Deployed__c = System.Now();
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DP_D = RequestOldMap.get(req.Id).TimeSpentOn_Deployed__c;
                    Integer diff_DP = diff_DP_D.intvalue();
                    DateTime dT18 = dT.addMinutes(-diff_DP);
                    req.StartTime_Deployed__c = dT18;
                    req.StopTime_Deployed__c = null;
                    req.StopTime_Test_Production__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c == null){
                    req.StartTime_Rejected__c = System.Now();
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c != null){
                    DateTime dT = System.now();
                    Decimal diff_RE_D = RequestOldMap.get(req.Id).TimeSpentOn_Rejected__c;
                    Integer diff_RE = diff_RE_D.intvalue();
                    DateTime dT19 = dT.addMinutes(-diff_RE);
                    req.StartTime_Rejected__c = dT19;
                    req.StopTime_Rejected__c = null;
                    req.StopTime_Test_Production__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c == null){
                    req.StartTime_Duplicate__c = System.Now();
                    req.StopTime_Test_Production__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c != null){      
                    DateTime dT = System.now();
                    Decimal diff_DU_D = RequestOldMap.get(req.Id).TimeSpentOn_Duplicate__c;
                    Integer diff_DU = diff_DU_D.intvalue();
                    DateTime dT20 = dT.addMinutes(-diff_DU);
                    req.StartTime_Duplicate__c = dT20;
                    req.StopTime_Duplicate__c = null;
                    req.StopTime_Test_Production__c = System.Now();
                }
            }
            
            if(RequestOldMap.get(req.Id).Status__c == 'Close: Deployed'){
                if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement' && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c == null){
                    req.StartTime_Identify_New_Requirement__c = System.Now();
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement'  && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_New_Requirement__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Identify_New_Requirement__c = dT11;
                    req.StopTime_Identify_New_Requirement__c = null;
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c == null){
                    req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();            
                    req.StopTime_Deployed__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ICR_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_OnHoldWaitingonClie__c;
                    Integer diff_ICR = diff_ICR_D.intvalue();
                    DateTime dT2 = dT.addMinutes(-diff_ICR);
                    req.StartTime_Identify_OnHoldWaitingonClient__c = dT2;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = null;
                    req.StopTime_Deployed__c = System.Now();                    
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c == null){
                    req.StartTime_Identify_Submit_for_Business__c = System.Now();
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SBR_D = RequestOldMap.get(req.Id).TimeSpentOn_Submit_for_Business_Review__c;
                    Integer diff_SBR = diff_SBR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_SBR);
                    req.StartTime_Identify_Submit_for_Business__c = dT3;
                    req.StopTime_Identify_Submit_for_Business__c = null;
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c == null){
                    req.StartTime_Emergency_Request__c = System.Now();
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ER_D = RequestOldMap.get(req.Id).TimeSpentOn_Emergency_Request__c;
                    Integer diff_ER = diff_ER_D.intvalue();
                    DateTime dT4 = dT.addMinutes(-diff_ER);
                    req.StartTime_Emergency_Request__c = dT4;
                    req.StopTime_Emergency_Request__c = null;
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c == null){
                    req.StartTime_Deferred__c = System.Now();
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c != null){
                    DateTime dT = System.now();
                    Decimal diff_D_D = RequestOldMap.get(req.Id).TimeSpentOn_Deferred__c;
                    Integer diff_D = diff_D_D.intvalue();
                    DateTime dT5 = dT.addMinutes(-diff_D);
                    req.StartTime_Deferred__c = dT5;
                    req.StopTime_Deferred__c = null;
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c == null){
                    req.StartTime_Approve_to_Estimate__c = System.Now();
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AE_D = RequestOldMap.get(req.Id).TimeSpentOn_Approve_to_Estimate__c;
                    Integer diff_AE = diff_AE_D.intvalue();
                    DateTime dT6 = dT.addMinutes(-diff_AE);
                    req.StartTime_Approve_to_Estimate__c = dT6;
                    req.StopTime_Approve_to_Estimate__c = null;
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c == null){
                    req.StartTime_Level_of_Effort_Complete__c = System.Now();
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c != null){
                    DateTime dT = System.now();
                    Decimal diff_LEC_D = RequestOldMap.get(req.Id).TimeSpentOn_Level_of_Effort_Complete__c;
                    Integer diff_LEC = diff_LEC_D.intvalue();
                    DateTime dT7 = dT.addMinutes(-diff_LEC);
                    req.StartTime_Level_of_Effort_Complete__c = dT7;
                    req.StopTime_Level_of_Effort_Complete__c = null;
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c == null){
                    req.StartTime_Approved_to_Deploy__c = System.Now();
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AD_D = RequestOldMap.get(req.Id).TimeSpentOn_Approved_to_Deploy__c;
                    Integer diff_AD = diff_AD_D.intvalue();
                    DateTime dT8 = dT.addMinutes(-diff_AD);
                    req.StartTime_Approved_to_Deploy__c = dT8;
                    req.StopTime_Approved_to_Deploy__c = null;
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c == null){
                    req.StartTime_Design__c = System.Now();
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DE_D = RequestOldMap.get(req.Id).TimeSpentOn_Design__c;
                    Integer diff_DE = diff_DE_D.intvalue();
                    DateTime dT10 = dT.addMinutes(-diff_DE);
                    req.StartTime_Design__c = dT10;
                    req.StopTime_Design__c = null;
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c == null){
                    req.StartTime_Build__c = System.Now();
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Build__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Build__c = dT11;
                    req.StopTime_Build__c = null;
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c == null){
                    req.StartTime_Test__c = System.Now();
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c != null){
                    DateTime dT = System.now();
                    Decimal diff_T_D = RequestOldMap.get(req.Id).TimeSpentOn_Test__c;
                    Integer diff_T = diff_T_D.intvalue();
                    DateTime dT12 = dT.addMinutes(-diff_T);
                    req.StartTime_Test__c = dT12;
                    req.StopTime_Test__c = null;
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c == null){
                    req.StartTime_SIT__c = System.Now();
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SIT_D = RequestOldMap.get(req.Id).TimeSpentOn_SIT__c;
                    Integer diff_SIT = diff_SIT_D.intvalue();
                    DateTime dT13 = dT.addMinutes(-diff_SIT);
                    req.StartTime_SIT__c = dT13;
                    req.StopTime_SIT__c = null;
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c == null){
                    req.StartTime_UAT__c = System.Now();
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_UAT_D = RequestOldMap.get(req.Id).TimeSpentOn_UAT__c;
                    Integer diff_UAT = diff_UAT_D.intvalue();
                    DateTime dT14 = dT.addMinutes(-diff_UAT);
                    req.StartTime_UAT__c = dT14;
                    req.StopTime_UAT__c = null;
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c == null){
                    req.StartTime_Build_Production__c = System.Now();
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_BP_D = RequestOldMap.get(req.Id).TimeSpentOn_Build_Production__c;
                    Integer diff_BP = diff_BP_D.intvalue();
                    DateTime dT15 = dT.addMinutes(-diff_BP);
                    req.StartTime_Build_Production__c = dT15;
                    req.StopTime_Build_Production__c = null;
                    req.StopTime_Deployed__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c == null){
                    req.StartTime_Test_Production__c = System.Now();
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_TP_D = RequestOldMap.get(req.Id).TimeSpentOn_Test_Production__c;
                    Integer diff_TP = diff_TP_D.intvalue();
                    DateTime dT16 = dT.addMinutes(-diff_TP);
                    req.StartTime_Test_Production__c = dT16;
                    req.StopTime_Test_Production__c = null;
                    req.StopTime_Deployed__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c == null){
                    req.StartTime_Rejected__c = System.Now();
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c != null){
                    DateTime dT = System.now();
                    Decimal diff_RE_D = RequestOldMap.get(req.Id).TimeSpentOn_Rejected__c;
                    Integer diff_RE = diff_RE_D.intvalue();
                    DateTime dT19 = dT.addMinutes(-diff_RE);
                    req.StartTime_Rejected__c = dT19;
                    req.StopTime_Rejected__c = null;
                    req.StopTime_Deployed__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c == null){
                    req.StartTime_Duplicate__c = System.Now();
                    req.StopTime_Deployed__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c != null){      
                    DateTime dT = System.now();
                    Decimal diff_DU_D = RequestOldMap.get(req.Id).TimeSpentOn_Duplicate__c;
                    Integer diff_DU = diff_DU_D.intvalue();
                    DateTime dT20 = dT.addMinutes(-diff_DU);
                    req.StartTime_Duplicate__c = dT20;
                    req.StopTime_Duplicate__c = null;
                    req.StopTime_Deployed__c = System.Now();
                }
            }
            
            
            if(RequestOldMap.get(req.Id).Status__c == 'Close: Rejected'){
                if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement' && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c == null){
                    req.StartTime_Identify_New_Requirement__c = System.Now();
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement'  && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_New_Requirement__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Identify_New_Requirement__c = dT11;
                    req.StopTime_Identify_New_Requirement__c = null;
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c == null){
                    req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();            
                    req.StopTime_Rejected__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ICR_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_OnHoldWaitingonClie__c;
                    Integer diff_ICR = diff_ICR_D.intvalue();
                    DateTime dT2 = dT.addMinutes(-diff_ICR);
                    req.StartTime_Identify_OnHoldWaitingonClient__c = dT2;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = null;
                    req.StopTime_Rejected__c = System.Now();                    
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c == null){
                    req.StartTime_Identify_Submit_for_Business__c = System.Now();
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SBR_D = RequestOldMap.get(req.Id).TimeSpentOn_Submit_for_Business_Review__c;
                    Integer diff_SBR = diff_SBR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_SBR);
                    req.StartTime_Identify_Submit_for_Business__c = dT3;
                    req.StopTime_Identify_Submit_for_Business__c = null;
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c == null){
                    req.StartTime_Emergency_Request__c = System.Now();
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ER_D = RequestOldMap.get(req.Id).TimeSpentOn_Emergency_Request__c;
                    Integer diff_ER = diff_ER_D.intvalue();
                    DateTime dT4 = dT.addMinutes(-diff_ER);
                    req.StartTime_Emergency_Request__c = dT4;
                    req.StopTime_Emergency_Request__c = null;
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c == null){
                    req.StartTime_Deferred__c = System.Now();
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c != null){
                    DateTime dT = System.now();
                    Decimal diff_D_D = RequestOldMap.get(req.Id).TimeSpentOn_Deferred__c;
                    Integer diff_D = diff_D_D.intvalue();
                    DateTime dT5 = dT.addMinutes(-diff_D);
                    req.StartTime_Deferred__c = dT5;
                    req.StopTime_Deferred__c = null;
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c == null){
                    req.StartTime_Approve_to_Estimate__c = System.Now();
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AE_D = RequestOldMap.get(req.Id).TimeSpentOn_Approve_to_Estimate__c;
                    Integer diff_AE = diff_AE_D.intvalue();
                    DateTime dT6 = dT.addMinutes(-diff_AE);
                    req.StartTime_Approve_to_Estimate__c = dT6;
                    req.StopTime_Approve_to_Estimate__c = null;
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c == null){
                    req.StartTime_Level_of_Effort_Complete__c = System.Now();
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c != null){
                    DateTime dT = System.now();
                    Decimal diff_LEC_D = RequestOldMap.get(req.Id).TimeSpentOn_Level_of_Effort_Complete__c;
                    Integer diff_LEC = diff_LEC_D.intvalue();
                    DateTime dT7 = dT.addMinutes(-diff_LEC);
                    req.StartTime_Level_of_Effort_Complete__c = dT7;
                    req.StopTime_Level_of_Effort_Complete__c = null;
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c == null){
                    req.StartTime_Approved_to_Deploy__c = System.Now();
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AD_D = RequestOldMap.get(req.Id).TimeSpentOn_Approved_to_Deploy__c;
                    Integer diff_AD = diff_AD_D.intvalue();
                    DateTime dT8 = dT.addMinutes(-diff_AD);
                    req.StartTime_Approved_to_Deploy__c = dT8;
                    req.StopTime_Approved_to_Deploy__c = null;
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c == null){
                    req.StartTime_Design__c = System.Now();
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DE_D = RequestOldMap.get(req.Id).TimeSpentOn_Design__c;
                    Integer diff_DE = diff_DE_D.intvalue();
                    DateTime dT10 = dT.addMinutes(-diff_DE);
                    req.StartTime_Design__c = dT10;
                    req.StopTime_Design__c = null;
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c == null){
                    req.StartTime_Build__c = System.Now();
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Build__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Build__c = dT11;
                    req.StopTime_Build__c = null;
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c == null){
                    req.StartTime_Test__c = System.Now();
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c != null){
                    DateTime dT = System.now();
                    Decimal diff_T_D = RequestOldMap.get(req.Id).TimeSpentOn_Test__c;
                    Integer diff_T = diff_T_D.intvalue();
                    DateTime dT12 = dT.addMinutes(-diff_T);
                    req.StartTime_Test__c = dT12;
                    req.StopTime_Test__c = null;
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c == null){
                    req.StartTime_SIT__c = System.Now();
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SIT_D = RequestOldMap.get(req.Id).TimeSpentOn_SIT__c;
                    Integer diff_SIT = diff_SIT_D.intvalue();
                    DateTime dT13 = dT.addMinutes(-diff_SIT);
                    req.StartTime_SIT__c = dT13;
                    req.StopTime_SIT__c = null;
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c == null){
                    req.StartTime_UAT__c = System.Now();
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_UAT_D = RequestOldMap.get(req.Id).TimeSpentOn_UAT__c;
                    Integer diff_UAT = diff_UAT_D.intvalue();
                    DateTime dT14 = dT.addMinutes(-diff_UAT);
                    req.StartTime_UAT__c = dT14;
                    req.StopTime_UAT__c = null;
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c == null){
                    req.StartTime_Build_Production__c = System.Now();
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_BP_D = RequestOldMap.get(req.Id).TimeSpentOn_Build_Production__c;
                    Integer diff_BP = diff_BP_D.intvalue();
                    DateTime dT15 = dT.addMinutes(-diff_BP);
                    req.StartTime_Build_Production__c = dT15;
                    req.StopTime_Build_Production__c = null;
                    req.StopTime_Rejected__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c == null){
                    req.StartTime_Test_Production__c = System.Now();
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_TP_D = RequestOldMap.get(req.Id).TimeSpentOn_Test_Production__c;
                    Integer diff_TP = diff_TP_D.intvalue();
                    DateTime dT16 = dT.addMinutes(-diff_TP);
                    req.StartTime_Test_Production__c = dT16;
                    req.StopTime_Test_Production__c = null;
                    req.StopTime_Rejected__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c == null){
                    req.StartTime_Deployed__c = System.Now();
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DP_D = RequestOldMap.get(req.Id).TimeSpentOn_Deployed__c;
                    Integer diff_DP = diff_DP_D.intvalue();
                    DateTime dT18 = dT.addMinutes(-diff_DP);
                    req.StartTime_Deployed__c = dT18;
                    req.StopTime_Deployed__c = null;
                    req.StopTime_Rejected__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c == null){
                    req.StartTime_Duplicate__c = System.Now();
                    req.StopTime_Rejected__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Duplicate' && RequestNewMap.get(req.Id).StopTime_Duplicate__c != null){      
                    DateTime dT = System.now();
                    Decimal diff_DU_D = RequestOldMap.get(req.Id).TimeSpentOn_Duplicate__c;
                    Integer diff_DU = diff_DU_D.intvalue();
                    DateTime dT20 = dT.addMinutes(-diff_DU);
                    req.StartTime_Duplicate__c = dT20;
                    req.StopTime_Duplicate__c = null;
                    req.StopTime_Rejected__c = System.Now();
                }
            }
            
            
            if(RequestOldMap.get(req.Id).Status__c == 'Close: Duplicate'){
                if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement' && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c == null){
                    req.StartTime_Identify_New_Requirement__c = System.Now();
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: New Requirement'  && RequestNewMap.get(req.Id).StopTime_Identify_New_Requirement__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_New_Requirement__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Identify_New_Requirement__c = dT11;
                    req.StopTime_Identify_New_Requirement__c = null;
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c == null){
                    req.StartTime_Identify_OnHoldWaitingonClient__c = System.Now();            
                    req.StopTime_Duplicate__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: On-Hold Waiting on Client' && RequestNewMap.get(req.Id).StopTime_Identify_OnHoldWaitingonClient__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ICR_D = RequestOldMap.get(req.Id).TimeSpentOn_Identify_OnHoldWaitingonClie__c;
                    Integer diff_ICR = diff_ICR_D.intvalue();
                    DateTime dT2 = dT.addMinutes(-diff_ICR);
                    req.StartTime_Identify_OnHoldWaitingonClient__c = dT2;
                    req.StopTime_Identify_OnHoldWaitingonClient__c = null;
                    req.StopTime_Duplicate__c = System.Now();                    
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c == null){
                    req.StartTime_Identify_Submit_for_Business__c = System.Now();
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Submit for Business Review' && RequestNewMap.get(req.Id).StopTime_Identify_Submit_for_Business__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SBR_D = RequestOldMap.get(req.Id).TimeSpentOn_Submit_for_Business_Review__c;
                    Integer diff_SBR = diff_SBR_D.intvalue();
                    DateTime dT3 = dT.addMinutes(-diff_SBR);
                    req.StartTime_Identify_Submit_for_Business__c = dT3;
                    req.StopTime_Identify_Submit_for_Business__c = null;
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c == null){
                    req.StartTime_Emergency_Request__c = System.Now();
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Emergency Request' && RequestNewMap.get(req.Id).StopTime_Emergency_Request__c != null){
                    DateTime dT = System.now();
                    Decimal diff_ER_D = RequestOldMap.get(req.Id).TimeSpentOn_Emergency_Request__c;
                    Integer diff_ER = diff_ER_D.intvalue();
                    DateTime dT4 = dT.addMinutes(-diff_ER);
                    req.StartTime_Emergency_Request__c = dT4;
                    req.StopTime_Emergency_Request__c = null;
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c == null){
                    req.StartTime_Deferred__c = System.Now();
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Identify: Deferred' && RequestNewMap.get(req.Id).StopTime_Deferred__c != null){
                    DateTime dT = System.now();
                    Decimal diff_D_D = RequestOldMap.get(req.Id).TimeSpentOn_Deferred__c;
                    Integer diff_D = diff_D_D.intvalue();
                    DateTime dT5 = dT.addMinutes(-diff_D);
                    req.StartTime_Deferred__c = dT5;
                    req.StopTime_Deferred__c = null;
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c == null){
                    req.StartTime_Approve_to_Estimate__c = System.Now();
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Approve to Estimate' && RequestNewMap.get(req.Id).StopTime_Approve_to_Estimate__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AE_D = RequestOldMap.get(req.Id).TimeSpentOn_Approve_to_Estimate__c;
                    Integer diff_AE = diff_AE_D.intvalue();
                    DateTime dT6 = dT.addMinutes(-diff_AE);
                    req.StartTime_Approve_to_Estimate__c = dT6;
                    req.StopTime_Approve_to_Estimate__c = null;
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c == null){
                    req.StartTime_Level_of_Effort_Complete__c = System.Now();
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Consolidate: Level of Effort Complete' && RequestNewMap.get(req.Id).StopTime_Level_of_Effort_Complete__c != null){
                    DateTime dT = System.now();
                    Decimal diff_LEC_D = RequestOldMap.get(req.Id).TimeSpentOn_Level_of_Effort_Complete__c;
                    Integer diff_LEC = diff_LEC_D.intvalue();
                    DateTime dT7 = dT.addMinutes(-diff_LEC);
                    req.StartTime_Level_of_Effort_Complete__c = dT7;
                    req.StopTime_Level_of_Effort_Complete__c = null;
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c == null){
                    req.StartTime_Approved_to_Deploy__c = System.Now();
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Approve: Approved to Deploy' && RequestNewMap.get(req.Id).StopTime_Approved_to_Deploy__c != null){
                    DateTime dT = System.now();
                    Decimal diff_AD_D = RequestOldMap.get(req.Id).TimeSpentOn_Approved_to_Deploy__c;
                    Integer diff_AD = diff_AD_D.intvalue();
                    DateTime dT8 = dT.addMinutes(-diff_AD);
                    req.StartTime_Approved_to_Deploy__c = dT8;
                    req.StopTime_Approved_to_Deploy__c = null;
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c == null){
                    req.StartTime_Design__c = System.Now();
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Design' && RequestNewMap.get(req.Id).StopTime_Design__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DE_D = RequestOldMap.get(req.Id).TimeSpentOn_Design__c;
                    Integer diff_DE = diff_DE_D.intvalue();
                    DateTime dT10 = dT.addMinutes(-diff_DE);
                    req.StartTime_Design__c = dT10;
                    req.StopTime_Design__c = null;
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c == null){
                    req.StartTime_Build__c = System.Now();
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build' && RequestNewMap.get(req.Id).StopTime_Build__c != null){
                    DateTime dT = System.now();
                    Decimal diff_B_D = RequestOldMap.get(req.Id).TimeSpentOn_Build__c;
                    Integer diff_B = diff_B_D.intvalue();
                    DateTime dT11 = dT.addMinutes(-diff_B);
                    req.StartTime_Build__c = dT11;
                    req.StopTime_Build__c = null;
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c == null){
                    req.StartTime_Test__c = System.Now();
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test' && RequestNewMap.get(req.Id).StopTime_Test__c != null){
                    DateTime dT = System.now();
                    Decimal diff_T_D = RequestOldMap.get(req.Id).TimeSpentOn_Test__c;
                    Integer diff_T = diff_T_D.intvalue();
                    DateTime dT12 = dT.addMinutes(-diff_T);
                    req.StartTime_Test__c = dT12;
                    req.StopTime_Test__c = null;
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c == null){
                    req.StartTime_SIT__c = System.Now();
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: SIT' && RequestNewMap.get(req.Id).StopTime_SIT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_SIT_D = RequestOldMap.get(req.Id).TimeSpentOn_SIT__c;
                    Integer diff_SIT = diff_SIT_D.intvalue();
                    DateTime dT13 = dT.addMinutes(-diff_SIT);
                    req.StartTime_SIT__c = dT13;
                    req.StopTime_SIT__c = null;
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c == null){
                    req.StartTime_UAT__c = System.Now();
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: UAT' && RequestNewMap.get(req.Id).StopTime_UAT__c != null){
                    DateTime dT = System.now();
                    Decimal diff_UAT_D = RequestOldMap.get(req.Id).TimeSpentOn_UAT__c;
                    Integer diff_UAT = diff_UAT_D.intvalue();
                    DateTime dT14 = dT.addMinutes(-diff_UAT);
                    req.StartTime_UAT__c = dT14;
                    req.StopTime_UAT__c = null;
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c == null){
                    req.StartTime_Build_Production__c = System.Now();
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Build Production' && RequestNewMap.get(req.Id).StopTime_Build_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_BP_D = RequestOldMap.get(req.Id).TimeSpentOn_Build_Production__c;
                    Integer diff_BP = diff_BP_D.intvalue();
                    DateTime dT15 = dT.addMinutes(-diff_BP);
                    req.StartTime_Build_Production__c = dT15;
                    req.StopTime_Build_Production__c = null;
                    req.StopTime_Duplicate__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c == null){
                    req.StartTime_Test_Production__c = System.Now();
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Release: Test Production' && RequestNewMap.get(req.Id).StopTime_Test_Production__c != null){
                    DateTime dT = System.now();
                    Decimal diff_TP_D = RequestOldMap.get(req.Id).TimeSpentOn_Test_Production__c;
                    Integer diff_TP = diff_TP_D.intvalue();
                    DateTime dT16 = dT.addMinutes(-diff_TP);
                    req.StartTime_Test_Production__c = dT16;
                    req.StopTime_Test_Production__c = null;
                    req.StopTime_Duplicate__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c == null){
                    req.StartTime_Deployed__c = System.Now();
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Deployed' && RequestNewMap.get(req.Id).StopTime_Deployed__c != null){
                    DateTime dT = System.now();
                    Decimal diff_DP_D = RequestOldMap.get(req.Id).TimeSpentOn_Deployed__c;
                    Integer diff_DP = diff_DP_D.intvalue();
                    DateTime dT18 = dT.addMinutes(-diff_DP);
                    req.StartTime_Deployed__c = dT18;
                    req.StopTime_Deployed__c = null;
                    req.StopTime_Duplicate__c = System.Now();
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c == null){
                    req.StartTime_Rejected__c = System.Now();
                    req.StopTime_Duplicate__c = System.Now(); 
                }
                else if(RequestNewMap.get(req.Id).Status__c == 'Close: Rejected' && RequestNewMap.get(req.Id).StopTime_Rejected__c != null){
                    DateTime dT = System.now();
                    Decimal diff_RE_D = RequestOldMap.get(req.Id).TimeSpentOn_Rejected__c;
                    Integer diff_RE = diff_RE_D.intvalue();
                    DateTime dT19 = dT.addMinutes(-diff_RE);
                    req.StartTime_Rejected__c = dT19;
                    req.StopTime_Rejected__c = null;
                    req.StopTime_Duplicate__c = System.Now();
                }
            }       
        }    
    }catch(Exception e){
        system.debug('The following error has occurred:'+e.getMessage());
    }
    }   
}