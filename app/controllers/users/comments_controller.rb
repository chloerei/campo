class Users::CommentsController < Users::ApplicationController
  def index
    @comments = @user.comments.order(id: :desc).page(params[:page])
  end
end
