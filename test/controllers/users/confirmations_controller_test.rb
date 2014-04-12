require 'test_helper'

class Users::ConfirmationsControllerTest < ActionController::TestCase
  def setup
    $redis.flushdb
  end

  test "should redirect to root if already confirmed" do
    login_as create(:user, confirmed: true)
    get :new
    assert_redirected_to root_url
  end

  test "should get new page" do
    login_as create(:user, confirmed: false)
    get :new
    assert_response :success, @response.body
  end

  test "should confirm user if token valid" do
    login_as create(:user, confirmed: false)
    get :show, token: current_user.confirmation_token
    assert current_user.reload.confirmed?
  end

  test "should not confirm user if token invalid" do
    login_as create(:user, confirmed: false)
    get :show, token: current_user.confirmation_token[0..-2]
    assert !current_user.reload.confirmed?
  end

  test "should show" do
    login_as create(:user, confirmed: false)
    get :show
    assert_response :success, @response.body
  end

  test "should create confirm" do
    login_as create(:user, confirmed: false)
    xhr :post, :create
    assert ActionMailer::Base.deliveries.any?
  end

  test "should access limit" do
    login_as create(:user, confirmed: false)
    ip = '1.2.3.4'
    key = "verifies:limiter:#{ip}"
    request.headers['REMOTE_ADDR'] = ip
    assert_equal nil, $redis.get(key)
    assert_difference "ActionMailer::Base.deliveries.count" do
      xhr :post, :create
      assert_equal 1, $redis.get(key).to_i
    end

    assert_no_difference "ActionMailer::Base.deliveries.count" do
      xhr :post, :create
      assert_equal 1, $redis.get(key).to_i
    end
  end
end
