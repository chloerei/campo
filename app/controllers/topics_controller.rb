class TopicsController < ApplicationController
  before_filter :require_logined, except: [:index, :show]

  def index
    @topics = Topic.order(hot: :desc).page(params[:page])
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
    @topic.build_main_post
  end

  def create
    @topic = Topic.new topic_params.merge(user: current_user)
    @topic.main_post.user = current_user

    if @topic.save
      redirect_to @topic
    else
      render :new
    end
  end

  def edit
    @topic = current_user.topics.find params[:id]
  end

  def update
    @topic = current_user.topics.find params[:id]
    @topic.title = topic_params[:title]
    @topic.main_post.content = topic_params[:main_post_attributes][:content]
    if @topic.save
      redirect_to @topic
    else
      render :edit
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title, main_post_attributes: [:content])
  end
end
