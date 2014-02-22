class Admin::TopicsController < Admin::ApplicationController
  before_filter :find_topic, only: [:show, :update, :trash, :restore]

  def index
    @topics = Topic.no_trashed.order(id: :desc).page(params[:page])
  end

  def trashed
    @topics = Topic.trashed.order(id: :desc).page(params[:page])
    render :index
  end

  def show
  end

  def update
    if @topic.update_attributes params.require(:topic).permit(:title, :category_id, :body)
      flash[:success] = 'Topic have been successfully updated'
      redirect_to admin_topic_url(@topic)
    else
      render :show
    end
  end

  def trash
    @topic.trash
    flash[:success] = 'Topic have been successfully trashed'
    redirect_to admin_topic_path(@topic)
  end

  def restore
    @topic.restore
    flash[:success] = 'Topic have been successfully restored'
    redirect_to admin_topic_path(@topic)
  end

  private

  def find_topic
    @topic = Topic.find params[:id]
  end
end
