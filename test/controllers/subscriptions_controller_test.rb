require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  test "should subscribe topic" do
    topic = create(:topic)
    user = create(:user)
    login_as user

    assert_difference "topic.subscribed_users.count" do
      xhr :put, :update, topic_id: topic, status: 'subscribed'
    end
    assert topic.subscribed_by? user
    assert !topic.ignored_by?(user)

    assert_difference "topic.ignored_users.count" do
      xhr :put, :update, topic_id: topic, status: 'ignored'
    end
    assert !topic.subscribed_by?(user)
    assert topic.ignored_by? user
  end

  test "should destroy topic subscripton" do
    topic = create(:topic)
    user = create(:user)
    login_as user

    topic.subscribe_by user

    assert_difference "topic.subscriptions.count", -1 do
      xhr :delete, :destroy, topic_id: topic
    end
  end
end
