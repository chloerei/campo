require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "should create post" do
    topic = create(:topic)
    assert_difference "Post.count" do
      assert_require_logined do
        xhr :post, :create, topic_id: topic, post: attributes_for(:post)
      end
    end
  end

  test "should edit post" do
    topic_post = create(:post)
    assert_require_logined do
      xhr :get, :edit, topic_id: topic_post.topic, id: topic_post
    end
    assert_response :success, @response.body
  end
end
