class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :email_lower
      t.string :username
      t.string :username_lower
      t.string :password_digest
      t.text   :bio
      t.string :avatar
      t.string :locale
      t.datetime :locked_at
      t.string :password_reset_token
      t.datetime :password_reset_token_created_at

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :email_lower, unique: true
    add_index :users, :username, unique: true
    add_index :users, :username_lower, unique: true
  end
end
