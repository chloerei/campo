class LikesController < ApplicationController
  before_filter :login_required, :find_likeable

  def create
    @likeable.likes.create user: current_user
  end

  def destroy
    @likeable.likes.find_by(user_id: current_user.id).try(:destroy)
  end

  private

  def find_likeable
    resource, id = request.path.split('/')[1, 2]
    @likeable = resource.singularize.classify.constantize.find(id)
  end
end
