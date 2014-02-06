class CommentsController < ApplicationController
  before_filter :login_required
  before_filter :find_comment, only: [:edit, :cancel, :update, :trash]

  def create
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
    @comment = @commentable.comments.create params.require(:comment).permit(:body).merge(user: current_user)
  end

  def edit
  end

  def cancel
  end

  def update
    @comment.update_attributes params.require(:comment).permit(:body)
  end

  def trash
    @comment.trash
  end

  def preview
    @body = params[:body]
    render layout: false
  end

  private

  def find_comment
    @comment = current_user.comments.find params[:id]
  end
end
