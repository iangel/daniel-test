/**@author  Accenture
* @Created Date 2019-03-11
* @version  1.0
* @description This class conatins method to restrict user on closing parent case if Internal request is open.
*/ 

public without sharing class NS_ChildRequestClosureRestriction {

    /*Class Name*/    
    private static final String CLASS_NAME = 'NS_ChildRequestClosureRestriction';

       
    /*Method Name*/ 
    private static final String METHOD_NAME='closeCaseAlert';
 
    /**@author-  Accenture
*  @description- To restrict user on closing parent case if Internal request is open.
*  Record Type based on Contact Status,auto-create and auto-update Associated Account based on Contact's primary Account name. 
*  @param- List of contacts
*  @return- None
*  @throws- None
*/     
   
    public static void closeCaseAlert(list<case> newcase){

  
        try{
        list<case> countCase= new list<case>();       
       
        for(case caseNew: newcase)
            {
        for(case caseRequest:[select id from case where parentid=:casenew.id and status NOT IN ('NS_Closed' ,'NS_Cancelled') and
                      RecordType.Name=:'NS Internal' LIMIT 100])
        {
            
          countcase.add(caseRequest);
            
        }
                  if( casenew.status.equals('NS_Closed') && countcase.size()>0 )
        {
            casenew.addError(NS_StaticVariablesUtility.ChildError);
        }
                
            }
        }
        
        catch(exception exp)
        {
            NS_StaticVariablesUtility.createExceptionRecord(exp, CLASS_NAME, METHOD_NAME);
            
        }
         
    }
    
    
}