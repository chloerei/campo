require 'test_helper'

class NotificationsControllerTest < ActionController::TestCase
  test "should get index" do
    user = create(:user)
    create(:notification, user: user, subject: create(:comment), name: 'comment')
    create(:notification, user: user, subject: create(:comment), name: 'mention')

    login_as user
    get :index
    assert_response :success, @response.body
  end

  test "should destroy notification" do
    user = create(:user)
    notification = create(:notification, user: user)
    login_as user
    assert_difference "user.notifications.count", -1 do
      xhr :delete, :destroy, id: notification
    end
  end

  test "should mark all as read after get index" do
    user = create(:user)
    login_as user
    3.times { create :notification, user: user }
    assert_equal 3, user.notifications.unread.count
    get :index
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
