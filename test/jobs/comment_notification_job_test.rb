require 'test_helper'

class CommentNotificationJobTest < ActiveSupport::TestCase
  test "should create mention notifications" do
    user = create(:user, confirmed: true)
    comment = create(:comment, body: "@#{user.username}")

    assert_difference ["user.notifications.named('mention').count", "ActionMailer::Base.deliveries.count"] do
      CommentNotificationJob.create_mention_notification(comment)
    end
  end

  test "should no create mention notification if use ignore" do
    user = create(:user, send_mention_web: false, send_mention_email: false)
    comment = create(:comment, body: "@#{user.username}")

    assert_no_difference ["user.notifications.named('mention').count", "ActionMailer::Base.deliveries.count"] do
      CommentNotificationJob.create_mention_notification(comment)
    end
  end

  test "shuold create comment notifications for subscribed_users" do
    user = create(:user, confirmed: true)
    topic = create(:topic, user: user)
    comment = create(:comment, commentable: topic)

    assert_difference ["user.notifications.named('comment').count", "ActionMailer::Base.deliveries.count"] do
      CommentNotificationJob.create_comment_notification(comment)
    end
  end

  test "shuold not create comment notifications for subscribed_users if user ignore" do
    user = create(:user, send_comment_web: false, send_comment_email: false)
    topic = create(:topic, user: user)
    comment = create(:comment, commentable: topic)

    assert_no_difference ["user.notifications.named('comment').count", "ActionMailer::Base.deliveries.count"] do
      CommentNotificationJob.create_comment_notification(comment)
    end
  end
end
