class Admin::CommentsController < Admin::ApplicationController
  before_filter :find_comment, except: [:index, :trashed]

  def index
    @comments = Comment.no_trashed.order(id: :desc).page(params[:page])
  end

  def trashed
    @comments = Comment.trashed.order(id: :desc).page(params[:page])
    render :index
  end

  def show
  end

  def update
    if @comment.update_attributes params.require(:comment).permit(:body)
      flash[:success] = 'Comment have been successfully updated'
      redirect_to admin_comment_path(@comment)
    else
      render :show
    end
  end

  def trash
    @comment.trash
    flash[:success] = 'Comment have been successfully trashed'
    redirect_to admin_comment_path(@comment)
  end

  def restore
    @comment.restore
    flash[:success] = 'Comment have been successfully restore'
    redirect_to admin_comment_path(@comment)
  end

  private

  def find_comment
    @comment = Comment.find params[:id]
  end
end
