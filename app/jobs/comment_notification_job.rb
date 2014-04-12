class CommentNotificationJob
  @queue = 'notification'

  def self.perform(comment_id)
    comment = Comment.find comment_id
    create_mention_notification(comment)
    create_comment_notification(comment)
  end

  def self.create_mention_notification(comment)
    users = comment.mention_users - [comment.user]
    if comment.commentable.respond_to? :ignored_users
      users = users - comment.commentable.ignored_users
    end

    users.each do |user|
      Notification.create(user: user,
                          subject: comment,
                          name: 'mention')
    end
  end

  def self.create_comment_notification(comment)
    if comment.commentable.respond_to? :subscribed_users
      users = comment.commentable.subscribed_users - comment.mention_users - [comment.user]

      users.each do |user|
        Notification.create(user: user,
                            subject: comment,
                            name: 'comment')
      end
    end
  end
end
