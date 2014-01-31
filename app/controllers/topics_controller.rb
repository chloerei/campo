class TopicsController < ApplicationController
  before_filter :login_required, except: [:index, :show]

  def index
    @topics = Topic.page(params[:page])

    case params[:sort]
    when 'newest'
      @topics = @topics.order(id: :desc)
    else
      @topics = @topics.order(hot: :desc)
    end
  end

  def show
    @topic = Topic.find params[:id]

    respond_to do |format|
      format.html
    end
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new topic_params

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

    if @topic.update_attributes topic_params
      redirect_to @topic
    else
      render :edit
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :content)
  end
end
