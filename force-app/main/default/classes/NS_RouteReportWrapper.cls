public class NS_RouteReportWrapper {

        @AuraEnabled public string RouteID;
        @AuraEnabled public string Station;
        @AuraEnabled public string StationName;
        @AuraEnabled public string MondayInd;
        @AuraEnabled public string TuesdayInd;
        @AuraEnabled public string WednesdayInd;
        @AuraEnabled public string ThursdayInd;
        @AuraEnabled public string FridayInd;
        @AuraEnabled public string SaturdayInd;
        @AuraEnabled public string SundayInd;
        
        public NS_RouteReportWrapper(String RID, String Stn, String StnName, String MnInd, String TuInd, String WdInd, String ThInd, String FrInd, String StInd, String SnInd){
            RouteID = RID;
            Station = Stn;
            StationName = StnName;
            MondayInd = MnInd;
            TuesdayInd = TuInd;
            WednesdayInd = WdInd;
            ThursdayInd = ThInd;
            FridayInd = FrInd;
            SaturdayInd = StInd;
            SundayInd = SnInd;
        }
    }