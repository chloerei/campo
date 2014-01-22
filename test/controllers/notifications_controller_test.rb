require 'test_helper'

class NotificationsControllerTest < ActionController::TestCase
  test "should get index" do
    assert_require_logined do
      get :index
    end
    assert_response :success, @response.body
  end

  test "should destroy notification" do
    user = create(:user)
    notification = create(:notification, user: user)
    assert_difference "user.notifications.count", -1 do
      assert_require_logined(user) do
        xhr :delete, :destroy, id: notification
      end
    end
  end
end
