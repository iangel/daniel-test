({
    /**	 	 
	 * @description This function calls the apex class to release the selected cases        
	 */
    updAssgnd : function(component, event, updateId) {
        var actionOncaserelease = component.get("c.releaseCase");
        actionOncaserelease.setParams({CaseToUpdate : updateId});
        actionOncaserelease.setCallback(this, function(response){
            var resState = response.getState();
            if (resState === "SUCCESS") {
                component.set("v.isOpen", false);
            }
        });
        location.reload();
        $A.enqueueAction(actionOncaserelease);
    },

    getAssgnd : function(component, event, page, recordToDisplay) {
        var actionOngetassignedcases = component.get("c.getAssignedCases");
        actionOngetassignedcases.setParams({pageNumber: page,
                          recordNumber: recordToDisplay});
        actionOngetassignedcases.setCallback(this, function(response){
            var resState = response.getState();
            if (resState === "SUCCESS") {
                component.set("v.NsAssignedCaseList", response.getReturnValue().AssignedCaseList);
                if(response.getReturnValue().AssgndTotal===0) {
                    component.set("v.page", 0);
                }else {
                    component.set("v.page", response.getReturnValue().AssgndPage);
                }
                component.set("v.pages", Math.ceil(response.getReturnValue().AssgndTotal / recordToDisplay));
            }
        });
        $A.enqueueAction(actionOngetassignedcases);
    }
})