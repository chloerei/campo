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
    post = create(:post)
    get :show, id: post
    assert_response :success, @response.body
  end

  test "should destroy post" do
    post = create(:post)
    assert_difference "Post.count", -1 do
      delete :destroy, id: post
    end
    assert_redirected_to admin_posts_path
  end
end
