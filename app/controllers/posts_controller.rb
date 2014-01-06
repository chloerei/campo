class PostsController < ApplicationController
  before_filter :require_logined

  def create
    @topic = Topic.find params[:topic_id]
    @post = @topic.posts.create post_params.merge user: current_user
    respond_to do |format|
      format.js {
        render :create
      }
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
