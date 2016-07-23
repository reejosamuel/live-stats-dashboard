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

    // debugger

    if ("txn_type" in data) {
      var key = data["txn_type"];

      var total_value = data["total_value"];
      var total_count = data["total_count"];


      if (total_value != null) {
        set_transaction_data (key, total_value, false);
      }

      if (total_count != null) {
        set_transaction_data (key, total_count, true);
      }
    }

    // if (key === "connection_status") {
    //   var connection_status = value == true ? "green" : "red";
    //   var elem = $(".pulse-card .pulse-button")
    //   elem.removeClass("red").removeClass("green");
    //   elem.addClass(connection_status)
    // }
  },

  speak: function(message) {
    // return this.perform('speak', {
    //   sale: message
    // });
  },
});

function set_transaction_data(key, value, count_type = false) {

  var typeString = count_type ? "count" : "value";
  var amountString = "";
  // format 2 decimal places
  if (count_type == false) {
    value = parseFloat(value).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
    var amountArr = value.split(".");
    amountString = $("<strong class=\"card-value\"><small>AED </small>" + amountArr[0] + "<small>." + amountArr[1] + "</small></strong>");
  } else {
    amountString = $("<strong class=\"card-value\">" + value + "</strong>");
  }

  // animate the transition
  $("." + key + "." + typeString + " .card-value").fadeOut("slow", function(){
     var div = amountString.hide();
     $(this).replaceWith(amountString);
     $("." + key + " .card-value").fadeIn("slow");
  });

  $("." + key + " .card-timestamp").on('change.livestamp',
    function(event, from, to) {
      event.preventDefault();
      $(this).html("Last update: " + to);
    }).livestamp(new Date()
  );
}

