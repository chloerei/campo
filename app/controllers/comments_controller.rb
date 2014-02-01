class CommentsController < ApplicationController
  before_filter :login_required

  def create
    @comment = current_user.comments.create params.require(:comment).permit(:commentable_type, :commentable_id, :content)
  end

  def preview
    @content = params[:content]
    render layout: false
  end
end
