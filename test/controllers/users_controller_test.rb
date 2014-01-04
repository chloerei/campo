require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new page" do
    get :new
    assert_response :success, @response.body
  end

  test "should create user" do
    assert_difference "User.count" do
      post :create, user: attributes_for(:user)
    end
  end
end
