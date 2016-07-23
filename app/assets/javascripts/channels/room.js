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

    if ("status" in data) {
      // connection status
      var connection_status = data["status"] == true ? "green" : "red";
      var elem = $(".pulse-card .pulse-button")
      elem.removeClass("red").removeClass("green");
      elem.addClass(connection_status)
      updateTimestamp("pulse-card", updated_at);
      return;
    }

    if ("txn_type" in data) {
      var key = data["txn_type"];

      var total_value = data["total_value"];
      var total_count = data["total_count"];
      var updated_at  = parseRailsTime(data["updated_at"]);

      // debugger

      if (total_value != null) {
        set_transaction_data (key, total_value, false);
        updateTimestamp(key, updated_at);
      }

      if (total_count != null) {
        set_transaction_data (key, total_count, true);
        updateTimestamp(key, updated_at);
      }

      return;
    }


  },

  speak: function(message) {
    // return this.perform('speak', {
    //   sale: message
    // });
  },
});

function set_transaction_data(key, value, updated_at, count_type = false) {

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
}

function updateTimestamp(key, updated_at) {
  $("." + key + " .card-timestamp").on('change.livestamp',
  function(event, from, to) {
    event.preventDefault();
    $(this).html("Last update: " + to);
  }).livestamp(updated_at);
}


function parseRailsTime(iso8601) {
  var s = $.trim(iso8601);
  s = s.replace(/\.\d+/,""); // remove milliseconds
  s = s.replace(/-/,"/").replace(/-/,"/");
  s = s.replace(/T/," ").replace(/Z/," UTC");
  s = s.replace(/([\+\-]\d\d)\:?(\d\d)/," $1$2"); // -04:00 -> -0400
  s = s.replace(/([\+\-]\d\d)$/," $100"); // +09 -> +0900
  return new Date(s);
}
