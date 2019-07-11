({/**	 	 
	 * @description This is the controller JS to fetch the picklist values.        
	 */
    doInit: function(component, event, helper) {
        helper.getContact(component, event, helper);
        helper.ifIs3PL(component);
        helper.isOssRep(component);
        
        
        // POC
        var controllingFieldAPI = component.get("v.controllingFieldAPI");
        var dependingFieldAPI = component.get("v.dependingFieldAPI");
        var subDependingFieldAPI = component.get("v.subDependingFieldAPI");
        
        var objDetails = component.get("v.objDetail");
        // call the helper function
        helper.fetchPicklistValues(component,objDetails,controllingFieldAPI, dependingFieldAPI, "v.depnedentFieldMap");
        
        // 2nd and 3ed picklist 
        helper.fetchPicklistValues(component,objDetails,dependingFieldAPI, subDependingFieldAPI, "v.subDepnedentFieldMap");
        
    },
    
    onControllerFieldChange: function(component, event, helper) {     
        var controllerValueKey = event.getSource().get("v.value"); // get selected controller field value
        var depnedentFieldMap = component.get("v.depnedentFieldMap");
        
        if (controllerValueKey != '--- None ---') {
            // disable and reset sub dependent field 
           
           
            var ListOfDependentFields = depnedentFieldMap[controllerValueKey];
            
            if(ListOfDependentFields.length > 0){
                component.set("v.bDisabledDependentFld" , false);  
                helper.fetchDepValues(component, ListOfDependentFields,"v.listDependingValues");    
            }else{
                component.set("v.bDisabledDependentFld" , true); 
                component.set("v.listDependingValues", ['--- None ---']);
            }  
            
        } else {
            component.set("v.listDependingValues", ['--- None ---']);
            component.set("v.bDisabledDependentFld" , true);
        }
        
        component.set("v.bDisabledSubDependentFld" , true);
        component.set("v.typeFieldrequired" , false); 
        component.set("v.listSubDependingValues", ['--- None ---']);
    },      
    onSubControllerFieldChange : function(component, event, helper) {     
        var controllerValueKey = event.getSource().get("v.value"); // get selected sub controller field value
        var depnedentFieldMap = component.get("v.subDepnedentFieldMap");
       
        if (controllerValueKey != '--- None ---') {
            var ListOfDependentFields = depnedentFieldMap[controllerValueKey];
            if(ListOfDependentFields.length > 0){
                component.set("v.bDisabledSubDependentFld" , false);  
                 component.set("v.typeFieldrequired" , true);  
                helper.fetchDepValues(component, ListOfDependentFields,"v.listSubDependingValues");    
            }else{
                component.set("v.bDisabledSubDependentFld" , true); 
                 component.set("v.typeFieldrequired" , false);  
                component.set("v.listSubDependingValues", ['--- None ---']);
            }  
            
        } else {
            component.set("v.listSubDependingValues", ['--- None ---']);
            component.set("v.bDisabledSubDependentFld" , true);
            component.set("v.typeFieldrequired" , false); 
        }
    },
    
    
    onSubmit: function(component, event, helper) {
        var contactId =component.find("contactid").get("v.value");
        var callCategory= component.find("callCategory").get("v.value"); 
        var caseType=component.find("caseType").get("v.value"); 
        var callReason = component.find("callReason").get("v.value"); 
        var callSubject=component.find("Subject").get("v.value");
        var callOrigin=component.find("Origin").get("v.value");
        var callAfterHours=component.find("AfterHrs").get("v.value");
/*Brief description :  Changes are being implemented Case Creation Form: Remove “Status” field and add “Origin”	
*Defect no./wa/request no: WA#744
*Developer Name : Moumita Sarangi
*Date :17/01/2019*/
        var callDescription= component.find("Description").get("v.value");
        var onBehalfofid =component.find("onbehalfofid").get("v.value");
         if(contactId  === '') {
             var toastEvent = $A.get("e.force:showToast");
             toastEvent.setParams({
                 "type":
                	 "warning",
                 "message":
                	 "Please select a Contact!"
             });
             toastEvent.fire();
          }
        else if(onBehalfofid==='' && component.get("v.is_3pl")) {
               var toastEvent = $A.get("e.force:showToast");	
            toastEvent.setParams({	
                "type":
                	"warning",
                "message":
                	"Contacting on behalf of cannot be blank"	
            });	
            toastEvent.fire();	
          }
        else if(callCategory  === '--- None ---' || callCategory==='' ) {
        
            var toastEvent = $A.get("e.force:showToast");
             toastEvent.setParams({
                 "type":
                	 "warning",
                 "message":
                	"Interaction Category can not be blank."
             });
             toastEvent.fire();                     
          }
      else if(callReason  === '--- None ---') {        
            var toastEvent = $A.get("e.force:showToast");
             toastEvent.setParams({
                 "type":
                	 "warning",
                 "message":
                	"Interaction Reason can not be blank."
             });
             toastEvent.fire();  
          }
       else if (callSubject === '' || callSubject === undefined) {
            var toastEvent = $A.get("e.force:showToast");
             toastEvent.setParams({
                 "type":
                	 "warning",
                 "message":
                	"Subject can not be blank."
             });
             toastEvent.fire();  
          }
        else {
              
              helper.getData(component, event, helper, callCategory, callReason, 
                             callDescription, callOrigin, callSubject, contactId, onBehalfofid,caseType,callAfterHours);
        }
    },
    handleError: function(component, event){
        var errorsArr  = event.getParam("errors");
        for (var i = 0; i < errorsArr.length; i++) {
        }
    },
     showSpinner: function(component, event, helper) {
      component.set("v.spinner", true);
   },
    hideSpinner : function(component, event, helper){
           component.set("v.spinner", false);
    }
 })