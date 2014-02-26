class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.belongs_to :user, index: true
      t.belongs_to :category, index: true
      t.string :title
      t.text :body
      t.float :hot, default: 0.0
      t.integer :comments_count, default: 0
      t.integer :likes_count, default: 0
      t.integer :subscriptions_count, default: 0
      t.boolean :trashed, default: false

      t.timestamps
    end

    add_index :topics, :hot
  end
end
