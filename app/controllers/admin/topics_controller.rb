class Admin::TopicsController < Admin::ApplicationController
  before_filter :find_topic, only: [:show, :update, :trash, :restore]

  def index
    @topics = Topic.untrashed.order(id: :desc).page(params[:page])
  end

  def trashed
    @topics = Topic.trashed.order(id: :desc).page(params[:page])
    render :index
  end

  def show
  end

  def update
    @topic.update_attributes params.require(:topic).permit(:title, :category_id, :body)
    redirect_to admin_topic_url(@topic)
  end

  def trash
    @topic.trash
    redirect_to admin_topic_path(@topic)
  end

  def restore
    @topic.restore
    redirect_to admin_topic_path(@topic)
  end

  private

  def find_topic
    @topic = Topic.find params[:id]
  end
end
