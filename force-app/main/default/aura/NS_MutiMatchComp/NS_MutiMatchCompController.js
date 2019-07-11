({ // init
    init: function (component, event, helper) {
        var today = new Date();
        var minInc = 2;
        var secInc = 0;
        var sec = 60*minInc+secInc;
        var secToDisp = 0;
    	var myPageRef = component.get("v.pageReference");
        //5.9, jlong add default namespace prefix due to SF'19 citical update 
        //var ANI = myPageRef.state.ANI;
        if ( myPageRef.state.ANI )
        {
            var ANI = myPageRef.state.ANI;
        }else {
        	var ANI = myPageRef.state.c__ANI;    
        }
        component.set("v.ANI", ANI);
        var interval = window.setInterval(
        $A.getCallback(function() {
                helper.UpdateTabLabel(component, ANI, interval);
            }), 1000
        );
        var interval1 = window.setInterval(
            $A.getCallback(function() {
           	if(sec >= 0){      	
                if((sec%60) === 0){
                    secToDisp = 0;
                    minInc--;
                }else{
                    secToDisp = sec%60;
                }
                if((secToDisp+'').length === 1){
                    secToDisp = minInc+':0'+secToDisp;
                }else{
                    secToDisp = minInc+':'+secToDisp;
                }
                // component.set('v.lastModifiedDate',secToDisp);
                if(sec === 0){
                   window.clearInterval(interval1);
                   // helper.closeFocusedTab(component);                    
                }
                sec--;
               }
            }), 1000
        );
        if(ANI !== undefined && ANI !== ""){
            helper.setPhoneNumber(component);
            helper.runMatchLogic(component);
            if(!component.get('v.ShowNoRecordModal')){
                helper.getAccData(component);
            }
        }
    },
    handlePageChange: function(component, event, helper) {
        var myPageRef = component.get("v.pageReference");
        var ANI = myPageRef.state.ANI;
        component.set("v.ANI", ANI);
       },
    getContactsByAccId : function (component, event, helper) {
    	helper.getContactsByAccId(component, event, helper);
    },
  	onEnterKeyAC : function (component, event, helper) {
        if(event.getParams().keyCode === 13){
    	 helper.getAccSearchData(component, event, helper);
        }
    },
    ShowAccountSearches : function (component, event, helper) {
        helper.getAccSearchData(component, event, helper);
        },
    ShowContactSearches : function (component, event, helper) {
        helper.getConSearchData(component, event, helper);
        },
  	onEnterKeyContact : function (component, event, helper) {
        if(event.getParams().keyCode === 13){
    	  helper.getConSearchData(component, event, helper);
        }
    },
    StoreSelectedAccountContact : function (component, event, helper) {
        helper.storeAccConId(component, event, helper);
	},
    OpenSelectedAccount : function (component, event, helper) {
        helper.updateCustomSettings(component, event, helper);
	},
    createAccountRecord : function (component, event, helper) {
        var action = component.get('c.getOfflineAccountId');
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                helper.closeFocusedTab(component);
            	var createRecordEvent = $A.get("e.force:createRecord");
            	createRecordEvent.setParams({
            	"entityApiName": "Account",
            	"recordTypeId" : response.getReturnValue(),
				"defaultFieldValues": {
					"NS_OfflineContactWorkPhone__c" : component.get('v.PhoneNumberUnformatted')
                }
                });
                createRecordEvent.fire();
            } else if (state === "ERROR") {
                var errors = response.getError();
                }
        }));
        $A.enqueueAction(action);
	},
    createContactRecord : function (component, event, helper) {
    	helper.closeFocusedTab(component);
        var createRecordEvent = $A.get("e.force:createRecord");
        var selacc = component.get('v.selectedAccount');
        createRecordEvent.setParams({
            "entityApiName": "Contact",
            "defaultFieldValues": {
            	"AccountId" : selacc,
				"Phone" : component.get('v.PhoneNumberUnformatted')
        	}
        });
        createRecordEvent.fire();
	},
   createAssocContactRecord : function (component, event, helper) {
        if( component.get("v.selectedAccount")=== undefined && component.get("v.storeSelectedContact")=== undefined){
             var toastEvent = $A.get("e.force:showToast");
             toastEvent.setParams({
                 "type":
                	 "warning",
                 "message":
                	 "Please select an Account and a Contact!"
             });
             toastEvent.fire();
        }
        else if( component.get("v.selectedAccount")=== undefined ){
           var toastEvent = $A.get("e.force:showToast");
             toastEvent.setParams({
                 "type":
                	 "warning",
                 "message":
                	 "Please select an Account!"
             });
             toastEvent.fire();
        }
         else if( component.get("v.storeSelectedContact")=== undefined ){
           var toastEvent = $A.get("e.force:showToast");
             toastEvent.setParams({
                 "type":
                	 "warning",
                 "message":
                	 "Please select a Contact!"
             });
             toastEvent.fire();
        }
        else if( component.get("v.selectedAccount")!== undefined  && component.get("v.storeSelectedContact")!== undefined ){
        helper.createrecinAssocAc(component, event, helper);
        }
	},
    closeNoRecMod: function(component, event, helper) {
        component.set("v.ShowNoRecordModal", false);
    }
})