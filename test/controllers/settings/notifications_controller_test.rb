require 'test_helper'

class Settings::NotificationsControllerTest < ActionController::TestCase
  def setup
    login_as create(:user)
  end

  test "should get show page" do
    get :show
    assert_response :success, @response.body
  end

  test "should update notification settings" do
    post :update, user: { send_mention_web: false }
    assert_equal false, current_user.reload.send_mention_web?
  end
end
