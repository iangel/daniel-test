({
	cancelRecord : function(component, event, helper) {
		
        var homeEvt = $A.get("e.force:navigateToObjectHome");
homeEvt.setParams({
    "scope": "Case"
});
homeEvt.fire();
        
	}
})