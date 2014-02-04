class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :subscribable, polymorphic: true, index: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
