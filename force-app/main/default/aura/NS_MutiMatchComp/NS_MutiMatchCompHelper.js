({ // Update tab label
    UpdateTabLabel : function(component, ANI, interval){
        var formattedphone = 'Caller Selection';
        if(ANI !== undefined){
            if(ANI.length === 10){
                formattedphone = '('+ANI.slice(0, 0+3)+') '+ANI.slice(3, 3+3)+'-'+ANI.slice(6, 6+4);
            }else{
                formattedphone = ANI;
            }
        }
        // Sets the Lightning component Tab name. known issue https://success.salesforce.com/issues_view?id=a1p3A0000001D3FQAU
        var workspaceAPI = component.find("workspace");
        workspaceAPI.getFocusedTabInfo().then(function(response) {
            var focusedTabId = response.tabId;
            workspaceAPI.setTabLabel({
                tabId: focusedTabId,
                label: formattedphone
            });
        })
        // Sets the Lightning componenet Tab name
        window.clearInterval(interval);
    },
    closeFocusedTab : function(component) {
        var workspaceAPI = component.find("workspace");
        workspaceAPI.getFocusedTabInfo().then(function(response) {
        var focusedTabId = response.tabId;
        workspaceAPI.closeTab({tabId: focusedTabId});
        });
    },
  setPhoneNumber : function(component) {
      var ANI = component.get("v.ANI");
      var formattedphone;
      var action = component.get('c.setPhoneNumber');
      action.setParams({ "phone" : ANI });
      action.setCallback(this, $A.getCallback(function (response) {
          var state = response.getState();
          if (state === "SUCCESS") {
              if(ANI !== undefined && ANI.length === 10){
                  formattedphone = '('+ANI.slice(0, 0+3)+') '+ANI.slice(3, 3+3)+'-'+ANI.slice(6, 6+4);
              }else{
                  formattedphone = ANI;
              }
              component.set('v.PhoneNumber', formattedphone);
              component.set('v.PhoneNumberUnformatted', ANI);
          } else if (state === "ERROR") {
              var errors = response.getError();
          }
      }));
      $A.enqueueAction(action);
  },
  runMatchLogic : function(component) {
      var action = component.get('c.runMatchLogic');
      action.setCallback(this, $A.getCallback(function (response) {
          var state = response.getState();
          if (state === "SUCCESS") {
              component.set('v.ShowNoRecordModal', !response.getReturnValue());
              // https://success.salesforce.com/issues_view?id=a1p3A000000mCRqQAM&title=lightning-component-force-showtoast-displays-toast-message-behind-action-window-in-lightning-experience-and-salesforce1
              if(!response.getReturnValue()){
				var toastEvent = $A.get("e.force:showToast");
             	toastEvent.setParams({
                     "type": "error",
                     "message": "This phone number is not stored in ConnectNS. Please search for the Account.",
					 "title": "No Record Found"
             	});
             	toastEvent.fire();
              }
            } else if (state === "ERROR") {
              var errors = response.getError();
          }
      }));
      $A.enqueueAction(action);
  },
  getAccData : function(component) {
      var action = component.get('c.getMatchedAccounts');
      action.setCallback(this, $A.getCallback(function (response) {
          var state = response.getState();
          if (state === "SUCCESS") {
              if ($.fn.DataTable !== undefined){
                  if ($.fn.DataTable.isDataTable( '#MatchedAccountsTbl' ) ){
                      $('#MatchedAccountsTbl').DataTable().destroy();
                  }
              }
              var dataSet = response.getReturnValue().accountRecords;
              var length = response.getReturnValue().accountRecords.length;
              component.set('v.currComp', "v.myAccdata");
              component.set('v.myAccdata', dataSet);
              if(length > 0){
                  setTimeout(function(){
                      if ( ! $.fn.DataTable.isDataTable( '#MatchedAccountsTbl' ) ){
                          $('#MatchedAccountsTbl').DataTable({
                              "oLanguage": {
                                  "sSearch":
                                  "Filter:"
                              },
                              "sScrollX": "100%",
                              "sScrollXInner": "100%"
                          });
                      }else{
                          $('#MatchedAccountsTbl').DataTable({
                              "oLanguage": {
                                  "sSearch":
                                  "Filter:"
                              },
                              "sScrollX": "100%",
                              "sScrollXInner": "100%"
                          });
                      }
                  }, 500);
              }
          } else if (state === "ERROR") {
              var errors = response.getError();
          }
      }));
      $A.enqueueAction(action);
  },
  getContactsByAccId : function(component, event, helper) {
      component.set("v.ShowContinue", false);
      component.set('v.selectedAccount', event.currentTarget.dataset.aid);
      var action = component.get('c.getContactByAccId');
      action.setParams({
          "accId" : event.currentTarget.dataset.aid,
          "ANI" : component.get('v.PhoneNumberUnformatted')
      });
      action.setCallback(this, $A.getCallback(function (response) {
          var state = response.getState();
          if (state === "SUCCESS") {
              if ($.fn.DataTable.isDataTable( '#MatchedContactsTbl' ) ){
                  $('#MatchedContactsTbl').DataTable().destroy();
              }
              component.set('v.myCondata', response.getReturnValue());
              if(response.getReturnValue().length !== 0){
                  setTimeout(function(){
                      if ( ! $.fn.DataTable.isDataTable( '#MatchedContactsTbl' ) ){
                          $('#MatchedContactsTbl').DataTable({
                              "oLanguage": {
                                  "sSearch":
                                  "Filter:"
                              },
                              "sScrollX": "100%",
                              "sScrollXInner": "100%"
                          });
                      }else{
                          $('#MatchedContactsTbl').DataTable({
                              "oLanguage": {
                                  "sSearch":
                                  "Filter:"
                              },
                              "sScrollX": "100%",
                              "sScrollXInner": "100%"
                          });
                      }
                  }, 100);
              }
          } else if (state === "ERROR") {
              var errors = response.getError();
          }
      }));
      $A.enqueueAction(action);
  },
  getAccSearchData : function(component, event, helper) {
      var action;
      action = component.get('c.fetchNextRecords');
      action.setParams({
          "param" : component.get('v.searchAcc'),
          "offset" : component.get('v.offset'),
          "nameOrPhone" : component.get('v.selectedValue'),
          "reclimit" : component.get('v.reclimit')
      });
      action.setCallback(this, $A.getCallback(function (response) {
          var state = response.getState();
          if (state === "SUCCESS"){
              if( $.fn.DataTable.isDataTable( '#AccountSearchTbl' ) ){
                  $('#AccountSearchTbl').DataTable().destroy();
              }
              component.set('v.ShowAccountSearch', true);
              component.set('v.myAccSearchData', response.getReturnValue().accountRecords);
              if(component.get('v.myAccSearchData').length !== 0){
                  setTimeout(function(){
                      if ( ! $.fn.DataTable.isDataTable( '#AccountSearchTbl' ) ){
                          $('#AccountSearchTbl').DataTable({
                              "oLanguage": {
                                  "sSearch":
                                  "Filter:"
                              },
                              "sScrollX": "100%",
                              "sScrollXInner": "100%"
                          });
                      }else{
                          $('#AccountSearchTbl').DataTable({
                              "oLanguage": {
                                  "sSearch":
                                  "Filter:"
                              },
                              "sScrollX": "100%",
                              "sScrollXInner": "100%"
                          });
                      }
                  }, 500);
              }
          } else if (state === "ERROR") {
              var errors = response.getError();
          }
      }));
      $A.enqueueAction(action);
  },
  getConSearchData : function(component, event, helper) {
      var action;
      action = component.get('c.fetchNextConRecords');
      action.setParams({
          "param" : component.get('v.searchCon'),
          "offset" : component.get('v.conoffset'),
          "nameOrPhone" : component.get('v.selectedValue'),
          "reclimit" : component.get('v.reclimit')
      });
      action.setCallback(this, $A.getCallback(function (response) {
          var state = response.getState();
          if (state === "SUCCESS") {
              if ($.fn.DataTable.isDataTable( '#ContactSearchTbl' ) ){
                  $('#ContactSearchTbl').DataTable().destroy();
              }
              component.set('v.ShowContactSearch', true);
              component.set('v.myConSearchdata', response.getReturnValue().contactRecords);
              if(component.get('v.myConSearchdata').length !== 0){
                  setTimeout(function(){
                      if ( ! $.fn.DataTable.isDataTable( '#ContactSearchTbl' ) ){
                          $('#ContactSearchTbl').DataTable({
                              "oLanguage": {
                                  "sSearch":
                                  "Filter:"
                              },
                              "sScrollX": "100%",
                              "sScrollXInner": "100%"
                          });
                      }else{
                          $('#ContactSearchTbl').DataTable({
                              "oLanguage": {
                                  "sSearch":
                                  "Filter:"
                              },
                              "sScrollX": "100%",
                              "sScrollXInner": "100%"
                          });
                      }
                  }, 500);
              }
          } else if (state === "ERROR") {
              var errors = response.getError();
          }
      }));
      $A.enqueueAction(action);
  },
   createrecinAssocAc : function(component, event, helper) {
      var action=component.get("c.associateAccount");
      action.setParams({
           "myMap": {
               		 "accId": component.get("v.selectedAccount"),
                     "conId": component.get("v.storeSelectedContact")
           			}
           });
      action.setCallback(this, function(response){
          var state = response.getState();
          if (state === "SUCCESS") {
              var isSaved = response.getReturnValue();
              if(isSaved==="true"){
                  var toastEvent = $A.get("e.force:showToast");
                      toastEvent.setParams({
                          "type":
                        	  "Success",
                          "duration":
                        	  5000,
                          "message":
                        	  "Association created successfully!"
                      });
                      toastEvent.fire();
              }else{
                  var toastEvent = $A.get("e.force:showToast");
                      toastEvent.setParams({
                          "type":
                        	  "error",
                          "duration":
                        	  5000,
                          "message":
                        	 "Association already exists!"
                      });
                      toastEvent.fire();
              }
            }
          });
      $A.enqueueAction(action);
  },
  storeAccConId : function(component, event, helper) {
      component.set("v.ShowContinue", true);
      var accountId = event.currentTarget.dataset.aid;
      var contactId = event.currentTarget.dataset.cid;
      component.set("v.storeSelectedAccount", accountId);
      component.set("v.storeSelectedContact", contactId);
  },
  updateCustomSettings : function(component, event, helper) {
      // var accId = event.currentTarget.dataset.aid;
      // var cId = event.currentTarget.dataset.cid;
      var accId = component.get('v.selectedAccount');
      var cId = component.get("v.storeSelectedContact");
      // var selectedRows = event.getParam('selectedRows');
      var action = component.get('c.updateCustomSettings');
      action.setParams({ "accId" : accId, "conId" :cId });
      action.setCallback(this, $A.getCallback(function (response) {
          var state = response.getState();
          if (state === "SUCCESS") {
              var isDummy = response.getReturnValue();
              if(accId!==undefined && !isDummy){
                  var focusedTabId;
                  var workspaceAPI = component.find("workspace");
        workspaceAPI.getFocusedTabInfo().then(function(response) {
             focusedTabId = response.tabId;
        });
                  var workspaceAPI = component.find("workspace");
                      workspaceAPI.openTab({
                          recordId: accId,
                          focus: true
                  }).then(function(response) {
                      workspaceAPI.openSubtab({
                          parentTabId: response,
                          recordId: cId,
                          focus: false
                      })
                     workspaceAPI.closeTab({tabId: focusedTabId})
                  });
              }
              else {// redirects to Contact page for orphaned contacts
                  var workspaceAPI = component.find("workspace");
                   workspaceAPI.getFocusedTabInfo().then(function(response) {
                  var focusedTabId = response.tabId;
                  workspaceAPI.closeTab({tabId: focusedTabId});
              }).then(function(response) {
                  workspaceAPI.openTab({
                      recordId: cId,
                      focus: true
                  })
                   });
              }
             } else if (state === "ERROR") {
              var errors = response.getError();
          }
      }));
      $A.enqueueAction(action);
  }
 })