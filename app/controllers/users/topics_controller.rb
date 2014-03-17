class Users::TopicsController < Users::ApplicationController
  def index
    @topics = @user.topics.includes(:category).order(id: :desc).page(params[:page])
  end
end
