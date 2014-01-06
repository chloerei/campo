class PostsController < ApplicationController
  before_filter :require_logined

  def show
    @topic = Topic.find params[:topic_id]
    @post = @topic.posts.find params[:id]

    respond_to do |format|
      format.js
    end
  end

  def create
    @topic = Topic.find params[:topic_id]
    @post = @topic.posts.create post_params.merge user: current_user

    respond_to do |format|
      format.js
    end
  end

  def edit
    @topic = Topic.find params[:topic_id]
    @post = @topic.posts.find params[:id]
    respond_to do |format|
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
