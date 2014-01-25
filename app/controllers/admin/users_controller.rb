class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.order(id: :desc).page(params[:page])
  end

  def show
    @user = User.find params[:id]
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to admin_users_path
  end
end
