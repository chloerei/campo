class Settings::AccountsController < Settings::ApplicationController
  before_action :current_password_required, only: [:update]

  def show
  end

  def update
    if @user.update_attributes params.require(:user).permit(:username, :email, :locale)
      flash[:success] = I18n.t('settings.accounts.flashes.successfully_updated')
      redirect_to settings_account_path
    else
      render :show
    end
  end
end
