/** 
 *  Author : Accenture 
 *  Description : Question Log Wrapper class 
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  05\06\2015        created 
 *
 */
public class SaaSQuestionLogWrapper
{
    public Boolean checked{ get; set;}
    public Question_Log__c questionLogObj{ get; set;}  
       
   /**
    * Construtor 
    * @param Question_Log__c questObj
    *
    */   
    public SaaSQuestionLogWrapper(Question_Log__c questObj)
    {
        questionLogObj = questObj;
        checked = false;
    }      
}