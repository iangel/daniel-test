({
    createRecord : function (component, event, helper) {
        var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
            "entityApiName": "Contact",
            "defaultFieldValues": {
                'AccountId' : component.get('v.recordId')
            }
        });
        createRecordEvent.fire();
    }
})