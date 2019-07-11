({
   /* GetMetricsSummary : function(component, event, helper) {
		var action = component.get('c.getMetricsSummary');
        action.setParams({ "accId" : component.get("v.recordId") });
        action.setCallback(this, $A.getCallback(function (response) {
        }));
        $A.enqueueAction(action);
    },*/
	
 	helperFun : function(component,event,secId) {
	  var acc = component.find(secId);
        	for(var cmp in acc) {
        	$A.util.toggleClass(acc[cmp], 'slds-show');  
        	$A.util.toggleClass(acc[cmp], 'slds-hide');  
       }
	},
	 invokePipelineData: function(component, event, helper){
        var action = component.get('c.getPipeLineData');  
        action.setParams({ "accId" : component.get("v.recordId") });
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {               
                 component.set('v.equipsummary_data', response.getReturnValue().EquipmentElement);
                
            }else if (states === "ERROR") {
                var errors = response.getError();
                // console.error(errors);
            }
        }));
        $A.enqueueAction(action);
    },
    invokeTYESGetCustomerSummary : function(component, event, helper) {
		var action = component.get('c.invokeTYESGetCustomerSummary');
        action.setStorable();
        action.setParams({ "accId" : component.get("v.recordId") });
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.swdata', response.getReturnValue().scheduleElement);
                component.set('v.equipsummary_data', response.getReturnValue().EquipmentElement);
                	if(response.getReturnValue().GeneralInstructionElement !== undefined){
                    	component.set('v.general_instruction_p1', response.getReturnValue().GeneralInstructionElement.string1);
                		component.set('v.general_instruction_p2', response.getReturnValue().GeneralInstructionElement.string2);
                    }
                if(response.getReturnValue().SpecialInstructionElement !== undefined){
                   component.set('v.special_instruction', response.getReturnValue().SpecialInstructionElement.string1);
                   component.set('v.special_instruction_l2', response.getReturnValue().SpecialInstructionElement.string2);
                    /*component.set('v.special_instruction', response.getReturnValue().SpecialInstructionElement);*/
                   
                }                
            } else if (state === "ERROR") {
                var errors = response.getError();
              // console.error(errors);
            }
        }));
        $A.enqueueAction(action);
    },

    getDataLopa : function(component, event, helper) {
		var action = component.get('c.getLopaData');
          action.setStorable();
        action.setParams({ "accId" : component.get("v.recordId") });
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
              //  var parsed = JSON.parse(response.getReturnValue());
            	// console.log('success has '+response.getReturnValue()+'Records');
				//component.set('v.lopadata',parsed);
               component.set('v.lopadata',response.getReturnValue()); 
            } else if (state === "ERROR") {
                var errors = response.getError();
                // console.error(errors);
            }
        }));
        $A.enqueueAction(action);
    },

    GetTECData : function(component, event, helper) {
		var action = component.get('c.invokeTransitExceptionCount');
          action.setStorable();
        action.setParams({ "accId" : component.get("v.recordId") });
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                if ($.fn.DataTable.isDataTable( '#TES' ) ){
                   $('#TES').DataTable().destroy();
                }
                if(response.getReturnValue().length === 0){
                }else{
                    component.set('v.tecdata', response.getReturnValue());
                    setTimeout(function(){
                        $('#TES').DataTable({
                            "oLanguage": {
                                "sSearch":
                                "Filter Records:"
                             }
                        }, 100)});
                }
           } else if (state === "ERROR") {
                var errors = response.getError();
                // console.error(errors);
            }
        }));
        $A.enqueueAction(action);
    },

    GetTEDDataNew : function(component, event, helper) {
        component.set('v.teddata', "");
        var action = component.get('c.invokeTransitExceptionDetail');
        action.setParams({
            "accId" : component.get("v.recordId"),
            "equipmentInit" : event.currentTarget.dataset.init,
            "equipmentNr" : event.currentTarget.dataset.nr,
            "waybillSrNr" : event.currentTarget.dataset.srnr
        });	
           action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
            	// console.log('success has '+response.getReturnValue()+'Records');
				
                component.set('v.teddata', response.getReturnValue());
            } else if (state === "ERROR") {
                var errors = response.getError();
                // console.error(errors);
            }
        }));
        $A.enqueueAction(action);
    },

    GetCrewData : function(component, event, helper) {
		var action = component.get('c.GetCrewData');
        action.setStorable();
        action.setParams({ "accId" : component.get("v.recordId") });
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
            	var v = response.getReturnValue();
                // console.log('success has '+v.length+'Records');
				component.set('v.route_reportdata', v);
            } else if (state === "ERROR") {
                var errors = response.getError();
                // console.error(errors);
            }
        }));
        $A.enqueueAction(action);
	},

    GetCarRequestDataForCurrentWeek : function(component, event, helper) {
		var action = component.get('c.getCarRequestService');
       action.setStorable();
       action.setParams({ "accId" : component.get("v.recordId") });
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
            	var v = response.getReturnValue();
                if(v!=null && Object.keys(v).length!=0){
                   var c= v.length;
					component.set('v.carRequestServiceCurrentWeek', v['currentWeek']);
                    component.set('v.carRequestServiceNextWeek', v['nextWeek']);
                }else{
                   component.set('v.showCarRequestCurrentWeek', false);
                   component.set('v.showCarRequestNextWeek', false);
                }
            } else if (state === "ERROR") {
                var errors = response.getError();
                // console.error(errors);
            }
        }));
        $A.enqueueAction(action);
	},
    
    toggleHelper : function(component, event) {
    	var toggleText = component.find("tooltip");
    	$A.util.toggleClass(toggleText, "toggle");
   }
    
})