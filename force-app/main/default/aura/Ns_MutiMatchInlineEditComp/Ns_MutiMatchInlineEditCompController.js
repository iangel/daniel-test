({doInit : function(component, event, helper) {
        // To be called on page load
        // call apply highlights
        component.set("v.prevData", component.get("v.Data"));
        helper.applyHightlights(component, event, helper);
    },
    inlineEdit : function(component, event, helper) {
        helper.setDefaults(component, event, helper);
        helper.selectChange(component, event, helper);
        // after the 100 millisecond set focus to input field   
        setTimeout(function(){
            component.find("inputId").focus();
        }, 100);
    },
    onChange : function(component, event, helper) {
        // if edit field value changed and field not equal to blank,
        // then show save and cancel button by set attribute to true
        var resValue = event.getSource().get("v.value");
        if( resValue === 'undefined' && resValue.trim()=== '') {
            component.set("v.showSaveCancelBtn", true);
        }else {
            helper.toggleHightlights(component, event, helper);
        }
    },
    rndrHilght : function(component, event, helper){
    // To render Highlight
        var isTrue = (component.get("v.Data") === component.get("v.default"));
        var divElement = component.find("pDiv");
        if(isTrue) {
           if(component.get("v.Sn") === '1') {
                $A.util.addClass(divElement, "exactmatch");
            }
            if(component.get("v.Sn") === '2') {
                $A.util.addClass(divElement, "exactmatch");
            }
            if(component.get("v.Sn") === '3') {
                $A.util.addClass(divElement, "exactmatch");
            }
            if(component.get("v.Sn") === '4') {
                $A.util.addClass(divElement, "exactmatch");
            }
            }else {
             $A.util.removeClass(divElement, "alternatematch");
             $A.util.removeClass(divElement, "exactmatch");
        }
    },
    closeBox : function (component, event, helper) {
      // on focus out, close the input section by setting the 'nameEditMode' att. as false   
        component.set("v.nameEditMode", false);
      // check if change/update Name field is blank, then add error class to column -
      // by setting the 'showErrorClass' att. as True , else remove error class by setting it False   
        var resValue = event.getSource().get("v.value");
        if( resValue === 'undefined' && resValue.trim()=== '') {
            component.set("v.showErrorClass", true);
        }else {
            component.set("v.showErrorClass", false);
        }
    },
    saveWrkphn: function(component, event, helper) {
        var actionComp = component.get("c.saveContactDetails");
        actionComp.setParams({
            'Id': component.get("v.contact").Id,
            'data': component.get("v.Data"),
            'sn': component.get("v.Sn")
        });
        actionComp.setCallback(this, function(response) {
            var responseState = response.getState();
            if (responseState === "SUCCESS") {
                var resMess = response.getReturnValue().description;
                if(response.getReturnValue().code === '1') {
                    component.set("v.Data", component.get("v.prevData"));
                    helper.showToast(component, event, helper, 'ERROR', 'error', resMess);
                }else {
                    helper.showToast(component, event, helper, 'Success', 'success', resMess);
                }
                helper.selectChange(component, event, helper);
            }else {
                helper.showToast(component, event, helper, 'Error', 'error', resMess);
            }
        });
        $A.enqueueAction(actionComp);
    },
    onCancel : function(component, event, helper){
        helper.selectChange(component, event, helper);
		component.set("v.Data", component.get("v.prevData"));
    },
    slctChnge : function(component, event, helper) {
        helper.setDefaults(component, event, helper);
        helper.selectChange(component, event, helper);
    },
    // These two are probably not being used. Avinash needs to confirm  
    showComponent : function (component, event, helper) {
      $A.util.removeClass(component.find("yourIdentifier"), "slds-hide");
    },
    hideComponent : function (component, event, helper) {
      $A.util.addClass(component.find("yourIdentifier"), "slds-hide");
    }
})