class AddConfirmedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirmed, :boolean, default: false
  end
end
