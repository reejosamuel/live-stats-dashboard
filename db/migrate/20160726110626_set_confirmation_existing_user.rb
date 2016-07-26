class SetConfirmationExistingUser < ActiveRecord::Migration[5.0]
  def up
    User.all.update_all confirmed_at: Time.now
  end

  def down
    User.all.update_all confirmed_at: nil
  end
end
