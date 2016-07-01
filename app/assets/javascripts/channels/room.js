App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data
    // on the websocket for this channel

    //debugger

    _.each(data, function(value, key) {

      if (key === "sale") {
        var xxdata = Highcharts.charts[0].series[0]
        var x = (new Date()).getTime(), // current time
            y = parseFloat(value);
        xxdata.addPoint([x, y], true, true);
      }


      // format 2 decimal places
      value = parseFloat(value).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
      var amountArr = value.split(".");
      var amountString = $("<strong class=\"card-value\"><small>AED </small>" + amountArr[0] + "<small>." + amountArr[1] + "</small></strong>");

      // animate the transition
      $("." + key + " .card-value").fadeOut("slow", function(){
         var div = amountString.hide();
         $(this).replaceWith(amountString);
         $("." + key + " .card-value").fadeIn("slow");
      });
    });
  },

  speak: function(message) {
    return this.perform('speak', {
      sale: message
    });
  },
});

