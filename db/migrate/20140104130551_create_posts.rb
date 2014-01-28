class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :topic, index: true
      t.references :user, index: true
      t.text :content
      t.integer :post_number
      t.integer :like_users_count, default: 0
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
