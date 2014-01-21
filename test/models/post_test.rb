require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "should get post_number after create" do
    topic = create(:topic)
    assert_equal 1, topic.main_post.post_number
    assert_equal 2, create(:post).post_number
    assert_equal 3, create(:post, :topic => Topic.last).post_number
  end

  test "should create post_topic notification after create post" do
    topic = create(:topic)
    assert_difference "topic.user.notifications.where(name: 'post_topic').count" do
      create :post, topic: topic
    end
  end
end
