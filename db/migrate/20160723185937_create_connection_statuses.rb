class CreateConnectionStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :connection_statuses do |t|
      t.boolean :status

      t.timestamps
    end
  end
end
