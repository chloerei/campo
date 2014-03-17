class Admin::TopicsController < Admin::ApplicationController
  before_action :find_topic, only: [:show, :update, :trash, :restore]

  def index
    @topics = Topic.includes(:user).order(id: :desc).page(params[:page])
  end

  def trashed
    @topics = Topic.trashed.includes(:user).order(id: :desc).page(params[:page])
    render :index
  end

  def show
  end

  def update
    if @topic.update_attributes params.require(:topic).permit(:title, :category_id, :body)
      flash[:success] = I18n.t('admin.topics.flashes.successfully_updated')
      redirect_to admin_topic_url(@topic)
    else
      render :show
    end
  end

  def trash
    @topic.trash
    flash[:success] = I18n.t('admin.topics.flashes.successfully_trashed')
    redirect_to admin_topic_path(@topic)
  end

  def restore
    @topic.restore
    flash[:success] = I18n.t('admin.topics.flashes.successfully_restored')
    redirect_to admin_topic_path(@topic)
  end

  private

  def find_topic
    @topic = Topic.with_trashed.find params[:id]
  end
end
