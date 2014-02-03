class Admin::CommentsController < Admin::ApplicationController
  before_filter :find_comment, except: [:index]

  def index
    @comments = Comment.order(id: :desc).page(params[:page])
  end

  def show
  end

  def trash
    @comment.trash
    redirect_to admin_comment_path(@comment)
  end

  def restore
    @comment.restore
    redirect_to admin_comment_path(@comment)
  end

  private

  def find_comment
    @comment = Comment.find params[:id]
  end
end
