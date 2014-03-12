class Settings::PasswordsController < Settings::ApplicationController
  before_action :current_password_required, only: [:update]

  def show
  end

  def update
    if @user.update_attributes params.require(:user).permit(:password, :password_confirmation)
      flash[:success] = I18n.t('settings.passwords.flashes.successfully_updated')
      redirect_to settings_password_url
    else
      render :show
    end
  end
end
