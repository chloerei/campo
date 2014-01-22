require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  test "should inc user unread_notifications_count" do
    user = create(:user)
    assert_difference "user.notifications.unread.count" do
      create(:notification, user: user)
    end

    assert_difference "user.notifications.unread.count", -1 do
      user.notifications.last.destroy
    end
  end
end
