class CreatePostLikes < ActiveRecord::Migration
  def change
    create_table :post_likes, id: false do |t|
      t.references :post
      t.references :user
    end

    add_index :post_likes, [:user_id, :post_id], unique: true
  end
end
