class TopicsController < ApplicationController
  before_filter :require_logined, except: [:index, :show]

  def index
  end

  def new
    @topic = Topic.new
    @topic.posts.build
  end
end
