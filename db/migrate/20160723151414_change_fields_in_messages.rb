class ChangeFieldsInMessages < ActiveRecord::Migration[5.0]
  def change
    remove_column :messages, :sale, :float
    remove_column :messages, :refund, :float
    remove_column :messages, :tip, :float
    remove_column :messages, :void, :float
    remove_column :messages, :connection_status, :boolean

    add_column :messages, :txn_type, :integer
    add_column :messages, :total_count, :float
    add_column :messages, :total_value, :float
  end
end
