class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug, index: true
      t.text :description
      t.integer :topics_count, default: 0

      t.timestamps
    end
  end
end
