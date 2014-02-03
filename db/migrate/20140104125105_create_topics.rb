class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.text :content
      t.float :hot, index: true, default: 0.0
      t.integer :comments_count, default: 0
      t.boolean :trashed, default: false

      t.timestamps
    end
  end
end
