require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "should create post" do
    topic = create(:topic)
    assert_difference "Post.count" do
      assert_require_logined do
        post :create, topic_id: topic, post: attributes_for(:post), format: 'js'
      end
    end
  end
end
