public class NS_TransitExceptionDetailWrapper {
    
        @AuraEnabled public String AdditionalDetails;
        @AuraEnabled public String ControlStation;
        @AuraEnabled public String DelayReason;
        @AuraEnabled public String EqInit;
        @AuraEnabled public String EqNr;
        @AuraEnabled public String OperatingStation;
        @AuraEnabled public String PLANNEDMOVEMENTDATE;
		@AuraEnabled public String PLANNEDMOVEMENTTRAIN;
        @AuraEnabled public String QueueInsertDtm;
        @AuraEnabled public String WaybillSrNr;
        
        public NS_TransitExceptionDetailWrapper(){}
        
        public NS_TransitExceptionDetailWrapper(String WbSrNr, String AddDetails, String CntrlStation, String DlayReason, String EqInt, String EqNumber, String OpratinStation, String PlanMovemntDTM, String PlanMovemntTrain, String QInsertDtm){
            AdditionalDetails = AddDetails;
            ControlStation = CntrlStation;
            DelayReason = DlayReason;
            EqInit = EqInt;
            EqNr = EqNumber;
            OperatingStation = OpratinStation;
            PLANNEDMOVEMENTDATE = PlanMovemntDTM;
            PLANNEDMOVEMENTTRAIN = PlanMovemntTrain;
            WaybillSrNr = WbSrNr;
            QueueInsertDtm = QInsertDtm;
        }
    }