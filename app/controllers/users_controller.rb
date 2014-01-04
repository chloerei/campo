class UsersController < ApplicationController
  before_filter :require_no_logined

  def new
    store_location params[:return_to] if params[:return_to].present?
    @user = User.new
  end

  def create
    @user = User.new params.require(:user).permit(:username, :email, :name, :password)
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
        render json: {
          uniqueness: !User.exists?(email: params[:email])
        }
      end
    end
  end

  def check_username
    respond_to do |format|
      format.json do
        render json: {
          uniqueness: !User.exists?(username: params[:username])
        }
      end
    end
  end
end
