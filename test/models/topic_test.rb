require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  test "should calculate hot" do
    topic = create(:topic)
    assert topic.calculate_hot > 0
    old_hot = topic.hot
    topic.comments_count += 1
    assert topic.calculate_hot > old_hot
  end

  test "should delete topic" do
    topic = create(:topic)
    assert_difference "Topic.visible.count", -1 do
      topic.delete
    end
    assert topic.deleted?

    assert_difference "Topic.visible.count" do
      topic.restore
    end
    assert !topic.deleted?
  end
end
