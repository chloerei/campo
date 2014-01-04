class UsersController < ApplicationController
  before_filter :require_no_logined

  def new
    @user = User.new
  end

  def create
    @user = User.new params.require(:user).permit(:username, :email, :name, :password)
    if @user.save
      login_as @user
      redirect_to root_url
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
