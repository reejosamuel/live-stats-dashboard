class AddFieldsToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :sale, :float
    add_column :messages, :refund, :float
    add_column :messages, :tip, :float
    add_column :messages, :void, :float
    remove_column :messages, :content, :text
  end
end
