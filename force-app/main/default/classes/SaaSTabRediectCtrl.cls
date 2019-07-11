/** 
 *  Author : Accenture 
 *  Description : Contoller Class for SaaSTabRediect VF page
 *  Created Date : 11\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  08\06\2015        created 
 *
 */
public with sharing class SaaSTabRediectCtrl 
{
    /**
     *  if the user is already selected the page it redirect the Home page or Project selection page.
     */
    public PageReference redirectPage() 
    {
        PageReference  pageRef = null;
        if(SaaSUtility.getLoggedInValueSession() != null)
        {
            pageRef = new PageReference(SaaSTextConstant.VALUE_DELIVERY_APPROACH_VF_PAGE_NAME_URL);
        }
        else
        {
            pageRef = new PageReference('/apex/SaaSValueDeliveryHome');            
        }
        return pageRef;
    }

}