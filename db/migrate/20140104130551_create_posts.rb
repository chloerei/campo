class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :post_number
      t.references :topic, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
