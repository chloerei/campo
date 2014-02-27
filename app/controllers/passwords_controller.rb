class PasswordsController < ApplicationController
  before_filter :no_login_required

  def new
  end

  def create
    if @user = User.find_by(email: params[:email])
      @user.generate_password_reset_token
      UserMailer.password_reset(@user.id).deliver
      redirect_to password_path
    else
      flash[:warning] = I18n.t('passwords.flashes.user_email_not_found')
      render :new
    end
  end
end
