class NotificationMailer < ActionMailer::Base
  include Resque::Mailer

  helper :markdown, :comments

  def mention(user_id, comment_id)
    @user = User.find user_id
    @comment = Comment.find comment_id
    I18n.locale = @user.locale
    headers(message_id: "#{@comment.commentable_type.downcase.pluralize}/#{@comment.commentable_id}/#{@comment.id}@#{CONFIG['host']}",
            in_reply_to: "#{@comment.commentable_type.downcase.pluralize}/#{@comment.commentable_id}@#{CONFIG['host']}")
    mail(from: "#{@comment.user.name} <notification@#{CONFIG['host']}>",
         to: @user.email,
         subject: "#{@comment.commentable.title} ##{@comment.commentable.id}")
  end

  def comment(user_id, comment_id)
    @user = User.find user_id
    @comment = Comment.find comment_id
    I18n.locale = @user.locale
    headers(message_id: "#{@comment.commentable_type.downcase.pluralize}/#{@comment.commentable_id}/#{@comment.id}@#{CONFIG['host']}",
            in_reply_to: "#{@comment.commentable_type.downcase.pluralize}/#{@comment.commentable_id}@#{CONFIG['host']}")
    mail(from: "#{@comment.user.name} <notification@#{CONFIG['host']}>",
         to: @user.email,
         subject: "#{@comment.commentable.title} ##{@comment.commentable.id}")
  end
end
