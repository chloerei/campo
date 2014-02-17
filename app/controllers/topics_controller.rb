class TopicsController < ApplicationController
  before_filter :login_required, :no_locked_required, except: [:index, :show]
  before_filter :find_topic, only: [:edit, :update, :trash]

  def index
    @topics = Topic.no_trashed.page(params[:page])

    if params[:category_id]
      @category = Category.find_by! slug_lower: params[:category_id].downcase
      @topics = @topics.where(category: @category)
    end

    # Set default tab
    unless %w(hot newest).include? params[:tab].to_s
      params[:tab] = 'hot'
    end

    case params[:tab]
    when 'hot'
      @topics = @topics.order(hot: :desc)
    when 'newest'
      @topics = @topics.order(id: :desc)
    end
  end

  def search
    @topics = Topic.search(
      query: {
        multi_match: {
          query: params[:q].to_s,
          fields: ['title', 'body']
        }
      },
      filter: {
        missing: {
          field: 'trashed_at'
        }
      }
    ).page(params[:page]).records
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
    @topic = current_user.topics.create topic_params
  end

  def edit
  end

  def update
    @topic.update_attributes topic_params
  end

  def trash
    @topic.trash
    redirect_via_turbolinks_to topics_path
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :category_id, :body)
  end

  def find_topic
    @topic = current_user.topics.find params[:id]
  end
end
