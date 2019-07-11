public class NS_CallerSelectionWrapperController{
    public String inboundANI{get;set;}
    public PageReference NS_CallerSelectionWrapperController(){    
        inboundANI= ApexPages.currentPage().getParameters().get('ANI');     
        System.debug('ANI: '+inboundANI);
        PageReference pageRef = new PageReference('/lightning/n/Caller_Selection');
        //pageRef.getParameters().put('ANI', inboundANI);
        //5.28, jlong, change to algin with Summer '19 release of page redirect query parameter namespace 
        pageRef.getParameters().put('c__ANI', inboundANI);
        pageRef.setRedirect(true);
        return pageRef;
    }
}