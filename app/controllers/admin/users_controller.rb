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
    if @user.update_attributes params.require(:user).permit(:name, :username, :email, :bio, :avatar, :remove_avatar)
      flash[:success] = 'Change have been successfully saved'
      redirect_to admin_user_url(@user)
    else
      render :show
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User #{@user.username} have been successfully destroy"
    redirect_to admin_users_path
  end

  def lock
    @user.lock
    flash[:success] = 'User have been successfully locked'
    redirect_to admin_user_url(@user)
  end

  def unlock
    @user.unlock
    flash[:success] = 'User have been successfully unlocked'
    redirect_to admin_user_url(@user)
  end

  private

  def find_user
    @user = User.find params[:id]
  end
end
