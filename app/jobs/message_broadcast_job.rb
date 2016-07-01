class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform message
    # Broadcast baby!
    # byebug
    ActionCable.server.broadcast 'room_channel', message
  end

end
