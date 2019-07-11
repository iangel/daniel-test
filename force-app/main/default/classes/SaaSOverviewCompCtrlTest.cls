/** 
 *  Author : Accenture 
 *  Description : Test class for SaaSOverviewCompCtrl
 *  Created Date : 01\10\2015
 * 
 *  
 *
 */ 

@istest
private class SaaSOverviewCompCtrlTest
{
 static testMethod void UnitMethod() {
 
     string itemkey;
     itemkey= SaaSUtility.getURLParameter(SaaSTextConstant.VALUE_DELIVERY_OPTIONS_ID_URL_PARAM);

     Release__c release = new Release__c(Name ='test',Design__c =1,Release__c =12);
     insert release;
     Value_Delivery_Session__c ValueDeliverySetup = new Value_Delivery_Session__c(Description__c ='testing',End_Date__c = system.today()+10,Start_Time__c =system.today(),Releases__c = release.ID);
     insert ValueDeliverySetup;
     
     Value_Delivery_Setup__c vds = new Value_Delivery_Setup__c(Id=itemkey,name ='Test Delivery',Project_Phase__c='Initiate and Confirm',Value_Delivery_Session__c=ValueDeliverySetup.ID,Component_Title__c = 'Test Component',Sequence_Order__c=1);
     insert vds;
     
     Value_Delivery_Setup__c vdsp = new Value_Delivery_Setup__c(name ='Test Delivery',Project_Phase__c='Initiate and Confirm',Value_Delivery_Session__c=ValueDeliverySetup.ID,Component_Title__c = 'Test Component',Sequence_Order__c=1);
     insert vdsp;
     
     Value_Delivery_Objectives_Options__c  deliverysetup = new Value_Delivery_Objectives_Options__c (Objectives_and_Attendees_for_Participant__c=vds.Id,Id=itemkey,Sequence_No__c =1,Option_Description__c ='test');
     insert deliverysetup;
     
     Value_Delivery_User_Config__c vdU = new Value_Delivery_User_Config__c();
     vdu.Name = 'TestUser';           
     vdu.Selected_Session__c = ValueDeliverySetup.id;
     insert vdu;

     ApexPages.CurrentPage().getparameters().put('valueDeliveryOptionsID', deliverysetup.id);
     ApexPages.CurrentPage().getparameters().put('valueDeliveryObjID', vds.id);  

     SaaSOverviewCompCtrl Comp= new SaaSOverviewCompCtrl();
     comp.newObjectivesOptions = deliverysetup;     
     comp.valueDeliveryObjectiveObj = vds;
     comp.valueDeliveryObj = vds;
     comp.itemList = vds;
     List<String> lst = new List<String>{'test'};   
     comp.mapKeys = lst;
     
     List<Value_Delivery_Setup__c> stp = comp.overViewDetail;
     comp.dynamciContentLst = stp;

     comp.getValueDeliveryOption();
     
     
     comp.addValueDelivery();           
     comp.valueDeliveryObj = new Value_Delivery_Setup__c();
     comp.valueDeliveryObj.Component_Title__c ='Test';
     comp.valueDeliveryObj.Sequence_Order__c =1;
     comp.bussinesOnjectiveOption = 'ss \n dd';
     
     comp.addValueDelivery();           
     comp.valueDeliveryObj = new Value_Delivery_Setup__c();
     comp.valueDeliveryObj.Component_Title__c ='Test';
     comp.valueDeliveryObj.Sequence_Order__c =-1;
     comp.bussinesOnjectiveOption = 'ss \n dd';
     
     comp.addValueDelivery();           
     
     comp.updateValueDeliveryObjective();
     
     comp.insertBusinessOption();
     comp.updateValueDeliveryOption();
     comp.getValueDeliveryObjective();
     comp.deleteValueDeliveryObjective();
     comp.deleteValueDeliveryOption();
     
     comp.assignBusinessObjectiveID();
          
   }
    
    static testMethod void UnitMethodNegative() {
 
     string itemkey;
     itemkey= SaaSUtility.getURLParameter(SaaSTextConstant.VALUE_DELIVERY_OPTIONS_ID_URL_PARAM);

     Release__c release = new Release__c(Name ='test',Design__c =1,Release__c =12);
     insert release;
     Value_Delivery_Session__c ValueDeliverySetup = new Value_Delivery_Session__c(Description__c ='testing',End_Date__c = system.today()+10,Start_Time__c =system.today(),Releases__c = release.ID);
     insert ValueDeliverySetup;
     
     Value_Delivery_Setup__c vds = new Value_Delivery_Setup__c(Id=itemkey,name ='Test Delivery',Project_Phase__c='Initiate and Confirm',Value_Delivery_Session__c=ValueDeliverySetup.ID,Component_Title__c = '',Sequence_Order__c=-1);
     insert vds;
     
     Value_Delivery_Setup__c vdsp = new Value_Delivery_Setup__c(name ='Test Delivery',Project_Phase__c='Initiate and Confirm',Value_Delivery_Session__c=ValueDeliverySetup.ID,Component_Title__c = 'Test Component');
     //insert vdsp;
     
     Value_Delivery_Objectives_Options__c  deliverysetup = new Value_Delivery_Objectives_Options__c (Objectives_and_Attendees_for_Participant__c=vds.Id,Id=itemkey,Sequence_No__c =1,Option_Description__c ='');
     insert deliverysetup;
     
     Value_Delivery_User_Config__c vdU = new Value_Delivery_User_Config__c();
     vdu.Name = 'TestUser';           
     vdu.Selected_Session__c = ValueDeliverySetup.id;
     insert vdu;
     
     ApexPages.CurrentPage().getparameters().put('valueDeliveryOptionsID', deliverysetup.id);
     ApexPages.CurrentPage().getparameters().put('valueDeliveryObjID', vds.id);  

     SaaSOverviewCompCtrl Comp= new SaaSOverviewCompCtrl();
     comp.newObjectivesOptions = deliverysetup;     
     comp.valueDeliveryObjectiveObj = vds;
     comp.valueDeliveryObj = vdsp;
     comp.itemList = vds;
     comp.updateValueDeliveryObjective(); 
        
     comp.valueDeliveryObjectiveObj = vdsp;
     comp.deleteValueDeliveryObjective();  
          
     comp.valueDelOptionObj = deliverysetup;
     comp.updateValueDeliveryOption();
     comp.insertBusinessOption();  
     comp.getValueDeliveryObjective();   
   }
    
}