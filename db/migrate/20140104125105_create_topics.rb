class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.references :user, index: true
      t.string :title
      t.float :hot, index: true, default: 0.0
      t.integer :posts_count, default: 0

      t.timestamps
    end
  end
end
