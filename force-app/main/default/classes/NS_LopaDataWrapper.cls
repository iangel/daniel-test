public class NS_LopaDataWrapper{
        @AuraEnabled public String NonCompliantCustomerRSN;
        @AuraEnabled public String NonCompliantMechRSN;
        @AuraEnabled public String NonCompliantRRRSN;
        @AuraEnabled public String PercentFailureCustRsn;
        @AuraEnabled public String PercentFailureMechRsn;
        @AuraEnabled public String PercentFailureRRRsn;
        @AuraEnabled public String PercentTotalFailure;
        @AuraEnabled public String TotalPending;
        @AuraEnabled public String TotalPlanned;
        
        public NS_LopaDataWrapper(String NonCompCustRSN,String NonCompMechRSN, String NonCompRRRSN, String PercentFailCustRsn, String PercentFailMechRsn, 
                               String PercentFailRRRsn, String PercentTotalFail, String TotPending, String TotPlanned){
            NonCompliantCustomerRSN = NonCompCustRSN;
            NonCompliantMechRSN = NonCompMechRSN;
            NonCompliantRRRSN = NonCompRRRSN;
            PercentFailureCustRsn = PercentFailCustRsn;
            PercentFailureMechRsn = PercentFailMechRsn;
            PercentFailureRRRsn = PercentFailRRRsn;
            PercentTotalFailure = PercentTotalFail;
            TotalPending = TotPending;
            TotalPlanned = TotPlanned;
        }        
    }