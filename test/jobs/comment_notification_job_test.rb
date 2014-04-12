require 'test_helper'

class CommentNotificationJobTest < ActiveSupport::TestCase
  test "should create mention notifications" do
    user = create(:user)
    comment = create(:comment, body: "@#{user.username}")

    assert_difference "user.notifications.named('mention').count" do
      CommentNotificationJob.create_mention_notification(comment)
    end
  end

  test "should no create mention notification if use ignore" do
    user = create(:user, send_mention_web: false)
    comment = create(:comment, body: "@#{user.username}")

    assert_no_difference "user.notifications.named('mention').count" do
      CommentNotificationJob.create_mention_notification(comment)
    end
  end

  test "shuold create comment notifications for subscribed_users" do
    user = create(:user)
    topic = create(:topic)
    topic.subscribe_by user
    comment = create(:comment, commentable: topic)

    assert_difference "user.notifications.named('comment').count" do
      CommentNotificationJob.create_comment_notification(comment)
    end
  end

  test "shuold not create comment notifications for subscribed_users if user ignore" do
    user = create(:user, send_comment_web: false)
    topic = create(:topic)
    topic.subscribe_by user
    comment = create(:comment, commentable: topic)

    assert_no_difference "user.notifications.named('comment').count" do
      CommentNotificationJob.create_comment_notification(comment)
    end
  end
end
