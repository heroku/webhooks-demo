App.events = App.cable.subscriptions.create('EventsChannel', {
    received: function(data) {
        console.log(data);

        var list = $('.events-list');

        if (list.length > 0) {
          var newListRow = $('<div>');
          newListRow.addClass('events-list-row dt-row hover-bg-lightest-silver');

          var createdAt = $('<div>');
          createdAt.addClass('fl w-third pv2 mv1 pl2 f4');
          createdAt.html(data.created_at);
          $(newListRow).append(createdAt);

          var codeBlock = $('<pre>');
          codeBlock.addClass('events-payload ba b--silver br2 code lh-copy w-100 w-60-l h4 overflow-x-scroll overflow-y-scroll ph1 pv2 mv1 fl f4');
          codeBlock.html(data.payload);
          $(newListRow).append(codeBlock);

          $(list).append(newListRow);
        } else {
          throw "Events list not found!";
        }
    }
});
