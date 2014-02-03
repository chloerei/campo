class Admin::TopicsController < Admin::ApplicationController
  before_filter :find_topic, except: [:index]

  def index
    @topics = Topic.order(id: :desc).page(params[:page])
  end

  def show
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
