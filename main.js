$(function(){
    ws = new WebSocket("ws://localhost:51234");
    ws.onmessage = function(evt) {
        $("#msg").append("<p>"+evt.data+"</p>");
    };
    
    ws.onclose = function() {
        console.log("socket closed")
    };

    ws.onopen = function() {
        ws.send("hello server");
    };

    $("#input").keypress(function(e){
        if(e.keyCode ==13){
            var val = $("#input").val()
            ws.send(val)
            $("#input").val("")
        }
    });
});
