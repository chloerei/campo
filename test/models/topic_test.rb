require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  test "should calculate hot" do
    topic = create(:topic)
    assert topic.calculate_hot > 0
    old_hot = topic.hot
    topic.posts_count += 1
    assert topic.calculate_hot > old_hot
  end
end
