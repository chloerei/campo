require 'test_helper'

class Admin::PostsControllerTest < ActionController::TestCase
  def setup
    login_as create(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success, @response.body
  end

  test "should get show page" do
    topic_post = create(:post)
    get :show, id: topic_post
    assert_response :success, @response.body
  end

  test "should destroy post" do
    topic_post = create(:post)
    assert_difference "Post.visible.count", -1 do
      delete :destroy, id: topic_post
    end
    assert_redirected_to admin_post_path(topic_post)
  end

  test "should restore post" do
    topic_post = create(:post, deleted: true)
    assert_difference "Post.visible.count" do
      patch :restore, id: topic_post
    end
    assert_redirected_to admin_post_path(topic_post)
  end
end
