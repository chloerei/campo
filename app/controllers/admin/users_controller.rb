class Admin::UsersController < Admin::ApplicationController
  before_filter :find_user, except: [:index]

  def index
    @users = User.order(id: :desc).page(params[:page])
  end

  def show
  end

  def update
    @user.update_attributes params.require(:user).permit(:name, :username, :email, :bio)
    redirect_to admin_user_url(@user)
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def find_user
    @user = User.find params[:id]
  end
end
