class Message < ApplicationRecord
  enum txn_type: [:sale, :refund, :tip, :void]

  after_commit {
    MessageBroadcastJob.perform_later self
  }
end
