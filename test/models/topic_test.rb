require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  test "should calculate hot" do
    topic = create(:topic)
    assert_equal topic.created_at.to_i / 45000, topic.reload.hot

    old_hot = topic.hot

    create(:post, topic: topic)
    assert topic.reload.hot > old_hot
  end
end
