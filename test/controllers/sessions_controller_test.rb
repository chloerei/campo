require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    # reset access limiter
    $redis.flushdb
  end

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
    assert !login?
    post :create, user: { login: 'Username', password: '12345678' }
    assert login?
  end

  test "should destroy session" do
    login_as create(:user)
    delete :destroy
    assert !login?
  end

  test "should redirect back after login" do
    session[:return_to] = '/foo'
    create(:user, username: 'username', password: '12345678')
    post :create, user: { login: 'Username', password: '12345678' }
    assert_redirected_to '/foo'
  end

  test "should access limit" do
    ip = '1.2.3.4'
    key = "sessions:limiter:#{ip}"
    request.headers['REMOTE_ADDR'] = ip
    assert_equal nil, $redis.get(key)
    post :create, user: { login: 'Username', password: '12345678' }
    assert_equal 1, $redis.get(key).to_i
    $redis.set(key, 5)
    post :create, user: { login: 'Username', password: '12345678' }
    assert_template :access_limiter
  end
end
