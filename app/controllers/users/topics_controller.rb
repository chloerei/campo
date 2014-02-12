class Users::TopicsController < Users::ApplicationController
  def index
    @topics = @user.topics.no_trashed.order(id: :desc).page(params[:page])
  end
end
