class AddCommentNotificationSettingsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :send_comment_email, :boolean, default: true
    add_column :users, :send_comment_web, :boolean, default: true
    add_column :users, :send_mention_email, :boolean, default: true
    add_column :users, :send_mention_web, :boolean, default: true
  end
end
