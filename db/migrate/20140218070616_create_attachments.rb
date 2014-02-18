class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.belongs_to :user, index: true
      t.string :file

      t.timestamps
    end
  end
end
