class Users::LikesController < Users::ApplicationController
  def index
    @likes = @user.likes.includes(:likeable).order(id: :desc).page(params[:page])
  end

  def destroy
    @like = @user.likes.find params[:id]
    @like.destroy
  end
end
