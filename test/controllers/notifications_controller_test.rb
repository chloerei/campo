require 'test_helper'

class NotificationsControllerTest < ActionController::TestCase
  test "should get index" do
    user = create(:user)
    create(:notification, user: user)

    assert_require_logined(user) do
      get :index
    end
    assert_response :success, @response.body
  end

  test "should read notification after get index" do
    user = create(:user)
    login_as user

    create(:notification, user: user)
    assert_difference "user.notifications.unread.count", -1 do
      get :index
    end

    per_page = Notification.default_per_page

    (per_page + 1).times { create(:notification, user: user) }
    assert_difference "user.notifications.unread.count", -per_page do
      get :index
    end

    assert_difference "user.notifications.unread.count", -1 do
      get :index, page: 2
    end
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

  test "should mark all as read" do
    user = create(:user)
    login_as user
    3.times { create :notification, user: user }
    xhr :post, :mark
    assert_equal 0, user.notifications.unread.count
  end

  test "should destroy all notification" do
    user = create(:user)
    login_as user
    3.times { create :notification, user: user }
    xhr :delete, :clear
    assert_equal 0, user.notifications.count
  end
end
