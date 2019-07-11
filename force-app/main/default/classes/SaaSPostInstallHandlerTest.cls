/** 
 *  Author : Accenture 
 *  Description : Test Class for SaaSPostInstallHandler  class
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  09\06\2015        created 
 *
 */
@isTest
public class SaaSPostInstallHandlerTest
{
    static testMethod void installTest() 
    {
        SaaSPostInstallHandler  postinstall = new SaaSPostInstallHandler();
        Test.testInstall(postinstall, null, true);
    }
}