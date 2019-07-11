/** 
 *  Author : Accenture 
 *  Description : Test class for SaaSCreateUserStoriesCtrl
 *  Created Date : 11\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  08\06\2015        created 
 *
 */
@isTest
public class SaaSValueDeliveryCtrlTest 
{
   static testMethod void ValidateSaaSValueDeliveryCtrl()
   {
       Release__c rel = SaaSTestUtility.createRelease();
       Value_Delivery_Session__c sessiom  = SaaSTestUtility.createValueDeliverySession(rel);
       
       Value_Delivery_User_Config__c vdU = new Value_Delivery_User_Config__c();
       vdu.Name = 'TestUser';      
       vdu.Selected_Session__c= sessiom.id;
       insert vdu;
       
       SaaSValueDeliveryCtrl vdc = new SaaSValueDeliveryCtrl();      
       vdc.getReleases();      
        vdc.updateValueDelSession();
       vdc.releaseID = rel.id;
       vdc.updateValueDelSession();       
       vdc.sessionID = vdu.id;
       vdc.updateValueDelSession();       
       List<SelectOption> opt = vdc.getSession();
       vdc.updateValueDelSession();
   }
  
}