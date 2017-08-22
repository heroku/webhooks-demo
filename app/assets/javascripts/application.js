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

$(document).on('click', '.js-dropdown', function(e) {
  e.stopImmediatePropagation();
  return $(this).closest('.dropdown').toggleClass('dropdown-is-open');
});

$(document).on('click', function(e) {
  return $('.js-dropdown').closest('.dropdown').removeClass('dropdown-is-open');
});
