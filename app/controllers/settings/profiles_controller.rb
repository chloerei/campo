class Settings::ProfilesController < Settings::ApplicationController
  def show
  end

  def update
    if @user.update_attributes params.require(:user).permit(:name, :bio, :avatar, :remove_avatar)
      redirect_to settings_profile_url
    else
      render :show
    end
  end
end
