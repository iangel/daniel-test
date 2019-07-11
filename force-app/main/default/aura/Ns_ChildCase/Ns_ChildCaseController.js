({
    init : function (component) {
        
 
        var controllerMethod = component.get("c.getChildcase");
        controllerMethod.setParams({ "caseId" : component.get("v.recordId")});
        // Configure response handler        
        controllerMethod.setCallback(this, function(response) {
            var state = response.getState();
            var respText = response.getReturnValue();
            var respJson = JSON.stringify(respText);
            var caseDetails = JSON.parse(respJson);
            if (state === "SUCCESS") {
                
                
                var massageCase=caseDetails.Message;
                if(caseDetails.Message === true){
                    
                    //alert(casedetails.AccountId);
                    var accid= caseDetails.AccountId;
                    var conid= caseDetails.ContactId;
                    var casesubject= caseDetails.Subject;
                    
                    
                    var flow = component.find("flowData");     
                    
                    
                    var inputVariables = [
                        {
                            name : "ParentId",
                            type : "String",
                            value: component.get("v.recordId")
                        },
                     /*   {
                            name : "AccountofCase",
                            type : "String",
                            value: accid
                        },
                        {
                            name : "ContactOfCase",
                            type : "String",
                            value: conid
                        }, */                  
                        {
                            name : "Casesubject",
                            type : "String",
                            value: casesubject
                        }
                        
                    ];
                    
                    // In the component whose aura:id is "flowData, start your flow
                    // and initialize the account sObject variable. Reference the flow's
                    // Unique Name.
                    flow.startFlow("flCase_InternalRequest",inputVariables);
                    
                }
                
                else
                {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Not Authorized!!!",
                        "message": "This Case is Closed. If additional work is required, update Status to Working."
                    });
                    toastEvent.fire();
                   // alert('This is a request,you cannot raise any request for this.!!!');
                }
            }         
            else if (state === "INCOMPLETE") {
               
            }
                else if (state === "ERROR") {
                   
                }
                    else {
                      
                    }
        });
        $A.enqueueAction(controllerMethod);
    }
})