class Admin::UsersController < Admin::ApplicationController
  before_filter :find_user, except: [:index, :locked]

  def index
    @users = User.unlocked.order(id: :desc).page(params[:page])
  end

  def locked
    @users = User.locked.order(id: :desc).page(params[:page])
    render :index
  end

  def show
  end

  def update
    @user.update_attributes params.require(:user).permit(:name, :username, :email, :bio)
    redirect_via_turbolinks_to admin_user_url(@user)
  end

  def destroy
    @user.destroy
    redirect_via_turbolinks_to admin_users_path
  end

  def lock
    @user.lock
    redirect_via_turbolinks_to admin_user_url(@user)
  end

  def unlock
    @user.unlock
    redirect_via_turbolinks_to admin_user_url(@user)
  end

  private

  def find_user
    @user = User.find params[:id]
  end
end
