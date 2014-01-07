class TopicsController < ApplicationController
  before_filter :require_logined, except: [:index, :show]

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find params[:id]

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @topic = Topic.new
    @topic.posts.build
  end

  def create
    @topic = Topic.new topic_params.merge(user: current_user)
    @topic.posts.first.user = current_user
    if @topic.save
      redirect_to @topic
    else
      render :new
    end
  end

  def edit
    @topic = Topic.find params[:id]

    respond_to do |format|
      format.js
    end
  end

  def update
    @topic = Topic.find params[:id]
    @topic.update_attributes params.require(:topic).permit(:title)

    respond_to do |format|
      format.js
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title, { posts_attributes: [:content] })
  end
end
