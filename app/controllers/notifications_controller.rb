class NotificationsController < ApplicationController
  before_filter :require_logined

  def index
    @notifications = current_user.notifications.page(params[:page])
  end
end
