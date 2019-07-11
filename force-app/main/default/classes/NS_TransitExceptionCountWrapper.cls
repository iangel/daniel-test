public class NS_TransitExceptionCountWrapper {

        @AuraEnabled public String EquipmentInit;
        @AuraEnabled public String EquipmentNr;
        @AuraEnabled public String EquipmentDTM;
        @AuraEnabled public String TEQCount;
        @AuraEnabled public String WaybillSrNr;
        
        public NS_TransitExceptionCountWrapper(){}
        
        public NS_TransitExceptionCountWrapper(String EquipInit, String EquipNr, String EquipDTM, String TEQCnt, String WaybillSrNum){
            EquipmentInit = EquipInit;
            EquipmentNr = EquipNr;
            EquipmentDTM = EquipDTM;
            TEQCount = TEQCnt;
            WaybillSrNr = WaybillSrNum;
        
    }
}