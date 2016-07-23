class AddConnectionStatusToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :connection_status, :boolean
  end
end
