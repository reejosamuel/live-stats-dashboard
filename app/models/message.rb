class Message < ApplicationRecord
  after_commit {
    MessageBroadcastJob.perform_later self
  }
end
