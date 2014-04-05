class RemovePasswordResetTokenInUsers < ActiveRecord::Migration
  def change
    remove_column :users, :password_reset_token
    remove_column :users, :password_reset_token_created_at
  end
end
