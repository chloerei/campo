require 'test_helper'

class Users::TopicsControllerTest < ActionController::TestCase
  def setup
    @user = create(:user)
  end

  test "should get index" do
    create(:topic, user: @user)
    get :index, username: @user.username
    assert_response :success, @response.body
  end

  test "should get likes" do
    create(:like, user: @user, likeable: create(:topic))
    get :likes, username: @user.username
    assert_response :success, @response.body
  end
end
