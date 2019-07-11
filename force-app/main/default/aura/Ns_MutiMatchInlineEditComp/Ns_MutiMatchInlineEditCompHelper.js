({selectChange : function(component, event, helper) {
        var changeElement1 = component.find("div1");
        var changeElement2 = component.find("div2");
        $A.util.toggleClass(changeElement1, "slds-hide");
        $A.util.toggleClass(changeElement2, "slds-hide");
    },
    applyHightlights : function(component, event, helper) {
        var divElement = component.find("pDiv");
        if(component.get("v.Sn") === '1' && component.get("v.contact").WorkPhoneMatch) {
            $A.util.addClass(divElement, "alternatematch");
        }
        if(component.get("v.Sn") === '2' && component.get("v.contact").isExactMatch) {
            $A.util.addClass(divElement, "exactmatch");
        }
        if(component.get("v.Sn") === '3' && component.get("v.contact").Other_PhoneMatch) {
            $A.util.addClass(divElement, "alternatematch");
        }
        if(component.get("v.Sn") === '4' && component.get("v.contact").Other_Phone2Match) {
            $A.util.addClass(divElement, "alternatematch");
        }
    },
    toggleHightlights : function(component, event, helper) {
        var divElement = component.find("inputId");
    },
    setDefaults : function(component, event, helper) {
        if(component.get("v.default") === '') {	
        // to do
        }
        else {
            component.set("v.Data", component.get("v.default"));
        }
    },
    showToast : function(component, event, helper, title, type, message) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : title,
            message: message,
            duration:'5000',
            key: 'info_alt',
            type: type,
            mode: 'pester'
        });
        toastEvent.fire();
    },
})