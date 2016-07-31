class ConnectionStatus < ApplicationRecord
  # after_commit {
  #   MessageBroadcastJob.perform_later self
  # }
end
