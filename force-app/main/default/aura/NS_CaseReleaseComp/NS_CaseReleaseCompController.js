({
    /**	 	 
	 * @description This is the controller JS to fetch the assigned cases and release the selected cases.        
	 */
    openModal: function(component, event, helper) {
        component.set("v.isopen", true);
        var pageValue = component.get("v.page") || 1;
        var recordToDisplay = component.find("recordSize").get("v.value");
        helper.getAssgnd(component, event, pageValue, recordToDisplay);
    },
    closeModal: function(component, event, helper) {
        component.set("v.isopen", false);
    },
    chkboxSlct: function(component, event, helper) {
        var selectedRec = event.getSource().get("v.value");
        var selectedId= event.getSource().get("v.text");
        var actionOnretainownership = component.get("c.setRetainOwnership");
        actionOnretainownership.setParams({csId : selectedId});
        actionOnretainownership.setCallback(this, function(response){
            var resState = response.getState();
        });
        $A.enqueueAction(actionOnretainownership);
        var pageValue = component.get("v.page") || 1;
        var recordToDisplay = component.find("recordSize").get("v.value");
        helper.getAssgnd(component, event, pageValue, recordToDisplay);
        var getSelectedNumber = component.get("v.selectedcount");
        if (selectedRec === true) {
            getSelectedNumber++;
        } else {
            getSelectedNumber--;
        }
        component.set("v.selectedcount", getSelectedNumber);
    },
    releaseCs: function(component, event, helper) {
        var updateId = [];
        var checkedId = component.find("checked");
        if(component.find("checked")=== undefined) {
            component.set("v.isOpen", true);
            }else{
            if(!Array.isArray(checkedId)) {
                if (checkedId.get("v.value") === true) {
                    updateId.push(checkedId.get("v.text"));
                }
            }else{
                for (var i = 0; i < checkedId.length; i++) {
                    if (checkedId[i].get("v.value") === true) {
                        updateId.push(checkedId[i].get("v.text"));
                    }
                }
            }
            helper.updAssgnd(component, event, updateId);
        }
    },
    navigateRecord: function(component, event, helper) {
        var pageValue = component.get("v.page") || 1;
        var directionValue = event.getSource().get("v.label");
        var recordToDisplay = component.find("recordSize").get("v.value");
        pageValue = directionValue === "Previous" ? (pageValue - 1) : (pageValue + 1);
        helper.getAssgnd(component, event, pageValue, recordToDisplay);
    },

    onSelect: function(component, event, helper) {
        var page = 1
        var recordToDisplay = component.find("recordSize").get("v.value");
        helper.getAssgnd(component, event, page, recordToDisplay);
    },
})