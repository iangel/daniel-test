/**
* @Author : Accenture IDC Team
* @Description : class that supports messages displayed on visualforce pages.
* @Version : 1.0
*/
public with sharing class SasSCustomPageMessages 
{

    public String CustomPageMessages_ClosableErrorsRenderPlaceHolder 
    {
        get { 
            if(CustomPageMessages_ClosableErrorsRenderPlaceHolder == null) CustomPageMessages_ClosableErrorsRenderPlaceHolder = ''; 
            return CustomPageMessages_ClosableErrorsRenderPlaceHolder; 
        }
        private set;
    } 

    public List<SaaSPageMessages.PageMessage> getPageMessages() 
    {
        return SaaSPageMessages.getMessages();
    }    
}