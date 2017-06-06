App.events = App.cable.subscriptions.create('EventsChannel', {
    received: function(data) {
        var p = document.createElement("pre");
        console.log(data);
        p.innerHTML = JSON.stringify(data);
        document.body.appendChild(p);
    }
});
