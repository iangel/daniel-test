public class NS_GCS{
        public class GCSWrapper{
        @AuraEnabled public SummaryBullets SpecialInstructionElement;
        @AuraEnabled public List<CustomerSummarySchedule> scheduleElement;
        @AuraEnabled public List<EquipmentSummary> EquipmentElement;
        @AuraEnabled public SummaryBullets GeneralInstructionElement;
    }
    
    public class CustomerSummarySchedule{
        @AuraEnabled public String CutOffDayOfWeek;
        @AuraEnabled public String CutoffTimeDisplay;
        @AuraEnabled public String ScheduleCloseTime;
        @AuraEnabled public String ScheduleDayOfWeek;
        @AuraEnabled public String ScheduleOpenTime;
        
        public CustomerSummarySchedule(String CutOffDOW, String CutoffTimeDisp, String SchCloseTime, String SchDayOfWeek, String SchOpenTime){
            CutOffDayOfWeek = CutOffDOW;
            CutoffTimeDisplay = CutoffTimeDisp;
            ScheduleCloseTime = SchCloseTime;
            ScheduleDayOfWeek = SchDayOfWeek;
            ScheduleOpenTime = SchOpenTime;   
        }
    }
    
    public class EquipmentSummary{
        @AuraEnabled public String TagName;
        @AuraEnabled public String EmptyCount;
        @AuraEnabled public String Length;
        @AuraEnabled public String LoadCount;
        @AuraEnabled public String TotalCount;
        @AuraEnabled public String Weight;
        
        public EquipmentSummary(String tname, String EptyCount, String Lnth, String LoadCnt, String TotalCnt, String TotalWeight){
            TagName = tname;
            EmptyCount = EptyCount;
            Length = Lnth;
            LoadCount = LoadCnt;
            TotalCount = TotalCnt;
            Weight = TotalWeight;   
        }
    }
    
    public class SummaryBullets{
        @AuraEnabled public String string1;
        @AuraEnabled public String string2;
        
        public SummaryBullets(String str1, String str2){
            string1 = str1;
            string2 = str2;    
        }
    }

    }