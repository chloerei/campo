class TopicsController < ApplicationController
  before_filter :login_required, :no_locked_required, except: [:index, :show]
  before_filter :find_topic, only: [:edit, :update, :trash]

  def index
    @topics = Topic.no_trashed.page(params[:page])

    if params[:category_id]
      @category = Category.find_by! slug_lower: params[:category_id].downcase
      @topics = @topics.where(category: @category)
    end

    case params[:sort]
    when 'newest'
      @topics = @topics.order(id: :desc)
    else # hot
      @topics = @topics.order(hot: :desc)
      params.delete(:sort) # clean for other
    end
  end

  def show
    @topic = Topic.find params[:id]

    if params[:comment_id] and comment = @topic.comments.no_trashed.find_by(id: params.delete(:comment_id))
      params[:page] = comment.page
    end

    @comments = @topic.comments.no_trashed.order(id: :asc).page(params[:page])

    respond_to do |format|
      format.html
    end
  end

  def new
    @category = Category.find_by slug_lower: params[:category_id].downcase if params[:category_id].present?
    @topic = Topic.new category: @category
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
  end

  def update
    if @topic.update_attributes topic_params
      redirect_to @topic
    else
      render :edit
    end
  end

  def trash
    @topic.trash
    redirect_to topics_path
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :category_id, :body)
  end

  def find_topic
    @topic = current_user.topics.find params[:id]
  end
end
