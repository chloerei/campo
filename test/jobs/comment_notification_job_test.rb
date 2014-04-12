require 'test_helper'

class CommentNotificationJobTest < ActiveSupport::TestCase
  test "should create_mention_notifications" do
    user = create(:user)
    comment = create(:comment, body: "@#{user.username}")

    assert_difference "user.notifications.named('mention').count" do
      CommentNotificationJob.create_mention_notification(comment)
    end
  end

  test "shuold create_comment_notifications for subscribed_users" do
    user = create(:user)
    topic = create(:topic)
    topic.subscribe_by user
    comment = create(:comment, commentable: topic)

    assert_difference "user.notifications.named('comment').count" do
      CommentNotificationJob.create_comment_notification(comment)
    end
  end
end
