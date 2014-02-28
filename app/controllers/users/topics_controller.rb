class Users::TopicsController < Users::ApplicationController
  def index
    @topics = @user.topics.order(id: :desc).page(params[:page])
  end
end
