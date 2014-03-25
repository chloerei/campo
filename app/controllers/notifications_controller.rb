class NotificationsController < ApplicationController
  before_action :login_required
  after_action :mark_all_as_read, only: [:index]

  def index
    @notifications = current_user.notifications.includes(:subject).order(id: :desc).page(params[:page])
  end

  def destroy
    @notification = current_user.notifications.find params[:id]
    @notification.destroy
  end

  def clear
    current_user.notifications.delete_all
  end

  private

  def mark_all_as_read
    current_user.notifications.unread.update_all(read: true, updated_at: Time.now.utc)
  end
end
