$(document).ready(function() {
  var path = window.location.pathname
  $('#tabs > a').each(function(_, a) {
    var tab = $(a)
    if (tab.attr('href') === path) {
      tab.addClass('b--purple')
    }
  })
})
