class SubscriptionsController < ApplicationController
  before_action :login_required, :no_locked_required, :find_subscribable

  def update
    case params[:status]
    when 'subscribed'
      @subscribable.subscribe_by(current_user)
    when 'ignored'
      @subscribable.ignore_by(current_user)
    end
  end

  def destroy
    @subscribable.subscriptions.where(user: current_user).destroy_all
    render :update
  end

  private

  def find_subscribable
    resource, id = request.path.split('/')[1, 2]
    @subscribable = resource.singularize.classify.constantize.find(id)
  end
end
