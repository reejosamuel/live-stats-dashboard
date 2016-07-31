# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
    # when we know a client is subscribed, preload the values
    Message.all.each do |message|
      ActionCable.server.broadcast 'room_channel', message
    end

    # ConnectionStatus.all.each do |message|
    #   ActionCable.server.broadcast 'room_channel', message
    # end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak data
    # client sends data to server here
    # Message.create content: data['sale']
  end
end
