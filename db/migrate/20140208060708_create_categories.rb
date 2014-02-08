class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug
      t.string :slug_lower
      t.text :description
      t.integer :topics_count, default: 0

      t.timestamps
    end

    add_index :categories, :slug, unique: true
    add_index :categories, :slug_lower, unique: true
  end
end
