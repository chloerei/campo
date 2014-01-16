class CreatePostVotes < ActiveRecord::Migration
  def change
    create_table :post_votes do |t|

      t.references :user, index: true
      t.references :post, index: true
      t.boolean :up

      t.timestamps
    end

    add_index :post_votes, [:user_id, :post_id], unique: true
  end
end
