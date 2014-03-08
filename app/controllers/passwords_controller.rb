class PasswordsController < ApplicationController
  before_filter :no_login_required
  before_filter :check_token, only: [:edit, :update]

  def show
  end

  def new
  end

  def create
    if @user = User.find_by(email: params[:email])
      @user.generate_password_reset_token
      UserMailer.password_reset(@user.id).deliver
      redirect_to password_path
    else
      flash.now[:warning] = I18n.t('passwords.flashes.user_email_not_found')
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes params.require(:user).permit(:password, :password_confirmation)
      flash[:success] = I18n.t('passwords.flashes.successfully_update')
      redirect_to login_url
    else
      render :edit
    end
  end

  private

  def check_token
    if params[:email].present? && params[:token].present?
      @user = User.find_by(email: params[:email], password_reset_token: params[:token])
    end

    unless @user && @user.password_reset_token_created_at > 1.hour.ago
      flash[:warning] = I18n.t('passwords.flashes.token_invalid')
      redirect_to new_password_path
    end
  end
end
