module NotificationsHelper
  def unread_notifications_count
    if logined?
      current_user.notifications.unread.count
    end
  end
end
