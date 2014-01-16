require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  test "should calculate hot" do
    topic = create(:topic)
    assert_equal 0.0, topic.hot

    topic.main_post.update_attribute :votes_up, 10
    assert topic.calculate_hot > 0

    old_hot = topic.calculate_hot
    topic.main_post.update_attribute :votes_up, 20
    assert topic.calculate_hot > old_hot

    topic.main_post.update_attribute :votes_down, 100
    assert topic.calculate_hot < 0
  end
end
