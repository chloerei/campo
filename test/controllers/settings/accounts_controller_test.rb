require 'test_helper'

class Settings::AccountsControllerTest < ActionController::TestCase
  def setup
    login_as create(:user)
  end

  test "should get settings account page" do
    get :show
    assert_response :success, @response.body
  end

  test "should update settings account" do
    patch :update, user: { username: 'change' }
    assert_equal 'change', current_user.reload.username
  end
end
