require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get login page" do
    get :new
    assert_response :success, @response.body
  end

  test "should create session" do
    create(:user, username: 'Username', password: '12345678')
    assert !logined?
    post :create, login: 'Username', password: '12345678'
    assert logined?
  end
end
