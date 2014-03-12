class LikesController < ApplicationController
  before_action :login_required, :no_locked_required, :find_likeable

  def create
    @likeable.likes.find_or_create_by user: current_user
  end

  def destroy
    @likeable.likes.where(user: current_user).destroy_all
  end

  private

  def find_likeable
    resource, id = request.path.split('/')[1, 2]
    @likeable = resource.singularize.classify.constantize.find(id)
  end
end
