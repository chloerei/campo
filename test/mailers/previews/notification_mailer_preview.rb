# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  def mention
    user = User.first || create(:user)
    comment = Comment.first || create(:comment, body: '@username')
    NotificationMailer.mention(user.id, comment.id)
  end

  def comment
    user = User.first || create(:user)
    comment = Comment.first || create(:comment, body: '@username')
    NotificationMailer.comment(user.id, comment.id)
  end
end
