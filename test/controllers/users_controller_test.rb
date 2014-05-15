require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new page" do
    get :new
    assert_response :success, @response.body
  end

  test "should store_location" do
    get :new, return_to: '/foo'
    assert_equal '/foo', session[:return_to]
  end

  test "should create user" do
    assert !login?
    assert_difference ["User.count", "ActionMailer::Base.deliveries.size"] do
      post :create, user: attributes_for(:user)
    end
    assert login?
  end

  test "should create user with locale" do
    @request.headers['http_accept_language.parser'] = HttpAcceptLanguage::Parser.new('zh-CN')
    assert_difference "User.count" do
      post :create, user: attributes_for(:user)
    end
    assert_equal 'zh-CN', User.last.locale
  end

  test "should redirect back after signup" do
    session[:return_to] = '/foo'
    post :create, user: attributes_for(:user)
    assert_redirected_to '/foo'
  end

  test "should redirect to root if logined" do
    login_as create(:user)
    get :new
    assert_redirected_to root_url

    post :create, user: attributes_for(:user)
    assert_redirected_to root_url
  end

  test "should check email" do
    user = create(:user)

    # exist
    get :check_email, user: { email: user.email }, format: 'json'
    assert_equal 'false', @response.body

    # noexist
    get :check_email, user: { email: build(:user).email }, format: 'json'
    assert_equal 'true', @response.body
  end

  test "should check username" do
    user = create(:user)

    # exist
    get :check_username, user: { username: user.username }, format: 'json'
    assert_equal 'false', @response.body

    # noexist
    get :check_username, user: { username: build(:user).username }, format: 'json'
    assert_equal 'true', @response.body
  end
end
