require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "should count page" do
    topic = create(:topic)
    3.times { create :comment, commentable: topic }
    assert_equal 1, topic.comments.order(id: :asc).first.page(2)
    assert_equal 1, topic.comments.order(id: :asc).second.page(2)
    assert_equal 2, topic.comments.order(id: :asc).last.page(2)
  end

  test "should get mention_users" do
    user1 = create :user, username: 'user1'
    user2 = create :user, username: 'user2'
    comment = build(:comment, body: '@user1 @user2')
    assert_equal [user1, user2].sort, comment.mention_users.sort
  end

  test "should create_mention_notifications" do
    user = create(:user)

    assert_difference "user.notifications.named('mention').count" do
    create(:comment, body: "@#{user.username}")
    end
  end

  test "shuold create_comment_notifications for subscribed_users" do
    user = create(:user)
    topic = create(:topic)
    topic.subscribe_by user

    assert_difference "user.notifications.named('comment').count" do
      create(:comment, commentable: topic)
    end
  end
end
