class Admin::ApplicationController < ApplicationController
  layout 'admin'
  before_action :login_required, :admin_required

  private

  def admin_required
    raise AccessDenied unless current_user.admin?
  end
end
