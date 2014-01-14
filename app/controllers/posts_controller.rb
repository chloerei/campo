class PostsController < ApplicationController
  before_filter :require_logined

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

  def preview
    @content = params[:content]
    render layout: false
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
