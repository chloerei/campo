class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true
      t.references :subject, polymorphic: true, index: true
      t.string :name
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
