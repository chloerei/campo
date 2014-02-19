class Settings::PasswordsController < ApplicationController
  before_filter :login_required

  def show
    @user = current_user
  end

  def update
    @user = current_user

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
