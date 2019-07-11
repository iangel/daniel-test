({ 
  getData: function(component, event, helper, srContactId,srSubject,
                       trainId,equipment,srDescription,SelectedQ,accId,onBehalfOfId){
      var action=component.get("c.processData");
      action.setParams({
          "myMap": {
              "srContactId":srContactId,
              "srSubject": srSubject,
              "trainId":trainId,
              "equipment":equipment,
              "srDescription": srDescription,
              "SelectedQ" : SelectedQ,
              "accId" : accId,
              "onBehalfOfId": onBehalfOfId
          }
      });
      action.setCallback(this, function(response){
       var workspaceAPI = component.find("workspace");
         var resultSet = response.getReturnValue();  
       
          var isCasecreated=resultSet['isCasecreated'];
          if(isCasecreated){
                component.set("v.caseNumber",resultSet['caseNumber']);
               component.set("v.myRecordId",resultSet['caseId']);
               component.set("v.isOpen", true);
    
              component.find('srContactid').get("v.body")[0].set('v.values', "");
              component.find("srSubject").set("v.value", "");
              component.find("trainId").set("v.value", "");
              component.find("equipment").set("v.value", "");              
              component.find("srDescription").set("v.value", "");
              component.find("BU").set("v.value", "");
              component.find("Queue").set("v.value", "");
          
          }else{
              var toastEvent = $A.get("e.force:showToast");
                      toastEvent.setParams({
                          "type":
                        	  "Success",
                          "duration":
                        	  6000,
                          "message":
                        	  "Case  has not been created!"
                      });
                      toastEvent.fire();
          }
       					//component.find("srContactId").set("v.value", "");
         			//	component.find("trainId").set("v.value", "");
          			//	component.find("noOfrailcar").set("v.value", "");
//          				component.find("railcarNumber").set("v.value", ""); 
                      //  component.find("srStatus").set("v.value", "--None--");
                      //  component.find("srPriority").set("v.value", "--None--");
                     //   component.find("srDescription").set("v.value", "");
                           
     });
      $A.enqueueAction(action);
  },
 
   fetchPicklistValues: function(component, controllerField, controllerValueKey, dependentField) {
       // call the server side function  
      var action = component.get("c.getDependentOptionsImpl");
      // pass paramerters [object name , contrller field name ,dependent field name] -
      // to server side function 
 
      action.setParams({
         'objApiName': component.get("v.objInfo"),
         'contrfieldApiName': controllerField,
         'controllerLabelName' : controllerValueKey,
         'depfieldApiName': dependentField
      });
      //set callback   
      action.setCallback(this, function(response) {
         if (response.getState() == "SUCCESS") {
            //store the return response from server (map<string,List<string>>)  
            var StoreResponse = response.getReturnValue();
 
            // once set #StoreResponse to depnedentFieldMap attribute 
            // 
            if(dependentField=='NS_Queue__c') {
                 component.set("v.QueueFieldMap", StoreResponse);
                console.log(StoreResponse);
            }
            // create a empty array for store map keys(@@--->which is controller picklist values) 
 
            var listOfkeys = []; // for store all map keys (controller picklist values)
            var ControllerField = []; // for store controller picklist value to set on ui field. 
 
            // play a for loop on Return map 
            // and fill the all map key on listOfkeys variable.
            for (var singlekey in StoreResponse) {
               listOfkeys.push(singlekey);
            }
 
            //set the controller field value for ui:inputSelect  
            if (listOfkeys != undefined && listOfkeys.length > 0) {
               ControllerField.push({
                  class: "optionClass",
                  label: "--- None ---",
                  value: "--- None ---"
               });
            }
 
            for (var i = 0; i < listOfkeys.length; i++) {
               ControllerField.push({
                  class: "optionClass",
                  label: listOfkeys[i],
                  value: listOfkeys[i]
               });
            }
            // set the ControllerField variable values to country(controller picklist field)
            // 
            if(controllerField=='NS_Owner_Business_Unit__c') {
                 component.find('BU').set("v.options", ControllerField);
            }
         }
          else if(response.getState() == "ERROR") {
              console.log('error in response: ');
              console.log(response.getError());
          }
      });
      $A.enqueueAction(action);
   },
 
   fetchDepValues: function(component, ListOfDependentFields, dependentFieldName) {
      // create a empty array var for store dependent picklist values for controller field)  
      var dependentFields = [];
 
      if (ListOfDependentFields != undefined && ListOfDependentFields.length > 0) {
         dependentFields.push({
            class: "optionClass",
            label: "--- None ---",
            value: "--- None ---"
         });
 
      }
      for (var i = 0; i < ListOfDependentFields.length; i++) {
         dependentFields.push({
            class: "optionClass",
            label: ListOfDependentFields[i],
            value: ListOfDependentFields[i]
         });
      }
       if(dependentFieldName=='NS_Queue__c') {
           component.find('Queue').set("v.options", dependentFields);
           component.set("v.isBUDisabled", false);
       }
       
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
  }
})