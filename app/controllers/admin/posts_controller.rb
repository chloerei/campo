class Admin::PostsController < Admin::ApplicationController
  before_filter :find_post, except: [:index]

  def index
    @posts = Post.order(id: :desc).page(params[:page])
  end

  def show
  end

  def destroy
    @post.delete
    redirect_to admin_post_path(@post)
  end

  def restore
    @post.restore
    redirect_to admin_post_path(@post)
  end

  private

  def find_post
    @post = Post.find params[:id]
  end
end
