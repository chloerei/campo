class SubscriptionsController < ApplicationController
  before_filter :login_required, :find_subscribable

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
  end

  private

  def find_subscribable
    resource, id = request.path.split('/')[1, 2]
    @subscribable = resource.singularize.classify.constantize.find(id)
  end
end
