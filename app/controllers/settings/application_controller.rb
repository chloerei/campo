class Settings::ApplicationController < ApplicationController
  before_action :login_required, :set_user

  private

  def set_user
    @user = current_user
  end

  def current_password_required
    unless params[:current_password] && @user.authenticate(params[:current_password])
      flash.now[:warning] = I18n.t('settings.flashes.incorrect_current_password')
      render :show
    end
  end
end
