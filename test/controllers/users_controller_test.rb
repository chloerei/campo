require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new page" do
    get :new
    assert_response :success, @response.body
  end

  test "should create user" do
    assert !logined?
    assert_difference "User.count" do
      post :create, user: attributes_for(:user)
    end
    assert logined?
  end

  test "should redirect to root if logined" do
    login_as create(:user)
    get :new
    assert_redirected_to root_url

    post :create, user: attributes_for(:user)
    assert_redirected_to root_url
  end
end
