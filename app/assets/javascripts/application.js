//= require jquery
//= require action_cable
//= require_self
//= require_tree ./channels

this.App = {};
App.cable = ActionCable.createConsumer();

// Malibu
$('<div>').load('https://www.herokucdn.com/malibu/latest/sprite.svg', function() {
    $("body").append($(this).html());
});
