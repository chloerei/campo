class Settings::AccountsController < Settings::ApplicationController
  def show
  end

  def update
    if @user.update_attributes params.require(:user).permit(:username, :email)
      redirect_to settings_account_path
    else
      render :show
    end
  end
end
