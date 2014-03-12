class NotificationsController < ApplicationController
  before_action :login_required

  def index
    @notifications = current_user.notifications.order(id: :desc).page(params[:page])
  end

  def destroy
    @notification = current_user.notifications.find params[:id]
    @notification.destroy

    respond_to do |format|
      format.js
    end
  end

  def mark
    current_user.notifications.unread.update_all(read: true)

    respond_to do |format|
      format.js
    end
  end

  def clear
    current_user.notifications.delete_all

    respond_to do |format|
      format.js
    end
  end
end
