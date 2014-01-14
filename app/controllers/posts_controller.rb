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

  def vote
    @post = Post.find_by! id: params[:id]
    if PostVote::VALUE.keys.include? params[:type]
      post_vote = @post.post_votes.find_or_initialize_by(user_id: current_user.id)
      post_vote.update_attribute :value, params[:type]
    elsif params[:type] == 'cancel'
      @post.post_votes.find_by(user_id: current_user.id).try(:destroy)
    end

    respond_to do |format|
      format.js { render :show }
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
