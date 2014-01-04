require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get login page" do
    get :new
    assert_response :success, @response.body
  end

  test "should store_location" do
    get :new, return_to: '/foo'
    assert_equal '/foo', session[:return_to]
  end

  test "should create session" do
    create(:user, username: 'Username', password: '12345678')
    assert !logined?
    post :create, login: 'Username', password: '12345678'
    assert logined?
  end

  test "should destroy session" do
    login_as create(:user)
    delete :destroy
    assert !logined?
  end

  test "should redirect back after login" do
    session[:return_to] = '/foo'
    create(:user, username: 'username', password: '12345678')
    post :create, login: 'Username', password: '12345678'
    assert_redirected_to '/foo'
  end
end
