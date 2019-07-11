({doInit: function(component, event, helper) {
        // call the helper function with pass [component, Controller field and Dependent Field] Api name 
      //  helper.fetchPicklistValues(component, 'NS_InteractionCategory__c', 'NS_InteractionReason__c');
    	helper.removeContactInfo(component, event, helper);
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

    onPicklistChange: function(component, event, helper) {
        // get the value of select option         
    },
    onSubmit: function(component, event, helper) {
        var acId =component.find("acId").get("v.value");
        var callCategory= component.find("callCategory").get("v.value"); 
       	var caseType=component.find("caseType").get("v.value"); 
        var callReason = component.find("callReason").get("v.value");
        var callSubject=component.find("Subject").get("v.value");
/*Brief description :  Changes are being implemented Case Creation Form: Remove “Status” field and add “Origin”	
*Defect no./wa/request no: WA#744
*Developer Name : Moumita Sarangi
*Date :17/01/2019*/
        //var callStatus=component.find("Status").get("v.value");
        //var callPriority=component.find("Priority").get("v.value");
        var callOrigin=component.find("Origin").get("v.value");
        var callDescription= component.find("Description").get("v.value");
        var callAfterHours=component.find("AfterHrs").get("v.value");
        if(callCategory  === '--- None ---') {
            component.find("callCategory").set("v.errors", [{
            message:
            	"Interaction Category can not be blank."}] );
        }
        else if(callReason  === '--- None ---') {
            component.find("callReason").set("v.errors", [{
            message:
            	"Interaction Reason can not be blank."}] );
        }
            else if (callSubject === '' || callSubject === undefined) {
                component.find("Subject").set("v.errors", [{
                message:
                	"Subject can not be blank."}] );
            }
                else {
                    component.find("callCategory").set("v.errors", null );
                    component.find("callReason").set("v.errors", null );
                    component.find("Subject").set("v.errors", null );
                    helper.getData(component, event, helper, callCategory, callReason, callDescription, callOrigin, callSubject, acId,caseType,callAfterHours);
                }
    },
    handleError: function(component, event){
        var errorsArr  = event.getParam("errors");
        for (var i = 0; i < errorsArr.length; i++) {
           // console.log("error " + i + ": " + JSON.stringify(errorsArr[i]));
        }
    },
})