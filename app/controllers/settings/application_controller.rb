class Settings::ApplicationController < ApplicationController
  before_filter :login_required, :set_user

  private

  def set_user
    @user = current_user
  end

  def current_password_required
    unless params[:current_password] && @user.authenticate(params[:current_password])
      flash.now[:warning] = 'Password is incorrect, please enter current password to save changes.'
      render :show
    end
  end
end
