class Users::CommentsController < Users::ApplicationController
  def index
    @comments = @user.comments.includes(:commentable).order(id: :desc).page(params[:page])
  end
end
