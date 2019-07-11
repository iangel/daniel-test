({ getContact: function(component, event, helper) {
    var action = component.get("c.getContact");
    action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS") {
            var conId=response.getReturnValue();
            if (conId !== null && conId!== '' &&  conId!== undefined ){
                var values=[{
                    type:'Case',
                    id:conId
                }];
                component.find('contactid').get("v.body")[0].set('v.values', values);
            }
            else {
                 component.find('contactid').get("v.body")[0].set('v.values', "");
            }
        }
    });
    $A.enqueueAction(action);
},

  
  fetchPicklistValues: function(component,objDetails,controllerField, dependentField,mapAttrName) {
        // call the server side function  
        var action = component.get("c.getDependentOptionsImpl");
        // pass paramerters [object definition , contrller field name ,dependent field name] -
        // to server side function 
        action.setParams({
            'contrfieldApiName': controllerField,
            'depfieldApiName': dependentField 
        });
        //set callback   
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                //store the return response from server (map<string,List<string>>)  
                var StoreResponse = response.getReturnValue();
                // once set #StoreResponse to depnedentFieldMap attribute 
                component.set(mapAttrName,StoreResponse);
                
                if(mapAttrName == 'v.depnedentFieldMap'){

                    // create a empty array for store map keys(@@--->which is controller picklist values) 
                    var listOfkeys = []; // for store all map keys (controller picklist values)
                    var ControllerField = []; // for store controller picklist value to set on lightning:select. 
                    
                    // play a for loop on Return map 
                    // and fill the all map key on listOfkeys variable.
                    for (var singlekey in StoreResponse) {
                        listOfkeys.push(singlekey);
                    }
                    
                    //set the controller field value for lightning:select
                    if (listOfkeys != undefined && listOfkeys.length > 0) {
                        ControllerField.push('--- None ---');
                    }
                    
                    for (var i = 0; i < listOfkeys.length; i++) {
                        ControllerField.push(listOfkeys[i]);
                    }  
                    // set the ControllerField variable values to country(controller picklist field)
                    component.set("v.listControllingValues", ControllerField);
                }
            }else{
                alert('Something went wrong..');
            }
        });
        $A.enqueueAction(action);
    },
    
    fetchDepValues: function(component, ListOfDependentFields,lstAttrName) {
        // create a empty array var for store dependent picklist values for controller field  
        var dependentFields = [];
        dependentFields.push('--- None ---');
        for (var i = 0; i < ListOfDependentFields.length; i++) {
            dependentFields.push(ListOfDependentFields[i]);
        }
        // set the dependentFields variable values to store(dependent picklist field) on lightning:select
        component.set(lstAttrName, dependentFields);
        
    },
/*Brief description :  Changes are being implemented Case Creation Form: Remove “Status” field and add “Origin”	
*Defect no./wa/request no: WA#744
*Developer Name : Moumita Sarangi
*Date :17/01/2019*/  
//getData: function(component, event, helper, category, reason, description, status,priority, subject, contactid, onBehalfOfId,caseType){
  getData: function(component, event, helper, category, reason, description, origin, subject, contactid, onBehalfOfId,caseType,AfterHours){
      component.set("v.spinner", true);
      if(AfterHours === true){
         var CallAfterHours = 'true';
      }
      else{
        var CallAfterHours = 'false';  
      }
      var action=component.get("c.performBackgroundActions");
       action.setParams({
          "myMap": {
                    "category": category,
                    "reason": reason,
                    "description": description,
                    "origin": origin,
                    "subject": subject,
                    "contactid": contactid,
                    "onBehalfOfId": onBehalfOfId,
                    "accountid": component.get("v.recordId"),
             		"caseType":caseType,
              		"AfterHours" : CallAfterHours
                }
      });
      action.setCallback(this, function(response){
          var state = response.getState();
          var changeFocus=false;
          if (state === "SUCCESS") {
              var id = response.getReturnValue();
              if(id[2]==="true"){
                  changeFocus=true;
              }
               component.set("v.spinner", false);
              //if(id.length===3){
              if(id.length===4 || id.length===3){
                  var workspaceAPI = component.find("workspace");
                  workspaceAPI.openTab({
                      recordId:component.get("v.recordId"),
                       focus: !changeFocus
                  }).then(function(response) {
                      workspaceAPI.openSubtab({
                          parentTabId: response,
                          recordId:id[1],
                          focus:changeFocus
                      })
                      var defaultVal = [{
                          class: "optionClass",
                          label: '--- None ---',
                          value: '--- None ---'
                      }];
                      var toastEvent = $A.get("e.force:showToast");
                      toastEvent.setParams({
                          "type":
                        	  "Success",
                          "duration":
                        	  6000,
                          "message":
                        	  "Case "+id[0]+" has been created!"
                      });
                      toastEvent.fire();
                      component.find("Subject").set("v.value", "");
                      component.find("Origin").set("v.value", "--None--");
                      component.find("Description").set("v.value", "");
                       component.find("caseType").set("v.value", "--- None ---");
                      component.find("AfterHrs").set("v.value", "");
                          
                  })
                  .catch(function(error) {
                  // console.log(error);
                  });
              }
              else{
                  component.set("v.spinner", false);
                  var toastEvent = $A.get("e.force:showToast");
                  toastEvent.setParams({
                          "title":
                        	  "Error",
                         "duration":
                        	  12000,  
                      	"type":
                        	  "error",
                          "message": id[0]
                      });
                  toastEvent.fire();
              }
          }
      });
      $A.enqueueAction(action);
  },
  ifIs3PL: function(component){
      var action=component.get("c.is3PLRecordType");
       action.setParams({
          "accId": component.get("v.recordId")
      });
      action.setCallback(this, function(response){
          var state = response.getState();
          if (state === "SUCCESS") {
              var is3PL = response.getReturnValue();
              var changeElement1 = component.find("onbehalfofdiv");
                component.set("v.is_3pl", is3PL);
              if(is3PL){
                  $A.util.toggleClass(changeElement1, "slds-hide")
              }
          }
      });
      $A.enqueueAction(action);
  },
  isOssRep: function(component){
      var ControllerMethod = component.get("c.isOssRepLoggedin");
      ControllerMethod.setCallback(this, function(response){
          var state = response.getState();
          if (state === "SUCCESS") {
              var isOssRep = response.getReturnValue();
              var AfterHours = component.find("AfterHours");
                component.set("v.isOssReploggedin", isOssRep);
              if(isOssRep == false){
                  $A.util.toggleClass(AfterHours, "slds-hide")
              }
          }
      });
      $A.enqueueAction(ControllerMethod); 
  }
 })