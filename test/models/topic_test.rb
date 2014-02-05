require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  test "should calculate hot" do
    topic = create(:topic)
    assert topic.calculate_hot > 0
    old_hot = topic.hot
    topic.comments_count += 1
    assert topic.calculate_hot > old_hot
  end

  test "should trash" do
    topic = create(:topic)

    assert_difference "Topic.trashed.count" do
      assert_difference "Topic.untrashed.count", -1 do
        topic.trash
        assert_equal true, topic.trashed?
      end
    end

    assert_difference "Topic.trashed.count", -1 do
      assert_difference "Topic.untrashed.count" do
        topic.restore
        assert_equal false, topic.trashed?
      end
    end
  end

  test "should add user to subscribers" do
    topic = create(:topic)
    assert topic.subscribed_by?(topic.user)
  end

  test "should subscribe_by user" do
    topic = create(:topic)
    user = create(:user)
    topic.subscribe_by user
    assert topic.subscribed_by? user
  end

  test "should ignore_by user" do
    topic = create(:topic)
    user = create(:user)
    topic.ignore_by user
    assert topic.ignored_by? user
  end
end
