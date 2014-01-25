class PostsController < ApplicationController
  before_filter :login_required

  def show
    @post = Post.find_by! id: params[:id]

    respond_to do |format|
      format.js
    end
  end

  def create
    @topic = Topic.find params[:post][:topic_id]
    @post = @topic.posts.create post_params.merge user: current_user

    respond_to do |format|
      format.js
    end
  end

  def edit
    @post = current_user.posts.find_by! id: params[:id]

    respond_to do |format|
      format.js
    end
  end

  def update
    @post = current_user.posts.find_by! id: params[:id]
    @post.update_attributes post_params

    respond_to do |format|
      format.js
    end
  end

  def like
    @post = Post.find params[:id]
    @post.like_users.push current_user

    respond_to do |format|
      format.js
    end
  end

  def unlike
    @post = Post.find params[:id]
    @post.like_users.delete current_user
  end

  def preview
    @content = params[:content]
    render layout: false

    respond_to do |format|
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
