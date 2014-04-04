class Users::CommentsController < Users::ApplicationController
  def index
    @comments = @user.comments.includes(:commentable).order(id: :desc).page(params[:page])
  end

  def likes
    @comments = @user.like_comments.includes(:commentable, :user).order(id: :desc).page(params[:page])
    render :index
  end
end
