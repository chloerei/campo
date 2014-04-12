class Settings::NotificationsController < Settings::ApplicationController
  def show
  end

  def update
    if @user.update_attributes params.require(:user).permit(:send_mention_email, :send_mention_web, :send_comment_email, :send_comment_web)
      flash[:success] = I18n.t('settings.notifications.flashes.successfully_updated')
      redirect_to settings_notifications_url
    else
      render :show
    end
  end
end
