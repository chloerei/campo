class Admin::TopicsController < Admin::ApplicationController
  def index
    @topics = Topic.order(id: :desc).page(params[:page])
  end

  def show
    @topic = Topic.find params[:id]
  end

  def destroy
    @topic = Topic.find params[:id]
    @topic.destroy
    redirect_to admin_topics_path
  end
end
