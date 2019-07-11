/* ================================================
* @Inner Class Name : CarRequestWrapper
* @author id: arjun.c.ghosh@accenture.com
* @Purpose: Wrapper class for the response
* @created date: 09-01-2019
================================================*/
    public class NS_CarRequestWrapper{
        @AuraEnabled public string accepted;
        @AuraEnabled public string customerPattern;
        @AuraEnabled public string fulfilled;
        @AuraEnabled public string loadFill;
        @AuraEnabled public string marketingPriorityRank;
        @AuraEnabled public string orderFill;
        @AuraEnabled public string projected;
        @AuraEnabled public string requestFill;
        @AuraEnabled public string requested;
        @AuraEnabled public string startWeekDate;
        @AuraEnabled public string surplusShortage;
        @AuraEnabled public string weeklyFillTarget;
        
        public NS_CarRequestWrapper(String accepted, String customerPattern, String fulfilled, String loadFill, String marketingPriorityRank, String orderFill, String projected, 
                                 String requestFill, String requested, String startWeekDate,String surplusShortage, String weeklyFillTarget){
                                     this.accepted=accepted;
                                     this.customerPattern=customerPattern;
                                     this.fulfilled=fulfilled;
                                     this.loadFill=loadFill;
                                     this.marketingPriorityRank=marketingPriorityRank;
                                     this.orderFill=orderFill;
                                     this.projected=projected;
                                     this.requestFill=requestFill;
                                     this.requested=requested;
                                     this.startWeekDate=startWeekDate;
                                     this.surplusShortage=surplusShortage;
                                     this.weeklyFillTarget=weeklyFillTarget;
                                 }
    }