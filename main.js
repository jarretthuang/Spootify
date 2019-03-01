
$(document).ready(function(){
    var random_boolean = Math.random() >= 0.5;
    if (random_boolean) {
        $("body").css("background-color", "white");
        $("body").css("filter", "invert(100%)");
    }
    
    $("#join-button").click(function() {
        $(".submit-text").show();
        $(".check-submit").hide();
        $("#application-form").modal({
            fadeDuration: 100
        });
    });
    
    $("#ign-input").focusout(function() {
        jsonParser($("#ign-input").val());
    });
    
    var previousLookupName = "";
    
    function jsonParser(name) {
        if (name == "" || name == previousLookupName) return;
        var url = "https://api.silveress.ie/bns/v3/character/full/na/" + name;
        previousLookupName = name;
        showSpinner();
    
        $.getJSON(url, function(data) {
            hideSpinner();
            if (isEmpty(data)) {
                $("#char-lookup").html("Cannot find you on NA server!");
            } else {
                $("#char-lookup").html(confirmationText(data));
            }
            showCharacterLookup();
        });
    }
    
    function showCharacterLookup() {
        $("#char-lookup").show();
    }
    
    function isEmpty(obj) {
        for(var key in obj) {
            if(obj.hasOwnProperty(key))
            return false;
        }
        return true;
    }
    
    function confirmationText(char) {
        return "LV" + char.playerLevel + " HM" + char.playerLevelHM + " " + char.playerClass + " is that you?";
    }
    
    function showSpinner() {
        $(".lds-hourglass").css("opacity", "0.8");
    }
    
    function hideSpinner() {
        $(".lds-hourglass").css("opacity", "0");
    }
    
});
