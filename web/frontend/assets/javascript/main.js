

$(runApp);
let isDarkMode = true;

function runApp() {
    init();
    randomizeTheme();

}

function randomizeTheme() {
    let random_boolean = Math.random() >= 0.5;
    if (random_boolean) {
        let body = $("body");
        body.css("background-color", "white");
        body.css("filter", "invert(100%)");
        $(".do-not-invert").css("filter", "invert(100%)");
        isDarkMode = false;
    }
}

function init() {
    $("#login-button").click(function() {
        $(".submit-text").show();
        $(".check-submit").hide();
        $(".popup-form").modal({
            fadeDuration: 100
        });
    });
}

function sendQuery(query) {
    return new Promise(function(fulfill, reject) {
        try {
            let request = new XMLHttpRequest();
            request.open("POST", "/query", true);
            request.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            request.onload = function() {
                console.log("request" + request);
                console.log("request.responseText" + request.responseText);
                let result = request.responseText;
                console.log(result);
                if (request.status === 200) {
                    fulfill(result);
                } else {
                    reject(result);
                }

            };
            request.send(JSON.stringify(query));
        } catch (e) {
            reject(e);
        }
    });
}

function jsonParser(name) {
    //TODO
    // if (name === "" || name === previousLookupName) return;
    // let url = "https://api.silveress.ie/bns/v3/character/full/na/" + name;
    // previousLookupName = name;
    // showSpinner();
    //
    // $.getJSON(url, function(data) {
    //     hideSpinner();
    //     if (isEmpty(data)) {
    //         $("#char-lookup").html("Cannot find you on NA server!");
    //     } else {
    //         $("#char-lookup").html(confirmationText(data));
    //     }
    //     showCharacterLookup();
    // });
}

function isEmpty(obj) {
    for(let key in obj) {
        if(obj.hasOwnProperty(key))
            return false;
    }
    return true;
}
