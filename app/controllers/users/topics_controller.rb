class Users::TopicsController < Users::ApplicationController
  def index
    @topics = @user.topics.includes(:category).order(id: :desc).page(params[:page])
  end

  def likes
    @topics = @user.like_topics.includes(:category, :user).order(id: :desc).page(params[:page])
    render :index
  end
end
