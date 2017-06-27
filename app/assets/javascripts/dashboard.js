$(document).ready(function(){
  var numEvents = 0

  $('#loading-future-button').click(function() {
    $('#getting-started').slideUp()
    $('#events-spinner').slideDown()
    $('#events-table').slideDown()
    $('.events-list-row:hidden').slideDown()
    $('#loading-future-button').slideUp()

    numEvents = 0

    document.title = 'Webhooks Viewer Demo'
  })

  $('#no-events-button').click(function() {
    document.location = '/setup'
  })

  var render = function(data, hide) {
    var list = $('#events-list')

    if (list.length > 0) {
      var newListRow = $('<div>')
      newListRow.addClass('events-list-row dt-row-ns hover-bg-lightest-silver bb b--light-gray pv3 pv0-ns')

      var publishedAt = $('<div>')
      publishedAt.addClass('mw4-l db dtc-ns pv1 pr4 pv3-ns f4 f5-ns lh-copy')
      publishedAt.text(data.created_at)
      newListRow.append(publishedAt)

      var resource = $('<div>')
      resource.addClass('mw4-l db dtc-ns pv1 pr4 pv3-ns f4 lh-copy')
      resource.text(data.payload.resource)
      newListRow.append(resource)

      var action = $('<div>')
      action.addClass('mw4-l db dtc-ns pv1 pr4 pv3-ns f4 lh-copy')
      action.text(data.payload.action)
      newListRow.append(action)

      var codeBlock = $('<pre>')
      codeBlock.addClass('events-payload db dtc-ns pv1 pr3 pv3-ns f4 lh-copy')
      codeBlock.text(JSON.stringify(data.payload, null, 2))
      newListRow.append(codeBlock)

      if (hide) {
        newListRow.hide()
      }

      $('#events-list-header').after(newListRow)
    } else {
      throw "Events list not found!"
    }
  }

  $.ajax({url: "/events", dataType: 'json'}).done(function(events) {
    events.forEach(function(data) {
      render(data, false)
    })

    App.events = App.cable.subscriptions.create('EventsChannel', {
      received: function(data) {
        numEvents++

        $('#loading-future-done').text(numEvents + ' New Event' + (numEvents > 1 ? 's' : ''))
        document.title = '(' + numEvents + ') Webhooks Viewer Demo'

        $('#loading-future-button').slideDown()
        render(data, true)
      },
      connected: function() {
        $('#loading-future').css('visibility','visible')
      }
    })
  })
})
