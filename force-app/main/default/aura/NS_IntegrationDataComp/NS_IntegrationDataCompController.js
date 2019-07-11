({
   init: function (component, event, helper) {
        var action = component.get('c.hideSummarypage');
        action.setParams({ "accId" : component.get("v.recordId") });
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var res=response.getReturnValue();
                if(res==="NA"){
                    component.set("v.hideSummarypane", false);                    
                } 
                
                else{
                   if(res==="Service - Online"){
                    var a = component.get('c.checkClassCode');
        			$A.enqueueAction(a);
                   }
                   else if(res==="Service - Offline"){
                     var a = component.get('c.checkClassCode');
        			$A.enqueueAction(a);                   
                       component.set("v.hideSummarypane", false); 
                    }
             
                }
            } else if (state === "ERROR") {
                var errors = response.getError();
                // console.error(errors);
            }
            
        }));
        $A.enqueueAction(action);
        
        
    },
    openModalTED : function(component, event, helper) {
        helper.GetTEDData(component, event, helper);
        component.set("v.open_transitexception_dtl", true);
    },
    closeModalTED: function(component, event, helper) {
        component.set("v.open_transitexception_dtl", false);
    },
    showDetailRecord : function(component, event, helper) {
        // helper.GetTEDData(component, event, helper);
    },
    openModalEquipmentSummary : function(component, event, helper) {
        component.set("v.open_equipsummary_modal", true);
    },
    closeModalEquipmentSummary: function(component, event, helper) {
        component.set("v.open_equipsummary_modal", false);
    },
    openModalTransit : function(component, event, helper) {
        component.set("v.isOpenTransit", true);
    },
    closeModalTransit: function(component, event, helper) {
        component.set("v.isOpenTransit", false);
    },
    openModalGeneral : function(component, event, helper) {
        component.set("v.isOpenGeneral", true);
    },
    closeModalGeneral: function(component, event, helper) {
        component.set("v.isOpenGeneral", false);
    },
    openModalSpecial : function(component, event, helper) {
        component.set("v.isOpenSpecial", true);
    },
    closeModalSpecial: function(component, event, helper) {
        component.set("v.isOpenSpecial", false);
    },
    openModalSWindow : function(component, event, helper) {
        component.set("v.isOpenSWindow", true);
    },
    closeModalSWindow: function(component, event, helper) {
        component.set("v.isOpenSWindow", false);
    },
    openModalLOPA : function(component, event, helper) {
        component.set("v.isOpenLOPA", true);
    },
    closeModalLOPA: function(component, event, helper) {
        component.set("v.isOpenLOPA", false);
    },
    openModalCrew : function(component, event, helper) {
        component.set("v.isOpenCrew", true);
    },
    closeModalCrew: function(component, event, helper) {
        component.set("v.isOpenCrew", false);
    },
    getSelectedRow : function(component, event, helper) {
        helper.GetTEDDataNew(component, event, helper);
        component.set("v.open_transitexception_dtl", true);
    },

    display : function(component, event, helper) {
        helper.toggleHelper(component, event);
    },
    
    displayOut : function(component, event, helper) {
        helper.toggleHelper(component, event);
    },

     checkClassCode:function (component, event, helper) {
          var action = component.get('c.checkConditions');
        action.setParams({ "accId" : component.get("v.recordId") });
                  action.setCallback(this, $A.getCallback(function (response) {
                      var state = response.getState();
                      if (state === "SUCCESS") {
                            var res=response.getReturnValue();
                            if(res===true){
                                helper.invokePipelineData(component, event, helper);
                                // alert("Development in progress! Do not work on this page");
                            }else{
                                helper.invokeTYESGetCustomerSummary(component, event, helper);
                            }
                        }else if (states === "ERROR") {
                                        var errors = response.getError();
                    // console.error(errors);
                }
                  }));
                     $A.enqueueAction(action);
        
     
    },
    openAEMS: function(component, event, helper) {
        var action = component.get('c.getAemsUrl');
        action.setParams({ "accId" : component.get("v.recordId") });
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var aemsButtonUrl = response.getReturnValue();
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": aemsButtonUrl
                });
                urlEvent.fire();
            } else if (state === "ERROR") {
                var errors = response.getError();
            }
        }));
        $A.enqueueAction(action);
    },
    
    openCTMSShipmentStatus:function(component, event, helper) {
        var action = component.get('c.getShipmentStatus');
        action.setParams({ "accId" : component.get("v.recordId") });        
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var ctmsShipmentUrl = response.getReturnValue();
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": ctmsShipmentUrl
                });
                urlEvent.fire();
            } else if (state === "ERROR") {
                var errors = response.getError();
            }
        }));
        $A.enqueueAction(action);
    },
    
    openCTMSTrainSetInquiry:function(component, event, helper) {
        var action = component.get('c.getTrainSetEnquiry');
        action.setParams({ "accId" : component.get("v.recordId") });        
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var ctmsTrainsetUrl = response.getReturnValue();
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": ctmsTrainsetUrl
                });
                urlEvent.fire();
            } else if (state === "ERROR") {
                var errors = response.getError();
            }
        }));
        $A.enqueueAction(action);
    },

    openTeams:function(component, event, helper) {
        var action = component.get('c.getTeamsUrl');
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var teamsAppUrl =response.getReturnValue();
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": teamsAppUrl
                });
                urlEvent.fire();
            } else if (state === "ERROR") {
                var errors = response.getError();
            }
        }));
        $A.enqueueAction(action);
    },
    
    openAccessNSPortal : function(component, event, helper) {
        var action = component.get('c.getStationClassCode');
        action.setParams({ "accId" : component.get("v.recordId") });
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var url = response.getReturnValue();
                var urllink = url+$A.get("$Label.c.NS_AccessNSPortal");
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": urllink
                });
                urlEvent.fire();
            } else if (state === "ERROR") {
                var errors = response.getError();
            }
        }));
        $A.enqueueAction(action);
    },

    openReceiving : function(component, event, helper) {
        var action = component.get('c.getStationClassCode');
        action.setParams({ "accId" : component.get("v.recordId") });
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var url = response.getReturnValue();
                var urllink = url+$A.get("$Label.c.NS_Receivingtabs");
                //"https://accessnsuat.nscorp.com/accessNS_decoupling/login/#setCustomer/"+stationclasscode+"/receivingtabs";
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": urllink
                });
                urlEvent.fire();
            } else if (state === "ERROR") {
                var errors = response.getError();
            }
        }));
        $A.enqueueAction(action);
    },

    openOnsite : function(component, event, helper) {
        var action = component.get('c.getStationClassCode');
        action.setParams({ "accId" : component.get("v.recordId") });
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var url = response.getReturnValue();
                var urllink = url+$A.get("$Label.c.NS_OnsiteInventory");
                // var urllink = "https://accessnsuat.nscorp.com/accessNS_decoupling/login/#setCustomer/"+stationclasscode+"/onsiteInventoryTabs";
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": urllink
                });
                urlEvent.fire();
            } else if (state === "ERROR") {
                var errors = response.getError();
            }
        }));
        $A.enqueueAction(action);
    },

    openShipping : function(component, event, helper) {
        var action = component.get('c.getStationClassCode');
        action.setParams({ "accId" : component.get("v.recordId") });
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                if ($.fn.DataTable.isDataTable( '#MatchedContactsTbl' ) ){
                    $('#MatchedContactsTbl').DataTable().destroy();
                }
                var url = response.getReturnValue();
                var urllink =url+$A.get("$Label.c.NS_Shipping");
                // var urllink = "https://accessnsuat.nscorp.com/accessNS_decoupling/login/#setCustomer/"+stationclasscode+"/shippingTabs";
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": urllink
                });
                urlEvent.fire();
            } else if (state === "ERROR") {
                var errors = response.getError();
            }
        }));
        $A.enqueueAction(action);
    },
    
    handleSectionToggle: function (cmp, event, helper) {
        
        var openSections = event.getParam('openSections');
        
        if (openSections.length === 0) {
            // kept for future logics
        } else {
            helper.GetCarRequestDataForCurrentWeek(cmp, event, helper);
        }
    },
    
    handleSectionToggleLopa: function (cmp, event, helper) {
        var openSections = event.getParam('openSections');
        
        if (openSections.length === 0) {
            // kept for future logics
        } else {
            cmp.set('v.lopa_datacols', [
                {label: 'Non Compliant CustomerRSN', fieldName: 'NonCompliantCustomerRSN', type: 'text'},
                {label: 'Non Compliant RRRSN', fieldName: 'NonCompliantRRRSN', type: 'text'},
                {label: '% Fail CustRsn', fieldName: 'PercentFailureCustRsn', type: 'text'},
                {label: '% Fail RRRsn', fieldName: 'PercentFailureRRRsn', type: 'text'},
                {label: '% Total Fail', fieldName: 'PercentTotalFailure', type: 'text'},
                {label: 'Total Pending', fieldName: 'TotalPending', type: 'text'},
                {label: 'Total Planned', fieldName: 'TotalPlanned', type: 'text'}
            ]);
            helper.getDataLopa(cmp, event, helper);
            
        }
    },

    handleSectionToggleTES: function (cmp, event, helper) {
        
        var openSections = event.getParam('openSections');
        
        if (openSections.length === 0) {
            // kept for future logics
        } else {
            helper.GetTECData(cmp, event, helper);
        }
    },

    handleSectionTogglerouteReport: function (cmp, event, helper) {
        var openSections = event.getParam('openSections');
        
        if (openSections.length === 0) {
            // kept for future logics
        } else {
            helper.GetCrewData(cmp, event, helper);
        }
    }
})