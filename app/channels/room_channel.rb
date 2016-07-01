# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
    # when we know a client is subscribed, preload the values
    ActionCable.server.broadcast 'room_channel', Message.first
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak data
    # ActionCable.server.broadcast 'room_channel', message: data["message"]
    Message.create content: data['sale']
  end
end
