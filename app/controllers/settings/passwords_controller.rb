class Settings::PasswordsController < Settings::ApplicationController
  def show
  end

  def update
    if @user.authenticate params[:current_password]
      if @user.update_attributes params.require(:user).permit(:password, :password_confirmation)
        redirect_to settings_password_url
      else
        render :show
      end
    else
      render :show
    end
  end
end
