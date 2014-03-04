class UsersController < ApplicationController
  before_filter :no_login_required, only: [:new, :create]

  def new
    store_location params[:return_to]
    @user = User.new
  end

  def create
    @user = User.new params.require(:user).permit(:username, :email, :name, :password).merge(locale: locale)
    if @user.save
      login_as @user
      redirect_back_or_default root_url
    else
      render :new
    end
  end

  def check_email
    respond_to do |format|
      format.json do
        render json: !User.where(email_lower: params[:user][:email].downcase).where.not(id: params[:id]).exists?
      end
    end
  end

  def check_username
    respond_to do |format|
      format.json do
        render json: !User.where(username_lower: params[:user][:username].downcase).where.not(id: params[:id]).exists?
      end
    end
  end
end
