require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "should show post for cancel edit" do
    topic_post = create(:post)
    assert_login_required do
      xhr :get, :show, id: topic_post
    end
    assert_response :success, @response.body
  end

  test "should create post" do
    topic = create(:topic)
    assert_difference "topic.posts.count" do
      assert_login_required do
        xhr :post, :create, post: attributes_for(:post).merge(topic_id: topic)
      end
    end
  end

  test "should edit post" do
    topic_post = create(:post)
    assert_login_required topic_post.user do
      xhr :get, :edit, id: topic_post
    end
    assert_response :success, @response.body
  end

  test "should update post" do
    topic_post = create(:post)
    assert_login_required topic_post.user do
      xhr :patch, :update, id: topic_post, post: { content: 'change' }
    end
    assert_response :success, @response.body
    assert_equal 'change', topic_post.reload.content
  end

  test "should like post" do
    topic_post = create(:post)
    assert_login_required do
      xhr :post, :like, id: topic_post
    end
    assert_response :success, @response.body
    assert_equal 1, topic_post.reload.like_users_count
  end

  test "should unlike post" do
    topic_post = create(:post)
    user = create(:user)
    topic_post.like_users << user
    assert_login_required(user) do
      xhr :delete, :unlike, id: topic_post
    end
    assert_response :success, @response.body
    assert_equal 0, topic_post.reload.like_users_count
  end
end
