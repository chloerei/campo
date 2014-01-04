class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.references :user, index: true

      t.timestamps
    end
  end
end
