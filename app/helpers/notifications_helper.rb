module NotificationsHelper
  def unread_notifications_count
    if login?
      current_user.notifications.unread.count
    end
  end
end
