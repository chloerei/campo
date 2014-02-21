class Settings::PasswordsController < Settings::ApplicationController
  before_filter :current_password_required, only: [:update]

  def show
  end

  def update
    if @user.update_attributes params.require(:user).permit(:password, :password_confirmation)
      redirect_to settings_password_url
    else
      render :show
    end
  end
end
