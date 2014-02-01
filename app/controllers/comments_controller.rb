class CommentsController < ApplicationController
  before_filter :login_required
  before_filter :find_comment, only: [:edit, :update]

  def create
    @comment = current_user.comments.create params.require(:comment).permit(:commentable_type, :commentable_id, :content)
  end

  def edit
  end

  def update
    @comment.update_attributes params.require(:comment).permit(:content)
  end

  def preview
    @content = params[:content]
    render layout: false
  end

  private

  def find_comment
    @comment = current_user.comments.find params[:id]
  end
end
