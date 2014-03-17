class Admin::CommentsController < Admin::ApplicationController
  before_action :find_comment, except: [:index, :trashed]

  def index
    @comments = Comment.includes(:user, :commentable).order(id: :desc).page(params[:page])
  end

  def trashed
    @comments = Comment.trashed.includes(:user, :commentable).order(id: :desc).page(params[:page])
    render :index
  end

  def show
  end

  def update
    if @comment.update_attributes params.require(:comment).permit(:body)
      flash[:success] = I18n.t('admin.comments.flashes.successfully_updated')
      redirect_to admin_comment_path(@comment)
    else
      render :show
    end
  end

  def trash
    @comment.trash
    flash[:success] = I18n.t('admin.comments.flashes.successfully_trashed')
    redirect_to admin_comment_path(@comment)
  end

  def restore
    @comment.restore
    flash[:success] = I18n.t('admin.comments.flashes.successfully_restored')
    redirect_to admin_comment_path(@comment)
  end

  private

  def find_comment
    @comment = Comment.with_trashed.find params[:id]
  end
end
