class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :username_lower
      t.string :name
      t.string :email
      t.text   :bio

      t.timestamps
    end
  end
end
