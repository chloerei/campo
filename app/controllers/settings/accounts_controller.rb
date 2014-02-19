class Settings::AccountsController < ApplicationController
  before_filter :login_required

  def show
  end

  def update
    current_user.update_attributes params.require(:user).permit(:username, :email, :name, :bio)
    redirect_via_turbolinks_to settings_account_url
  end
end
