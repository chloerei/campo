class Settings::AccountsController < ApplicationController
  before_filter :login_required

  def show
  end

  def update
    if current_user.update_attributes params.require(:user).permit(:username, :email, :name, :bio, :avatar, :remove_avatar)
      redirect_to settings_account_path
    else
      render :show
    end
  end
end
