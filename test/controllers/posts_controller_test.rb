require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "should show post for cancel edit" do
    topic_post = create(:post)
    assert_require_logined do
      xhr :get, :show, topic_id: topic_post.topic, id: topic_post
    end
    assert_response :success, @response.body
  end

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
    assert_require_logined topic_post.user do
      xhr :get, :edit, topic_id: topic_post.topic, id: topic_post
    end
    assert_response :success, @response.body
  end

  test "should update post" do
    topic_post = create(:post)
    assert_require_logined topic_post.user do
      xhr :patch, :update, topic_id: topic_post.topic, id: topic_post, post: { content: 'change' }
    end
    assert_response :success, @response.body
    assert_equal 'change', topic_post.reload.content
  end
end
